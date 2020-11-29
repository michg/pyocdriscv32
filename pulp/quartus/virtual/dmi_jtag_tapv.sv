/* Copyright 2018 ETH Zurich and University of Bologna.
 * Copyright and related rights are licensed under the Solderpad Hardware
 * License, Version 0.51 (the “License”); you may not use this file except in
 * compliance with the License.  You may obtain a copy of the License at
 * http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
 * or agreed to in writing, software, hardware and materials distributed under
 * this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * File:   dmi_jtag_tap.sv
 * Author: Florian Zaruba <zarubaf@iis.ee.ethz.ch>
 * Date:   19.7.2018
 *
 * Description: JTAG TAP for DMI (according to debug spec 0.13)
 *
 */

module dmi_jtag_tapv #(
    parameter int IrLength = 5,
    // JTAG IDCODE Value
    parameter logic [31:0] IdcodeValue = 32'h00000001
    // xxxx             version
    // xxxxxxxxxxxxxxxx part number
    // xxxxxxxxxxx      manufacturer id
    // 1                required by standard
)(
    output  logic        tck_o,    // JTAG test clock pad
	 output logic         trstn_o,
    //input  logic        tms_i,    // JTAG test mode select pad
    //input  logic        trst_ni,  // JTAG test reset pad
   // input  logic        td_i,     // JTAG test data input pad
   // output logic        td_o,     // JTAG test data output pad
    //output logic        tdo_oe_o, // Data out output enable
    input  logic        testmode_i,
    output logic        test_logic_reset_o,
    output logic        shift_dr_o,
    output logic        update_dr_o,
    output logic        capture_dr_o,

    // we want to access DMI register
    output logic        dmi_access_o,
    // JTAG is interested in writing the DTM CSR register
    output logic        dtmcs_select_o,
    // clear error state
    output logic        dmi_reset_o,
    input  logic [1:0]  dmi_error_i,
    // test data to submodule
    output logic        dmi_tdi_o,
    // test data in from submodule
    input  logic        dmi_tdo_i

);
    logic tdi, tdo, tck;
    // to submodule
    assign dmi_tdi_o = tdi;
    assign tck_o = tck;
	 assign trstn_o = !test_logic_reset_o;
	 
  
    typedef enum logic [IrLength-1:0] {
        BYPASS0   = 5'h0,
        IDCODE    = 5'h1,
        DTMCSR    = 5'h10,
        DMIACCESS = 5'h11,
        BYPASS1   = 5'h1f
    } ir_reg_e;

    typedef struct packed {
        logic [31:18] zero1;
        logic         dmihardreset;
        logic         dmireset;
        logic         zero0;
        logic [14:12] idle;
        logic [11:10] dmistat;
        logic [9:4]   abits;
        logic [3:0]   version;
    } dtmcs_t;
   
  

    // ----------------
    // IR logic
    // ----------------
    logic [IrLength-1:0]  jtag_ir_shift_d, jtag_ir_shift_q, ir_in, ir_out; // shift register
    ir_reg_e              jtag_ir_d, jtag_ir_q; // IR register -> this gets captured from shift register upon update_ir
    logic capture_ir, pause_ir, update_ir, shift_dr, update_dr, capture_dr;
     
    virtual_jtag virtual_jtag_1 (
    .virtual_state_cir    (capture_ir  ), //o
    .virtual_state_uir    (update_ir  ), //o
    .ir_in    (ir_in  ), //o
    .ir_out   (ir_out ), //i
    .virtual_state_cdr    (capture_dr  ), //o
    .virtual_state_sdr    (shift_dr  ), //o
    .virtual_state_udr    (update_dr ), //o
    .tck                  (tck                ), //o
    .tdi                  (tdi                ), //o
    .tdo                  (tdo_mux     ),
   .jtag_state_tlr(test_logic_reset_o)  //i
  ); 

   assign shift_dr_o = shift_dr;
	assign update_dr_o = update_dr;
	assign capture_dr_o = capture_dr;
	
    always_comb begin
        ir_out = 'b0101;
        jtag_ir_d = jtag_ir_q;
        // update IR register
        if (update_ir) begin
            jtag_ir_d = ir_reg_e'(ir_in);
        end
            // synchronous test-logic reset
        if (test_logic_reset_o) begin
            jtag_ir_shift_d = '0;
            jtag_ir_d       = IDCODE;
        end

    end

    always_ff @(posedge tck) begin
         jtag_ir_q       <= jtag_ir_d;
    end

    // ----------------
    // TAP DR Regs
    // ----------------
    // - Bypass
    // - IDCODE
    // - DTM CS
    logic [31:0] idcode_d, idcode_q;
    logic        idcode_select;
    logic        bypass_select;
    dtmcs_t      dtmcs_d, dtmcs_q;
    logic        bypass_d, bypass_q;  // this is a 1-bit register

    assign dmi_reset_o = dtmcs_q.dmireset;

    always_comb begin
        idcode_d = idcode_q;
        bypass_d = bypass_q;
        dtmcs_d  = dtmcs_q;

        if (capture_dr) begin
            if (idcode_select) idcode_d = IdcodeValue;
            if (bypass_select) bypass_d = 1'b0;
            if (dtmcs_select_o) begin
                dtmcs_d  = '{
                                zero1        : '0,
                                dmihardreset : 1'b0,
                                dmireset     : 1'b0,
                                zero0        : '0,
                                idle         : 'd1,         // 1: Enter Run-Test/Idle and leave it immediately
                                dmistat      : dmi_error_i, // 0: No error, 1: Op failed, 2: too fast
                                abits        : 'd7, // The size of address in dmi
                                version      : 'd1  // Version described in spec version 0.13 (and later?)
                            };
            end
        end

        if (shift_dr) begin
            if (idcode_select)  idcode_d = {tdi, idcode_q[31:1]};
            if (bypass_select)  bypass_d = tdi;
            if (dtmcs_select_o) dtmcs_d  = {tdi, dtmcs_q[31:1]};
        end

        if (test_logic_reset_o) begin
            idcode_d = IdcodeValue;
            bypass_d = 1'b0;
        end
    end

    // ----------------
    // Data reg select
    // ----------------
    always_comb begin
        dmi_access_o   = 1'b0;
        dtmcs_select_o = 1'b0;
        idcode_select  = 1'b0;
        bypass_select  = 1'b0;
        case (jtag_ir_q)
            BYPASS0:   bypass_select  = 1'b1;
            IDCODE:    idcode_select  = 1'b1;
            DTMCSR:    dtmcs_select_o = 1'b1;
            DMIACCESS: dmi_access_o   = 1'b1;
            BYPASS1:   bypass_select  = 1'b1;
            default:   bypass_select  = 1'b1;
        endcase
    end

    // ----------------
    // Output select
    // ----------------
    logic tdo_mux;

    always_comb begin
          case (jtag_ir_q)    // synthesis parallel_case
            IDCODE:         tdo_mux = idcode_q[0];     // Reading ID code
            DTMCSR:         tdo_mux = dtmcs_q[0];
            DMIACCESS:      tdo_mux = dmi_tdo_i;       // Read from DMI TDO
            default:        tdo_mux = bypass_q;      // BYPASS instruction
          endcase

    end
 

    always_ff @(posedge tck) begin
            idcode_q    <= idcode_d;
            bypass_q    <= bypass_d;
            dtmcs_q     <= dtmcs_d;
        end
    


endmodule
