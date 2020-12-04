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



class PulpOCD:
    DMCONTROLREG = 0x10
    ABSTRACTCMDREG = 0x17
    PROGBUFFERREG = 0x20
    ABSTRACTDATAREG = 0x4
    SYSTEMBUSCONTROLREG = 0x38
    SYSTEMBUSADR0 = 0x39
    SYSTEMBUSDATA0 = 0x3c
    
    HALTREQBIT = 31
    RESUMEREQBIT = 30
    ACTIVEBIT = 0
    POSTEXECBIT = 18
    REGTRANSFERBIT = 17
    REGWRITEBIT = 16
    BUSREADONADDRBIT = 20
    
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
        self.writeapb(PulpOCD.DMCONTROLREG, (1<<PulpOCD.ACTIVEBIT))
        self._engine.go_idle()

    def writeapb(self, adr, data):
        self.write_ir(BitSequence(value = 0x11, length=self._irlen))
        self._engine.write_dr(BitSequence(value = ((adr&0xffff)<<34)| 
        ((data&0xffffffff)<<2)|(2), length = 41))
        self._engine.go_idle()
        for i in range(2):
            self._engine.write_tms(BitSequence(value=0 ,length=5))
    
    def readapb(self, adr):
        self.write_ir(BitSequence(value = 0x11, length=self._irlen))
        self._engine.write_dr(BitSequence(value = ((adr&0xffff)<<34)|(1),
         length = 41))
        self._engine.go_idle()
        for i in range(3):
            self._engine.write_tms(BitSequence(value=0 ,length=7))
        val = int(self._engine.read_dr(41))
        val = (val>>2) & 0xffffffff        
        return val
    
    def pushins(self, ins, pos=0, last=False): 
        self.writeapb(PulpOCD.PROGBUFFERREG + pos, ins)
        if last:
            ins = 0x00100073 #ebreak
            self.writeapb(PulpOCD.PROGBUFFERREG + pos + 1, ins)

    def execins(self):
        self.writeapb(PulpOCD.ABSTRACTCMDREG, (1<<PulpOCD.POSTEXECBIT) + PulpOCD.WORDSIZE) 

    def halt(self):
        self.writeapb(PulpOCD.DMCONTROLREG, (1<<PulpOCD.HALTREQBIT) + (1<<PulpOCD.ACTIVEBIT))
        self._engine.go_idle()
        self.writeapb(PulpOCD.DMCONTROLREG, (0<<PulpOCD.HALTREQBIT) + (1<<PulpOCD.ACTIVEBIT)) 
        
    def resume(self):
        self.writeapb(PulpOCD.DMCONTROLREG, (1<<PulpOCD.RESUMEREQBIT) + (1<<PulpOCD.ACTIVEBIT))
        self._engine.go_idle()
        self.writeapb(PulpOCD.DMCONTROLREG, (0<<PulpOCD.RESUMEREQBIT) + (1<<PulpOCD.ACTIVEBIT)) 
    
    def readreg(self, regnr):
        debugregnr = regnr + 0x1000
        self.writeapb(PulpOCD.ABSTRACTCMDREG, debugregnr + PulpOCD.WORDSIZE + 
        (1<<PulpOCD.REGTRANSFERBIT))
        self._engine.go_idle()
        for i in range(9):
            self._engine.write_tms(BitSequence(value=0 ,length=7))  
        val = self.readapb(PulpOCD.ABSTRACTDATAREG)  
        return val 
    
    def writereg(self, regnr, val):
        debugregnr = regnr + 0x1000
        self.writeapb(PulpOCD.ABSTRACTDATAREG, val)
        self._engine.go_idle()
        self.writeapb(PulpOCD.ABSTRACTCMDREG, debugregnr + (1<<PulpOCD.REGWRITEBIT) 
        + (1<<PulpOCD.REGTRANSFERBIT) + PulpOCD.WORDSIZE) 
    
    def readbus(self, adr):
        WORDSIZE = 2
        self.writeapb(PulpOCD.SYSTEMBUSCONTROLREG, (WORDSIZE<<17) + (1<<PulpOCD.BUSREADONADDRBIT))
        self.writeapb(PulpOCD.SYSTEMBUSADR0, adr)
        self._engine.go_idle()
        for i in range(9):
            self._engine.write_tms(BitSequence(value=0 ,length=7)) 
        val = self.readapb(PulpOCD.SYSTEMBUSDATA0)# & (1<<((WORDSIZE + 1)*8) - 1)
        return val
    
    readmem = readbus
    
    def setpc(self, val):
        debugregnr = 0x7b1
        self.writeapb(PulpOCD.ABSTRACTDATAREG, val)
        self._engine.go_idle()
        self.writeapb(PulpOCD.ABSTRACTCMDREG, debugregnr + (1<<PulpOCD.REGWRITEBIT) 
        + (1<<PulpOCD.REGTRANSFERBIT) + PulpOCD.WORDSIZE) 
    
    def writebus(self, adr, val):
        WORDSIZE = 2
        self.writeapb(PulpOCD.SYSTEMBUSCONTROLREG, (WORDSIZE<<17))
        self.writeapb(PulpOCD.SYSTEMBUSADR0, adr)
        self.writeapb(PulpOCD.SYSTEMBUSDATA0, val) 
    
    writemem = writebus
    
    def setreg2(self, regnr, val):
        if inrange(val, 12):
            opcode =  ((val & 0xfff) << 20) + (regnr << 7) +  0x13 #ADDI
            self.pushins(opcode, 0 , True)
            self.execins() 
        else:
            if (val & 0x800) != 0:
                val += 0x1000
            opcode =  (val & 0xfffff000) + (regnr << 7) +  0x37 #LUI
            self.pushins(opcode, 0)
            opcode =  ((val & 0xfff) << 20) + (regnr << 15) + (regnr << 7) +  0x13 #ADDI
            self.pushins(opcode, 1, True)  
            self.execins()

        
