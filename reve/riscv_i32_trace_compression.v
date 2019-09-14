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

//a Module riscv_i32_trace_compression
    //   
    //   Compression of a packed trace
    //   
module riscv_i32_trace_compression
(

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
    packed_trace__compressed_data_num_bytes,

    compressed_trace__valid,
    compressed_trace__data
);

    //b Clocks

    //b Inputs
        //   Packed trace
    input packed_trace__seq_valid;
    input [2:0]packed_trace__seq;
    input packed_trace__nonseq_valid;
    input [1:0]packed_trace__nonseq;
    input packed_trace__bkpt_valid;
    input [3:0]packed_trace__bkpt;
    input packed_trace__data_valid;
    input packed_trace__data_reason;
    input [39:0]packed_trace__data;
    input [2:0]packed_trace__compressed_data_nybble;
    input [3:0]packed_trace__compressed_data_num_bytes;

    //b Outputs
        //   Compressed trace
    output [4:0]compressed_trace__valid;
    output [63:0]compressed_trace__data;

// output components here

    //b Output combinatorials
        //   Compressed trace
    reg [4:0]compressed_trace__valid;
    reg [63:0]compressed_trace__data;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b compressed_trace_out combinatorial process
        //   
        //       Present the state - note bytes_valid may already be combinatorial from the state
        //       
    always @ ( * )//compressed_trace_out
    begin: compressed_trace_out__comb_code
    reg [4:0]compressed_trace__valid__var;
    reg [63:0]compressed_trace__data__var;
        compressed_trace__valid__var = 5'h0;
        compressed_trace__data__var = 64'h0;
        compressed_trace__valid__var = {2'h0,packed_trace__compressed_data_nybble};
        if ((packed_trace__data_valid!=1'h0))
        begin
            compressed_trace__valid__var = ((compressed_trace__valid__var+5'h4)+{packed_trace__compressed_data_num_bytes,1'h0});
        end //if
        case ({{packed_trace__bkpt_valid,packed_trace__nonseq_valid},packed_trace__seq_valid}) //synopsys parallel_case
        3'h0: // req 1
            begin
            compressed_trace__data__var = 64'h0;
            end
        3'h1: // req 1
            begin
            compressed_trace__data__var = {{60'h0,1'h0},packed_trace__seq};
            end
        3'h2: // req 1
            begin
            compressed_trace__data__var = {{60'h0,2'h2},packed_trace__nonseq};
            end
        3'h3: // req 1
            begin
            compressed_trace__data__var = {{{{56'h0,2'h2},packed_trace__nonseq},1'h0},packed_trace__seq};
            end
        3'h4: // req 1
            begin
            compressed_trace__data__var = {{56'h0,packed_trace__bkpt},4'hd};
            end
        3'h6: // req 1
            begin
            compressed_trace__data__var = {{{{52'h0,packed_trace__bkpt},4'hd},2'h2},packed_trace__nonseq};
            end
        3'h7: // req 1
            begin
            compressed_trace__data__var = {{{{{{48'h0,packed_trace__bkpt},4'hd},2'h2},packed_trace__nonseq},1'h0},packed_trace__seq};
            end
        3'h5: // req 1
            begin
            compressed_trace__data__var = {{{{52'h0,packed_trace__bkpt},4'hd},1'h0},packed_trace__seq};
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_trace_compression:compressed_trace_out: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        if ((packed_trace__data_valid!=1'h0))
        begin
            case (packed_trace__compressed_data_nybble) //synopsys parallel_case
            3'h0: // req 1
                begin
                compressed_trace__data__var = compressed_trace__data__var | {{{{16'h0,packed_trace__data[39:0]},packed_trace__data_reason},packed_trace__compressed_data_num_bytes[2:0]},4'he};
                end
            3'h1: // req 1
                begin
                compressed_trace__data__var = compressed_trace__data__var | {{{{{12'h0,packed_trace__data[39:0]},packed_trace__data_reason},packed_trace__compressed_data_num_bytes[2:0]},4'he},4'h0};
                end
            3'h2: // req 1
                begin
                compressed_trace__data__var = compressed_trace__data__var | {{{{{8'h0,packed_trace__data[39:0]},packed_trace__data_reason},packed_trace__compressed_data_num_bytes[2:0]},4'he},8'h0};
                end
            3'h3: // req 1
                begin
                compressed_trace__data__var = compressed_trace__data__var | {{{{{4'h0,packed_trace__data[39:0]},packed_trace__data_reason},packed_trace__compressed_data_num_bytes[2:0]},4'he},12'h0};
                end
            3'h4: // req 1
                begin
                compressed_trace__data__var = compressed_trace__data__var | {{{{packed_trace__data[39:0],packed_trace__data_reason},packed_trace__compressed_data_num_bytes[2:0]},4'he},16'h0};
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_trace_compression:compressed_trace_out: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //if
        compressed_trace__valid = compressed_trace__valid__var;
        compressed_trace__data = compressed_trace__data__var;
    end //always

endmodule // riscv_i32_trace_compression
