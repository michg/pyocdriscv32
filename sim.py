from socket import *
from pyftdi.bits import BitSequence

class JtagSimController:
    """JTAG master of an FTDI device"""
    
    # Private API
    def __init__(self, debug=False):
        """
        trst uses the nTRST optional JTAG line to hard-reset the TAP
          controller
        """
        self.virtual = False
        self.s = socket(AF_INET, SOCK_STREAM)
        self._last = None  # Last deferred TDO bit
        self.debug = debug
        
    
    def readwritebit(self, tms, tdi):
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
        
    writebit = readwritebit

    def shiftinoutval(self, length, inval):
        outval = 0
        for i in range(length):
            bit = inval & 1
            tdo = self.readwritebit(0, bit)
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
    
    def write_tms(self, tms, should_read=False):
        """Change the TAP controller state"""
        if not isinstance(tms, BitSequence):
            raise JtagError('Expect a BitSequence')
        tdo = 0
        for val in tms:
            if(self._last):
                if(self.debug):
                    print(">>Tmsout:" + bin(val))
                if(should_read):
                    tdo = self.readwritebit(val,1)
                    if(self.debug):
                        print(">>Tmsin:" + bin(tdo))
                else:
                    self.writebit(val, 1)
            else:
                if(should_read):
                    tdo = self.readwritebit(val,0)
                    if(self.debug):
                        print(">>Tmsin:" + bin(tdo))
                else:
                    self.writebit(val, 0)
            should_read = False
            self._last = None
        return BitSequence(tdo, 1) 

    def read(self, length):
        """Read out a sequence of bits from TDO"""
        bs = BitSequence(value=self.shiftinoutval(length, 0), length=length)
        return bs

    def write(self, out, use_last=True):
        if not isinstance(out, BitSequence):
            return JtagError('Expect a BitSequence')
        if use_last:
            (out, self._last) = (out[:-1], bool(out[-1]))
        length = len(out)
        self.shiftinoutval(length, int(out))
    
    def writeread(self, out, use_last=True):
        if not isinstance(out, BitSequence):
            return JtagError('Expect a BitSequence')
        if use_last:
            (out, self._last) = (out[:-1], bool(out[-1]))
        length = len(out)
        bs = BitSequence(value=self.shiftinoutval(length, int(out)), length=length)
        return bs


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

