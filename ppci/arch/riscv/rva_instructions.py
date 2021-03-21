""" Definitions of Riscv instructions. """

from ..isa import Isa
from ..encoding import Instruction, Syntax, Operand
from .registers import RiscvRegister
from .tokens import RiscvToken, RiscvcToken



class RegisterSet(set):
    def __repr__(self):
        reg_names = sorted(str(r) for r in self)
        return ", ".join(reg_names)


rvaisa = Isa()


class RiscvaInstruction(Instruction):
    tokens = [RiscvToken]
    isa = rvaisa


class OpAmo(RiscvaInstruction):
    """ amo rd, rs2, (rs1) """
    def encode(self):
        tokens = self.get_tokens()
        tokens[0].opcode = 0b0101111 
        tokens[0].rd = self.rd.num
        tokens[0].funct3 = 0b010
        tokens[0].rs1 = self.rs1.num
        tokens[0].rs2 = self.rs2.num
        tokens[0].funct7 = self.funct
        return tokens[0].encode()


def make_amo(mnemonic, ext, funct):
    rd = Operand("rd", RiscvRegister, write=True)
    rs2 = Operand("rs2", RiscvRegister, read=True)
    rs1 = Operand("rs1", RiscvRegister, read=True)
    syntax = Syntax(["amo" + mnemonic, ".", "w", ".", ext, " ", rd, ",", " ", rs2, ",", "(", rs1, ")"])
    members = {"syntax": syntax, "rd": rd, "rs2": rs2, "rs1": rs1, "funct": funct}
    return type("Amo" + mnemonic + ext + "_ins", (OpAmo,), members)


Amoswapa = make_amo("swap", "aq", 0b0000110)
Amoswapr = make_amo("swap", "rl", 0b0000101)


