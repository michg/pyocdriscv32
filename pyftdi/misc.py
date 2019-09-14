# Copyright (c) 2010-2016 Emmanuel Blot <emmanuel.blot@free.fr>
# Copyright (c) 2008-2016, Neotion
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of the Neotion nor the names of its contributors may
#       be used to endorse or promote products derived from this software
#       without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL NEOTION BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA,
# OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
# EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

"""Miscelleanous helpers"""

from array import array
from re import match


# String values evaluated as true boolean values
TRUE_BOOLEANS = ['on', 'true', 'enable', 'enabled', 'yes', 'high', '1']
# String values evaluated as false boolean values
FALSE_BOOLEANS = ['off', 'false', 'disable', 'disabled', 'no', 'low', '0']
# ASCII or '.' filter
ASCIIFILTER = ''.join([((len(repr(chr(_x))) == 3) or (_x == 0x5c)) and chr(_x)
                       or '.' for _x in range(128)]) + '.' * 128
ASCIIFILTER = bytearray(ASCIIFILTER.encode('ascii'))


def hexdump(data, full=False, abbreviate=False):
    """Convert a binary buffer into a hexadecimal representation.

       Return a multi-line strings with hexadecimal values and ASCII
       representation of the buffer data.

       :param data: binary buffer to dump
       :type data: bytes or array or bytearray or list(int)
       :param bool full: use `hexdump -Cv` format
       :param bool abbreviate: replace identical lines with '*'
    """
    try:
        if isinstance(data, (bytes, array)):
            src = bytearray(data)
        elif not isinstance(data, bytearray):
            # data may be a list/tuple
            src = bytearray(b''.join(data))
        else:
            src = data
    except Exception:
        raise TypeError("Unsupported data type '%s'" % type(data))

    length = 16
    result = []
    last = b''
    abv = False
    for i in range(0, len(src), length):
        s = src[i:i+length]
        if abbreviate:
            if s == last:
                if not abv:
                    result.append('*\n')
                    abv = True
                continue
            else:
                abv = False
        hexa = ' '.join(["%02x" % x for x in s])
        printable = s.translate(ASCIIFILTER).decode('ascii')
        if full:
            hx1, hx2 = hexa[:3*8], hexa[3*8:]
            hl = length//2
            result.append("%08x  %-*s %-*s |%s|\n" %
                          (i, hl*3, hx1, hl*3, hx2, printable))
        else:
            result.append("%06x   %-*s  %s\n" %
                          (i, length*3, hexa, printable))
        last = s
    return ''.join(result)


def hexline(data, sep=' '):
    """Convert a binary buffer into a hexadecimal representation.

       Return a string with hexadecimal values and ASCII representation
       of the buffer data.

       :param data: binary buffer to dump
       :type data: bytes or array or bytearray or list(int)
    """
    try:
        if isinstance(data, (bytes, array)):
            src = bytearray(data)
        elif not isinstance(data, bytearray):
            # data may be a list/tuple
            src = bytearray(b''.join(data))
        else:
            src = data
    except Exception:
        raise TypeError("Unsupported data type '%s'" % type(data))

    hexa = sep.join(["%02x" % x for x in src])
    printable = src.translate(ASCIIFILTER).decode('ascii')
    return "(%d) %s : %s" % (len(data), hexa, printable)


def to_int(value):
    """Parse a value and convert it into an integer value if possible.

       Input value may be:
       - a string with an integer coded as a decimal value
       - a string with an integer coded as a hexadecimal value
       - a integral value
       - a integral value with a unit specifier (kilo or mega)

       :param value: input value to convert to an integer
       :type value: str or int
       :return: the value as an integer
       :rtype: int
       :raise ValueError: if the input value cannot be converted into an int
    """
    if not value:
        return 0
    if isinstance(value, int):
        return value
    mo = match('^\s*(\d+)\s*(?:([KMkm]i?)?B?)?\s*$', value)
    if mo:
        mult = {'K': (1000),
                'KI': (1 << 10),
                'M': (1000 * 1000),
                'MI': (1 << 20)}
        value = int(mo.group(1))
        if mo.group(2):
            value *= mult[mo.group(2).upper()]
        return value
    return int(value.strip(), value.startswith('0x') and 16 or 10)


def to_bool(value, permissive=True, allow_int=False):
    """Parse a string and convert it into a boolean value if possible.

       Input value may be:
       - a string with an integer value, if `allow_int` is enabled
       - a boolean value
       - a string with a common boolean definition

       :param value: the value to parse and convert
       :type value: str or int or bool
       :param bool permissive: default to the False value if parsing fails
       :param bool allow_int: allow an integral type as the input value
       :rtype: bool
       :raise ValueError: if the input value cannot be converted into an bool
    """
    if value is None:
        return False
    if isinstance(value, bool):
        return value
    if isinstance(value, int):
        if allow_int:
            return bool(value)
        else:
            if permissive:
                return False
            raise ValueError("Invalid boolean value: '%d'", value)
    if value.lower() in TRUE_BOOLEANS:
        return True
    if permissive or (value.lower() in FALSE_BOOLEANS):
        return False
    raise ValueError('"Invalid boolean value: "%s"' % value)


def xor(_a_, _b_):
    """XOR logical operation.

       :param _a_: first argument
       :param _b_: second argument
       :return: xor-ed value
       :rtype: bool
    """
    return bool((not(_a_) and _b_) or (_a_ and not(_b_)))


def is_iterable(obj):
    """Tells whether an instance is iterable or not.

       :param obj: the instance to test
       :type obj: object
       :return: True if the object is iterable
       :rtype: bool
    """
    try:
        iter(obj)
        return True
    except TypeError:
        return False


def pretty_size(size, sep=' ', lim_k=1 << 10, lim_m=10 << 20, plural=True,
                floor=True):
    """Convert a size into a more readable unit-indexed size (KiB, MiB)

       :param int size: integral value to convert
       :param str sep: the separator character between the integral value and
            the unit specifier
       :param int lim_k: any value above this limit is a candidate for KiB
            conversion.
       :param int lim_m: any value above this limit is a candidate for MiB
            conversion.
       :param bool plural: whether to append a final 's' to byte(s)
       :param bool floor: how to behave when exact conversion cannot be
            achieved: take the closest, smaller value or fallback to the next
            unit that allows the exact representation of the input value
       :return: the prettyfied size
       :rtype: str
    """
    size = int(size)
    if size > lim_m:
        ssize = size >> 20
        if floor or (ssize << 20) == size:
            return '%d%sMiB' % (ssize, sep)
    if size > lim_k:
        ssize = size >> 10
        if floor or (ssize << 10) == size:
            return '%d%sKiB' % (ssize, sep)
    return '%d%sbyte%s' % (size, sep, (plural and 's' or ''))
