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

//a Module riscv_i32_decode
    //   
    //   Instruction decoder for RISC-V I32 instruction set.
    //   
    //   This is based on the RISC-V v2.2 specification (hence figure numbers
    //   are from that specification)
    //   
    //   It provides for the option of RV32E and RV32M.
    //   
    //   RV32E indicates an illegal instruction if a register outside 0-15 is accessed.
    //   
    //   RV32M provides decode of multiply and divide; if it is not desired
    //   then the instructions are decoded as illegal.
    //   
    //   25-bit opcode spaces should chose one of the standard R/I/S/U encodings
    //   R is Rd, Rs1, Rs2           plus 10 bits for encoding
    //   I is Rd, Rs1, imm(12 bits)  plus 3 bits for encoding
    //   S is Rs1, Rs2, imm(12 bits) plus 3 bits for encoding
    //   U is Rd, imm(20 bits starting at bit 12) with no spare bits
    //   
    //   Custom-0 is a 25-bit opcode space with instruction bottom bits of 7b0001011
    //   Custom-1 is a 25-bit opcode space with instruction bottom bits of 7b0101011
    //   Custom-2 is a 25-bit opcode space with instruction bottom bits of 7b1011011; this conflicts with RV-128 but is available for RV-32
    //   Custom-3 is a 25-bit opcode space with instruction bottom bits of 7b1111011; this conflicts with RV-128 but is available for RV-32
    //   
    //   22-bit opcode spaces are parts of the standard 25-bit opcode spaces
    //   There are 2 unused branch encodings (funct3 of 3b010, 3b011)
    //   There are 2 unused ALU-immediate encodings (funct3 of 3b001, 3b101)
    //   
    //   Atomic instructions are 7b0101111 in bottom 7 bits - top 6 bits are the atomic type; this has a standard 3-register encoding
    //   
    //   
module riscv_i32_decode
(

    riscv_config__i32c,
    riscv_config__e32,
    riscv_config__i32m,
    riscv_config__i32m_fuse,
    riscv_config__debug_enable,
    riscv_config__coproc_disable,
    riscv_config__unaligned_mem,
    instruction__data,
    instruction__debug__valid,
    instruction__debug__debug_op,
    instruction__debug__data,

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
    idecode__ext__dummy
);

    //b Clocks

    //b Inputs
    input riscv_config__i32c;
    input riscv_config__e32;
    input riscv_config__i32m;
    input riscv_config__i32m_fuse;
    input riscv_config__debug_enable;
    input riscv_config__coproc_disable;
    input riscv_config__unaligned_mem;
    input [31:0]instruction__data;
    input instruction__debug__valid;
    input [1:0]instruction__debug__debug_op;
    input [15:0]instruction__debug__data;

    //b Outputs
    output [4:0]idecode__rs1;
    output idecode__rs1_valid;
    output [4:0]idecode__rs2;
    output idecode__rs2_valid;
    output [4:0]idecode__rd;
    output idecode__rd_written;
    output idecode__csr_access__access_cancelled;
    output [2:0]idecode__csr_access__access;
    output [11:0]idecode__csr_access__address;
    output [31:0]idecode__csr_access__write_data;
    output [31:0]idecode__immediate;
    output [4:0]idecode__immediate_shift;
    output idecode__immediate_valid;
    output [3:0]idecode__op;
    output [3:0]idecode__subop;
    output [6:0]idecode__funct7;
    output [2:0]idecode__minimum_mode;
    output idecode__illegal;
    output idecode__illegal_pc;
    output idecode__is_compressed;
    output idecode__ext__dummy;

