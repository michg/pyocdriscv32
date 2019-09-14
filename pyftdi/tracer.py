# Copyright (c) 2017-2019, Emmanuel Blot <emmanuel.blot@free.fr>
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

"""MPSSE command debug tracer."""


from array import array
from binascii import hexlify
from collections import deque
from inspect import stack
from logging import getLogger
from string import ascii_uppercase
from struct import unpack as sunpack
from .ftdi import Ftdi


class FtdiMpsseTracer:
    """FTDI MPSSE protocol decoder

       Far from being complete for now
    """

    COMMAND_PREFIX = 'GET SET READ WRITE RW ENABLE DISABLE CLK LOOPBACK SEND'
    NO_RX = ('SEND_IMMEDIATE', 'SET_BITS_LOW', 'SET_BITS_HIGH')

    def build_commands(prefix):
        commands = {}
        for cmd in dir(Ftdi):
            if cmd[0] not in ascii_uppercase:
                continue
            value = getattr(Ftdi, cmd)
            if not isinstance(value, int):
                continue
            family = cmd.split('_')[0]
            if family not in prefix.split():
                continue
            commands[value] = cmd
        return commands

    COMMANDS = build_commands(COMMAND_PREFIX)

    ST_IDLE = range(1)

    def __init__(self):
        self.log = getLogger('pyftdi.mpsse')
        self._trace_tx = bytearray()
        self._trace_rx = bytearray()
        self._state = self.ST_IDLE
        self._clkdiv5 = False
        self._cmd_decoded = True
        self._resp_decoded = True
        self._last_codes = deque()
        self._expect_resp = deque()

    def send(self, buffer):
        self._trace_tx.extend(buffer)
        while self._trace_tx:
            try:
                code = self._trace_tx[0]
                cmd = self.COMMANDS[code]
                if cmd not in self.NO_RX:
                    self._last_codes.append(code)
                if self._cmd_decoded:
                    self.log.debug("Command: %02X: %s", code, cmd)
                cmd_decoder = getattr(self, '_cmd_%s' % cmd.lower())
                self._cmd_decoded = cmd_decoder()
                if self._cmd_decoded:
                    continue
            except IndexError:
                self.log.warning('Empty buffer')
            except KeyError:
                self.log.warning('Unknown command code: %02X', code)
            except AttributeError:
                self.log.warning('Decoder for command %s is not implemented',
                                 cmd)
            # on error, flush all buffers
            self._trace_tx = bytearray()
            self._trace_rx = bytearray()
            self._last_codes.clear()

    def receive(self, buffer):
        self._trace_rx.extend(buffer)
        while self._trace_rx:
            code = None
            try:
                code = self._last_codes.popleft()
                cmd = self.COMMANDS[code]
                resp_decoder = getattr(self, '_resp_%s' % cmd.lower())
                self._resp_decoded = resp_decoder()
                if self._resp_decoded:
                    continue
            except IndexError:
                self.log.warning('Empty buffer')
            except KeyError:
                self.log.warning('Unknown command code: %02X', code)
            except AttributeError:
                self.log.warning('Decoder for response %s is not implemented',
                                 cmd)
            # on error, flush RX buffer
            self._trace_rx = bytearray()
            self._last_codes.clear()

    def _cmd_enable_clk_div5(self):
        self.log.info('Enable clock divisor /5')
        self._clkdiv5 = True
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_disable_clk_div5(self):
        self.log.info('Disable clock divisor /5')
        self._clkdiv5 = False
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_set_tck_divisor(self):
        if len(self._trace_tx) < 3:
            return False
        value, = sunpack('<H', self._trace_tx[1:3])
        base = self._clkdiv5 and 12E6 or 60E6
        freq = base / ((1 + value) * 2)
        self.log.info('Set frequency %.3fMHZ', freq/1E6)
        self._trace_tx[:] = self._trace_tx[3:]
        return True

    def _cmd_loopback_end(self):
        self.log.info('Disable loopback')
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_enable_clk_adaptive(self):
        self.log.info('Enable adaptive clock')
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_disable_clk_adaptive(self):
        self.log.info('Disable adaptive clock')
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_enable_clk_3phase(self):
        self.log.info('Enable 3-phase clock')
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_disable_clk_3phase(self):
        self.log.info('Disable 3-phase clock')
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_send_immediate(self):
        self.log.debug('Send immediate')
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_get_bits_low(self):
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_get_bits_high(self):
        self._trace_tx[:] = self._trace_tx[1:]
        return True

    def _cmd_set_bits_low(self):
        if len(self._trace_tx) < 3:
            return False
        value, direction = sunpack('BB', self._trace_tx[1:3])
        self.log.info('Set gpio[7:0]  %02x %s',
                      value, self.bits2str(value, direction))
        self._trace_tx[:] = self._trace_tx[3:]
        return True

    def _cmd_set_bits_high(self):
        if len(self._trace_tx) < 3:
            return False
        value, direction = sunpack('BB', self._trace_tx[1:3])
        self.log.info('Set gpio[15:8] %02x %s',
                      value, self.bits2str(value, direction))
        self._trace_tx[:] = self._trace_tx[3:]
        return True

    def _cmd_write_bytes_pve_msb(self):
        return self._decode_output_mpsse_bytes()

    def _cmd_write_bytes_nve_msb(self):
        return self._decode_output_mpsse_bytes()

    def _cmd_write_bytes_pve_lsb(self):
        return self._decode_output_mpsse_bytes()

    def _cmd_write_bytes_nve_lsb(self):
        return self._decode_output_mpsse_bytes()

    def _cmd_read_bytes_pve_msb(self):
        return self._decode_input_mpsse_request()

    def _resp_read_bytes_pve_msb(self):
        return self._decode_input_mpsse_bytes()

    def _cmd_read_bytes_nve_msb(self):
        return self._decode_input_mpsse_request()

    def _resp_read_bytes_nve_msb(self):
        return self._decode_input_mpsse_bytes()

    def _cmd_read_bytes_pve_lsb(self):
        return self._decode_input_mpsse_request()

    def _resp_read_bytes_pve_lsb(self):
        return self._decode_input_mpsse_bytes()

    def _cmd_read_bytes_nve_lsb(self):
        return self._decode_input_mpsse_request()

    def _resp_read_bytes_nve_lsb(self):
        return self._decode_input_mpsse_bytes()

    def _cmd_rw_bytes_nve_pve_msb(self):
        return self._decode_output_mpsse_bytes(True)

    def _resp_rw_bytes_nve_pve_msb(self):
        return self._decode_input_mpsse_bytes()

    def _cmd_rw_bytes_pve_nve_msb(self):
        return self._decode_output_mpsse_bytes(True)

    def _resp_rw_bytes_pve_nve_msb(self):
        return self._decode_input_mpsse_bytes()

    def _resp_get_bits_low(self):
        if len(self._trace_rx) < 1:
            return False
        value = self._trace_rx[0]
        self.log.info('Get gpio[7:0]  %02x %s',
                      value, self.bits2str(value, 0xFF))
        self._trace_rx[:] = self._trace_rx[1:]
        return True

    def _resp_get_bits_high(self):
        if len(self._trace_rx) < 1:
            return False
        value = self._trace_rx[0]
        self.log.info('Get gpio[15:8] %02x %s',
                      value, self.bits2str(value, 0xFF))
        self._trace_rx[:] = self._trace_rx[1:]
        return True

    def _decode_output_mpsse_bytes(self, expect_rx=False):
        caller = stack()[1].function
        if len(self._trace_tx) < 4:
            return False
        length = sunpack('<H', self._trace_tx[1:3])[0] + 1
        if len(self._trace_tx) < 4 + length:
            return False
        if expect_rx:
            self._expect_resp.append(length)
        payload = self._trace_tx[3:3+length]
        funcname = caller[5:].title().replace('_', '')
        self.log.info('%s> (%d) %s',
                      funcname, length, hexlify(payload).decode('utf8'))
        self._trace_tx[:] = self._trace_tx[3+length:]
        return True

    def _decode_input_mpsse_request(self):
        if len(self._trace_tx) < 3:
            return False
        length = sunpack('<H', self._trace_tx[1:3])[0] + 1
        self._expect_resp.append(length)
        self._trace_tx[:] = self._trace_tx[3:]
        return True

    def _decode_input_mpsse_bytes(self):
        if not self._expect_resp:
            self.log.warning('Response w/o request?')
            return False
        if len(self._trace_rx) < self._expect_resp[0]:  # peek
            return False
        caller = stack()[1].function
        length = self._expect_resp.popleft()
        payload = self._trace_rx[:length]
        self._trace_rx[:] = self._trace_rx[length:]
        funcname = caller[5:].title().replace('_', '')
        self.log.info('%s< (%d) %s',
                      funcname, length, hexlify(payload).decode('utf8'))

    @classmethod
    def bits2str(cls, value, mask, z='_'):
        vstr = '{0:08b}'.format(value)
        mstr = '{0:08b}'.format(mask)
        return ''.join([m == '1' and v or z for v, m in zip(vstr, mstr)])

    # read_bytes_pve_msb
    # read_bytes_nve_msb
    # read_bits_pve_msb
    # read_bits_nve_msb
    # read_bytes_pve_lsb
    # read_bytes_nve_lsb
    # read_bits_pve_lsb
    # read_bits_nve_lsb
    # rw_bytes_pve_pve_lsb
    # rw_bytes_pve_nve_lsb
    # rw_bytes_nve_pve_lsb
    # rw_bytes_nve_nve_lsb
    # rw_bits_pve_pve_lsb
    # rw_bits_pve_nve_lsb
    # rw_bits_nve_pve_lsb
    # rw_bits_nve_nve_lsb
    # write_bits_tms_pve
    # write_bits_tms_nve
    # rw_bits_tms_pve_pve
    # rw_bits_tms_nve_pve
    # rw_bits_tms_pve_nve
    # rw_bits_tms_nve_nve

