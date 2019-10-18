### PyOCD-RISCV32

Generating with a pythonscript JTAG-sequences for the
debug port of different RISCV32 cores:
- [murax](https://github.com/SpinalHDL/VexRiscv)
- [reve](https://github.com/atthecodeface/cdl_hardware)
- [pulpissimo](https://github.com/aignacio/riscv_verilator_model)

using the API of [pyftdi](https://github.com/eblot/pyftdi).

To try it in simulation [verilator](https://www.veripool.org/wiki/verilator) is needed.
For murax do the following:
`cd murax`
Build the simulation:
`make`
Run the simulation:
`obj_dir/vmurax` 
or with tracing enabled:
`obj_dir/vmurax vcd`
Finally run dbgjtag.py:
`python3 dbgjtag murax`