// output components here

    //b Output combinatorials
    reg [4:0]idecode__rs1;
    reg idecode__rs1_valid;
    reg [4:0]idecode__rs2;
    reg idecode__rs2_valid;
    reg [4:0]idecode__rd;
    reg idecode__rd_written;
    reg idecode__csr_access__access_cancelled;
    reg [2:0]idecode__csr_access__access;
    reg [11:0]idecode__csr_access__address;
    reg [31:0]idecode__csr_access__write_data;
    reg [31:0]idecode__immediate;
    reg [4:0]idecode__immediate_shift;
    reg idecode__immediate_valid;
    reg [3:0]idecode__op;
    reg [3:0]idecode__subop;
    reg [6:0]idecode__funct7;
    reg [2:0]idecode__minimum_mode;
    reg idecode__illegal;
    reg idecode__illegal_pc;
    reg idecode__is_compressed;
    reg idecode__ext__dummy;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
        //   Combinatorials used in the module, not exported as the decode
    reg [1:0]combs__must_be_ones;
    reg combs__is_imm_op;
    reg [4:0]combs__opc;
    reg [6:0]combs__funct7;
    reg [2:0]combs__funct3;
    reg [31:0]combs__imm_signed;
    reg combs__rs1_nonzero;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b instruction_breakout combinatorial process
        //   
        //       Break out the instruction into fields, using constants from
        //       riscv_internal_types
        //   
        //       Any output ports driven by these signals are simple wires, of
        //       course.
        //   
        //       All base instruction types (R/I/S/U) need the opcode @combs.opc
        //       field; for those that require rd, rs1 and rs2 they is always in
        //       the same place; the remaining fields are funct3 (used in R/I/S
        //       types), funct7 (used in R type instructions), and various
        //       immediate fields.
        //   
        //       Spec 2.2 fig 2.3 shows opcode (must_be_ones and opc); rd, rs1, rs2; funct3 and funct7.
        //       The other fields in fig 2.3 relate to the immediate value (see immediate_decode)
        //       
    always @ ( * )//instruction_breakout
    begin: instruction_breakout__comb_code
        combs__must_be_ones = instruction__data[1:0];
        combs__opc = instruction__data[6:2];
        idecode__rd = instruction__data[11:7];
        combs__funct3 = instruction__data[14:12];
        idecode__rs1 = instruction__data[19:15];
        idecode__rs2 = instruction__data[24:20];
        combs__funct7 = instruction__data[31:25];
    end //always

    //b immediate_decode combinatorial process
        //   
        //       Decode the immediate value based on the instruction opcode class.
        //   
        //       The immediate is generally a sign-extended value, with the sign
        //       bit coming from the top bit of the instruction.  Hence @a
        //       combs.imm_signed is created as a 32 bit value of either all ones
        //       or all zeros, to be used as a sign extension bit vector as required.
        //       
        //       The immediate variants of the RISC-V I32 base instruction (fig 2.4) are:
        //   
        //         I-type (12-bit sign extended using i[31], i[11;20]) (register-immediate, load, jalr)
        //   
        //         S-type (12-bit sign extended using i[31], i[6;25], i[5;7]) (store)
        //   
        //         B-type ?(13-bit, one zero, sign extended using i[31], i[7], i[6;25], i[4;8], 0) (branch)
        //   
        //         U-type ?(32-bit, twelve zeros, sign extended using i[31]; i[19;12], 12b0 (lui, auipc)
        //   
        //         J-type ?(12-bit sign extended using i[31], i[8;12], i[20], i[10;21], 0) (jal)
        //   
        //       Note that all are sign extended, hence i[31] is replicated on the top bits.
        //       
    always @ ( * )//immediate_decode
    begin: immediate_decode__comb_code
    reg idecode__immediate_valid__var;
    reg [31:0]idecode__immediate__var;
        combs__imm_signed = ((combs__funct7[6]!=1'h0)?64'hffffffffffffffff:64'h0);
        idecode__immediate_valid__var = 1'h0;
        idecode__immediate_shift = idecode__rs2;
        idecode__immediate__var = {{combs__imm_signed[19:0],combs__funct7},idecode__rs2};
        case (combs__opc) //synopsys parallel_case
        5'h4: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            end
        5'h0: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            end
        5'h19: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            end
        5'h8: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            idecode__immediate__var = {{combs__imm_signed[19:0],combs__funct7},idecode__rd};
            end
        5'h18: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            idecode__immediate__var = {{{{{combs__imm_signed[18:0],combs__funct7[6]},idecode__rd[0]},combs__funct7[5:0]},idecode__rd[4:1]},1'h0};
            end
        5'h1b: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            idecode__immediate__var = {{{{{{{combs__imm_signed[10:0],combs__funct7[6]},idecode__rs1},combs__funct3},idecode__rs2[0]},combs__funct7[5:0]},idecode__rs2[4:1]},1'h0};
            end
        5'hd: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            idecode__immediate__var = {{{{combs__funct7,idecode__rs2},idecode__rs1},combs__funct3},12'h0};
            end
        5'h5: // req 1
            begin
            idecode__immediate_valid__var = 1'h1;
            idecode__immediate__var = {{{{combs__funct7,idecode__rs2},idecode__rs1},combs__funct3},12'h0};
            end
        5'h1c: // req 1
            begin
            idecode__immediate_valid__var = instruction__data[14];
            idecode__immediate__var = {27'h0,idecode__rs1};
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
        idecode__immediate_valid = idecode__immediate_valid__var;
        idecode__immediate = idecode__immediate__var;
    end //always

    //b instruction_decode combinatorial process
        //   
        //       Decode the instruction
        //       
    always @ ( * )//instruction_decode
    begin: instruction_decode__comb_code
    reg idecode__rs1_valid__var;
    reg idecode__rs2_valid__var;
    reg idecode__rd_written__var;
    reg [2:0]idecode__minimum_mode__var;
    reg [3:0]idecode__op__var;
    reg idecode__illegal__var;
    reg [3:0]idecode__subop__var;
    reg [2:0]idecode__csr_access__access__var;
    reg [11:0]idecode__csr_access__address__var;
        idecode__ext__dummy = 1'h0;
        idecode__illegal_pc = 1'h0;
        idecode__is_compressed = 1'h0;
        idecode__rs1_valid__var = 1'h0;
        idecode__rs2_valid__var = 1'h0;
        idecode__rd_written__var = 1'h0;
        idecode__minimum_mode__var = 3'h0;
        combs__is_imm_op = (combs__opc==5'h4);
        idecode__op__var = 4'hf;
        idecode__illegal__var = 1'h1;
        idecode__subop__var = 4'h0;
        idecode__funct7 = combs__funct7;
        idecode__csr_access__access_cancelled = 1'h0;
        idecode__csr_access__access__var = 3'h0;
        idecode__csr_access__address__var = 12'h0;
        idecode__csr_access__write_data = 32'h0;
        idecode__csr_access__address__var = instruction__data[31:20];
        idecode__csr_access__access__var = 3'h0;
        combs__rs1_nonzero = (idecode__rs1!=5'h0);
        case (combs__opc) //synopsys parallel_case
        5'hd: // req 1
            begin
            idecode__op__var = 4'ha;
            idecode__rd_written__var = 1'h1;
            idecode__illegal__var = 1'h0;
            end
        5'h5: // req 1
            begin
            idecode__op__var = 4'h9;
            idecode__rd_written__var = 1'h1;
            idecode__illegal__var = 1'h0;
            end
        5'h1b: // req 1
            begin
            idecode__op__var = 4'h1;
            idecode__rd_written__var = 1'h1;
            idecode__illegal__var = 1'h0;
            end
        5'h19: // req 1
            begin
            idecode__op__var = 4'h2;
            idecode__rs1_valid__var = 1'h1;
            idecode__rd_written__var = 1'h1;
            idecode__illegal__var = 1'h0;
            end
        5'h0: // req 1
            begin
            idecode__op__var = 4'h6;
            idecode__subop__var = {1'h0,combs__funct3};
            idecode__rs1_valid__var = 1'h1;
            idecode__rd_written__var = 1'h1;
            idecode__illegal__var = 1'h0;
            end
        5'h8: // req 1
            begin
            idecode__op__var = 4'h6;
            idecode__subop__var = {1'h1,combs__funct3};
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = 1'h1;
            idecode__illegal__var = 1'h0;
            end
        5'h18: // req 1
            begin
            idecode__op__var = 4'h0;
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = 1'h1;
            idecode__subop__var = 4'hf;
            idecode__illegal__var = 1'h0;
            case (combs__funct3) //synopsys parallel_case
            3'h0: // req 1
                begin
                idecode__subop__var = 4'h0;
                end
            3'h1: // req 1
                begin
                idecode__subop__var = 4'h1;
                end
            3'h4: // req 1
                begin
                idecode__subop__var = 4'h2;
                end
            3'h6: // req 1
                begin
                idecode__subop__var = 4'h4;
                end
            3'h5: // req 1
                begin
                idecode__subop__var = 4'h3;
                end
            3'h7: // req 1
                begin
                idecode__subop__var = 4'h5;
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
        5'hc: // req 1
            begin
            idecode__op__var = 4'h7;
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = !(combs__is_imm_op!=1'h0);
            idecode__rd_written__var = 1'h1;
            if (((combs__funct7==7'h1)&&!(combs__is_imm_op!=1'h0)))
            begin
                if ((1'h1&&(riscv_config__i32m!=1'h0)))
                begin
                    idecode__illegal__var = 1'h0;
                    idecode__op__var = 4'h8;
                    case (combs__funct3) //synopsys parallel_case
                    3'h0: // req 1
                        begin
                        idecode__subop__var = 4'h0;
                        end
                    3'h1: // req 1
                        begin
                        idecode__subop__var = 4'h1;
                        end
                    3'h2: // req 1
                        begin
                        idecode__subop__var = 4'h2;
                        end
                    3'h3: // req 1
                        begin
                        idecode__subop__var = 4'h3;
                        end
                    3'h4: // req 1
                        begin
                        idecode__subop__var = 4'h4;
                        end
                    3'h5: // req 1
                        begin
                        idecode__subop__var = 4'h5;
                        end
                    3'h6: // req 1
                        begin
                        idecode__subop__var = 4'h6;
                        end
                    3'h7: // req 1
                        begin
                        idecode__subop__var = 4'h7;
                        end
    //synopsys  translate_off
    //pragma coverage off
                    default:
                        begin
                            if (1)
                            begin
                                $display("%t *********CDL ASSERTION FAILURE:riscv_i32_decode:instruction_decode: Full switch statement did not cover all values", $time);
                            end
                        end
    //pragma coverage on
    //synopsys  translate_on
                    endcase
                end //if
            end //if
            else
            
            begin
                idecode__illegal__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7!=7'h0))&&(combs__funct7!=7'h20));
                case (combs__funct3) //synopsys parallel_case
                3'h0: // req 1
                    begin
                    idecode__subop__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7[5]!=1'h0))?4'h8:4'h0);
                    end
                3'h2: // req 1
                    begin
                    idecode__subop__var = 4'h2;
                    end
                3'h3: // req 1
                    begin
                    idecode__subop__var = 4'h3;
                    end
                3'h4: // req 1
                    begin
                    idecode__subop__var = 4'h4;
                    end
                3'h6: // req 1
                    begin
                    idecode__subop__var = 4'h6;
                    end
                3'h7: // req 1
                    begin
                    idecode__subop__var = 4'h7;
                    end
                3'h1: // req 1
                    begin
                    idecode__illegal__var = (combs__funct7!=7'h0);
                    idecode__subop__var = 4'h1;
                    end
                3'h5: // req 1
                    begin
                    idecode__illegal__var = ((combs__funct7[4:0]!=5'h0)||(combs__funct7[6]!=1'h0));
                    idecode__subop__var = ((combs__funct7[5]!=1'h0)?4'hd:4'h5);
                    end
                default: // req 1
                    begin
                    idecode__illegal__var = 1'h1;
                    end
                endcase
            end //else
            end
        5'h4: // req 1
            begin
            idecode__op__var = 4'h7;
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = !(combs__is_imm_op!=1'h0);
            idecode__rd_written__var = 1'h1;
            if (((combs__funct7==7'h1)&&!(combs__is_imm_op!=1'h0)))
            begin
                if ((1'h1&&(riscv_config__i32m!=1'h0)))
                begin
                    idecode__illegal__var = 1'h0;
                    idecode__op__var = 4'h8;
                    case (combs__funct3) //synopsys parallel_case
                    3'h0: // req 1
                        begin
                        idecode__subop__var = 4'h0;
                        end
                    3'h1: // req 1
                        begin
                        idecode__subop__var = 4'h1;
                        end
                    3'h2: // req 1
                        begin
                        idecode__subop__var = 4'h2;
                        end
                    3'h3: // req 1
                        begin
                        idecode__subop__var = 4'h3;
                        end
                    3'h4: // req 1
                        begin
                        idecode__subop__var = 4'h4;
                        end
                    3'h5: // req 1
                        begin
                        idecode__subop__var = 4'h5;
                        end
                    3'h6: // req 1
                        begin
                        idecode__subop__var = 4'h6;
                        end
                    3'h7: // req 1
                        begin
                        idecode__subop__var = 4'h7;
                        end
    //synopsys  translate_off
    //pragma coverage off
                    default:
                        begin
                            if (1)
                            begin
                                $display("%t *********CDL ASSERTION FAILURE:riscv_i32_decode:instruction_decode: Full switch statement did not cover all values", $time);
                            end
                        end
    //pragma coverage on
    //synopsys  translate_on
                    endcase
                end //if
            end //if
            else
            
            begin
                idecode__illegal__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7!=7'h0))&&(combs__funct7!=7'h20));
                case (combs__funct3) //synopsys parallel_case
                3'h0: // req 1
                    begin
                    idecode__subop__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7[5]!=1'h0))?4'h8:4'h0);
                    end
                3'h2: // req 1
                    begin
                    idecode__subop__var = 4'h2;
                    end
                3'h3: // req 1
                    begin
                    idecode__subop__var = 4'h3;
                    end
                3'h4: // req 1
                    begin
                    idecode__subop__var = 4'h4;
                    end
                3'h6: // req 1
                    begin
                    idecode__subop__var = 4'h6;
                    end
                3'h7: // req 1
                    begin
                    idecode__subop__var = 4'h7;
                    end
                3'h1: // req 1
                    begin
                    idecode__illegal__var = (combs__funct7!=7'h0);
                    idecode__subop__var = 4'h1;
                    end
                3'h5: // req 1
                    begin
                    idecode__illegal__var = ((combs__funct7[4:0]!=5'h0)||(combs__funct7[6]!=1'h0));
                    idecode__subop__var = ((combs__funct7[5]!=1'h0)?4'hd:4'h5);
                    end
                default: // req 1
                    begin
                    idecode__illegal__var = 1'h1;
                    end
                endcase
            end //else
            end
        5'h3: // req 1
            begin
            idecode__illegal__var = 1'h0;
            idecode__op__var = 4'h5;
            idecode__subop__var = ((combs__funct3[0]!=1'h0)?4'h1:4'h0);
            end
        5'h1c: // req 1
            begin
            idecode__op__var = 4'h3;
            idecode__rs1_valid__var = 1'h1;
            idecode__rd_written__var = 1'h1;
            idecode__illegal__var = 1'h0;
            case (combs__funct3[1:0]) //synopsys parallel_case
            2'h1: // req 1
                begin
                idecode__op__var = 4'h4;
                idecode__subop__var = 4'h1;
                idecode__csr_access__access__var = 3'h3;
                if ((idecode__rd==5'h0))
                begin
                    idecode__csr_access__access__var = 3'h1;
                end //if
                end
            2'h2: // req 1
                begin
                idecode__op__var = 4'h4;
                idecode__subop__var = 4'h2;
                idecode__csr_access__access__var = 3'h6;
                if (!(combs__rs1_nonzero!=1'h0))
                begin
                    idecode__csr_access__access__var = 3'h2;
                end //if
                end
            2'h3: // req 1
                begin
                idecode__op__var = 4'h4;
                idecode__subop__var = 4'h3;
                idecode__csr_access__access__var = 3'h7;
                if (!(combs__rs1_nonzero!=1'h0))
                begin
                    idecode__csr_access__access__var = 3'h2;
                end //if
                end
            2'h0: // req 1
                begin
                idecode__op__var = 4'h3;
                case (instruction__data[31:20]) //synopsys parallel_case
                12'h0: // req 1
                    begin
                    idecode__subop__var = 4'h0;
                    end
                12'h1: // req 1
                    begin
                    idecode__subop__var = 4'h1;
                    end
                12'h302: // req 1
                    begin
                    idecode__subop__var = 4'h2;
                    idecode__minimum_mode__var = 3'h3;
                    end
                12'h105: // req 1
                    begin
                    idecode__subop__var = 4'h3;
                    idecode__minimum_mode__var = 3'h3;
                    end
                default: // req 1
                    begin
                    idecode__illegal__var = 1'h1;
                    end
                endcase
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_decode:instruction_decode: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
            end
        5'h2: // req 1
            begin
            if (1'h0)
            begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'hb;
                idecode__subop__var = {1'h0,combs__funct3};
            end //if
            end
        5'ha: // req 1
            begin
            if (1'h0)
            begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'hc;
                idecode__subop__var = {1'h0,combs__funct3};
            end //if
            end
        5'h16: // req 1
            begin
            if (1'h0)
            begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'hd;
                idecode__subop__var = {1'h0,combs__funct3};
            end //if
            end
        5'h1e: // req 1
            begin
            if (1'h0)
            begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'he;
                idecode__subop__var = {1'h0,combs__funct3};
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
        if ((combs__must_be_ones!=2'h3))
        begin
            idecode__illegal__var = 1'h1;
        end //if
        if ((idecode__rs1==5'h0))
        begin
            idecode__rs1_valid__var = 1'h0;
        end //if
        if ((idecode__rs2==5'h0))
        begin
            idecode__rs2_valid__var = 1'h0;
        end //if
        if ((idecode__rd==5'h0))
        begin
            idecode__rd_written__var = 1'h0;
        end //if
        if (((riscv_config__e32!=1'h0)||(1'h0!=64'h0)))
        begin
            if (((idecode__rs1_valid__var!=1'h0)&&(idecode__rs1[4]!=1'h0)))
            begin
                idecode__illegal__var = 1'h1;
            end //if
            if (((idecode__rs2_valid__var!=1'h0)&&(idecode__rs2[4]!=1'h0)))
            begin
                idecode__illegal__var = 1'h1;
            end //if
            if (((idecode__rd_written__var!=1'h0)&&(idecode__rd[4]!=1'h0)))
            begin
                idecode__illegal__var = 1'h1;
            end //if
        end //if
        idecode__rs1_valid = idecode__rs1_valid__var;
        idecode__rs2_valid = idecode__rs2_valid__var;
        idecode__rd_written = idecode__rd_written__var;
        idecode__minimum_mode = idecode__minimum_mode__var;
        idecode__op = idecode__op__var;
        idecode__illegal = idecode__illegal__var;
        idecode__subop = idecode__subop__var;
        idecode__csr_access__access = idecode__csr_access__access__var;
        idecode__csr_access__address = idecode__csr_access__address__var;
    end //always

endmodule // riscv_i32_decode
