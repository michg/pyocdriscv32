import sys, os, string
from socket import *
import select
import logging 
import time
from array import array
from pyftdi.ftdi import Ftdi
from pyftdi.bits import BitSequence 
from pyftdi.jtag import JtagStateMachine, JtagTool


def inrange(value, bits):    
    upper_limit = 1 << (bits - 1)
    lower_limit = -(1 << (bits - 1))
    return value in range(lower_limit, upper_limit)  



class ReveOCD:
    DMCONTROLREG = 0x10
    ABSTRACTCMDREG = 0x17
    PROGBUFFERREG = 0x20
    ABSTRACTDATAREG = 0x4
    
    HALTREQBIT = 31
    RESUMEREQBIT = 30
    ACTIVEBIT = 0
    POSTEXECBIT = 18
    REGTRANSFERBIT = 17
    REGWRITEBIT = 16
    
    WORDSIZE = 2<<20
    
    def __init__(self, engine, irlen):
        self._engine = engine
        self._irlen = irlen
        if hasattr(engine._ctrl,'virtual'):
            self.virtual = engine._ctrl.virtual
            self.write_ir = self._engine.write_vir
        else:
            self.virtual = False
            self.write_ir = self._engine.write_ir
    
    def resetdm(self):
        self.write_ir(BitSequence(value = 0x10, length=self._irlen))
        self._engine.write_dr(BitSequence(value = (3<<16), length = 32))
        self._engine.go_idle()
        self._engine.write_dr(BitSequence(value = 0, length = 32))
        self._engine.go_idle() 
        pass
   
    def writeapb(self, adr, data):
        self.write_ir(BitSequence(value = 0x11, length=self._irlen))
        self._engine.write_dr(BitSequence(value = ((adr&0xffff)<<34)| 
        ((data&0xffffffff)<<2)|(2), length = 50))
    
    def readapb(self, adr):
        self.write_ir(BitSequence(value = 0x11, length=self._irlen))
        self._engine.write_dr(BitSequence(value = ((adr&0xffff)<<34)|(1),
         length = 50))
        self._engine.go_idle()        
        for i in range(8):
            self._engine.write_tms(BitSequence(value=0 ,length=7)) 
        val = (int(self._engine.read_dr(50))>>2) & 0xffffffff
        return val
    
    def pushins(self, ins): 
        self.writeapb(ReveOCD.PROGBUFFERREG, ins)
        self.writeapb(ReveOCD.ABSTRACTCMDREG, (1<<ReveOCD.POSTEXECBIT) + ReveOCD.WORDSIZE) 

    def halt(self):
        self.writeapb(ReveOCD.DMCONTROLREG, (1<<ReveOCD.HALTREQBIT) + 1<<ReveOCD.ACTIVEBIT)
        self._engine.go_idle()
        self.writeapb(ReveOCD.DMCONTROLREG, (0<<ReveOCD.HALTREQBIT) + 1<<ReveOCD.ACTIVEBIT) 
        
    def resume(self):
        self.writeapb(ReveOCD.DMCONTROLREG, (1<<ReveOCD.RESUMEREQBIT) + 1<<ReveOCD.ACTIVEBIT)
        self._engine.go_idle()
        self.writeapb(ReveOCD.DMCONTROLREG, (0<<ReveOCD.RESUMEREQBIT) + 1<<ReveOCD.ACTIVEBIT) 
    
    def readreg(self, regnr):
        debugregnr = regnr + 0x1000
        self.writeapb(ReveOCD.ABSTRACTCMDREG, debugregnr + ReveOCD.WORDSIZE + 
        (1<<ReveOCD.REGTRANSFERBIT))
        self._engine.go_idle()
        val = self.readapb(ReveOCD.ABSTRACTDATAREG)  
        return val 
    
    def writereg(self, regnr, val):
        debugregnr = regnr + 0x1000
        self.writeapb(ReveOCD.ABSTRACTDATAREG, val)
        self._engine.go_idle()
        self.writeapb(ReveOCD.ABSTRACTCMDREG, debugregnr + (1<<ReveOCD.REGWRITEBIT) 
        + (1<<ReveOCD.REGTRANSFERBIT) + ReveOCD.WORDSIZE) 
    
    def setreg2(self, regnr, val):
        if inrange(val, 12):
            opcode =  ((val & 0xfff) << 20) + (regnr << 7) +  0x13 #ADDI
            self.pushins(opcode)
        else:
            if (val & 0x800) != 0:
                val += 0x1000
            opcode =  (val & 0xfffff000) + (regnr << 7) +  0x37 #LUI
            self.pushins(opcode)
            opcode =  ((val & 0xfff) << 20) + (regnr << 15) + (regnr << 7) +  0x13 #ADDI
            self.pushins(opcode)  
    
    def writemem(self, adr, val):
        regdst = 1
        if inrange(val, 12):
            opcode =  ((val & 0xfff) << 20) + (regdst << 7) +  0x13 #ADDI
            self.pushins(opcode)
        else:
            if (val & 0x800) != 0:
                val += 0x1000
            opcode =  (val & 0xfffff000) + (regdst << 7) +  0x37 #LUI
            self.pushins(opcode)
            opcode =  ((val & 0xfff) << 20) + (regdst << 15) + (regdst << 7) +  0x13 #ADDI
            self.pushins(opcode) 
        
        regdst = 2
        if inrange(adr, 12):
            opcode =  ((adr & 0xfff) << 20) + (regdst << 7) +  0x13 #ADDI
            self.pushins(opcode)
        else:
            if (adr & 0x800) != 0:
                adr += 0x1000
            opcode =  (adr & 0xfffff000) + (regdst << 7) +  0x37 #LUI
            self.pushins(opcode)
            opcode =  ((adr & 0xfff) << 20) + (regdst << 15) + (regdst << 7) +  0x13 #ADDI
            self.pushins(opcode)
        opcode =  (1 << 20) + (2 << 15) + (2 << 12) +  0x23 #SW
        self.pushins(opcode)
    
    def readmem(self, adr):
        regdst = 1
    
        if inrange(adr, 12):
            opcode =  ((adr & 0xfff) << 20) + (regdst << 7) +  0x13 #ADDI
            self.pushins(opcode)
        else:
            if (adr & 0x800) != 0:
                adr += 0x1000
            opcode =  (adr & 0xfffff000) + (regdst << 7) +  0x37 #LUI
            self.pushins(opcode)
            opcode =  ((adr & 0xfff) << 20) + (regdst << 15) + (regdst << 7) +  0x13 #ADDI
            self.pushins(opcode)
        opcode =  (1 << 15) + (2 << 12) + (1 << 7) + 0x3 #LW
        self.pushins(opcode)
        self._engine.go_idle()
        val = self.readreg(1)
        return val
    
    def setpc(self, val):
        self.writereg(1, val)
        opcode = (1 << 15) +  0x67 #JALR x1
        self.pushins(opcode) 
    