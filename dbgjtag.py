import sys, os, string

import select
import logging 
import time
from array import array
from pyftdi.ftdi import Ftdi
from pyftdi.bits import BitSequence 
from pyftdi.jtag import JtagStateMachine, JtagTool, JtagEngine
from murax.ocd import MuraxOCD
from pulp.ocd import PulpOCD
from reve.ocd import ReveOCD
from collections import namedtuple
from sys import argv
from blaster import Blaster
from sim import JtagSimController
import struct

def inrange(value, bits):    
    upper_limit = 1 << (bits - 1)
    lower_limit = -(1 << (bits - 1))
    return value in range(lower_limit, upper_limit)  

Archdata = namedtuple('Archdata', ['Ocd', 'membaseadr','bootadr','irsize']) 
Muraxdata = Archdata(MuraxOCD, 0x80000000, 0x80000000, 4)
Pulpdata = Archdata(PulpOCD, 0x30000000, 0x30000080, 5) # 1C//3=tbnew2
Revedata = Archdata(ReveOCD, 0x00000000, 0x0, 5)  #ref=0x0,0

archmap = {
    'murax': Muraxdata,
    'pulp': Pulpdata,
    'reve': Revedata
    }

VIR = 1
VIRLEN = 1
VIR = 0xE
VDR = 0xC

class JtagOCDEngine():
    def __init__(self, ctrl):
        self._ctrl = ctrl
        self._sm = JtagStateMachine()
        self._seq = bytearray()

    def close(self):
        """Terminate a JTAG session/connection"""
        self._ctrl.close()

    def reset(self):
        """Reset the attached TAP controller"""
        self._ctrl.reset()
        self._sm.reset()

    def write_tms(self, out, should_read=False):
        """Change the TAP controller state"""
        return self._ctrl.write_tms(out, should_read)

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
    
    def readwrite_dr(self, out):
        """Read the data register from the TAP controller"""
        self.change_state('shift_dr')
        data = int(self._ctrl.writeread(out, use_last=True))
        events = BitSequence('11')
        tdo = int(self.write_tms(events, should_read=True))
        # (write_tms calls sync())
        # update the current state machine's state
        self._sm.handle_events(events)
        data+= tdo<<(len(out)-1)
        return data
        
    
    def write_vir(self, val):
        self.write_ir(BitSequence(value=VIR, length=10))
        self.write_dr(BitSequence(value=(1<<len(val))|int(val) , length=len(val)+1))
        self.write_ir(BitSequence(value=VDR, length=10))
    
    def shift_register(self, out):
        if not self._sm.state_of('shift'):
            raise JtagError("Invalid state: %s" % self._sm.state())
        if self._sm.state_of('capture'):
            bs = BitSequence(False)
            self._ctrl.write_tms(bs)
            self._sm.handle_events(bs)
        bs = self._ctrl.writeread(out, use_last=False)
        return bs
     
    


def loadbinary(filename, startadr):
    with open(filename, "rb") as f:
        bindata = f.read() 
    for i in range(len(bindata) // 4):       
        ocd.writemem(startadr + i*4, struct.unpack('<I',bindata[i*4:(i+1)*4])[0])
        
if __name__ == '__main__':
    if(argv[1]=='f'):
        engine = JtagEngine(trst=False, frequency=10E3)
        engine.configure('ftdi://olimex:ft2232h/1')
    elif(argv[1]=='s'):
        ctrl = JtagSimController()
        ctrl.configure(7894)
        engine = JtagOCDEngine(ctrl)
    elif(argv[1]=='v'):
        ctrl = Blaster()
        engine = JtagOCDEngine(ctrl)
        
    tool = JtagTool(engine)
    time.sleep(1)
    engine.reset()
    id = tool.idcode()
    print("ID:%08x" %id)
    engine.go_idle()
    engine.capture_ir()
    arch = archmap.get(argv[2], archmap['murax'])
    if argv[1]!='v':
        irlen = tool.detect_register_size()
    else:
        irlen = arch.irsize
    ocd = arch.Ocd(engine, irlen)
    memadr = arch.membaseadr
    ocd.resetdm() 
    ocd.halt()
    ocd.writereg(5, 0x12345678)
    time.sleep(3)
    ocd.writereg(4, 0x87654321)
    time.sleep(3)
    val = ocd.readreg(5);
    print("REG5:%08x" %val) 
    val = ocd.readreg(4);
    print("REG4:%08x" %val)     
    ocd.writemem(memadr,0xabcdefbc)
    time.sleep(3)
    val = ocd.readmem(memadr)
    print("MEM:%08x" %val)
    loadbinary(argv[2]+".bin",memadr)    
    ocd.setpc(arch.bootadr)
    ocd.resume()
    time.sleep(5) 
    engine.close()
    
        