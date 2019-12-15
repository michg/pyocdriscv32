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
    idecode__csr_access__mode,
    idecode__csr_access__access_cancelled,
    idecode__csr_access__access,
    idecode__csr_access__custom__mhartid,
    idecode__csr_access__custom__misa,
    idecode__csr_access__custom__mvendorid,
    idecode__csr_access__custom__marchid,
    idecode__csr_access__custom__mimpid,
    idecode__csr_access__address,
    idecode__csr_access__select,
    idecode__csr_access__write_data,
    idecode__immediate,
    idecode__immediate_shift,
    idecode__immediate_valid,
    idecode__op,
    idecode__subop,
    idecode__shift_op,
    idecode__funct7,
    idecode__illegal,
    idecode__is_compressed,
    idecode__ext__dummy,

    alu_result__result,
    alu_result__arith_result,
    alu_result__branch_condition_met,
    alu_result__branch_target,
    alu_result__csr_access__mode,
    alu_result__csr_access__access_cancelled,
    alu_result__csr_access__access,
    alu_result__csr_access__custom__mhartid,
    alu_result__csr_access__custom__misa,
    alu_result__csr_access__custom__mvendorid,
    alu_result__csr_access__custom__marchid,
    alu_result__csr_access__custom__mimpid,
    alu_result__csr_access__address,
    alu_result__csr_access__select,
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
    input [2:0]idecode__csr_access__mode;
    input idecode__csr_access__access_cancelled;
    input [2:0]idecode__csr_access__access;
    input [31:0]idecode__csr_access__custom__mhartid;
    input [31:0]idecode__csr_access__custom__misa;
    input [31:0]idecode__csr_access__custom__mvendorid;
    input [31:0]idecode__csr_access__custom__marchid;
    input [31:0]idecode__csr_access__custom__mimpid;
    input [11:0]idecode__csr_access__address;
    input [11:0]idecode__csr_access__select;
    input [31:0]idecode__csr_access__write_data;
    input [31:0]idecode__immediate;
    input [4:0]idecode__immediate_shift;
    input idecode__immediate_valid;
    input [3:0]idecode__op;
    input [3:0]idecode__subop;
    input [3:0]idecode__shift_op;
    input [6:0]idecode__funct7;
    input idecode__illegal;
    input idecode__is_compressed;
    input idecode__ext__dummy;

    //b Outputs
    output [31:0]alu_result__result;
    output [31:0]alu_result__arith_result;
    output alu_result__branch_condition_met;
    output [31:0]alu_result__branch_target;
    output [2:0]alu_result__csr_access__mode;
    output alu_result__csr_access__access_cancelled;
    output [2:0]alu_result__csr_access__access;
    output [31:0]alu_result__csr_access__custom__mhartid;
    output [31:0]alu_result__csr_access__custom__misa;
    output [31:0]alu_result__csr_access__custom__mvendorid;
    output [31:0]alu_result__csr_access__custom__marchid;
    output [31:0]alu_result__csr_access__custom__mimpid;
    output [11:0]alu_result__csr_access__address;
    output [11:0]alu_result__csr_access__select;
    output [31:0]alu_result__csr_access__write_data;

