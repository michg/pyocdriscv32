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

//a Module riscv_i32_dmem_request
    //   
    //   
    //   
module riscv_i32_dmem_request
(

    dmem_exec__idecode__rs1,
    dmem_exec__idecode__rs1_valid,
    dmem_exec__idecode__rs2,
    dmem_exec__idecode__rs2_valid,
    dmem_exec__idecode__rd,
    dmem_exec__idecode__rd_written,
    dmem_exec__idecode__csr_access__access_cancelled,
    dmem_exec__idecode__csr_access__access,
    dmem_exec__idecode__csr_access__address,
    dmem_exec__idecode__csr_access__write_data,
    dmem_exec__idecode__immediate,
    dmem_exec__idecode__immediate_shift,
    dmem_exec__idecode__immediate_valid,
    dmem_exec__idecode__op,
    dmem_exec__idecode__subop,
    dmem_exec__idecode__funct7,
    dmem_exec__idecode__minimum_mode,
    dmem_exec__idecode__illegal,
    dmem_exec__idecode__illegal_pc,
    dmem_exec__idecode__is_compressed,
    dmem_exec__idecode__ext__dummy,
    dmem_exec__arith_result,
    dmem_exec__rs2,
    dmem_exec__exec_committed,
    dmem_exec__first_cycle,

    dmem_request__access__valid,
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
    dmem_request__multicycle
);

    //b Clocks

    //b Inputs
    input [4:0]dmem_exec__idecode__rs1;
    input dmem_exec__idecode__rs1_valid;
    input [4:0]dmem_exec__idecode__rs2;
    input dmem_exec__idecode__rs2_valid;
    input [4:0]dmem_exec__idecode__rd;
    input dmem_exec__idecode__rd_written;
    input dmem_exec__idecode__csr_access__access_cancelled;
    input [2:0]dmem_exec__idecode__csr_access__access;
    input [11:0]dmem_exec__idecode__csr_access__address;
    input [31:0]dmem_exec__idecode__csr_access__write_data;
    input [31:0]dmem_exec__idecode__immediate;
    input [4:0]dmem_exec__idecode__immediate_shift;
    input dmem_exec__idecode__immediate_valid;
    input [3:0]dmem_exec__idecode__op;
    input [3:0]dmem_exec__idecode__subop;
    input [6:0]dmem_exec__idecode__funct7;
    input [2:0]dmem_exec__idecode__minimum_mode;
    input dmem_exec__idecode__illegal;
    input dmem_exec__idecode__illegal_pc;
    input dmem_exec__idecode__is_compressed;
    input dmem_exec__idecode__ext__dummy;
    input [31:0]dmem_exec__arith_result;
    input [31:0]dmem_exec__rs2;
    input dmem_exec__exec_committed;
    input dmem_exec__first_cycle;

    //b Outputs
    output dmem_request__access__valid;
    output [4:0]dmem_request__access__req_type;
    output [31:0]dmem_request__access__address;
    output dmem_request__access__sequential;
    output [3:0]dmem_request__access__byte_enable;
    output [31:0]dmem_request__access__write_data;
    output dmem_request__load_address_misaligned;
    output dmem_request__store_address_misaligned;
    output dmem_request__reading;
    output [1:0]dmem_request__read_data_rotation;
    output [3:0]dmem_request__read_data_byte_clear;
    output [3:0]dmem_request__read_data_byte_enable;
    output dmem_request__sign_extend_byte;
    output dmem_request__sign_extend_half;
    output dmem_request__multicycle;

