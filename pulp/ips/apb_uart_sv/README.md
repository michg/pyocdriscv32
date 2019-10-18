# APB UART (SystemVerilog)

This module implements the basic interface you would expect from a standard TI 16550 UART. It exists because of current incompatibility of Verilator to understand our VHDL based UART. This UART will likely vanish with the release of our uDMA based peripherals.