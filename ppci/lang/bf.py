""" This is the brain-fuck language front-end. """

import logging
from .. import ir
from ..common import CompilerError
from ..irutils import Builder
from ..arch import get_arch

__all__ = ("bf_to_ir", "BrainFuckGenerator")


def bf_to_ir(source, target):
    """ Compile brainfuck source into ir code """
    target = get_arch(target)
    ircode = BrainFuckGenerator(target).generate(source)
    return ircode


class BrainFuckGenerator:
    """ Brainfuck is a language that is so simple, the entire front-end can
    be implemented in one pass.
    """

    logger = logging.getLogger("bfgen")

    def __init__(self, arch):
        self.arch = arch
        self.builder = Builder()

    def generate(self, src, module_name="main", function_name="main"):
        """ Takes a brainfuck program and returns the IR-code module """
        self.logger.info("Generating IR-code from brainfuck")

        # Assembler code will call sample_start
        self.builder.module = ir.Module(module_name)

        ir_func = self.builder.new_procedure(function_name, ir.Binding.GLOBAL)
        self.builder.set_function(ir_func)
        block1 = self.builder.new_block()
        ir_func.entry = block1
        self.builder.set_block(block1)

        # Allocate space on stack for ptr register:
        ptr_var = self.builder.emit(
            ir.Alloc("ptr_alloc", self.arch.get_size(ir.i32), 4)
        )
        ptr_var = self.builder.emit(ir.AddressOf(ptr_var, "ptr_addr"))

        bf_mem_size = 30000
        # Construct global array:
        data = ir.Variable(
            "data",
            ir.Binding.GLOBAL,
            bf_mem_size * self.arch.get_size(ir.i8),
            4,
        )
        self.builder.module.add_variable(data)

        # bsp puts function:
        bsp_putc = ir.ExternalProcedure("bsp_putc", [ir.u8])
        self.builder.module.add_external(bsp_putc)

        # Locate '1' and '0' constants:
        one_i32_ins = self.builder.emit_const(1, ir.i32)
        one_ins = self.builder.emit(ir.Cast(one_i32_ins, "val_inc", ir.i8))
        prc_inc = self.builder.emit(ir.Cast(one_i32_ins, "ptr_incr", ir.ptr))
        zero_ins = self.builder.emit_const(0, ir.i32)
        zero_ptr = self.builder.emit(ir.Cast(zero_ins, "zero_ptr", ir.ptr))
        zero_byte = self.builder.emit(ir.Cast(zero_ins, "zero_ptr", ir.i8))
        array_size = self.builder.emit_const(bf_mem_size, ir.ptr)

        # Store initial value of ptr:
        self.builder.emit(ir.Store(zero_ptr, ptr_var))

        # Initialize array to zero:
        block3 = self.builder.new_block()
        block_init = self.builder.new_block()
        self.builder.emit(ir.Jump(block_init))

        self.builder.set_block(block_init)
        ptr_val = self.builder.emit_load(ptr_var, ir.ptr)
        cell_addr = self.builder.emit_add(data, ptr_val, ir.ptr)
        self.builder.emit(ir.Store(zero_ins, cell_addr))
        add_ins = self.builder.emit_add(ptr_val, prc_inc, ir.ptr)
        self.builder.emit(ir.Store(add_ins, ptr_var))
        self.builder.emit(
            ir.CJump(add_ins, "==", array_size, block3, block_init)
        )

        self.builder.set_block(block3)

        # Start with ptr at 'data' ptr address:
        ptr = data

        # A stack of all nested loops:
        loops = []

        # A mapping of all loop entries to the phi functions of ptr:
        phi_map = {}

        # Implement all instructions:
        for char in src:
            if char == ">":
                # ptr++;
                ptr = self.builder.emit_add(ptr, prc_inc, ir.ptr)
            elif char == "<":
                # ptr--;
                ptr = self.builder.emit_sub(ptr, prc_inc, ir.ptr)
            elif char == "+":
                # data[ptr]++;
                val_ins = self.builder.emit_load(ptr, ir.i8)
                add_ins = self.builder.emit_add(val_ins, one_ins, ir.i8)
                self.builder.emit(ir.Store(add_ins, ptr))
            elif char == "-":
                # data[ptr]--;
                val_ins = self.builder.emit_load(ptr, ir.i8)
                sub_ins = self.builder.emit_sub(val_ins, one_ins, ir.i8)
                self.builder.emit(ir.Store(sub_ins, ptr))
            elif char == ".":
                # putc(data[ptr])
                val_ins = self.builder.emit_load(ptr, ir.i8)
                self.builder.emit(ir.ProcedureCall(bsp_putc, [val_ins]))
            elif char == ",":  # pragma: no cover
                # data[ptr] = getchar()
                raise NotImplementedError('"," operator not implemented')
            elif char == "[":
                entry_block = self.builder.new_block()
                body = self.builder.new_block()
                exit_block = self.builder.new_block()
                current_block = self.builder.block

                # Register phi node into entry:
                ptr_phi = ir.Phi("ptr_phi", ir.ptr)
                ptr_phi.set_incoming(current_block, ptr)
                phi_map[entry_block] = ptr_phi

                # Jump to entry:
                self.builder.emit_jump(entry_block)
                self.builder.set_block(entry_block)

                # Register the phi node:
                self.builder.emit(ptr_phi)
                ptr = ptr_phi

                # Create test, jump to exit when *ptr == 0:
                val_ins = self.builder.emit_load(ptr, ir.i8)
                self.builder.emit(
                    ir.CJump(val_ins, "==", zero_byte, exit_block, body)
                )

                # Set body as current block:
                self.builder.set_block(body)
                loops.append((entry_block, exit_block))
            elif char == "]":
                # Jump back to condition code:
                entry_block, exit_block = loops.pop(-1)

                # Set incoming branch to phi node:
                current_block = self.builder.block
                ptr_phi = phi_map[entry_block]
                ptr_phi.set_incoming(current_block, ptr)

                # Jump to entry again:
                self.builder.emit_jump(entry_block)
                self.builder.set_block(exit_block)

                # Set ptr to phi value front entry:
                ptr = ptr_phi
        if loops:
            raise CompilerError("[ requires matching ]")

        # Close current block:
        self.builder.emit_exit()

        # Yield module
        return self.builder.module
