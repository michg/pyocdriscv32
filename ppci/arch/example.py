"""
    This is an example target with some instructions. It is used in test-cases
    and serves as a minimal example.
"""

from .arch import Architecture
from .arch_info import ArchInfo, TypeInfo
from .encoding import Instruction, Syntax, Operand
from .registers import Register, RegisterClass
from .. import ir
from .isa import Isa


class ExampleArch(Architecture):
    """ Simple example architecture. This is intended as starting point
    when creating a new backend """

    name = "example"

    def __init__(self, options=None):
        super().__init__(options=options)
        register_classes = [
            RegisterClass(
                "reg", [ir.i32, ir.ptr], ExampleRegister, [R0, R1, R2, R3, R10]
            ),
            RegisterClass("hreg", [ir.i16], HalfExampleRegister, [R10l]),
        ]
        self.gdb_registers = gdb_registers
        self.gdb_pc = R0
        self.isa = Isa()
        self.info = ArchInfo(
            type_infos={
                ir.i8: TypeInfo(1, 1),
                ir.u8: TypeInfo(1, 1),
                ir.i16: TypeInfo(2, 2),
                ir.u16: TypeInfo(2, 2),
                ir.i32: TypeInfo(4, 4),
                ir.u32: TypeInfo(4, 4),
                ir.f32: TypeInfo(4, 4),
                ir.f64: TypeInfo(8, 8),
                "int": ir.i32,
                "ptr": ir.u32,
            },
            register_classes=register_classes,
        )

    def gen_prologue(self, frame):
        return []

    def gen_epilogue(self, frame):
        return []

    def gen_call(self, label, args, rv):
        return []

    def gen_function_enter(self, args):
        return []

    def gen_function_exit(self, rv):
        return []

    def determine_arg_locations(self, arg_types):
        """ Given a set of argument types, determine locations
        """
        arg_locs = []
        regs = [R0, R1, R2, R3]
        for a in arg_types:
            r = regs.pop(0)
            arg_locs.append(r)
        return arg_locs

    def determine_rv_location(self, ret_type):
        rv = R0
        return rv


class ExampleRegister(Register):
    """ Example register class """

    bitsize = 32


class HalfExampleRegister(Register):
    """ Example register class """

    bitsize = 16


R0 = ExampleRegister("r0", 0)
R1 = ExampleRegister("r1", 1)
R2 = ExampleRegister("r2", 2)
R3 = ExampleRegister("r3", 3)
R4 = ExampleRegister("r4", 4)
R5 = ExampleRegister("r5", 5)
R6 = ExampleRegister("r6", 6)

# Two aliasing registers:
R10 = ExampleRegister("r10", 10)
R10l = HalfExampleRegister("r10l", 100, aliases=(R10,))

gdb_registers = (R0, R1, R2)


class ExampleInstruction(Instruction):
    """ Base class for all example instructions """

    tokens = []


class Def(ExampleInstruction):
    rd = Operand("rd", ExampleRegister, write=True)
    syntax = Syntax(["def", " ", rd])


class DefHalf(ExampleInstruction):
    rd = Operand("rd", HalfExampleRegister, write=True)
    syntax = Syntax(["def", " ", rd])


class Use(ExampleInstruction):
    rn = Operand("rn", ExampleRegister, read=True)
    syntax = Syntax(["use", " ", rn])


class UseHalf(ExampleInstruction):
    rn = Operand("rn", HalfExampleRegister, read=True)
    syntax = Syntax(["use", " ", rn])


class DefUse(ExampleInstruction):
    rd = Operand("rd", ExampleRegister, write=True)
    rn = Operand("rn", ExampleRegister, read=True)
    syntax = Syntax(["cpy", " ", rd, ",", " ", rn])


class Add(ExampleInstruction):
    rd = Operand("rd", ExampleRegister, write=True)
    rm = Operand("rm", ExampleRegister, read=True)
    rn = Operand("rn", ExampleRegister, read=True)
    syntax = Syntax(["add", " ", rd, ",", " ", rm, ",", " ", rn])


class Cmp(ExampleInstruction):
    rm = Operand("rm", ExampleRegister, read=True)
    rn = Operand("rn", ExampleRegister, read=True)
    syntax = Syntax(["cmp", " ", rm, ",", " ", rn])


class Use3(ExampleInstruction):
    rm = Operand("rm", ExampleRegister, read=True)
    rn = Operand("rn", ExampleRegister, read=True)
    ro = Operand("ro", ExampleRegister, read=True)
    syntax = Syntax(["use3", " ", rm, ",", " ", rn, ",", " ", ro])


class Mov(ExampleInstruction):
    rd = Operand("rd", ExampleRegister, write=True)
    rm = Operand("rm", ExampleRegister, read=True)
    syntax = Syntax(["mov", " ", rd, ",", " ", rm])
