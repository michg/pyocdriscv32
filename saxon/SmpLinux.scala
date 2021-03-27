package saxon.board.smplinux

import java.awt.image.BufferedImage
import java.awt.{Color, Dimension, Graphics}

import javax.swing.{JFrame, JPanel, WindowConstants}
import saxon.common.I2cModel
import saxon._
import spinal.core._
import spinal.core.sim._
import spinal.lib.blackbox.xilinx.s7.{BSCANE2, BUFG, STARTUPE2}
import spinal.lib.bus.bmb._
import spinal.lib.bus.bsb.BsbInterconnectGenerator
import spinal.lib.bus.misc.{AddressMapping, SizeMapping}
import spinal.lib.bus.simple.{PipelinedMemoryBus, PipelinedMemoryBusDecoder}
import spinal.lib.com.eth.{MacEthParameter, PhyParameter}
import spinal.lib.com.jtag.sim.JtagTcp
import spinal.lib.com.jtag.{Jtag, JtagTap, JtagTapDebuggerGenerator, JtagTapInstructionCtrl}
import spinal.lib.com.jtag.xilinx.Bscane2BmbMasterGenerator
import spinal.lib.com.spi.ddr.{SpiXdrMasterCtrl, SpiXdrParameter}
import spinal.lib.com.uart.UartCtrlMemoryMappedConfig
import spinal.lib.com.uart.sim.{UartDecoder, UartEncoder}
import spinal.lib.generator._
import spinal.lib.graphic.RgbConfig
import spinal.lib.graphic.vga.{BmbVgaCtrlGenerator, BmbVgaCtrlParameter, Vga}
import spinal.lib.io.{Gpio, InOutWrapper}
import spinal.lib.memory.sdram.sdr._
import spinal.lib.memory.sdram.xdr.CoreParameter
import spinal.lib.memory.sdram.xdr.phy.{Ecp5Sdrx2Phy, XilinxS7Phy, SdrInferedPhy}
import spinal.lib.misc.analog.{BmbBsbToDeltaSigmaGenerator, BsbToDeltaSigmaParameter}
import spinal.lib.system.dma.sg.{DmaMemoryLayout, DmaSgGenerator}
import vexriscv.demo.smp.VexRiscvSmpClusterGen
import vexriscv.plugin.AesPlugin



class SmpLinuxAbstract(cpuCount : Int) extends VexRiscvClusterGenerator(cpuCount){
  val fabric = withDefaultFabric()



  val uartA = BmbUartGenerator(0x10000)
  uartA.connectInterrupt(plic, 1)



  implicit val bsbInterconnect = BsbInterconnectGenerator()

  val ramA = BmbOnChipRamGenerator(0xA00000l)
  ramA.hexOffset = bmbPeripheral.mapping.lowerBound
  ramA.dataWidth.load(32)
  interconnect.addConnection(bmbPeripheral.bmb, ramA.ctrl)

  interconnect.addConnection(
      fabric.iBus.bmb -> List(bmbPeripheral.bmb),
      fabric.dBus.bmb -> List(bmbPeripheral.bmb)
  )
}

class SmpLinux(cpuCount : Int) extends Component{
  // Define the clock domains used by the SoC
  val debugCd = ClockDomainResetGenerator()
  debugCd.holdDuration.load(4095)
  debugCd.enablePowerOnReset()


  val sdramCd = ClockDomainResetGenerator()
  sdramCd.holdDuration.load(63)
  sdramCd.asyncReset(debugCd) 

  val systemCd = ClockDomainResetGenerator()
  systemCd.holdDuration.load(63)
  systemCd.asyncReset(sdramCd)
  systemCd.setInput(
    debugCd.outputClockDomain,
    omitReset = true
  )

  val system = systemCd.outputClockDomain on new SmpLinuxAbstract(cpuCount){
  }
  //val debug = system.withDebugBus(debugCd.outputClockDomain, sdramCd, 0x10B80000).withJtag()
  val debug = system.withDebugBus(debugCd.outputClockDomain, sdramCd, 0x10B80000).withVJtag()



  //Manage clocks and PLL
  val clocking =  new Area{
    val GCLK25 = in Bool()
    val XRST = in Bool()
   
    debugCd.setInput(
      ClockDomain(
        clock = GCLK25,
        //reset = ~XRST,
        frequency = FixedFrequency(50 MHz)
      )
    )
    sdramCd.setInput(
      ClockDomain(
        clock = GCLK25,
        frequency = FixedFrequency(50 MHz)
      )
    )

  } 
}

object SmpLinuxAbstract{
  def default(g : SmpLinuxAbstract) = g.rework {
    import g._



    // Configure the CPUs
    for((cpu, coreId) <- cores.zipWithIndex) {
      cpu.config.load(VexRiscvSmpClusterGen.vexRiscvConfig(
        hartId = coreId,
        ioRange = _ (31 downto 28) === 0x1,
        resetVector = 0x10A00000l,
        iBusWidth = 64,
        dBusWidth = 64
      ))
      //cpu.config.plugins += AesPlugin()
    }

    // Configure the peripherals
    ramA.size.load(64 KiB)
    //ramA.hexInit.load("Smplinux.hex")
    ramA.hexInit.loadNothing()


    uartA.parameter load UartCtrlMemoryMappedConfig(
      baudrate = 115200,
      txFifoDepth = 128,
      rxFifoDepth = 128
    )

 

    // Add some interconnect pipelining to improve FMax
    for(cpu <- cores) interconnect.setPipelining(cpu.dBus)(cmdValid = true, invValid = true, ackValid = true, syncValid = true)
    interconnect.setPipelining(fabric.exclusiveMonitor.input)(cmdValid = true, cmdReady = true, rspValid = true)
    interconnect.setPipelining(fabric.invalidationMonitor.output)(cmdValid = true, cmdReady = true, rspValid = true)
    interconnect.setPipelining(bmbPeripheral.bmb)(cmdHalfRate = true, rspHalfRate = true)
    interconnect.setPipelining(fabric.iBus.bmb)(cmdValid = true)

    g
  }
}


object SmpLinux {
  //Function used to configure the SoC
  def default(g : SmpLinux) = g.rework{
    import g._

    SmpLinuxAbstract.default(system)
    g
  }

  //Generate the SoC
  def main(args: Array[String]): Unit = {
    val cpuCount = sys.env.apply("SAXON_CPU_COUNT").toInt

    val report = SpinalRtlConfig
      .copy(
        defaultConfigForClockDomains = ClockDomainConfig(resetKind = SYNC),
        inlineRom = false
      )//.addStandardMemBlackboxing(blackboxByteEnables)
       .generateVerilog(InOutWrapper(default(new SmpLinux(cpuCount))))
    BspGenerator("digilent/SmpLinux", report.toplevel, report.toplevel.system.cores(0).dBus)
  }
}





