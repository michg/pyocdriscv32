### PyOCD-RISCV32

Generating with a pythonscript JTAG-sequences for the
debug port of different RISCV32 cores:

- [murax](https://github.com/SpinalHDL/VexRiscv)
- [saxonsoc](https://github.com/SpinalHDL/SaxonSoc)
- [reve](https://github.com/atthecodeface/cdl_hardware)
- [pulpissimo](https://github.com/aignacio/riscv_verilator_model)

using the API of [pyftdi](https://github.com/eblot/pyftdi).

To try it in simulation [verilator](https://www.veripool.org/wiki/verilator) is needed.
For pulp do the following:
Build the firmware pulp.bin:
`python3 mkfw.py pulp floathw rvf` 

Build the simulation:
`cd pulp`
`make all`
Run the simulation:
`output_verilator/riscv_soc` 
or with tracing enabled:
`output_verilator/riscv_soc vcd`
Finally run dbgjtag.py:
`python3 dbgjtag.py s pulp`

To use it on real hardware
(with an [ARM-USB-TINY-H](https://www.olimex.com/Products/ARM/JTAG/ARM-USB-TINY-H/)):
`python3 dbgjtag.py f pulp`

with an USB-Blaster and virtual JTAG:
`python3 dbgjtag.py v murax`
