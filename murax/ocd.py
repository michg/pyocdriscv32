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


class MuraxOCD:
    
    HALTREQBIT = 17
    HALTRELEASEBIT = 25
    RESETREQBIT = 16
    RESETRELEASEBIT = 24
   
    
    def __init__(self, engine, irlen):
        self._engine = engine
        self._irlen = irlen

    def resetdm(self):
        pass
    def writecmd(self, adr, data, size, write):
        self._engine.write_ir(BitSequence(value = 0x2, length=self._irlen))
        self._engine.write_dr(BitSequence(value = ((adr&0xffffffff)<<8)| 
        ((data&0xffffffff)<<40)|(write<<72) + (size<<73), length = 75))
    
    def readrsp(self, adr):
        self.writecmd(adr, 0, 2, 0)
        self._engine.write_ir(BitSequence(value = 0x3, length=self._irlen))
        val = int(self._engine.read_dr(34))
        val = (val>>2) & 0xffffffff
        return val
    
    def halt(self):
        self.writecmd(0, 1<<MuraxOCD.HALTREQBIT, 2, 1)
    
    def resume(self):
        self.writecmd(0, 1<<MuraxOCD.HALTRELEASEBIT, 2, 1)
    
    def reset(self):
        self.writecmd(0, 1<<MuraxOCD.RESETREQBIT, 2, 1)
    
    def pushins(self, ins): 
        self.writecmd(4, ins, 2, 1)
     
    def writereg(self, regnr, val):
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
            
    def readreg(self, regnr):
        ins = (regnr <<15) + 0x13 #addi x0,regnr,0
        self.pushins(ins)
        return self.readrsp(4)
   
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
        val = self.readrsp(4)
        return val
 
    def setpc(self, val):
        self.writereg(1, val)
        opcode = (1 << 15) +  0x67 #JALR x1
        self.pushins(opcode)
