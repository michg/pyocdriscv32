from ...utils.bitfun import wrap_negative, BitView
from ..encoding import Relocation
from .tokens import RiscvToken, RiscvIToken, RiscvSBToken


class BImm12Relocation(Relocation):
    name = "b_imm12"
    token = RiscvSBToken
    field = "imm"

    def calc(self, sym_value, reloc_value):
        assert sym_value % 2 == 0
        assert reloc_value % 2 == 0
        offset = (sym_value - reloc_value) // 2
        return wrap_negative(offset, 12)

    def apply(self, sym_value, data, reloc_value):
        """ Apply this relocation type given some parameters.

        This is the default implementation which stores the outcome of
        the calculate function into the proper token. """
        assert self.token is not None
        token = self.token.from_data(data)
        assert self.field is not None
        assert hasattr(token, self.field)
        setattr(token, self.field, self.calc(sym_value, reloc_value))
        return token.encode()


class BImm20Relocation(Relocation):
    name = "b_imm20"
    token = RiscvToken

    def apply(self, sym_value, data, reloc_value):
        assert sym_value % 2 == 0
        assert reloc_value % 2 == 0
        offset = sym_value - reloc_value
        rel20 = wrap_negative(offset >> 1, 20)
        bv = BitView(data, 0, 4)
        bv[21:31] = rel20 & 0x3FF
        bv[20:21] = rel20 >> 10 & 0x1
        bv[12:20] = rel20 >> 11 & 0xFF
        bv[31:32] = rel20 >> 19 & 0x1
        return data


class Abs32Imm20Relocation(Relocation):
    name = "abs32_imm20"
    token = RiscvToken

    def apply(self, sym_value, data, reloc_value):
        assert sym_value % 2 == 0
        bv = BitView(data, 0, 4)
        if sym_value & 0x800 == 0:
            bv[12:32] = (sym_value >> 12) & 0xFFFFF
        else:
            sym_value -= 0xFFFFF000
            bv[12:32] = (sym_value >> 12) & 0xFFFFF
        return data


class RelImm20Relocation(Relocation):
    name = "rel_imm20"
    token = RiscvToken

    def apply(self, sym_value, data, reloc_value):
        assert sym_value % 2 == 0
        assert reloc_value % 2 == 0
        offset = sym_value - reloc_value
        bv = BitView(data, 0, 4)
        if offset & 0x800 == 0:
            bv[12:32] = (offset >> 12) & 0xFFFFF
        else:
            offset -= 0xFFFFF000
            bv[12:32] = (offset >> 12) & 0xFFFFF

        return data


class Abs32Imm12Relocation(Relocation):
    name = "abs32_imm12"
    token = RiscvIToken
    field = "imm"

    def calc(self, sym_value, reloc_value):
        assert sym_value % 2 == 0
        return sym_value & 0xFFF

    def apply(self, sym_value, data, reloc_value):
        """ Apply this relocation type given some parameters.

        This is the default implementation which stores the outcome of
        the calculate function into the proper token. """
        assert self.token is not None
        token = self.token.from_data(data)
        assert self.field is not None
        assert hasattr(token, self.field)
        setattr(token, self.field, self.calc(sym_value, reloc_value))
        return token.encode()


class RelImm12Relocation(Relocation):
    name = "rel_imm12"
    token = RiscvIToken
    field = "imm"

    def calc(self, sym_value, reloc_value):
        assert sym_value % 2 == 0
        assert reloc_value % 2 == 0
        offset = sym_value - reloc_value + 4
        return offset & 0xFFF

    def apply(self, sym_value, data, reloc_value):
        """ Apply this relocation type given some parameters.

        This is the default implementation which stores the outcome of
        the calculate function into the proper token. """
        assert self.token is not None
        token = self.token.from_data(data)
        assert self.field is not None
        assert hasattr(token, self.field)
        setattr(token, self.field, self.calc(sym_value, reloc_value))
        return token.encode()


class AbsAddr32Relocation(Relocation):
    name = "absaddr32"
    token = RiscvToken

    def apply(self, sym_value, data, reloc_value):
        offset = sym_value
        bv = BitView(data, 0, 4)
        bv[0:32] = offset
        return data
