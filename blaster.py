from pyftdi.bits import BitSequence
from pyftdi.ftdi import Ftdi

TMS = 1<<1
TDI = 1<<4
TDO = 1<<6
TCK = 1<<0

class Blaster:
    def __init__(self, debug=False):
        self.blaster = Ftdi()
        self.virtual = True
        self.blaster.LATENCY_MIN = 1
        self.blaster.open(0x09FB, 0x6001)
        self.blaster.write_data_set_chunksize(1)
        self._last = None  # Last deferred TDO bit
        self.debug = debug
      
    def readwritebit(self, tms, tdi):
        val = tms*TMS + tdi*TDI 
        self.blaster.write_data([val])
        val = tms*TMS + tdi*TDI + TCK + TDO
        self.blaster.write_data([val])
        rd = self.blaster.read_data_bytes(1, attempt=3)
        tdo = ord(rd) & 1
        return tdo 

    def writebit(self, tms, tdi):
        val = tms*TMS + tdi*TDI 
        self.blaster.write_data([val])
        val = tms*TMS + tdi*TDI + TCK
        self.blaster.write_data([val])
    
    def shiftinoutval(self, length, val):
        outval = 0
        if(self.debug):
            print(">>Out{2:d}:0x{0:x}={0:0{1}b}".format(val,length,length));
        for i in range(length):
            bit = val & 1
            tdo = self.readwritebit(0, bit)
            val >>= 1
            outval += tdo<<i
        if(self.debug):
            print(">>In{2:d}:0x{0:x}={0:0{1}b}".format(outval,length,length))
        return outval
        
    
    def shiftinval(self, length, val):
        if(self.debug):
            print(">>Out{2:d}:0x{0:x}={0:0{1}b}".format(val,length,length));
        for i in range(length):
            bit = val & 1
            tdo = self.writebit(0, bit)
            val >>= 1
    
    def write_tms(self, tms, should_read=False):
        """Change the TAP controller state"""
        if not isinstance(tms, BitSequence):
            raise JtagError('Expect a BitSequence')
        tdo = 0
        for val in tms:
            if(self._last is not None):
                if(should_read):
                    if(self.debug):
                        print(">>Tmsout:" + bin(self._last))
                    tdo = self.readwritebit(val, int(self._last))
                    if(self.debug):
                        print(">>Tmsin:" + bin(tdo))
                else:
                    if(self.debug):
                        print(">>Tmsout:" + bin(self._last))
                    self.writebit(val, int(self._last))
            else:
                self.writebit(val, 0)
            should_read = False
            self._last = None
        return BitSequence(tdo, 1)
    
    def reset(self):
        """Reset the attached TAP controller.
           sync sends the command immediately (no caching)
        """
        # we can either send a TRST HW signal or perform 5 cycles with TMS=1
        # to move the remote TAP controller back to 'test_logic_reset'state
        
        # TAP reset (even with HW reset, could be removed though)
        self.write_tms(BitSequence('11111')) 
    
    def write(self, out, use_last=True):
        if not isinstance(out, BitSequence):
            return JtagError('Expect a BitSequence')
        if use_last:
            (out, self._last) = (out[:-1], bool(out[-1]))
        length = len(out)
        self.shiftinval(length, int(out))
        
    def writeread(self, out, use_last=True):
        if not isinstance(out, BitSequence):
            return JtagError('Expect a BitSequence')
        if use_last:
            (out, self._last) = (out[:-1], bool(out[-1]))
        length = len(out)
        bs = BitSequence(value=self.shiftinoutval(length, int(out)), length=length)
        return bs
    
    def read(self, length):
        """Read out a sequence of bits from TDO"""
        bs = BitSequence(value=self.shiftinoutval(length, 0), length=length)
        return bs
    
    def close(self):
        self.blaster.close()