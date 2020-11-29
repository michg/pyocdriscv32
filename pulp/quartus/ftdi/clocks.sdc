
create_clock -name input_clock -period 20.000 [get_ports clk_i]
create_clock -name jtag_clock -period 100.000 [get_ports jtag_tck]


derive_clock_uncertainty
    
set_clock_groups -asynchronous -group {input_clock} -group {jtag_clock}