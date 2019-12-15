""" This module contains internal representations of types. """

# pylint: disable=R0903


def is_scalar(typ):
    """ Determine whether the given type is of scalar kind """
    return isinstance(typ, (BasicType, PointerType)) and not is_void(typ)


def is_char_array(typ):
    """ Check if the given type is of string type. """
    return isinstance(typ, ArrayType) and typ.element_type.is_scalar


def is_integer(typ):
    """ Test if the given type is of integer type """
    return (
        isinstance(typ, BasicType) and typ.type_id in BasicType.INTEGER_TYPES
    )


def is_signed_integer(typ):
    """ Test if the given type is of signed integer type """
    return (
        isinstance(typ, BasicType)
        and typ.type_id in BasicType.SIGNED_INTEGER_TYPES
    )


def is_void(typ):
    """ Check if the given type is void """
    return isinstance(typ, BasicType) and typ.type_id == BasicType.VOID


def is_double(typ):
    """ Check if the given type is double """
    return isinstance(typ, BasicType) and typ.type_id == BasicType.DOUBLE


def is_float(typ):
    """ Check if the given type is float """
    return isinstance(typ, BasicType) and typ.type_id == BasicType.FLOAT


def is_array(typ):
    """ Check if the given type is an array """
    return isinstance(typ, ArrayType)


def is_union(typ):
    """ Check if the given type is of union type """
    return isinstance(typ, UnionType)


def is_struct(typ):
    """ Check if the given type is a struct """
    return isinstance(typ, StructType)


# A type system:
class CType:
    """ Base class for all types """

    def __init__(self, qualifiers=None):
        self.qualifiers = qualifiers

    @property
    def is_void(self):
        """ See if this type is void """
        return is_void(self)

    @property
    def is_pointer(self):
        """ Test if this type is of pointer type. """
        return isinstance(self, PointerType)

    @property
    def is_float(self):
        """ See if this type is float """
        return is_float(self)

    @property
    def is_double(self):
        """ See if this type is double """
        return is_double(self)

    @property
    def is_scalar(self):
        """ Check if this is a scalar type """
        return is_scalar(self)

    @property
    def is_compound(self):
        """ Test if this type is of compound type. """
        return not self.is_scalar

    @property
    def is_char_array(self):
        """ Check if this type is string type. """
        return is_char_array(self)

    @property
    def is_integer(self):
        """ Check if this type is an integer type """
        return is_integer(self)

    @property
    def is_signed(self):
        """ Check if this type is of signed integer type """
        return is_signed_integer(self)

    @property
    def is_array(self):
        """ Check if this type is array type. """
        return is_array(self)

    @property
    def is_struct(self):
        """ Check if this type is a struct """
        return is_struct(self)

    @property
    def is_union(self):
        """ Check if this type is of union type """
        return is_union(self)

    def pointer_to(self):
        """ Create a new pointer type to this type. """
        return PointerType(self)


class FunctionType(CType):
    """ Function type """

    def __init__(self, arguments, return_type, is_vararg=False):
        super().__init__()
        self.is_vararg = is_vararg
        # assert all(isinstance(a, VariableDeclaration) for a in arguments)
        self.arguments = arguments
        self.argument_types = [a.typ for a in arguments]
        assert all(isinstance(t, CType) for t in self.argument_types)
        self.return_type = return_type
        assert isinstance(return_type, CType)

    def __repr__(self):
        return "Function-type"


class IndexableType(CType):
    """ Array or pointer type """

    def __init__(self, element_type):
        super().__init__()
        assert isinstance(element_type, CType)
        self.element_type = element_type


class ArrayType(IndexableType):
    """ Array type """

    def __init__(self, element_type, size):
        super().__init__(element_type)
        self.size = size

    def __repr__(self):
        return "Array-type"


class PointerType(IndexableType):
    """ The famous pointer! """

    def __repr__(self):
        return "Pointer-type"


class EnumType(CType):
    """ Enum type """

    def __init__(self, constants=None):
        super().__init__()
        self.constants = constants

    @property
    def complete(self):
        """ Test if this enum is complete (values are defined) """
        return self.constants is not None

    def __repr__(self):
        return "Enum-type"


class StructOrUnionType(CType):
    """ Common base for struct and union types """

    def __init__(self, tag=None, fields=None):
        super().__init__()
        self._fields = None
        self._field_map = None
        self.tag = tag
        self.fields = fields

    @property
    def incomplete(self):
        """ Check whether this type is incomplete or not """
        return self.fields is None

    @property
    def complete(self):
        """ Test if this type is complete """
        return not self.incomplete

    def _get_fields(self):
        return self._fields

    def _set_fields(self, fields):
        self._fields = fields
        if fields:
            self._field_map = {f.name: f for f in fields}

    fields = property(_get_fields, _set_fields)

    def get_named_fields(self):
        """ Create a list of fields, including those in anonymous members. """
        fields = []
        for field in self.fields:
            if field.name is None:
                if isinstance(field.typ, StructOrUnionType):
                    fields.extend(field.typ.get_named_fields())
            else:
                fields.append(field)
        return fields

    def get_field_names(self):
        """ Get a list of valid field names. """
        return [f.name for f in self.get_named_fields()]

    def has_field(self, name: str):
        """ Check if this type has the given field """
        assert isinstance(name, str)
        return name in self._field_map

    def get_field(self, name: str):
        """ Get the field with the given name """
        assert isinstance(name, str)
        return self._field_map[name]


class StructType(StructOrUnionType):
    """ Structure type """

    def __repr__(self):
        if self.complete:
            field_names = self.get_field_names()
            return "Structured-type field_names={}".format(field_names)
        else:
            return "Incomplete structured"


class Field:
    """ A field inside a union or struct """

    def __init__(self, typ, name, bitsize):
        self.typ = typ
        assert isinstance(typ, CType)
        self.name = name
        self.bitsize = bitsize

    def __repr__(self):
        if self.bitsize is None:
            return "Struct-field .{}".format(self.name)
        else:
            return "Struct-field .{} : {}".format(self.name, self.bitsize)

    @property
    def is_bitfield(self):
        """ Test if this field is a bitfield (or not) """
        return self.bitsize is not None


class UnionType(StructOrUnionType):
    """ Union type """

    def __repr__(self):
        return "Union-type"


class BasicType(CType):
    """ This type is one of: int, unsigned int, float or void """

    VOID = "void"
    CHAR = "char"
    UCHAR = "unsigned char"
    SHORT = "short"
    USHORT = "unsigned short"
    INT = "int"
    UINT = "unsigned int"
    LONG = "long"
    ULONG = "unsigned long"
    LONGLONG = "long long"
    ULONGLONG = "unsigned long long"
    FLOAT = "float"
    DOUBLE = "double"
    LONGDOUBLE = "long double"

    SIGNED_INTEGER_TYPES = {CHAR, SHORT, INT, LONG, LONGLONG}

    UNSIGNED_INTEGER_TYPES = {UCHAR, USHORT, UINT, ULONG, ULONGLONG}

    INTEGER_TYPES = SIGNED_INTEGER_TYPES | UNSIGNED_INTEGER_TYPES

    FLOAT_TYPES = {FLOAT, DOUBLE, LONGDOUBLE}

    NUMERIC_TYPES = INTEGER_TYPES | FLOAT_TYPES

    def __init__(self, type_id):
        super().__init__()
        self.type_id = type_id

    def __repr__(self):
        return "Basic type {}".format(self.type_id)
