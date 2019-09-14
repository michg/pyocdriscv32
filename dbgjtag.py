import sys, os, string
from socket import *
import select
import logging 
import time
from array import array
from pyftdi.ftdi import Ftdi
from pyftdi.bits import BitSequence 
from pyftdi.jtag import JtagStateMachine, JtagTool
from murax.ocd import MuraxOCD
from pulpissimo.ocd import PulpOCD
from reve.ocd import ReveOCD
from collections import namedtuple
from sys import argv

def inrange(value, bits):    
    upper_limit = 1 << (bits - 1)
    lower_limit = -(1 << (bits - 1))
    return value in range(lower_limit, upper_limit)  

Archdata = namedtuple('Archdata', ['Ocd', 'membaseadr']) 
Muraxdata = Archdata(MuraxOCD, 0x80000000)
Pulpdata = Archdata(PulpOCD, 0x1c000000)
Revedata = Archdata(ReveOCD, 0x00000000)

archmap = {
    'murax': Muraxdata,
    'pulp': Pulpdata,
    'reve': Revedata
    }

class JtagSimController:
    """JTAG master of an FTDI device"""
    
    # Private API
    def __init__(self):
        """
        trst uses the nTRST optional JTAG line to hard-reset the TAP
          controller
        """
        self.s = socket(AF_INET, SOCK_STREAM)
        self._last = None  # Last deferred TDO bit 
    
    def clockout(self, tms, tdi):
        TMS = 1
        TDI = 2
        TDO = 4
        TCK = 8
        val = tms*TMS + tdi*TDI 
        self.s.send(chr(val).encode())
        val = tms*TMS + tdi*TDI + TCK + TDO
        self.s.send(chr(val).encode())
        tdo = self.s.recv(1)[0]
        return tdo

    def readsetdr(self, length, inval):
        outval = 0
        for i in range(length):
            bit = inval & 1
            tdo = self.clockout(0, bit)
            inval >>= 1
            outval += tdo<<i
        return outval
    
    # Public API
    def configure(self, port):
        """Configure the FTDI interface as a JTAG controller"""
        self.s.connect(('localhost', port))

    def close(self):
        self.s.close()

    def reset(self):
        """Reset the attached TAP controller.
           sync sends the command immediately (no caching)
        """
        # we can either send a TRST HW signal or perform 5 cycles with TMS=1
        # to move the remote TAP controller back to 'test_logic_reset'state
        
        # TAP reset (even with HW reset, could be removed though)
        self.write_tms(BitSequence('11111'))
    
    def write_tms(self, tms):
        """Change the TAP controller state"""
        if not isinstance(tms, BitSequence):
            raise JtagError('Expect a BitSequence')
        for val in tms:
            if(self._last):
                self.clockout(val, 1)
                self._last = None
            else:
                self.clockout(val, 0)

    def read(self, length):
        """Read out a sequence of bits from TDO"""
        bs = BitSequence(value=self.readsetdr(length, 0), length=length)
        return bs

    def write(self, out, use_last=True):
        if not isinstance(out, BitSequence):
            return JtagError('Expect a BitSequence')
        if use_last:
            (out, self._last) = (out[:-1], bool(out[-1]))
        length = len(out)
        self.readsetdr(length, int(out))

    def shift_register(self, out, use_last=False):
        """Shift a BitSequence into the current register and retrieve the
           register output"""
        if not isinstance(out, BitSequence):
            return JtagError('Expect a BitSequence')
        if use_last:
            (out, self._last) = (out[:-1], bool(out[-1]))
        length = len(out)
        bs = BitSequence(value=self.readsetdr(length, int(out)), length=length)
        return bs


class JtagSimEngine:
    """High-level JTAG engine controller"""

    def __init__(self):
        self._ctrl = JtagSimController()
        self._sm = JtagStateMachine()
        self._seq = bytearray()

    def configure(self, port):
        """Configure the FTDI interface as a JTAG controller"""
        self._ctrl.configure(port)

    def close(self):
        """Terminate a JTAG session/connection"""
        self._ctrl.close()

    def reset(self):
        """Reset the attached TAP controller"""
        self._ctrl.reset()
        self._sm.reset()

    def write_tms(self, out):
        """Change the TAP controller state"""
        self._ctrl.write_tms(out)

    def read(self, length):
        """Read out a sequence of bits from TDO"""
        return self._ctrl.read(length)

    def write(self, out, use_last=False):
        """Write a sequence of bits to TDI"""
        self._ctrl.write(out, use_last)

    def get_available_statenames(self):
        """Return a list of supported state name"""
        return [str(s) for s in self._sm.states]

    def change_state(self, statename):
        """Advance the TAP controller to the defined state"""
        # find the state machine path to move to the new instruction
        path = self._sm.find_path(statename)
        # convert the path into an event sequence
        events = self._sm.get_events(path)
        # update the remote device tap controller
        self._ctrl.write_tms(events)
        # update the current state machine's state
        self._sm.handle_events(events)

    def go_idle(self):
        """Change the current TAP controller to the IDLE state"""
        self.change_state('run_test_idle')

    def write_ir(self, instruction):
        """Change the current instruction of the TAP controller"""
        self.change_state('shift_ir')
        self._ctrl.write(instruction)
        self.change_state('update_ir')

    def capture_ir(self):
        """Capture the current instruction from the TAP controller"""
        self.change_state('capture_ir')

    def write_dr(self, data):
        """Change the data register of the TAP controller"""
        self.change_state('shift_dr')
        self._ctrl.write(data)
        self.change_state('update_dr')

    def read_dr(self, length):
        """Read the data register from the TAP controller"""
        self.change_state('shift_dr')
        data = self._ctrl.read(length)
        self.change_state('update_dr')
        return data

    def capture_dr(self):
        """Capture the current data register from the TAP controller"""
        self.change_state('capture_dr')

    def shift_register(self, length):
        if not self._sm.state_of('shift'):
            raise JtagError("Invalid state: %s" % self._sm.state())
        if self._sm.state_of('capture'):
            bs = BitSequence(False)
            self._ctrl.write_tms(bs)
            self._sm.handle_events(bs)
        return self._ctrl.shift_register(length)

    
        
if __name__ == '__main__':
    engine = JtagSimEngine()
    tool = JtagTool(engine)
    engine.configure(7894)
    time.sleep(1)
    engine.reset()
    id = tool.idcode()
    print("ID:%08x" %id)
    engine.go_idle()
    engine.capture_ir()
    irlen = tool.detect_register_size()
    arch = archmap.get(argv[1], archmap['murax'])
    ocd = arch.Ocd(engine, irlen)
    memadr = arch.membaseadr    
    ocd.resetdm() 
    ocd.halt()
    ocd.writereg(5, 0x12345678)
    val = ocd.readreg(5);
    print("REG5:%08x" %val)    
    ocd.writemem(memadr,0xabcdefbc)
    val = ocd.readmem(memadr)
    print("MEM:%08x" %val)
    engine.close()
    
        