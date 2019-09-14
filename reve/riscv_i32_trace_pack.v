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

//a Module riscv_i32_trace_pack
    //   
    //   Packs an instruction trace according to the control passed in
    //   
module riscv_i32_trace_pack
(
    clk,
    clk__enable,

    trace__instr_valid,
    trace__mode,
    trace__instr_pc,
    trace__instruction,
    trace__branch_taken,
    trace__branch_target,
    trace__trap,
    trace__ret,
    trace__jalr,
    trace__rfw_retire,
    trace__rfw_data_valid,
    trace__rfw_rd,
    trace__rfw_data,
    trace__bkpt_valid,
    trace__bkpt_reason,
    trace_control__enable,
    trace_control__enable_control,
    trace_control__enable_pc,
    trace_control__enable_rfd,
    trace_control__enable_breakpoint,
    trace_control__valid,
    reset_n,

    packed_trace__seq_valid,
    packed_trace__seq,
    packed_trace__nonseq_valid,
    packed_trace__nonseq,
    packed_trace__bkpt_valid,
    packed_trace__bkpt,
    packed_trace__data_valid,
    packed_trace__data_reason,
    packed_trace__data,
    packed_trace__compressed_data_nybble,
    packed_trace__compressed_data_num_bytes
);

    //b Clocks
        //   Free-running clock
    input clk;
    input clk__enable;

    //b Inputs
        //   Trace signals
    input trace__instr_valid;
    input [2:0]trace__mode;
    input [31:0]trace__instr_pc;
    input [31:0]trace__instruction;
    input trace__branch_taken;
    input [31:0]trace__branch_target;
    input trace__trap;
    input trace__ret;
    input trace__jalr;
    input trace__rfw_retire;
    input trace__rfw_data_valid;
    input [4:0]trace__rfw_rd;
    input [31:0]trace__rfw_data;
    input trace__bkpt_valid;
    input [3:0]trace__bkpt_reason;
        //   Control of trace
    input trace_control__enable;
    input trace_control__enable_control;
    input trace_control__enable_pc;
    input trace_control__enable_rfd;
    input trace_control__enable_breakpoint;
    input trace_control__valid;
        //   Active low reset
    input reset_n;

    //b Outputs
        //   Packed trace
    output packed_trace__seq_valid;
    output [2:0]packed_trace__seq;
    output packed_trace__nonseq_valid;
    output [1:0]packed_trace__nonseq;
    output packed_trace__bkpt_valid;
    output [3:0]packed_trace__bkpt;
    output packed_trace__data_valid;
    output packed_trace__data_reason;
    output [39:0]packed_trace__data;
    output [2:0]packed_trace__compressed_data_nybble;
    output [3:0]packed_trace__compressed_data_num_bytes;

