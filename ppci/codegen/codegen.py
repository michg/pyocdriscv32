""" Machine code generator.

The architecture is provided when the generator is created.
"""

import logging
from .. import ir
from ..irutils import Verifier, split_block
from ..arch.arch import Architecture
from ..arch.generic_instructions import Label, Comment, Global, DebugData
from ..arch.generic_instructions import RegisterUseDef, VirtualInstruction
from ..arch.generic_instructions import ArtificialInstruction, Alignment
from ..arch.encoding import Instruction
from ..arch.data_instructions import DZero, DByte
from ..arch import data_instructions
from ..arch.arch_info import Endianness
from ..binutils.debuginfo import DebugType, DebugLocation, DebugDb
from ..binutils.outstream import MasterOutputStream, FunctionOutputStream
from .irdag import SelectionGraphBuilder
from .instructionselector import InstructionSelector1
from .instructionscheduler import InstructionScheduler
from .registerallocator import GraphColoringRegisterAllocator
from .peephole import PeepHoleStream


class CodeGenerator:
    """ Machine code generator """

    logger = logging.getLogger("codegen")

    def __init__(self, arch, optimize_for="size"):
        assert isinstance(arch, Architecture), arch
        self.arch = arch
        self.verifier = Verifier()
        self.sgraph_builder = SelectionGraphBuilder(arch)
        weights_map = {
            "size": (10, 1, 1),
            "speed": (3, 10, 1),
            "co2": (1, 2, 10),
            "awesome": (13, 13, 13),
        }
        selection_weights = weights_map.get(optimize_for, (1, 1, 1))
        self.instruction_selector = InstructionSelector1(
            arch, self.sgraph_builder, weights=selection_weights
        )
        self.instruction_scheduler = InstructionScheduler()
        self.register_allocator = GraphColoringRegisterAllocator(
            arch, self.instruction_selector
        )

    def generate(
        self, ircode: ir.Module, output_stream, reporter, debug=False
    ):
        """ Generate machine code from ir-code into output stream """
        assert isinstance(ircode, ir.Module)
        if ircode.debug_db:
            self.debug_db = ircode.debug_db
        else:
            self.debug_db = DebugDb()

        self.logger.info(
            "Generating %s code for module %s", str(self.arch), ircode.name
        )

        # Declare externals:
        output_stream.select_section("data")
        for external in ircode.externals:
            self._mark_global(output_stream, external)

        # Generate code for global variables:
        output_stream.select_section("data")
        for var in ircode.variables:
            self.generate_global(var, output_stream, debug)

        # Generate code for functions:
        # Munch program into a bunch of frames. One frame per function.
        # Each frame has a flat list of abstract instructions.
        output_stream.select_section("code")
        for function in ircode.functions:
            self.generate_function(
                function, output_stream, reporter, debug=debug
            )

        # Output debug type data:
        if debug:
            for di in self.debug_db.infos:
                if isinstance(di, DebugType):
                    # TODO: prevent this from being emitted twice in some way?
                    output_stream.emit(DebugData(di))

    def generate_global(self, var, output_stream, debug):
        """ Generate code for a global variable """
        alignment = Alignment(var.alignment)
        output_stream.emit(alignment)
        self._mark_global(output_stream, var)
        label = Label(var.name)
        output_stream.emit(label)
        if var.amount == 0 and var.value is None and not var.used_by:
            pass  # E.g. empty WASM func_table
        elif var.amount > 0:
            if var.value:
                assert isinstance(var.value, tuple)
                for part in var.value:
                    if isinstance(part, bytes):
                        # Emit plain byte data:
                        for byte in part:
                            output_stream.emit(DByte(byte))
                    elif isinstance(part, tuple) and part[0] is ir.ptr:
                        # Emit reference to a label:
                        assert isinstance(part[1], str)
                        labels_refs = {
                            (2, Endianness.LITTLE): data_instructions.Dw2,
                            (4, Endianness.LITTLE): data_instructions.Dcd2,
                            (8, Endianness.LITTLE): data_instructions.Dq2,
                        }
                        key = (
                            self.arch.info.get_size(part[0]),
                            self.arch.info.endianness,
                        )
                        op_cls = labels_refs[key]
                        output_stream.emit(op_cls(part[1]))
                    else:
                        raise NotImplementedError(str(part))
            else:
                output_stream.emit(DZero(var.amount))
        else:  # pragma: no cover
            raise NotImplementedError()
        self.debug_db.map(var, label)
        if self.debug_db.contains(label) and debug:
            dv = self.debug_db.get(label)
            dv.address = label.name
            output_stream.emit(DebugData(dv))

    def generate_function(
        self, ir_function, output_stream, reporter, debug=False
    ):
        """ Generate code for one function into a frame """
        self.logger.info(
            "Generating %s code for function %s",
            str(self.arch),
            ir_function.name,
        )

        reporter.heading(3, "Log for {}".format(ir_function))
        reporter.dump_ir(ir_function)

        # Split too large basic blocks in smaller chunks (for literal pools):
        # TODO: fix arbitrary number of 500. This works for arm and thumb..
        split_block_nr = 1
        for block in ir_function:
            max_block_len = 200
            while len(block) > max_block_len:
                self.logger.debug("%s too large, splitting up", str(block))
                newname = "{}_splitted_block_{}".format(
                    ir_function.name, split_block_nr
                )
                split_block_nr += 1
                _, block = split_block(
                    block, pos=max_block_len, newname=newname
                )

        self._mark_global(output_stream, ir_function)

        # Create a frame for this function:
        frame_name = ir_function.name
        frame = self.arch.new_frame(frame_name, ir_function)
        frame.debug_db = self.debug_db  # Attach debug info
        self.debug_db.map(ir_function, frame)

        # Select instructions and schedule them:
        self.select_and_schedule(ir_function, frame, reporter)

        reporter.dump_frame(frame)

        # Do register allocation:
        self.register_allocator.alloc_frame(frame)

        # TODO: Peep-hole here?
        # frame.instructions = [i for i in frame.instructions]
        if hasattr(self.arch, "peephole"):
            frame.instructions = self.arch.peephole(frame)

        reporter.dump_frame(frame)

        # Add label and return and stack adjustment:
        instruction_list = []
        output_stream = MasterOutputStream(
            [FunctionOutputStream(instruction_list.append), output_stream]
        )
        peep_hole_stream = PeepHoleStream(output_stream)
        self.emit_frame_to_stream(frame, peep_hole_stream, debug=debug)
        peep_hole_stream.flush()

        # Emit function debug info:
        if self.debug_db.contains(frame) and debug:
            func_end_label = self.debug_db.new_label()
            output_stream.emit(Label(func_end_label))
            d = self.debug_db.get(frame)
            d.begin = frame_name
            d.end = func_end_label
            dd = DebugData(d)
            output_stream.emit(dd)

        reporter.dump_instructions(instruction_list, self.arch)

    def select_and_schedule(self, ir_function, frame, reporter):
        """ Perform instruction selection and scheduling """
        self.logger.debug("Selecting instructions")

        tree_method = True
        if tree_method:
            self.instruction_selector.select(ir_function, frame, reporter)
        else:  # pragma: no cover
            raise NotImplementedError("TODO")
            # Build a graph:
            # self.sgraph_builder.build(ir_function, function_info)
            # reporter.message('Selection graph')
            # reporter.dump_sgraph(sgraph)

            # Schedule instructions:
            # self.instruction_scheduler.schedule(sgraph, frame)

    def emit_frame_to_stream(self, frame, output_stream, debug=False):
        """
            Add code for the prologue and the epilogue. Add a label, the
            return instruction and the stack pointer adjustment for the frame.
            At this point we know how much stack space must be reserved for
            locals and what registers should be saved.
        """
        # Materialize the register allocated instructions into a stream of
        # real instructions.
        self.logger.debug("Emitting instructions")

        debug_data = []

        # Prefix code:
        output_stream.emit_all(self.arch.gen_prologue(frame))

        for instruction in frame.instructions:
            assert isinstance(instruction, Instruction), str(instruction)

            # If the instruction has debug location, emit it here:
            if self.debug_db.contains(instruction) and debug:
                d = self.debug_db.get(instruction)
                assert isinstance(d, DebugLocation)
                if not d.address:
                    label_name = self.debug_db.new_label()
                    d.address = label_name
                    source_line = d.loc.get_source_line()
                    output_stream.emit(Comment(source_line))
                    output_stream.emit(Label(label_name))
                    debug_data.append(DebugData(d))

            if isinstance(instruction, VirtualInstruction):
                # Process virtual instructions
                if isinstance(instruction, RegisterUseDef):
                    pass
                elif isinstance(instruction, ArtificialInstruction):
                    output_stream.emit(instruction)
                else:  # pragma: no cover
                    raise NotImplementedError(str(instruction))
            else:
                # Real instructions:
                assert all(r.is_colored for r in instruction.registers)
                output_stream.emit(instruction)

        # Postfix code, like register restore and stack adjust:
        output_stream.emit_all(self.arch.gen_epilogue(frame))

        # Last but not least, emit debug infos:
        for dd in debug_data:
            output_stream.emit(dd)

        # Check if we know what variables are live
        for tmp in frame.ig.temp_map:
            if self.debug_db.contains(tmp):
                self.debug_db.get(tmp)
                # print(tmp, di)
                # frame.live_ranges(tmp)
                # print('live ranges:', lr)

    def _mark_global(self, output_stream, value):
        # Indicate static or global variable.
        assert isinstance(value, ir.GlobalValue)

        if value.binding == ir.Binding.GLOBAL:
            output_stream.emit(Global(value.name))
