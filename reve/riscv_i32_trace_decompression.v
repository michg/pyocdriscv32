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

//a Module riscv_i32_trace_decompression
    //   
    //   Trace decompression
    //   
    //   This takes the input nybbles and combinatorially decodes the nybbles to a trace
    //   
    //   The input data can come from a shift register, which can be shifted down by nybbles_consumed
    //   
    //   The output decompression can be registered and used for tracing
    //   
module riscv_i32_trace_decompression
(

    compressed_nybbles,

    nybbles_consumed,
    decompressed_trace__seq_valid,
    decompressed_trace__seq,
    decompressed_trace__branch_taken,
    decompressed_trace__trap,
    decompressed_trace__ret,
    decompressed_trace__jalr,
    decompressed_trace__pc_valid,
    decompressed_trace__pc,
    decompressed_trace__rfw_data_valid,
    decompressed_trace__rfw_rd,
    decompressed_trace__rfw_data,
    decompressed_trace__bkpt_valid,
    decompressed_trace__bkpt_reason
);

    //b Clocks

    //b Inputs
        //   Nybbles from compressed trace
    input [63:0]compressed_nybbles;

    //b Outputs
        //   number of nybbles (from bit 0) consumed by current decompression
    output [4:0]nybbles_consumed;
        //   Decompressed trace
    output decompressed_trace__seq_valid;
    output [2:0]decompressed_trace__seq;
    output decompressed_trace__branch_taken;
    output decompressed_trace__trap;
    output decompressed_trace__ret;
    output decompressed_trace__jalr;
    output decompressed_trace__pc_valid;
    output [31:0]decompressed_trace__pc;
    output decompressed_trace__rfw_data_valid;
    output [4:0]decompressed_trace__rfw_rd;
    output [31:0]decompressed_trace__rfw_data;
    output decompressed_trace__bkpt_valid;
    output [3:0]decompressed_trace__bkpt_reason;