// output components here

    //b Output combinatorials
    reg [31:0]alu_result__result;
    reg [31:0]alu_result__arith_result;
    reg alu_result__branch_condition_met;
    reg [31:0]alu_result__branch_target;
    reg [2:0]alu_result__csr_access__mode;
    reg alu_result__csr_access__access_cancelled;
    reg [2:0]alu_result__csr_access__access;
    reg [31:0]alu_result__csr_access__custom__mhartid;
    reg [31:0]alu_result__csr_access__custom__misa;
    reg [31:0]alu_result__csr_access__custom__mvendorid;
    reg [31:0]alu_result__csr_access__custom__marchid;
    reg [31:0]alu_result__csr_access__custom__mimpid;
    reg [11:0]alu_result__csr_access__address;
    reg [11:0]alu_result__csr_access__select;
    reg [31:0]alu_result__csr_access__write_data;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
        //   Combinatorials used in the module, not exported as the decode
    reg [31:0]alu_combs__imm_or_rs2;
    reg [31:0]alu_combs__imm_or_rs1;
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
        //   Combinatorials used in the shifter
    reg [1:0]shift_combs__and_mask_type;
    reg [1:0]shift_combs__or_mask_type;
    reg [1:0]shift_combs__bb_mask_type;
    reg [4:0]shift_combs__shift_control;
    reg [4:0]shift_combs__shift_amount;
    reg [31:0]shift_combs__rotate_in;
    reg [31:0]shift_combs__rotate_by_16;
    reg [31:0]shift_combs__rotate_byte_reverse;
    reg [31:0]shift_combs__rotate_bit_reverse;
    reg [47:0]shift_combs__rotate_out;
    reg [63:0]shift_combs__mask_in;
    reg [63:0]shift_combs__mask_out;
    reg [31:0]shift_combs__shift_and_mask;
    reg [31:0]shift_combs__shift_or_mask;
    reg [31:0]shift_combs__shift_result;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b shifter_operation combinatorial process
        //   
        //       The shifter can be built as a 64-bit shift-right-by-N, with masks to combine the two halves
        //   
        //   
        //       A rotate right by 
        //       
    always @ ( * )//shifter_operation
    begin: shifter_operation__comb_code
    reg [1:0]shift_combs__and_mask_type__var;
    reg [1:0]shift_combs__or_mask_type__var;
    reg [1:0]shift_combs__bb_mask_type__var;
    reg [4:0]shift_combs__shift_control__var;
    reg [4:0]shift_combs__shift_amount__var;
    reg [31:0]shift_combs__rotate_by_16__var;
    reg [31:0]shift_combs__rotate_byte_reverse__var;
    reg [31:0]shift_combs__rotate_bit_reverse__var;
    reg [31:0]shift_combs__shift_and_mask__var;
    reg [31:0]shift_combs__shift_or_mask__var;
    reg [31:0]shift_combs__shift_result__var;
        shift_combs__and_mask_type__var = 2'h0;
        shift_combs__or_mask_type__var = 2'h0;
        shift_combs__bb_mask_type__var = 2'h0;
        case (idecode__shift_op) //synopsys parallel_case
        4'h0: // req 1
            begin
            shift_combs__and_mask_type__var = 2'h1;
            shift_combs__or_mask_type__var = 2'h0;
            end
        4'h4: // req 1
            begin
            shift_combs__and_mask_type__var = 2'h3;
            shift_combs__or_mask_type__var = 2'h0;
            end
        4'h6: // req 1
            begin
            shift_combs__and_mask_type__var = 2'h3;
            shift_combs__or_mask_type__var = ((rs1[31]!=1'h0)?2'h1:2'h0);
            end
        4'h1: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h1;
                shift_combs__or_mask_type__var = 2'h3;
            end //if
            end
        4'h5: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h3;
                shift_combs__or_mask_type__var = 2'h1;
            end //if
            end
        4'h3: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h0;
                shift_combs__or_mask_type__var = 2'h0;
            end //if
            end
        4'h7: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h0;
                shift_combs__or_mask_type__var = 2'h0;
            end //if
            end
        4'hc: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h0;
                shift_combs__or_mask_type__var = 2'h0;
            end //if
            end
        4'h8: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h1;
                shift_combs__bb_mask_type__var = 2'h1;
                shift_combs__or_mask_type__var = 2'h2;
            end //if
            end
        4'h9: // req 1
            begin
            if ((1'h1!=64'h0))
            begin
                shift_combs__and_mask_type__var = 2'h1;
                shift_combs__bb_mask_type__var = 2'h3;
                shift_combs__or_mask_type__var = 2'h2;
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
        shift_combs__rotate_in = rs1;
        shift_combs__shift_control__var = rs2[4:0];
        if ((idecode__immediate_valid!=1'h0))
        begin
            shift_combs__shift_control__var = idecode__immediate_shift;
        end //if
        shift_combs__shift_amount__var = shift_combs__shift_control__var;
        if (!((idecode__shift_op & 4'h4)!=4'h0))
        begin
            shift_combs__shift_amount__var = (~shift_combs__shift_control__var+5'h1);
        end //if
        shift_combs__mask_in = {32'hffffffff,32'h0};
        shift_combs__rotate_by_16__var = shift_combs__rotate_in;
        if ((shift_combs__shift_amount__var[4]!=1'h0))
        begin
            shift_combs__rotate_by_16__var = {shift_combs__rotate_in[15:0],shift_combs__rotate_in[31:16]};
        end //if
        shift_combs__rotate_byte_reverse__var = shift_combs__rotate_by_16__var;
        if ((shift_combs__shift_amount__var[3]!=1'h0))
        begin
            shift_combs__rotate_byte_reverse__var = {{{shift_combs__rotate_by_16__var[23:16],shift_combs__rotate_by_16__var[31:24]},shift_combs__rotate_by_16__var[7:0]},shift_combs__rotate_by_16__var[15:8]};
        end //if
        shift_combs__rotate_bit_reverse__var = shift_combs__rotate_byte_reverse__var;
        if ((shift_combs__shift_amount__var[0]!=1'h0))
        begin
            shift_combs__rotate_bit_reverse__var[7:0] = {{{{{{{shift_combs__rotate_byte_reverse__var[0],shift_combs__rotate_byte_reverse__var[1]},shift_combs__rotate_byte_reverse__var[2]},shift_combs__rotate_byte_reverse__var[3]},shift_combs__rotate_byte_reverse__var[4]},shift_combs__rotate_byte_reverse__var[5]},shift_combs__rotate_byte_reverse__var[6]},shift_combs__rotate_byte_reverse__var[7]};
            shift_combs__rotate_bit_reverse__var[15:8] = {{{{{{{shift_combs__rotate_byte_reverse__var[8],shift_combs__rotate_byte_reverse__var[9]},shift_combs__rotate_byte_reverse__var[10]},shift_combs__rotate_byte_reverse__var[11]},shift_combs__rotate_byte_reverse__var[12]},shift_combs__rotate_byte_reverse__var[13]},shift_combs__rotate_byte_reverse__var[14]},shift_combs__rotate_byte_reverse__var[15]};
            shift_combs__rotate_bit_reverse__var[23:16] = {{{{{{{shift_combs__rotate_byte_reverse__var[16],shift_combs__rotate_byte_reverse__var[17]},shift_combs__rotate_byte_reverse__var[18]},shift_combs__rotate_byte_reverse__var[19]},shift_combs__rotate_byte_reverse__var[20]},shift_combs__rotate_byte_reverse__var[21]},shift_combs__rotate_byte_reverse__var[22]},shift_combs__rotate_byte_reverse__var[23]};
            shift_combs__rotate_bit_reverse__var[31:24] = {{{{{{{shift_combs__rotate_byte_reverse__var[24],shift_combs__rotate_byte_reverse__var[25]},shift_combs__rotate_byte_reverse__var[26]},shift_combs__rotate_byte_reverse__var[27]},shift_combs__rotate_byte_reverse__var[28]},shift_combs__rotate_byte_reverse__var[29]},shift_combs__rotate_byte_reverse__var[30]},shift_combs__rotate_byte_reverse__var[31]};
        end //if
        shift_combs__rotate_out = ({shift_combs__rotate_by_16__var[15:0],shift_combs__rotate_by_16__var}>>shift_combs__shift_amount__var[3:0]);
        shift_combs__mask_out = (shift_combs__mask_in>>shift_combs__shift_amount__var);
        shift_combs__shift_and_mask__var = shift_combs__mask_out[31:0];
        case (shift_combs__and_mask_type__var) //synopsys parallel_case
        2'h0: // req 1
            begin
            shift_combs__shift_and_mask__var = 32'hffffffff;
            end
        2'h3: // req 1
            begin
            shift_combs__shift_and_mask__var = ~shift_combs__shift_and_mask__var;
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
        if ((shift_combs__shift_control__var==5'h0))
        begin
            shift_combs__shift_and_mask__var = 32'hffffffff;
        end //if
        if ((1'h1!=64'h0))
        begin
            case (shift_combs__bb_mask_type__var) //synopsys parallel_case
            2'h3: // req 1
                begin
                shift_combs__shift_and_mask__var = (shift_combs__shift_and_mask__var & ~(shift_combs__shift_and_mask__var<<64'h8));
                end
            2'h1: // req 1
                begin
                shift_combs__shift_and_mask__var = (shift_combs__shift_and_mask__var & ~(shift_combs__shift_and_mask__var<<64'h1));
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
        end //if
        shift_combs__shift_or_mask__var = shift_combs__mask_out[31:0];
        if ((shift_combs__shift_control__var==5'h0))
        begin
            shift_combs__shift_or_mask__var = 32'h0;
        end //if
        case (shift_combs__or_mask_type__var) //synopsys parallel_case
        2'h0: // req 1
            begin
            shift_combs__shift_or_mask__var = 32'h0;
            end
        2'h3: // req 1
            begin
            shift_combs__shift_or_mask__var = ~shift_combs__shift_and_mask__var;
            end
        2'h2: // req 1
            begin
            shift_combs__shift_or_mask__var = (rs2 & ~shift_combs__shift_and_mask__var);
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
        shift_combs__shift_result__var = ((shift_combs__rotate_out[31:0] & shift_combs__shift_and_mask__var) | shift_combs__shift_or_mask__var);
        if ((1'h1!=64'h0))
        begin
            if ((idecode__shift_op==4'hc))
            begin
                shift_combs__shift_result__var = shift_combs__rotate_bit_reverse__var;
            end //if
        end //if
        shift_combs__and_mask_type = shift_combs__and_mask_type__var;
        shift_combs__or_mask_type = shift_combs__or_mask_type__var;
        shift_combs__bb_mask_type = shift_combs__bb_mask_type__var;
        shift_combs__shift_control = shift_combs__shift_control__var;
        shift_combs__shift_amount = shift_combs__shift_amount__var;
        shift_combs__rotate_by_16 = shift_combs__rotate_by_16__var;
        shift_combs__rotate_byte_reverse = shift_combs__rotate_byte_reverse__var;
        shift_combs__rotate_bit_reverse = shift_combs__rotate_bit_reverse__var;
        shift_combs__shift_and_mask = shift_combs__shift_and_mask__var;
        shift_combs__shift_or_mask = shift_combs__shift_or_mask__var;
        shift_combs__shift_result = shift_combs__shift_result__var;
    end //always

    //b alu_operation combinatorial process
        //   
        //       
    always @ ( * )//alu_operation
    begin: alu_operation__comb_code
    reg [31:0]alu_combs__imm_or_rs2__var;
    reg [31:0]alu_combs__imm_or_rs1__var;
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
            alu_result__result__var = shift_combs__shift_result[31:0];
            end
        4'h5: // req 1
            begin
            alu_result__result__var = shift_combs__shift_result[31:0];
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
        alu_result__csr_access__mode = idecode__csr_access__mode;
        alu_result__csr_access__access_cancelled = idecode__csr_access__access_cancelled;
        alu_result__csr_access__access = idecode__csr_access__access;
        alu_result__csr_access__custom__mhartid = idecode__csr_access__custom__mhartid;
        alu_result__csr_access__custom__misa = idecode__csr_access__custom__misa;
        alu_result__csr_access__custom__mvendorid = idecode__csr_access__custom__mvendorid;
        alu_result__csr_access__custom__marchid = idecode__csr_access__custom__marchid;
        alu_result__csr_access__custom__mimpid = idecode__csr_access__custom__mimpid;
        alu_result__csr_access__address = idecode__csr_access__address;
        alu_result__csr_access__select = idecode__csr_access__select;
        alu_result__csr_access__write_data__var = idecode__csr_access__write_data;
        alu_result__csr_access__write_data__var = alu_combs__imm_or_rs1__var;
        alu_combs__imm_or_rs2 = alu_combs__imm_or_rs2__var;
        alu_combs__imm_or_rs1 = alu_combs__imm_or_rs1__var;
        alu_combs__arith_in_1 = alu_combs__arith_in_1__var;
        alu_combs__arith_carry_in = alu_combs__arith_carry_in__var;
        alu_combs__arith_result = alu_combs__arith_result__var;
        alu_result__branch_condition_met = alu_result__branch_condition_met__var;
        alu_result__result = alu_result__result__var;
        alu_result__branch_target = alu_result__branch_target__var;
        alu_result__csr_access__write_data = alu_result__csr_access__write_data__var;
    end //always

endmodule // riscv_i32_alu
