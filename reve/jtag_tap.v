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
module jtag_tap
(
    jtag_tck,
    jtag_tck__enable,

    dr_out,
    dr_tdi_mask,
    jtag__ntrst,
    jtag__tms,
    jtag__tdi,
    reset_n,

    tdo,
    dr_in,
    dr_action,
    ir
);

    //b Clocks
        //   JTAG TCK
    input jtag_tck;
    input jtag_tck__enable;

    //b Inputs
        //   DR from client (from client data if capture, shifted if shift)
    input [49:0]dr_out;
        //   One-hot mask indicating where TDI should be inserted (based on DR length, based on IR)
    input [49:0]dr_tdi_mask;
        //   JTAG inputs
    input jtag__ntrst;
    input jtag__tms;
    input jtag__tdi;
        //   Reste for all the logic
    input reset_n;

    //b Outputs
        //   JTAG TDO pin
    output tdo;
        //   DR to be fed to client
    output [49:0]dr_in;
        //   DR action (capture, update, shift, or none)
    output [1:0]dr_action;
        //   IR register to be used by client
    output [4:0]ir;

// output components here

    //b Output combinatorials
        //   DR to be fed to client
    reg [49:0]dr_in;
        //   DR action (capture, update, shift, or none)
    reg [1:0]dr_action;
        //   IR register to be used by client
    reg [4:0]ir;

    //b Output nets

    //b Internal and output registers
    reg [3:0]jtag_state__state;
    reg [49:0]jtag_state__sr;
    reg [4:0]jtag_state__ir;
    reg tdo;

    //b Internal combinatorials
    reg [3:0]jtag_combs__next_state;
    reg [49:0]jtag_combs__next_sr;
    reg [1:0]jtag_combs__ir_action;
    reg [1:0]jtag_combs__dr_action;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b wiring__comb combinatorial process
        //   
        //       Wire the outputs to depend on state (dr_action is a state decode)
        //       
    always @ ( * )//wiring__comb
    begin: wiring__comb_code
        ir = jtag_state__ir;
        dr_in = jtag_state__sr[49:0];
        dr_action = jtag_combs__dr_action;
    end //always

    //b wiring__negedge_jtag_tck_active_low_reset_n clock process
        //   
        //       Wire the outputs to depend on state (dr_action is a state decode)
        //       
    always @( negedge jtag_tck or negedge reset_n)
    begin : wiring__negedge_jtag_tck_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            tdo <= 1'h0;
        end
        else if (jtag_tck__enable)
        begin
            tdo <= jtag_state__sr[0];
        end //if
    end //always

    //b jtag_state_machine__comb combinatorial process
        //   
        //       Implement the JTAG state machine, and decode the FSM
        //       
    always @ ( * )//jtag_state_machine__comb
    begin: jtag_state_machine__comb_code
    reg [3:0]jtag_combs__next_state__var;
    reg [1:0]jtag_combs__ir_action__var;
    reg [1:0]jtag_combs__dr_action__var;
        jtag_combs__next_state__var = jtag_state__state;
        jtag_combs__ir_action__var = 2'h0;
        jtag_combs__dr_action__var = 2'h0;
        case (jtag_state__state) //synopsys parallel_case
        4'h0: // req 1
            begin
            if (!(jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h1;
            end //if
            end
        4'h1: // req 1
            begin
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h2;
            end //if
            end
        4'h2: // req 1
            begin
            jtag_combs__next_state__var = 4'h4;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h3;
            end //if
            end
        4'h3: // req 1
            begin
            jtag_combs__next_state__var = 4'ha;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h0;
            end //if
            end
        4'h4: // req 1
            begin
            jtag_combs__dr_action__var = 2'h1;
            jtag_combs__next_state__var = 4'h5;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h6;
            end //if
            end
        4'h5: // req 1
            begin
            jtag_combs__dr_action__var = 2'h2;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h6;
            end //if
            end
        4'h6: // req 1
            begin
            jtag_combs__next_state__var = 4'h7;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h9;
            end //if
            end
        4'h7: // req 1
            begin
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h8;
            end //if
            end
        4'h8: // req 1
            begin
            jtag_combs__next_state__var = 4'h5;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h9;
            end //if
            end
        4'h9: // req 1
            begin
            jtag_combs__dr_action__var = 2'h3;
            jtag_combs__next_state__var = 4'h1;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h2;
            end //if
            end
        4'ha: // req 1
            begin
            jtag_combs__ir_action__var = 2'h1;
            jtag_combs__next_state__var = 4'hb;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'hc;
            end //if
            end
        4'hb: // req 1
            begin
            jtag_combs__ir_action__var = 2'h2;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'hc;
            end //if
            end
        4'hc: // req 1
            begin
            jtag_combs__next_state__var = 4'hd;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'hf;
            end //if
            end
        4'hd: // req 1
            begin
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'he;
            end //if
            end
        4'he: // req 1
            begin
            jtag_combs__next_state__var = 4'hb;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'hf;
            end //if
            end
        4'hf: // req 1
            begin
            jtag_combs__ir_action__var = 2'h3;
            jtag_combs__next_state__var = 4'h1;
            if ((jtag__tms!=1'h0))
            begin
                jtag_combs__next_state__var = 4'h2;
            end //if
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:jtag_tap:jtag_state_machine: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        jtag_combs__next_state = jtag_combs__next_state__var;
        jtag_combs__ir_action = jtag_combs__ir_action__var;
        jtag_combs__dr_action = jtag_combs__dr_action__var;
    end //always

    //b jtag_state_machine__posedge_jtag_tck_active_low_reset_n clock process
        //   
        //       Implement the JTAG state machine, and decode the FSM
        //       
    always @( posedge jtag_tck or negedge reset_n)
    begin : jtag_state_machine__posedge_jtag_tck_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            jtag_state__state <= 4'h0;
        end
        else if (jtag_tck__enable)
        begin
            jtag_state__state <= jtag_combs__next_state;
        end //if
    end //always

    //b jtag_action__comb combinatorial process
        //   
        //       Handle JTAG action to update shift register and IR
        //       
    always @ ( * )//jtag_action__comb
    begin: jtag_action__comb_code
    reg [49:0]jtag_combs__next_sr__var;
        jtag_combs__next_sr__var = jtag_state__sr;
        case (jtag_combs__ir_action) //synopsys parallel_case
        2'h1: // req 1
            begin
            jtag_combs__next_sr__var = 50'h0;
            jtag_combs__next_sr__var[4:0] = jtag_state__ir;
            end
        2'h2: // req 1
            begin
            jtag_combs__next_sr__var = (jtag_state__sr>>64'h1);
            jtag_combs__next_sr__var[4] = jtag__tdi;
            end
        2'h3: // req 1
            begin
            end
        //synopsys  translate_off
        //pragma coverage off
        //synopsys  translate_on
        default:
            begin
            //Need a default case to make Cadence Lint happy, even though this is not a full case
            end
        //synopsys  translate_off
        //pragma coverage on
        //synopsys  translate_on
        endcase
        if ((jtag_combs__dr_action!=2'h0))
        begin
            jtag_combs__next_sr__var = 50'h0;
            jtag_combs__next_sr__var[49:0] = dr_out;
            if ((jtag__tdi!=1'h0))
            begin
                jtag_combs__next_sr__var[49:0] = (dr_out | dr_tdi_mask);
            end //if
        end //if
        jtag_combs__next_sr = jtag_combs__next_sr__var;
    end //always

    //b jtag_action__posedge_jtag_tck_active_low_reset_n clock process
        //   
        //       Handle JTAG action to update shift register and IR
        //       
    always @( posedge jtag_tck or negedge reset_n)
    begin : jtag_action__posedge_jtag_tck_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            jtag_state__ir <= 5'h0;
            jtag_state__sr <= 50'h0;
        end
        else if (jtag_tck__enable)
        begin
            if ((jtag_state__state==4'h0))
            begin
                jtag_state__ir <= 5'h1;
            end //if
            case (jtag_combs__ir_action) //synopsys parallel_case
            2'h1: // req 1
                begin
                end
            2'h2: // req 1
                begin
                end
            2'h3: // req 1
                begin
                jtag_state__ir <= jtag_state__sr[4:0];
                end
            //synopsys  translate_off
            //pragma coverage off
            //synopsys  translate_on
            default:
                begin
                //Need a default case to make Cadence Lint happy, even though this is not a full case
                end
            //synopsys  translate_off
            //pragma coverage on
            //synopsys  translate_on
            endcase
            jtag_state__sr <= jtag_combs__next_sr;
        end //if
    end //always

endmodule // jtag_tap