// output components here

    //b Output combinatorials
        //   number of nybbles (from bit 0) consumed by current decompression
    reg [4:0]nybbles_consumed;
        //   Decompressed trace
    reg decompressed_trace__seq_valid;
    reg [2:0]decompressed_trace__seq;
    reg decompressed_trace__branch_taken;
    reg decompressed_trace__trap;
    reg decompressed_trace__ret;
    reg decompressed_trace__jalr;
    reg decompressed_trace__pc_valid;
    reg [31:0]decompressed_trace__pc;
    reg decompressed_trace__rfw_data_valid;
    reg [4:0]decompressed_trace__rfw_rd;
    reg [31:0]decompressed_trace__rfw_data;
    reg decompressed_trace__bkpt_valid;
    reg [3:0]decompressed_trace__bkpt_reason;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg [47:0]trace_combs__data_nybbles;
    reg trace_combs__nonseq_valid;
    reg [1:0]trace_combs__nonseq;
    reg [4:0]trace_combs__nybbles_consumed;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b compressed_trace_out combinatorial process
        //   
        //       Present the state - but bytes_valid is combinatorial from the state
        //       
    always @ ( * )//compressed_trace_out
    begin: compressed_trace_out__comb_code
    reg decompressed_trace__seq_valid__var;
    reg [2:0]decompressed_trace__seq__var;
    reg decompressed_trace__branch_taken__var;
    reg decompressed_trace__trap__var;
    reg decompressed_trace__ret__var;
    reg decompressed_trace__jalr__var;
    reg decompressed_trace__pc_valid__var;
    reg [31:0]decompressed_trace__pc__var;
    reg decompressed_trace__rfw_data_valid__var;
    reg [4:0]decompressed_trace__rfw_rd__var;
    reg [31:0]decompressed_trace__rfw_data__var;
    reg decompressed_trace__bkpt_valid__var;
    reg [3:0]decompressed_trace__bkpt_reason__var;
    reg trace_combs__nonseq_valid__var;
    reg [1:0]trace_combs__nonseq__var;
    reg [47:0]trace_combs__data_nybbles__var;
    reg [4:0]trace_combs__nybbles_consumed__var;
    reg [4:0]nybbles_consumed__var;
        decompressed_trace__seq_valid__var = 1'h0;
        decompressed_trace__seq__var = 3'h0;
        decompressed_trace__branch_taken__var = 1'h0;
        decompressed_trace__trap__var = 1'h0;
        decompressed_trace__ret__var = 1'h0;
        decompressed_trace__jalr__var = 1'h0;
        decompressed_trace__pc_valid__var = 1'h0;
        decompressed_trace__pc__var = 32'h0;
        decompressed_trace__rfw_data_valid__var = 1'h0;
        decompressed_trace__rfw_rd__var = 5'h0;
        decompressed_trace__rfw_data__var = 32'h0;
        decompressed_trace__bkpt_valid__var = 1'h0;
        decompressed_trace__bkpt_reason__var = 4'h0;
        decompressed_trace__seq__var = compressed_nybbles[2:0];
        trace_combs__nonseq_valid__var = 1'h0;
        trace_combs__nonseq__var = compressed_nybbles[1:0];
        decompressed_trace__bkpt_reason__var = compressed_nybbles[7:4];
        trace_combs__data_nybbles__var = compressed_nybbles[47:0];
        trace_combs__nybbles_consumed__var = 5'h0;
        if ((compressed_nybbles[3]==1'h0))
        begin
            decompressed_trace__seq_valid__var = 1'h1;
            trace_combs__nybbles_consumed__var = 5'h1;
            trace_combs__data_nybbles__var = compressed_nybbles[51:4];
            if ((compressed_nybbles[7:6]==2'h2))
            begin
                trace_combs__nonseq_valid__var = 1'h1;
                trace_combs__nonseq__var = compressed_nybbles[5:4];
                trace_combs__data_nybbles__var = compressed_nybbles[55:8];
                trace_combs__nybbles_consumed__var = 5'h2;
                if ((compressed_nybbles[11:8]==4'hd))
                begin
                    decompressed_trace__bkpt_valid__var = 1'h1;
                    decompressed_trace__bkpt_reason__var = compressed_nybbles[15:12];
                    trace_combs__data_nybbles__var = compressed_nybbles[63:16];
                    trace_combs__nybbles_consumed__var = 5'h4;
                end //if
            end //if
            else
            
            begin
                if ((compressed_nybbles[7:4]==4'hd))
                begin
                    decompressed_trace__bkpt_valid__var = 1'h1;
                    decompressed_trace__bkpt_reason__var = compressed_nybbles[11:8];
                    trace_combs__data_nybbles__var = compressed_nybbles[59:12];
                    trace_combs__nybbles_consumed__var = 5'h3;
                end //if
            end //else
        end //if
        else
        
        begin
            if ((compressed_nybbles[3:2]==2'h2))
            begin
                trace_combs__nonseq_valid__var = 1'h1;
                trace_combs__nonseq__var = compressed_nybbles[1:0];
                trace_combs__data_nybbles__var = compressed_nybbles[51:4];
                trace_combs__nybbles_consumed__var = 5'h1;
                if ((compressed_nybbles[7:4]==4'hd))
                begin
                    decompressed_trace__bkpt_valid__var = 1'h1;
                    decompressed_trace__bkpt_reason__var = compressed_nybbles[11:8];
                    trace_combs__data_nybbles__var = compressed_nybbles[59:12];
                    trace_combs__nybbles_consumed__var = 5'h3;
                end //if
            end //if
            else
            
            begin
                if ((compressed_nybbles[3:0]==4'hd))
                begin
                    decompressed_trace__bkpt_valid__var = 1'h1;
                    decompressed_trace__bkpt_reason__var = compressed_nybbles[7:4];
                    trace_combs__data_nybbles__var = compressed_nybbles[55:8];
                    trace_combs__nybbles_consumed__var = 5'h2;
                end //if
            end //else
        end //else
        if ((trace_combs__nonseq_valid__var!=1'h0))
        begin
            decompressed_trace__branch_taken__var = (trace_combs__nonseq__var==2'h0);
            decompressed_trace__jalr__var = (trace_combs__nonseq__var==2'h1);
            decompressed_trace__trap__var = (trace_combs__nonseq__var==2'h2);
            decompressed_trace__ret__var = (trace_combs__nonseq__var==2'h3);
        end //if
        decompressed_trace__pc__var = trace_combs__data_nybbles__var[39:8];
        decompressed_trace__rfw_data__var = trace_combs__data_nybbles__var[39:8];
        decompressed_trace__rfw_rd__var = trace_combs__data_nybbles__var[47:43];
        nybbles_consumed__var = trace_combs__nybbles_consumed__var;
        if (((trace_combs__data_nybbles__var[3:0]==4'hc)||(trace_combs__data_nybbles__var[3:1]==3'h7)))
        begin
            nybbles_consumed__var = ((trace_combs__nybbles_consumed__var+5'h4)+{{1'h0,trace_combs__data_nybbles__var[6:4]},1'h0});
            decompressed_trace__pc_valid__var = !(trace_combs__data_nybbles__var[7]!=1'h0);
            decompressed_trace__rfw_data_valid__var = trace_combs__data_nybbles__var[7];
        end //if
        if ((compressed_nybbles[3:0]==4'h0))
        begin
            decompressed_trace__seq_valid__var = 1'h0;
            decompressed_trace__pc_valid__var = 1'h0;
            decompressed_trace__rfw_data_valid__var = 1'h0;
            decompressed_trace__bkpt_valid__var = 1'h0;
            decompressed_trace__branch_taken__var = 1'h0;
            decompressed_trace__trap__var = 1'h0;
            decompressed_trace__ret__var = 1'h0;
            decompressed_trace__jalr__var = 1'h0;
            nybbles_consumed__var = ((compressed_nybbles==64'h0)?64'hffffffffffffffff:64'h1);
        end //if
        decompressed_trace__seq_valid = decompressed_trace__seq_valid__var;
        decompressed_trace__seq = decompressed_trace__seq__var;
        decompressed_trace__branch_taken = decompressed_trace__branch_taken__var;
        decompressed_trace__trap = decompressed_trace__trap__var;
        decompressed_trace__ret = decompressed_trace__ret__var;
        decompressed_trace__jalr = decompressed_trace__jalr__var;
        decompressed_trace__pc_valid = decompressed_trace__pc_valid__var;
        decompressed_trace__pc = decompressed_trace__pc__var;
        decompressed_trace__rfw_data_valid = decompressed_trace__rfw_data_valid__var;
        decompressed_trace__rfw_rd = decompressed_trace__rfw_rd__var;
        decompressed_trace__rfw_data = decompressed_trace__rfw_data__var;
        decompressed_trace__bkpt_valid = decompressed_trace__bkpt_valid__var;
        decompressed_trace__bkpt_reason = decompressed_trace__bkpt_reason__var;
        trace_combs__nonseq_valid = trace_combs__nonseq_valid__var;
        trace_combs__nonseq = trace_combs__nonseq__var;
        trace_combs__data_nybbles = trace_combs__data_nybbles__var;
        trace_combs__nybbles_consumed = trace_combs__nybbles_consumed__var;
        nybbles_consumed = nybbles_consumed__var;
    end //always

endmodule // riscv_i32_trace_decompression
