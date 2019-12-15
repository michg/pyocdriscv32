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

//a Module riscv_i32_dmem_read_data
    //   
    //   
    //   
module riscv_i32_dmem_read_data
(

    dmem_access_resp__ack_if_seq,
    dmem_access_resp__ack,
    dmem_access_resp__abort_req,
    dmem_access_resp__may_still_abort,
    dmem_access_resp__access_complete,
    dmem_access_resp__read_data,
    last_data,
    dmem_request__access__valid,
    dmem_request__access__mode,
    dmem_request__access__req_type,
    dmem_request__access__address,
    dmem_request__access__sequential,
    dmem_request__access__byte_enable,
    dmem_request__access__write_data,
    dmem_request__load_address_misaligned,
    dmem_request__store_address_misaligned,
    dmem_request__reading,
    dmem_request__read_data_rotation,
    dmem_request__read_data_byte_clear,
    dmem_request__read_data_byte_enable,
    dmem_request__sign_extend_byte,
    dmem_request__sign_extend_half,
    dmem_request__multicycle,

    dmem_read_data
);

    //b Clocks

    //b Inputs
    input dmem_access_resp__ack_if_seq;
    input dmem_access_resp__ack;
    input dmem_access_resp__abort_req;
    input dmem_access_resp__may_still_abort;
    input dmem_access_resp__access_complete;
    input [31:0]dmem_access_resp__read_data;
    input [31:0]last_data;
    input dmem_request__access__valid;
    input [2:0]dmem_request__access__mode;
    input [4:0]dmem_request__access__req_type;
    input [31:0]dmem_request__access__address;
    input dmem_request__access__sequential;
    input [3:0]dmem_request__access__byte_enable;
    input [31:0]dmem_request__access__write_data;
    input dmem_request__load_address_misaligned;
    input dmem_request__store_address_misaligned;
    input dmem_request__reading;
    input [1:0]dmem_request__read_data_rotation;
    input [3:0]dmem_request__read_data_byte_clear;
    input [3:0]dmem_request__read_data_byte_enable;
    input dmem_request__sign_extend_byte;
    input dmem_request__sign_extend_half;
    input dmem_request__multicycle;

    //b Outputs
    output [31:0]dmem_read_data;

// output components here

    //b Output combinatorials
    reg [31:0]dmem_read_data;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg [31:0]mem_combs__aligned_data;
    reg [31:0]mem_combs__memory_data;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b code combinatorial process
    always @ ( * )//code
    begin: code__comb_code
    reg [31:0]mem_combs__aligned_data__var;
    reg [31:0]mem_combs__memory_data__var;
    reg [31:0]dmem_read_data__var;
        mem_combs__aligned_data__var = dmem_access_resp__read_data;
        case (dmem_request__read_data_rotation) //synopsys parallel_case
        2'h0: // req 1
            begin
            mem_combs__aligned_data__var = dmem_access_resp__read_data;
            end
        2'h1: // req 1
            begin
            mem_combs__aligned_data__var = {dmem_access_resp__read_data[7:0],dmem_access_resp__read_data[31:8]};
            end
        2'h2: // req 1
            begin
            mem_combs__aligned_data__var = {dmem_access_resp__read_data[15:0],dmem_access_resp__read_data[31:16]};
            end
        2'h3: // req 1
            begin
            mem_combs__aligned_data__var = {dmem_access_resp__read_data[23:0],dmem_access_resp__read_data[31:24]};
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_dmem_read_data:code: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        mem_combs__memory_data__var = mem_combs__aligned_data__var;
        mem_combs__memory_data__var[7:0] = (((dmem_request__read_data_byte_clear[0]!=1'h0)?8'h0:last_data[7:0]) | ((dmem_request__read_data_byte_enable[0]!=1'h0)?mem_combs__aligned_data__var[7:0]:8'h0));
        mem_combs__memory_data__var[15:8] = (((dmem_request__read_data_byte_clear[1]!=1'h0)?8'h0:last_data[15:8]) | ((dmem_request__read_data_byte_enable[1]!=1'h0)?mem_combs__aligned_data__var[15:8]:8'h0));
        mem_combs__memory_data__var[23:16] = (((dmem_request__read_data_byte_clear[2]!=1'h0)?8'h0:last_data[23:16]) | ((dmem_request__read_data_byte_enable[2]!=1'h0)?mem_combs__aligned_data__var[23:16]:8'h0));
        mem_combs__memory_data__var[31:24] = (((dmem_request__read_data_byte_clear[3]!=1'h0)?8'h0:last_data[31:24]) | ((dmem_request__read_data_byte_enable[3]!=1'h0)?mem_combs__aligned_data__var[31:24]:8'h0));
        dmem_read_data__var = mem_combs__memory_data__var;
        if (((dmem_request__sign_extend_byte!=1'h0)&&(mem_combs__memory_data__var[7]!=1'h0)))
        begin
            dmem_read_data__var[31:8] = 24'hffffff;
        end //if
        if (((dmem_request__sign_extend_half!=1'h0)&&(mem_combs__memory_data__var[15]!=1'h0)))
        begin
            dmem_read_data__var[31:16] = 16'hffff;
        end //if
        mem_combs__aligned_data = mem_combs__aligned_data__var;
        mem_combs__memory_data = mem_combs__memory_data__var;
        dmem_read_data = dmem_read_data__var;
    end //always

endmodule // riscv_i32_dmem_read_data