// output components here

    //b Output combinatorials
    reg dmem_request__access__valid;
    reg [4:0]dmem_request__access__req_type;
    reg [31:0]dmem_request__access__address;
    reg dmem_request__access__sequential;
    reg [3:0]dmem_request__access__byte_enable;
    reg [31:0]dmem_request__access__write_data;
    reg dmem_request__load_address_misaligned;
    reg dmem_request__store_address_misaligned;
    reg dmem_request__reading;
    reg [1:0]dmem_request__read_data_rotation;
    reg [3:0]dmem_request__read_data_byte_clear;
    reg [3:0]dmem_request__read_data_byte_enable;
    reg dmem_request__sign_extend_byte;
    reg dmem_request__sign_extend_half;
    reg dmem_request__multicycle;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg [1:0]dmem_combs__word_offset;
    reg dmem_combs__dmem_misaligned;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b code combinatorial process
    always @ ( * )//code
    begin: code__comb_code
    reg dmem_request__access__valid__var;
    reg [3:0]dmem_request__access__byte_enable__var;
    reg dmem_combs__dmem_misaligned__var;
    reg dmem_request__multicycle__var;
    reg [3:0]dmem_request__read_data_byte_enable__var;
    reg dmem_request__sign_extend_half__var;
    reg dmem_request__sign_extend_byte__var;
    reg [4:0]dmem_request__access__req_type__var;
    reg dmem_request__load_address_misaligned__var;
    reg dmem_request__store_address_misaligned__var;
    reg [31:0]dmem_request__access__write_data__var;
        dmem_request__access__valid__var = 1'h0;
        dmem_request__access__address = dmem_exec__arith_result;
        dmem_request__access__sequential = 1'h0;
        dmem_combs__word_offset = dmem_exec__arith_result[1:0];
        dmem_request__access__byte_enable__var = (4'hf<<dmem_combs__word_offset);
        dmem_combs__dmem_misaligned__var = (dmem_combs__word_offset!=2'h0);
        dmem_request__multicycle__var = (dmem_combs__word_offset!=2'h0);
        dmem_request__read_data_rotation = dmem_combs__word_offset;
        dmem_request__read_data_byte_enable__var = 4'hf;
        dmem_request__read_data_byte_clear = 4'hf;
        dmem_request__sign_extend_half__var = 1'h0;
        dmem_request__sign_extend_byte__var = 1'h0;
        case ((dmem_exec__idecode__subop & 4'h3)) //synopsys parallel_case
        4'h0: // req 1
            begin
            dmem_combs__dmem_misaligned__var = 1'h0;
            dmem_request__access__byte_enable__var = (4'h1<<dmem_combs__word_offset);
            dmem_request__read_data_byte_enable__var = 4'h1;
            dmem_request__sign_extend_byte__var = ((dmem_exec__idecode__subop & 4'h4)==4'h0);
            dmem_request__multicycle__var = 1'h0;
            end
        4'h1: // req 1
            begin
            dmem_combs__dmem_misaligned__var = dmem_combs__word_offset[0];
            dmem_request__access__byte_enable__var = (4'h3<<dmem_combs__word_offset);
            dmem_request__read_data_byte_enable__var = 4'h3;
            dmem_request__sign_extend_half__var = ((dmem_exec__idecode__subop & 4'h4)==4'h0);
            dmem_request__multicycle__var = (dmem_combs__word_offset==2'h3);
            end
        default: // req 1
            begin
            dmem_combs__dmem_misaligned__var = (dmem_combs__word_offset!=2'h0);
            dmem_request__access__byte_enable__var = (4'hf<<dmem_combs__word_offset);
            dmem_request__multicycle__var = (dmem_combs__word_offset!=2'h0);
            end
        endcase
        dmem_request__access__req_type__var = 5'h0;
        dmem_request__load_address_misaligned__var = 1'h0;
        dmem_request__store_address_misaligned__var = 1'h0;
        if ((dmem_exec__idecode__op==4'h6))
        begin
            dmem_request__access__valid__var = 1'h1;
            dmem_request__access__req_type__var = 5'h1;
            dmem_request__load_address_misaligned__var = dmem_combs__dmem_misaligned__var;
            if (((dmem_exec__idecode__subop & 4'h8)!=4'h0))
            begin
                dmem_request__access__req_type__var = 5'h2;
                dmem_request__store_address_misaligned__var = dmem_combs__dmem_misaligned__var;
                dmem_request__load_address_misaligned__var = 1'h0;
            end //if
        end //if
        if (!(dmem_exec__exec_committed!=1'h0))
        begin
            dmem_request__access__valid__var = 1'h0;
        end //if
        dmem_request__reading = ((dmem_request__access__valid__var!=1'h0)&&(dmem_request__access__req_type__var==5'h1));
        dmem_request__access__write_data__var = dmem_exec__rs2;
        case (dmem_combs__word_offset) //synopsys parallel_case
        2'h0: // req 1
            begin
            dmem_request__access__write_data__var = dmem_exec__rs2;
            end
        2'h1: // req 1
            begin
            dmem_request__access__write_data__var = {dmem_exec__rs2[23:0],dmem_exec__rs2[31:24]};
            end
        2'h2: // req 1
            begin
            dmem_request__access__write_data__var = {dmem_exec__rs2[15:0],dmem_exec__rs2[31:16]};
            end
        2'h3: // req 1
            begin
            dmem_request__access__write_data__var = {dmem_exec__rs2[7:0],dmem_exec__rs2[31:8]};
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_dmem_request:code: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        dmem_request__access__valid = dmem_request__access__valid__var;
        dmem_request__access__byte_enable = dmem_request__access__byte_enable__var;
        dmem_combs__dmem_misaligned = dmem_combs__dmem_misaligned__var;
        dmem_request__multicycle = dmem_request__multicycle__var;
        dmem_request__read_data_byte_enable = dmem_request__read_data_byte_enable__var;
        dmem_request__sign_extend_half = dmem_request__sign_extend_half__var;
        dmem_request__sign_extend_byte = dmem_request__sign_extend_byte__var;
        dmem_request__access__req_type = dmem_request__access__req_type__var;
        dmem_request__load_address_misaligned = dmem_request__load_address_misaligned__var;
        dmem_request__store_address_misaligned = dmem_request__store_address_misaligned__var;
        dmem_request__access__write_data = dmem_request__access__write_data__var;
    end //always

endmodule // riscv_i32_dmem_request
