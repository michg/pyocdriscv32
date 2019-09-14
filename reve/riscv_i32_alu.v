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

//a Module riscv_i32_alu
    //   
    //   
    //   
module riscv_i32_alu
(

    rs2,
    rs1,
    pc,
    idecode__rs1,
    idecode__rs1_valid,
    idecode__rs2,
    idecode__rs2_valid,
    idecode__rd,
    idecode__rd_written,
    idecode__csr_access__access_cancelled,
    idecode__csr_access__access,
    idecode__csr_access__address,
    idecode__csr_access__write_data,
    idecode__immediate,
    idecode__immediate_shift,
    idecode__immediate_valid,
    idecode__op,
    idecode__subop,
    idecode__funct7,
    idecode__minimum_mode,
    idecode__illegal,
    idecode__illegal_pc,
    idecode__is_compressed,
    idecode__ext__dummy,

    alu_result__result,
    alu_result__arith_result,
    alu_result__branch_condition_met,
    alu_result__branch_target,
    alu_result__csr_access__access_cancelled,
    alu_result__csr_access__access,
    alu_result__csr_access__address,
    alu_result__csr_access__write_data
);

    //b Clocks

    //b Inputs
    input [31:0]rs2;
    input [31:0]rs1;
    input [31:0]pc;
    input [4:0]idecode__rs1;
    input idecode__rs1_valid;
    input [4:0]idecode__rs2;
    input idecode__rs2_valid;
    input [4:0]idecode__rd;
    input idecode__rd_written;
    input idecode__csr_access__access_cancelled;
    input [2:0]idecode__csr_access__access;
    input [11:0]idecode__csr_access__address;
    input [31:0]idecode__csr_access__write_data;
    input [31:0]idecode__immediate;
    input [4:0]idecode__immediate_shift;
    input idecode__immediate_valid;
    input [3:0]idecode__op;
    input [3:0]idecode__subop;
    input [6:0]idecode__funct7;
    input [2:0]idecode__minimum_mode;
    input idecode__illegal;
    input idecode__illegal_pc;
    input idecode__is_compressed;
    input idecode__ext__dummy;

    //b Outputs
    output [31:0]alu_result__result;
    output [31:0]alu_result__arith_result;
    output alu_result__branch_condition_met;
    output [31:0]alu_result__branch_target;
    output alu_result__csr_access__access_cancelled;
    output [2:0]alu_result__csr_access__access;
    output [11:0]alu_result__csr_access__address;
    output [31:0]alu_result__csr_access__write_data;

