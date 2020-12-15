//a Note: created by CDL 1.4 - do not hand edit without recognizing it will be out of sync with the source
// Output mode 0 (VMOD=1, standard verilog=0)
// Verilog option comb reg suffix '__var'
// Verilog option include_displays 0
// Verilog option include_assertions 1
// Verilog option sv_assertions 0
// Verilog option assert delay string '<NULL>'
// Verilog option include_coverage 0
// Verilog option clock_gate_module_instance_type 'banana'
// Verilog option clock_gate_module_instance_extra_ports ''
// Verilog option use_always_at_star 1
// Verilog option clocks_must_have_enables 1

//a Module jtag_tap
    //   
    //   JTAG TAP controller module that basically implements the JTAG state
    //   machine, holds an IR, and interacts with a client to capture and update data.
    //   
module jtag_tapv
(
    
    tck,
	 tdi,
	 tdo,
	 shift,
	 
    dr_out,
    dr_tdi_mask,
    reset_n,
    dr_in,
    dr_action,
    ir
);

    //b Clocks
        //   JTAG TCK
   

    //b Inputs
        //   DR from client (from client data if capture, shifted if shift)
    input [49:0]dr_out;
        //   One-hot mask indicating where TDI should be inserted (based on DR length, based on IR)
    input [49:0]dr_tdi_mask;
        //   JTAG inputs
        //   Reste for all the logic
    input reset_n;

    //b Outputs
	 output tck;
	 output tdo;
	 output shift;
	 output tdi;
        //   DR to be fed to client
    output [49:0]dr_in;
        //   DR action (capture, update, shift, or none)
    output [1:0]dr_action;
        //   IR register to be used by client
    output reg [4:0]ir;

// output components here
    wire capture_ir, update_ir, capture_d, shift_dr, update_dr, tck, tdi, tdo, reset_o;
	 reg [4:0] ircap;
	 wire [4:0] ir_in;
    
    virtual_jtag virtual_jtag_1 (
    .virtual_state_cir    (capture_ir  ), //o
    .virtual_state_uir    (update_ir  ), //o
    .ir_in    (ir_in  ), //o
    .ir_out   (5'b01010 ), //i
    .virtual_state_cdr    (capture_dr  ), //o
    .virtual_state_sdr    (shift_dr  ), //o
    .virtual_state_udr    (update_dr ), //o
    .tck                  (tck                ), //o
    .tdi                  (tdi                ), //o
    .tdo                  (tdo),
   .jtag_state_tlr(reset_o)  //i
  ); 

  assign tck = tck;
  assign shift = shift_dr;
  reg [49:0]sr;

   always@(posedge tck or posedge reset_o) begin
   if(reset_o) begin
	   ir <= 5'b1;
		sr <= 50'b0;
   end else begin
      if(capture_dr) sr <= dr_out;
      if(shift_dr) begin
			if(tdi) sr <= dr_out | dr_tdi_mask; else sr <= dr_out;
		end
		if(update_ir) ir <= ir_in;
   end
   end
   assign dr_in = sr;
   assign tdo = sr[0];
   assign dr_action = (capture_dr) ? 2'h1: (update_dr) ? 2'h3 : (shift_dr) ? 2'h2: 0;
endmodule // jtag_tap