// output components here

    //b Output combinatorials
        //   Packed trace
    reg packed_trace__seq_valid;
    reg [2:0]packed_trace__seq;
    reg packed_trace__nonseq_valid;
    reg [1:0]packed_trace__nonseq;
    reg packed_trace__bkpt_valid;
    reg [3:0]packed_trace__bkpt;
    reg packed_trace__data_valid;
    reg packed_trace__data_reason;
    reg [39:0]packed_trace__data;
    reg [2:0]packed_trace__compressed_data_nybble;
    reg [3:0]packed_trace__compressed_data_num_bytes;

    //b Output nets

    //b Internal and output registers
    reg trace_state__enabled;
    reg trace_state__pc_required;
    reg trace_state__packed_trace__seq_valid;
    reg [2:0]trace_state__packed_trace__seq;
    reg trace_state__packed_trace__nonseq_valid;
    reg [1:0]trace_state__packed_trace__nonseq;
    reg trace_state__packed_trace__bkpt_valid;
    reg [3:0]trace_state__packed_trace__bkpt;
    reg trace_state__packed_trace__data_valid;
    reg trace_state__packed_trace__data_reason;
    reg [39:0]trace_state__packed_trace__data;
    reg [2:0]trace_state__packed_trace__compressed_data_nybble;
    reg [3:0]trace_state__packed_trace__compressed_data_num_bytes;

    //b Internal combinatorials
    reg [2:0]trace_combs__current_seq;
    reg [2:0]trace_combs__next_seq;
    reg trace_combs__next_seq_valid;
    reg trace_combs__next_nonseq_valid;
    reg trace_combs__next_bkpt_valid;
    reg trace_combs__next_data_valid;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b compressed_trace_out combinatorial process
        //   
        //       Present the state - but bytes_valid is combinatorial from the state
        //       
    always @ ( * )//compressed_trace_out
    begin: compressed_trace_out__comb_code
    reg [3:0]packed_trace__compressed_data_num_bytes__var;
        packed_trace__seq_valid = trace_state__packed_trace__seq_valid;
        packed_trace__seq = trace_state__packed_trace__seq;
        packed_trace__nonseq_valid = trace_state__packed_trace__nonseq_valid;
        packed_trace__nonseq = trace_state__packed_trace__nonseq;
        packed_trace__bkpt_valid = trace_state__packed_trace__bkpt_valid;
        packed_trace__bkpt = trace_state__packed_trace__bkpt;
        packed_trace__data_valid = trace_state__packed_trace__data_valid;
        packed_trace__data_reason = trace_state__packed_trace__data_reason;
        packed_trace__data = trace_state__packed_trace__data;
        packed_trace__compressed_data_nybble = trace_state__packed_trace__compressed_data_nybble;
        packed_trace__compressed_data_num_bytes__var = trace_state__packed_trace__compressed_data_num_bytes;
        packed_trace__compressed_data_num_bytes__var = 4'h4;
        if ((packed_trace__data[39:32]==8'h0))
        begin
            packed_trace__compressed_data_num_bytes__var = 4'h3;
        end //if
        if ((packed_trace__data[39:24]==16'h0))
        begin
            packed_trace__compressed_data_num_bytes__var = 4'h2;
        end //if
        if ((packed_trace__data[39:16]==24'h0))
        begin
            packed_trace__compressed_data_num_bytes__var = 4'h1;
        end //if
        if ((packed_trace__data[39:8]==32'h0))
        begin
            packed_trace__compressed_data_num_bytes__var = 4'h0;
        end //if
        packed_trace__compressed_data_num_bytes = packed_trace__compressed_data_num_bytes__var;
    end //always

    //b trace_state_logic__comb combinatorial process
        //   
        //       Probably a trap can happen even if trace.instr_valid is not asserted
        //       
    always @ ( * )//trace_state_logic__comb
    begin: trace_state_logic__comb_code
    reg [2:0]trace_combs__current_seq__var;
    reg [2:0]trace_combs__next_seq__var;
    reg trace_combs__next_seq_valid__var;
    reg trace_combs__next_nonseq_valid__var;
    reg trace_combs__next_bkpt_valid__var;
    reg trace_combs__next_data_valid__var;
        trace_combs__current_seq__var = trace_state__packed_trace__seq;
        if ((trace_state__packed_trace__seq_valid!=1'h0))
        begin
            trace_combs__current_seq__var = 3'h0;
        end //if
        trace_combs__next_seq__var = trace_combs__current_seq__var;
        trace_combs__next_seq_valid__var = 1'h0;
        trace_combs__next_nonseq_valid__var = 1'h0;
        trace_combs__next_bkpt_valid__var = 1'h0;
        trace_combs__next_data_valid__var = 1'h0;
        if (((trace_state__enabled!=1'h0)&&(trace_control__valid!=1'h0)))
        begin
            if ((trace__bkpt_valid!=1'h0))
            begin
                trace_combs__next_bkpt_valid__var = 1'h1;
            end //if
            if (((trace_control__enable_rfd!=1'h0)&&(trace__rfw_data_valid!=1'h0)))
            begin
                trace_combs__next_data_valid__var = 1'h1;
            end //if
            if ((trace__instr_valid!=1'h0))
            begin
                if (((((trace__branch_taken | trace__jalr) | trace__trap) | trace__ret)!=1'h0))
                begin
                    trace_combs__next_nonseq_valid__var = 1'h1;
                    trace_combs__next_seq_valid__var = (trace_combs__current_seq__var!=3'h0);
                end //if
                trace_combs__next_seq__var = (trace_combs__current_seq__var+3'h1);
                if ((trace_combs__current_seq__var==3'h6))
                begin
                    trace_combs__next_seq_valid__var = 1'h1;
                end //if
                if (((trace_control__enable_pc!=1'h0)&&(trace_state__pc_required!=1'h0)))
                begin
                    trace_combs__next_data_valid__var = 1'h1;
                end //if
            end //if
        end //if
        if (!(trace_control__enable_breakpoint!=1'h0))
        begin
            trace_combs__next_bkpt_valid__var = 1'h0;
        end //if
        if (!(trace_control__enable_control!=1'h0))
        begin
            trace_combs__next_seq_valid__var = 1'h0;
            trace_combs__next_nonseq_valid__var = 1'h0;
        end //if
        trace_combs__current_seq = trace_combs__current_seq__var;
        trace_combs__next_seq = trace_combs__next_seq__var;
        trace_combs__next_seq_valid = trace_combs__next_seq_valid__var;
        trace_combs__next_nonseq_valid = trace_combs__next_nonseq_valid__var;
        trace_combs__next_bkpt_valid = trace_combs__next_bkpt_valid__var;
        trace_combs__next_data_valid = trace_combs__next_data_valid__var;
    end //always

    //b trace_state_logic__posedge_clk_active_low_reset_n clock process
        //   
        //       Probably a trap can happen even if trace.instr_valid is not asserted
        //       
    always @( posedge clk or negedge reset_n)
    begin : trace_state_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            trace_state__packed_trace__seq <= 3'h0;
            trace_state__packed_trace__bkpt <= 4'h0;
            trace_state__packed_trace__data_reason <= 1'h0;
            trace_state__packed_trace__data <= 40'h0;
            trace_state__packed_trace__compressed_data_num_bytes <= 4'h0;
            trace_state__pc_required <= 1'h0;
            trace_state__pc_required <= 1'h1;
            trace_state__packed_trace__nonseq <= 2'h0;
            trace_state__packed_trace__seq_valid <= 1'h0;
            trace_state__packed_trace__nonseq_valid <= 1'h0;
            trace_state__packed_trace__bkpt_valid <= 1'h0;
            trace_state__packed_trace__data_valid <= 1'h0;
            trace_state__packed_trace__compressed_data_nybble <= 3'h0;
            trace_state__enabled <= 1'h0;
        end
        else if (clk__enable)
        begin
            if ((trace_state__packed_trace__seq_valid!=1'h0))
            begin
                trace_state__packed_trace__seq <= 3'h0;
            end //if
            if (((trace_state__enabled!=1'h0)&&(trace_control__valid!=1'h0)))
            begin
                if ((trace__bkpt_valid!=1'h0))
                begin
                    trace_state__packed_trace__bkpt <= trace__bkpt_reason;
                end //if
                if (((trace_control__enable_rfd!=1'h0)&&(trace__rfw_data_valid!=1'h0)))
                begin
                    trace_state__packed_trace__data_reason <= 1'h1;
                    trace_state__packed_trace__data <= {{trace__rfw_data,3'h0},trace__rfw_rd};
                    trace_state__packed_trace__compressed_data_num_bytes <= 4'h0;
                end //if
                if ((trace__instr_valid!=1'h0))
                begin
                    trace_state__pc_required <= 1'h0;
                    if (((((trace__branch_taken | trace__jalr) | trace__trap) | trace__ret)!=1'h0))
                    begin
                        trace_state__pc_required <= 1'h1;
                    end //if
                    if ((trace__branch_taken!=1'h0))
                    begin
                        trace_state__packed_trace__nonseq <= 2'h0;
                    end //if
                    if ((trace__jalr!=1'h0))
                    begin
                        trace_state__packed_trace__nonseq <= 2'h1;
                    end //if
                    if ((trace__trap!=1'h0))
                    begin
                        trace_state__packed_trace__nonseq <= 2'h2;
                    end //if
                    if ((trace__ret!=1'h0))
                    begin
                        trace_state__packed_trace__nonseq <= 2'h3;
                    end //if
                    if (((trace_control__enable_pc!=1'h0)&&(trace_state__pc_required!=1'h0)))
                    begin
                        trace_state__packed_trace__data_reason <= 1'h0;
                        trace_state__packed_trace__data <= {8'h0,trace__instr_pc};
                        trace_state__packed_trace__compressed_data_num_bytes <= 4'h0;
                    end //if
                end //if
            end //if
            if ((trace_state__enabled!=1'h0))
            begin
                trace_state__packed_trace__seq_valid <= trace_combs__next_seq_valid;
                trace_state__packed_trace__nonseq_valid <= trace_combs__next_nonseq_valid;
                trace_state__packed_trace__bkpt_valid <= trace_combs__next_bkpt_valid;
                trace_state__packed_trace__data_valid <= trace_combs__next_data_valid;
                trace_state__packed_trace__seq <= trace_combs__next_seq;
                trace_state__packed_trace__compressed_data_nybble <= (({2'h0,trace_combs__next_seq_valid}+{2'h0,trace_combs__next_nonseq_valid})+{{1'h0,trace_combs__next_bkpt_valid},1'h0});
            end //if
            if ((trace_control__enable!=1'h0))
            begin
                trace_state__enabled <= 1'h1;
            end //if
            else
            
            begin
                trace_state__enabled <= 1'h0;
                trace_state__pc_required <= 1'h0;
                trace_state__packed_trace__seq_valid <= 1'h0;
                trace_state__packed_trace__seq <= 3'h0;
                trace_state__packed_trace__nonseq_valid <= 1'h0;
                trace_state__packed_trace__nonseq <= 2'h0;
                trace_state__packed_trace__bkpt_valid <= 1'h0;
                trace_state__packed_trace__bkpt <= 4'h0;
                trace_state__packed_trace__data_valid <= 1'h0;
                trace_state__packed_trace__data_reason <= 1'h0;
                trace_state__packed_trace__data <= 40'h0;
                trace_state__packed_trace__compressed_data_nybble <= 3'h0;
                trace_state__packed_trace__compressed_data_num_bytes <= 4'h0;
                trace_state__pc_required <= 1'h1;
            end //else
            if ((!(trace_control__enable!=1'h0)&&!(trace_state__enabled!=1'h0)))
            begin
                trace_state__enabled <= trace_state__enabled;
                trace_state__pc_required <= trace_state__pc_required;
                trace_state__packed_trace__seq_valid <= trace_state__packed_trace__seq_valid;
                trace_state__packed_trace__seq <= trace_state__packed_trace__seq;
                trace_state__packed_trace__nonseq_valid <= trace_state__packed_trace__nonseq_valid;
                trace_state__packed_trace__nonseq <= trace_state__packed_trace__nonseq;
                trace_state__packed_trace__bkpt_valid <= trace_state__packed_trace__bkpt_valid;
                trace_state__packed_trace__bkpt <= trace_state__packed_trace__bkpt;
                trace_state__packed_trace__data_valid <= trace_state__packed_trace__data_valid;
                trace_state__packed_trace__data_reason <= trace_state__packed_trace__data_reason;
                trace_state__packed_trace__data <= trace_state__packed_trace__data;
                trace_state__packed_trace__compressed_data_nybble <= trace_state__packed_trace__compressed_data_nybble;
                trace_state__packed_trace__compressed_data_num_bytes <= trace_state__packed_trace__compressed_data_num_bytes;
            end //if
        end //if
    end //always

endmodule // riscv_i32_trace_pack