// output components here

    //b Output combinatorials
    reg [31:0]alu_result__result;
    reg [31:0]alu_result__arith_result;
    reg alu_result__branch_condition_met;
    reg [31:0]alu_result__branch_target;
    reg alu_result__csr_access__access_cancelled;
    reg [2:0]alu_result__csr_access__access;
    reg [11:0]alu_result__csr_access__address;
    reg [31:0]alu_result__csr_access__write_data;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
        //   Combinatorials used in the module, not exported as the decode
    reg [31:0]alu_combs__imm_or_rs2;
    reg [31:0]alu_combs__imm_or_rs1;
    reg [63:0]alu_combs__rshift_operand;
    reg [63:0]alu_combs__rshift_result;
    reg [4:0]alu_combs__shift_amount;
    reg [31:0]alu_combs__arith_in_0;
    reg [31:0]alu_combs__arith_in_1;
    reg alu_combs__arith_carry_in;
    reg alu_combs__carry_in_to_31;
    reg [31:0]alu_combs__arith_result_32;
    reg [32:0]alu_combs__arith_result;
    reg alu_combs__arith_eq;
    reg alu_combs__arith_unsigned_ge;
    reg alu_combs__arith_signed_ge;
    reg [31:0]alu_combs__pc_plus_4;
    reg [31:0]alu_combs__pc_plus_2;
    reg [31:0]alu_combs__pc_plus_inst;
    reg [31:0]alu_combs__pc_plus_imm;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b alu_operation combinatorial process
        //   
        //       
    always @ ( * )//alu_operation
    begin: alu_operation__comb_code
    reg [31:0]alu_combs__imm_or_rs2__var;
    reg [31:0]alu_combs__imm_or_rs1__var;
    reg [63:0]alu_combs__rshift_operand__var;
    reg [4:0]alu_combs__shift_amount__var;
    reg [31:0]alu_combs__arith_in_1__var;
    reg alu_combs__arith_carry_in__var;
    reg [32:0]alu_combs__arith_result__var;
    reg alu_result__branch_condition_met__var;
    reg [31:0]alu_result__result__var;
    reg [31:0]alu_result__branch_target__var;
    reg [31:0]alu_result__csr_access__write_data__var;
        alu_combs__imm_or_rs2__var = rs2;
        if ((idecode__immediate_valid!=1'h0))
        begin
            alu_combs__imm_or_rs2__var = idecode__immediate;
        end //if
        alu_combs__imm_or_rs1__var = rs1;
        if ((idecode__immediate_valid!=1'h0))
        begin
            alu_combs__imm_or_rs1__var = idecode__immediate;
        end //if
        alu_combs__rshift_operand__var = {32'h0,rs1};
        if ((((idecode__subop==4'hd) & rs1[31])!=1'h0))
        begin
            alu_combs__rshift_operand__var[63:32] = 32'hffffffff;
        end //if
        alu_combs__shift_amount__var = rs2[4:0];
        if ((idecode__immediate_valid!=1'h0))
        begin
            alu_combs__shift_amount__var = idecode__immediate_shift;
        end //if
        alu_combs__rshift_result = (alu_combs__rshift_operand__var>>alu_combs__shift_amount__var);
        alu_combs__arith_in_0 = rs1;
        alu_combs__arith_in_1__var = alu_combs__imm_or_rs2__var;
        alu_combs__arith_carry_in__var = 1'h0;
        if ((((idecode__subop==4'h8) | (idecode__subop==4'h2)) | (idecode__subop==4'h3)))
        begin
            alu_combs__arith_in_1__var = ~alu_combs__imm_or_rs2__var;
            alu_combs__arith_carry_in__var = 1'h1;
        end //if
        if ((idecode__op==4'h0))
        begin
            alu_combs__arith_in_1__var = ~rs2;
            alu_combs__arith_carry_in__var = 1'h1;
        end //if
        if (((idecode__op==4'h2)||(idecode__op==4'h6)))
        begin
            alu_combs__arith_in_1__var = idecode__immediate;
            alu_combs__arith_carry_in__var = 1'h0;
        end //if
        alu_combs__arith_result_32 = (({1'h0,alu_combs__arith_in_0[30:0]}+{1'h0,alu_combs__arith_in_1__var[30:0]})+{31'h0,alu_combs__arith_carry_in__var});
        alu_combs__carry_in_to_31 = alu_combs__arith_result_32[31];
        alu_combs__arith_result__var[30:0] = alu_combs__arith_result_32[30:0];
        alu_combs__arith_result__var[32:31] = (({1'h0,alu_combs__arith_in_0[31]}+{1'h0,alu_combs__arith_in_1__var[31]})+{1'h0,alu_combs__carry_in_to_31});
        alu_combs__arith_eq = (alu_combs__arith_result__var[31:0]==32'h0);
        alu_combs__arith_unsigned_ge = alu_combs__arith_result__var[32];
        alu_combs__arith_signed_ge = ((alu_combs__carry_in_to_31 ^ alu_combs__arith_result__var[32])==alu_combs__arith_result__var[31]);
        alu_result__branch_condition_met__var = 1'h0;
        case (idecode__subop) //synopsys parallel_case
        4'h0: // req 1
            begin
            alu_result__branch_condition_met__var = alu_combs__arith_eq;
            end
        4'h1: // req 1
            begin
            alu_result__branch_condition_met__var = !(alu_combs__arith_eq!=1'h0);
            end
        4'h5: // req 1
            begin
            alu_result__branch_condition_met__var = alu_combs__arith_unsigned_ge;
            end
        4'h4: // req 1
            begin
            alu_result__branch_condition_met__var = !(alu_combs__arith_unsigned_ge!=1'h0);
            end
        4'h3: // req 1
            begin
            alu_result__branch_condition_met__var = alu_combs__arith_signed_ge;
            end
        4'h2: // req 1
            begin
            alu_result__branch_condition_met__var = !(alu_combs__arith_signed_ge!=1'h0);
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
        alu_combs__pc_plus_4 = (pc+32'h4);
        alu_combs__pc_plus_2 = (pc+32'h2);
        alu_combs__pc_plus_inst = ((idecode__is_compressed!=1'h0)?alu_combs__pc_plus_2:alu_combs__pc_plus_4);
        alu_combs__pc_plus_imm = (pc+idecode__immediate);
        alu_result__arith_result = alu_combs__arith_result__var[31:0];
        alu_result__result__var = alu_combs__arith_result__var[31:0];
        case (idecode__subop) //synopsys parallel_case
        4'h0: // req 1
            begin
            alu_result__result__var = alu_combs__arith_result__var[31:0];
            end
        4'h8: // req 1
            begin
            alu_result__result__var = alu_combs__arith_result__var[31:0];
            end
        4'h2: // req 1
            begin
            alu_result__result__var = ((alu_combs__arith_signed_ge!=1'h0)?64'h0:64'h1);
            end
        4'h3: // req 1
            begin
            alu_result__result__var = ((alu_combs__arith_unsigned_ge!=1'h0)?64'h0:64'h1);
            end
        4'h4: // req 1
            begin
            alu_result__result__var = (rs1 ^ alu_combs__imm_or_rs2__var);
            end
        4'h6: // req 1
            begin
            alu_result__result__var = (rs1 | alu_combs__imm_or_rs2__var);
            end
        4'h7: // req 1
            begin
            alu_result__result__var = (rs1 & alu_combs__imm_or_rs2__var);
            end
        4'h1: // req 1
            begin
            alu_result__result__var = (rs1<<alu_combs__shift_amount__var);
            end
        4'h5: // req 1
            begin
            alu_result__result__var = alu_combs__rshift_result[31:0];
            end
        4'hd: // req 1
            begin
            alu_result__result__var = alu_combs__rshift_result[31:0];
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
        case (idecode__op) //synopsys parallel_case
        4'ha: // req 1
            begin
            alu_result__result__var = idecode__immediate;
            end
        4'h9: // req 1
            begin
            alu_result__result__var = alu_combs__pc_plus_imm;
            end
        4'h1: // req 1
            begin
            alu_result__result__var = alu_combs__pc_plus_inst;
            end
        4'h2: // req 1
            begin
            alu_result__result__var = alu_combs__pc_plus_inst;
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
        alu_result__branch_target__var = alu_combs__pc_plus_imm;
        case (idecode__op) //synopsys parallel_case
        4'h2: // req 1
            begin
            alu_result__branch_target__var = {alu_combs__arith_result__var[31:1],1'h0};
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
        alu_result__csr_access__access_cancelled = idecode__csr_access__access_cancelled;
        alu_result__csr_access__access = idecode__csr_access__access;
        alu_result__csr_access__address = idecode__csr_access__address;
        alu_result__csr_access__write_data__var = idecode__csr_access__write_data;
        alu_result__csr_access__write_data__var = alu_combs__imm_or_rs1__var;
        alu_combs__imm_or_rs2 = alu_combs__imm_or_rs2__var;
        alu_combs__imm_or_rs1 = alu_combs__imm_or_rs1__var;
        alu_combs__rshift_operand = alu_combs__rshift_operand__var;
        alu_combs__shift_amount = alu_combs__shift_amount__var;
        alu_combs__arith_in_1 = alu_combs__arith_in_1__var;
        alu_combs__arith_carry_in = alu_combs__arith_carry_in__var;
        alu_combs__arith_result = alu_combs__arith_result__var;
        alu_result__branch_condition_met = alu_result__branch_condition_met__var;
        alu_result__result = alu_result__result__var;
        alu_result__branch_target = alu_result__branch_target__var;
        alu_result__csr_access__write_data = alu_result__csr_access__write_data__var;
    end //always

endmodule // riscv_i32_alu
