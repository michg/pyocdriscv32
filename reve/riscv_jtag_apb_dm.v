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

//a Module riscv_jtag_apb_dm
    //   
    //   JTAG client module that presents an APB master interface
    //   
module riscv_jtag_apb_dm
(
    apb_clock,
    apb_clock__enable,
    jtag_tck,
    jtag_tck__enable,

    apb_response__prdata,
    apb_response__pready,
    apb_response__perr,
    dr_in,
    dr_action,
    ir,
    reset_n,

    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    dr_out,
    dr_tdi_mask
);

    //b Clocks
        //   APB clock signal, asynchronous to JTAG TCK
    input apb_clock;
    input apb_clock__enable;
        //   JTAG TCK signal, used as a clock
    input jtag_tck;
    input jtag_tck__enable;

    //b Inputs
        //   APB response
    input [31:0]apb_response__prdata;
    input apb_response__pready;
    input apb_response__perr;
        //   Data register in; used in update, replaced by dr_out in capture, shift
    input [49:0]dr_in;
        //   Action to perform with DR (capture or update, else ignore)
    input [1:0]dr_action;
        //   JTAG IR which is to be matched against t_jtag_addr
    input [4:0]ir;
        //   Reset that drives all the logic
    input reset_n;

    //b Outputs
        //   APB request out
    output [31:0]apb_request__paddr;
    output apb_request__penable;
    output apb_request__psel;
    output apb_request__pwrite;
    output [31:0]apb_request__pwdata;
        //   Data register out; same as data register in, except during capture when it is replaced by correct data dependent on IR, or shift when it goes right by one
    output [49:0]dr_out;
        //   One-hot mask indicating which DR bit TDI should replace (depends on IR)
    output [49:0]dr_tdi_mask;

// output components here

    //b Output combinatorials
        //   APB request out
    reg [31:0]apb_request__paddr;
    reg apb_request__penable;
    reg apb_request__psel;
    reg apb_request__pwrite;
    reg [31:0]apb_request__pwdata;
        //   Data register out; same as data register in, except during capture when it is replaced by correct data dependent on IR, or shift when it goes right by one
    reg [49:0]dr_out;
        //   One-hot mask indicating which DR bit TDI should replace (depends on IR)
    reg [49:0]dr_tdi_mask;

    //b Output nets

    //b Internal and output registers
    reg [31:0]apb_state__apb_request__paddr;
    reg apb_state__apb_request__penable;
    reg apb_state__apb_request__psel;
    reg apb_state__apb_request__pwrite;
    reg [31:0]apb_state__apb_request__pwdata;
    reg [31:0]apb_state__last_read_data;
    reg apb_state__busy;
    reg apb_state__access_in_progress;
    reg apb_state__ready_ack;
    reg apb_state__complete;
    reg [2:0]apb_state__ready_sync;
    reg [2:0]apb_state__complete_ack_sync;
    reg [1:0]jtag_state__op_status;
    reg [15:0]jtag_state__address;
    reg [31:0]jtag_state__last_read_data;
    reg [31:0]jtag_state__write_data;
    reg jtag_state__write_not_read;
    reg jtag_state__busy;
    reg jtag_state__ready;
    reg jtag_state__complete_ack;
    reg [2:0]jtag_state__ready_ack_sync;
    reg [2:0]jtag_state__complete_sync;

    //b Internal combinatorials
    reg sync_complete_ack;
    reg sync_complete;
    reg sync_ready_ack;
    reg sync_ready;
    reg [1:0]update_action;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b jtag_clock_domain__comb combinatorial process
        //   
        //       Handle the JTAG TAP interface; this provides capture, shift and update actions.
        //   
        //       Capture means set dr_out to the data dependent on ir
        //   
        //       Shift means set dr_out to be dr_in shifted down with tdi inserted
        //       at the correct bit point dependent on the register accessed by ir.
        //   
        //       Update means perform an update (or write) of register ir with given data dr_in
        //   
        //       A request form the JTAG clock domain to the APB clock domain
        //       starts with ready being asserted; in response the APB side
        //       indicates ready_ack, which (when synchronized) permits ready to be
        //       deasserted. At this point the APB side can indicate complete; when
        //       this is seen (synchronized) it is also acknowledged, and when the
        //       complete goes away (the APB side will be idle) the JTAG machine
        //       can also go idle.
        //   
        //       
    always @ ( * )//jtag_clock_domain__comb
    begin: jtag_clock_domain__comb_code
    reg [49:0]dr_out__var;
    reg [49:0]dr_tdi_mask__var;
    reg [1:0]update_action__var;
        dr_out__var = dr_in;
        dr_tdi_mask__var = 50'h0;
        update_action__var = 2'h0;
        case (dr_action) //synopsys parallel_case
        2'h2: // req 1
            begin
            dr_out__var = (dr_in>>64'h1);
            case (ir) //synopsys parallel_case
            5'h1: // req 1
                begin
                dr_tdi_mask__var[31] = 1'h1;
                end
            5'h10: // req 1
                begin
                dr_tdi_mask__var[31] = 1'h1;
                end
            5'h11: // req 1
                begin
                dr_tdi_mask__var[49] = 1'h1;
                end
            default: // req 1
                begin
                dr_tdi_mask__var[0] = 1'h1;
                end
            endcase
            end
        2'h1: // req 1
            begin
            case (ir) //synopsys parallel_case
            5'h1: // req 1
                begin
                dr_out__var[31:0] = 32'habcde6e3;
                end
            5'h10: // req 1
                begin
                dr_out__var = 50'h0;
                dr_out__var[14:12] = 3'h7;
                dr_out__var[11:10] = jtag_state__op_status;
                dr_out__var[9:4] = 6'h10;
                dr_out__var[3:0] = 4'h1;
                end
            5'h11: // req 1
                begin
                dr_out__var = 50'h0;
                dr_out__var[1:0] = jtag_state__op_status;
                dr_out__var[33:2] = jtag_state__last_read_data;
                dr_out__var[49:34] = jtag_state__address;
                if (((jtag_state__busy!=1'h0)&&!(jtag_state__write_not_read!=1'h0)))
                begin
                    dr_out__var[1:0] = 2'h3;
                end //if
                end
            default: // req 1
                begin
                dr_out__var = 50'h0;
                end
            endcase
            end
        2'h3: // req 1
            begin
            case (ir) //synopsys parallel_case
            5'h10: // req 1
                begin
                if ((dr_in[17:16]!=2'h0))
                begin
                    update_action__var = 2'h1;
                end //if
                end
            5'h11: // req 1
                begin
                if ((dr_in[1:0]==2'h1))
                begin
                    update_action__var = 2'h2;
                end //if
                if ((dr_in[1:0]==2'h2))
                begin
                    update_action__var = 2'h3;
                end //if
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
        dr_out = dr_out__var;
        dr_tdi_mask = dr_tdi_mask__var;
        update_action = update_action__var;
    end //always

    //b jtag_clock_domain__posedge_jtag_tck_active_low_reset_n clock process
        //   
        //       Handle the JTAG TAP interface; this provides capture, shift and update actions.
        //   
        //       Capture means set dr_out to the data dependent on ir
        //   
        //       Shift means set dr_out to be dr_in shifted down with tdi inserted
        //       at the correct bit point dependent on the register accessed by ir.
        //   
        //       Update means perform an update (or write) of register ir with given data dr_in
        //   
        //       A request form the JTAG clock domain to the APB clock domain
        //       starts with ready being asserted; in response the APB side
        //       indicates ready_ack, which (when synchronized) permits ready to be
        //       deasserted. At this point the APB side can indicate complete; when
        //       this is seen (synchronized) it is also acknowledged, and when the
        //       complete goes away (the APB side will be idle) the JTAG machine
        //       can also go idle.
        //   
        //       
    always @( posedge jtag_tck or negedge reset_n)
    begin : jtag_clock_domain__posedge_jtag_tck_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            jtag_state__op_status <= 2'h0;
            jtag_state__write_data <= 32'h0;
            jtag_state__address <= 16'h0;
            jtag_state__ready <= 1'h0;
            jtag_state__busy <= 1'h0;
            jtag_state__write_not_read <= 1'h0;
            jtag_state__complete_ack <= 1'h0;
            jtag_state__last_read_data <= 32'h0;
        end
        else if (jtag_tck__enable)
        begin
            case (dr_action) //synopsys parallel_case
            2'h2: // req 1
                begin
                end
            2'h1: // req 1
                begin
                case (ir) //synopsys parallel_case
                5'h1: // req 1
                    begin
                    end
                5'h10: // req 1
                    begin
                    end
                5'h11: // req 1
                    begin
                    if (((jtag_state__busy!=1'h0)&&!(jtag_state__write_not_read!=1'h0)))
                    begin
                        jtag_state__op_status <= 2'h3;
                    end //if
                    end
                default: // req 1
                    begin
                    end
                endcase
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
            if ((update_action==2'h1))
            begin
                jtag_state__op_status <= 2'h0;
            end //if
            if (((update_action==2'h2)||(update_action==2'h3)))
            begin
                if (((jtag_state__busy!=1'h0)||(jtag_state__op_status!=2'h0)))
                begin
                    jtag_state__op_status <= 2'h3;
                end //if
                else
                
                begin
                    jtag_state__write_data <= dr_in[33:2];
                    jtag_state__address <= dr_in[49:34];
                    jtag_state__ready <= 1'h1;
                    jtag_state__busy <= 1'h1;
                    jtag_state__write_not_read <= (update_action==2'h3);
                end //else
            end //if
            if ((jtag_state__busy!=1'h0))
            begin
                if ((sync_ready_ack!=1'h0))
                begin
                    jtag_state__ready <= 1'h0;
                end //if
                if ((sync_complete!=1'h0))
                begin
                    jtag_state__complete_ack <= 1'h1;
                end //if
                else
                
                begin
                    if ((jtag_state__complete_ack!=1'h0))
                    begin
                        jtag_state__complete_ack <= 1'h0;
                        if (!(jtag_state__write_not_read!=1'h0))
                        begin
                            jtag_state__last_read_data <= apb_state__last_read_data;
                        end //if
                        jtag_state__busy <= 1'h0;
                    end //if
                end //else
            end //if
        end //if
    end //always

    //b apb_clock_domain clock process
        //   
        //       APB clock domain logic.
        //   
        //       While a transaction is not in progress monitor sync_ready; when
        //       this occurs, start an APB transaction and acknowledge the ready.
        //   
        //       While a transaction is in progress keep going; keep acknowledging
        //       ready until its acknowledge is seen.  After a transaction has
        //       completed and ready has been taken away, indicate complete; keep
        //       indicating complete until the acknowledge is seen, when the APB
        //       side can then go back to idle.
        //   
        //       
    always @( posedge apb_clock or negedge reset_n)
    begin : apb_clock_domain__code
        if (reset_n==1'b0)
        begin
            apb_state__apb_request__penable <= 1'h0;
            apb_state__apb_request__psel <= 1'h0;
            apb_state__apb_request__pwrite <= 1'h0;
            apb_state__last_read_data <= 32'h0;
            apb_state__access_in_progress <= 1'h0;
            apb_state__ready_ack <= 1'h0;
            apb_state__complete <= 1'h0;
            apb_state__busy <= 1'h0;
            apb_state__apb_request__paddr <= 32'h0;
            apb_state__apb_request__pwdata <= 32'h0;
        end
        else if (apb_clock__enable)
        begin
            if ((apb_state__busy!=1'h0))
            begin
                if ((apb_state__access_in_progress!=1'h0))
                begin
                    apb_state__apb_request__penable <= 1'h1;
                    if (((apb_response__pready!=1'h0)&&(apb_state__apb_request__penable!=1'h0)))
                    begin
                        apb_state__apb_request__penable <= 1'h0;
                        apb_state__apb_request__psel <= 1'h0;
                        apb_state__apb_request__pwrite <= 1'h0;
                        apb_state__last_read_data <= apb_response__prdata;
                        apb_state__access_in_progress <= 1'h0;
                    end //if
                end //if
                if (((apb_state__ready_ack!=1'h0)&&!(sync_ready!=1'h0)))
                begin
                    apb_state__ready_ack <= 1'h0;
                end //if
                else
                
                begin
                    if (!(apb_state__access_in_progress!=1'h0))
                    begin
                        apb_state__complete <= 1'h1;
                        if (((sync_complete_ack!=1'h0)&&(apb_state__complete!=1'h0)))
                        begin
                            apb_state__complete <= 1'h0;
                            apb_state__busy <= 1'h0;
                        end //if
                    end //if
                end //else
            end //if
            else
            
            begin
                if ((sync_ready!=1'h0))
                begin
                    apb_state__ready_ack <= 1'h1;
                    apb_state__busy <= 1'h1;
                    apb_state__access_in_progress <= 1'h1;
                    apb_state__apb_request__paddr <= 32'h0;
                    apb_state__apb_request__paddr[7:0] <= jtag_state__address[7:0];
                    apb_state__apb_request__paddr[23:16] <= jtag_state__address[15:8];
                    apb_state__apb_request__penable <= 1'h0;
                    apb_state__apb_request__psel <= 1'h1;
                    apb_state__apb_request__pwrite <= jtag_state__write_not_read;
                    apb_state__apb_request__pwdata <= jtag_state__write_data;
                end //if
            end //else
        end //if
    end //always

    //b synchronizers__comb combinatorial process
        //   
        //       Synchronizers, which are just simple shift registers (three flops each)
        //   
        //       Also, drive out apb_request from the APB state
        //       
    always @ ( * )//synchronizers__comb
    begin: synchronizers__comb_code
        sync_ready_ack = jtag_state__ready_ack_sync[0];
        sync_complete = jtag_state__complete_sync[0];
        sync_ready = apb_state__ready_sync[0];
        sync_complete_ack = apb_state__complete_ack_sync[0];
        apb_request__paddr = apb_state__apb_request__paddr;
        apb_request__penable = apb_state__apb_request__penable;
        apb_request__psel = apb_state__apb_request__psel;
        apb_request__pwrite = apb_state__apb_request__pwrite;
        apb_request__pwdata = apb_state__apb_request__pwdata;
    end //always

    //b synchronizers__posedge_jtag_tck_active_low_reset_n clock process
        //   
        //       Synchronizers, which are just simple shift registers (three flops each)
        //   
        //       Also, drive out apb_request from the APB state
        //       
    always @( posedge jtag_tck or negedge reset_n)
    begin : synchronizers__posedge_jtag_tck_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            jtag_state__ready_ack_sync <= 3'h0;
            jtag_state__complete_sync <= 3'h0;
        end
        else if (jtag_tck__enable)
        begin
            jtag_state__ready_ack_sync <= (jtag_state__ready_ack_sync>>64'h1);
            jtag_state__ready_ack_sync[2] <= apb_state__ready_ack;
            jtag_state__complete_sync <= (jtag_state__complete_sync>>64'h1);
            jtag_state__complete_sync[2] <= apb_state__complete;
        end //if
    end //always

    //b synchronizers__posedge_apb_clock_active_low_reset_n clock process
        //   
        //       Synchronizers, which are just simple shift registers (three flops each)
        //   
        //       Also, drive out apb_request from the APB state
        //       
    always @( posedge apb_clock or negedge reset_n)
    begin : synchronizers__posedge_apb_clock_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            apb_state__ready_sync <= 3'h0;
            apb_state__complete_ack_sync <= 3'h0;
        end
        else if (apb_clock__enable)
        begin
            apb_state__ready_sync <= (apb_state__ready_sync>>64'h1);
            apb_state__ready_sync[2] <= jtag_state__ready;
            apb_state__complete_ack_sync <= (apb_state__complete_ack_sync>>64'h1);
            apb_state__complete_ack_sync[2] <= jtag_state__complete_ack;
        end //if
    end //always

endmodule // riscv_jtag_apb_dm
