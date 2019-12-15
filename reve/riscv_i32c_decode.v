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

//a Module riscv_i32c_decode
    //   
    //   Instruction decoder for RISC-V I16 instruction set.
    //   
    //   This is based on the RISC-V v2.2 specification (hence figure numbers
    //   are from that specification)
    //   
    //   Note that custom opcodes are available
    //   
    //   
module riscv_i32c_decode
(

    riscv_config__i32c,
    riscv_config__e32,
    riscv_config__i32m,
    riscv_config__i32m_fuse,
    riscv_config__debug_enable,
    riscv_config__coproc_disable,
    riscv_config__unaligned_mem,
    riscv_config__mem_abort_late,
    instruction__mode,
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
    input riscv_config__mem_abort_late;
    input [2:0]instruction__mode;
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
    output [2:0]idecode__csr_access__mode;
    output idecode__csr_access__access_cancelled;
    output [2:0]idecode__csr_access__access;
    output [31:0]idecode__csr_access__custom__mhartid;
    output [31:0]idecode__csr_access__custom__misa;
    output [31:0]idecode__csr_access__custom__mvendorid;
    output [31:0]idecode__csr_access__custom__marchid;
    output [31:0]idecode__csr_access__custom__mimpid;
    output [11:0]idecode__csr_access__address;
    output [11:0]idecode__csr_access__select;
    output [31:0]idecode__csr_access__write_data;
    output [31:0]idecode__immediate;
    output [4:0]idecode__immediate_shift;
    output idecode__immediate_valid;
    output [3:0]idecode__op;
    output [3:0]idecode__subop;
    output [3:0]idecode__shift_op;
    output [6:0]idecode__funct7;
    output idecode__illegal;
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
    reg [2:0]idecode__csr_access__mode;
    reg idecode__csr_access__access_cancelled;
    reg [2:0]idecode__csr_access__access;
    reg [31:0]idecode__csr_access__custom__mhartid;
    reg [31:0]idecode__csr_access__custom__misa;
    reg [31:0]idecode__csr_access__custom__mvendorid;
    reg [31:0]idecode__csr_access__custom__marchid;
    reg [31:0]idecode__csr_access__custom__mimpid;
    reg [11:0]idecode__csr_access__address;
    reg [11:0]idecode__csr_access__select;
    reg [31:0]idecode__csr_access__write_data;
    reg [31:0]idecode__immediate;
    reg [4:0]idecode__immediate_shift;
    reg idecode__immediate_valid;
    reg [3:0]idecode__op;
    reg [3:0]idecode__subop;
    reg [3:0]idecode__shift_op;
    reg [6:0]idecode__funct7;
    reg idecode__illegal;
    reg idecode__is_compressed;
    reg idecode__ext__dummy;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
        //   Combinatorials used in the module, not exported as the decode
    reg [1:0]combs__quadrant;
    reg [2:0]combs__opc;
    reg [4:0]combs__rd_q0;
    reg [4:0]combs__rd_q12;
    reg [4:0]combs__rs1;
    reg [4:0]combs__rs2;
    reg [31:0]combs__imm_signed;
    reg [31:0]combs__imm_ci_v1;
    reg [31:0]combs__imm_clwsp;
    reg [31:0]combs__imm_clui;
    reg [31:0]combs__imm_caddi16sp;
    reg [31:0]combs__imm_caddi4spn;
    reg [31:0]combs__imm_cswsp;
    reg [31:0]combs__imm_clwsw;
    reg [31:0]combs__imm_cb;
    reg [31:0]combs__imm_cj;

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
    always @ ( * )//instruction_breakout
    begin: instruction_breakout__comb_code
        combs__quadrant = instruction__data[1:0];
        combs__opc = instruction__data[15:13];
        combs__rd_q0 = {2'h1,instruction__data[4:2]};
        combs__rd_q12 = instruction__data[11:7];
        combs__rs1 = instruction__data[11:7];
        combs__rs2 = instruction__data[6:2];
    end //always

    //b immediate_decode combinatorial process
        //   
        //       Decode the immediate value based on the instruction opcode class.
        //   
        //       The immediate is sometimes a sign-extended value, with the sign
        //       bit coming from bit 12 of the instruction.  Hence @a
        //       combs.imm_signed is created as a 32 bit value of either all ones
        //       or all zeros, to be used as a sign extension bit vector as required.
        //   
        //       The immediate variants of the RISC-V I32C base instruction have to be extracted from section 12 and are:
        //   
        //       CI v1  sign extended     i[12],  i[5;2]                                for  li, addi, andi
        //       CI v2  zero ext          i[2;2] i[12], i[3;4], 2b0                     for lwsp
        //       CI v3  sign extended     i[12], i[5;2], 12b0                           for lui
        //       CI v4  sign extended     i[12], i[2;3], i[5], i[2], i[6], 4b0          for addi16sp
        //       CIW    zero ext    i[4;7], i[2;11], i[5] i[6], 2b0                     for addi4spn
        //       CSS,   zero ext               i[2;7], i[4;9], 2b0                      for swsp
        //       CL, CS zero ext           i[5], i[3;10], i[6], 2b0                     for lw, sw
        //       CB,    sign ext  i[12], i[2;5], i[2], i[2;10], i[2;3], 1b0             for beqz/bnez
        //       CJ     sign ext  i[12], i[8], i[2;9], i[3;6], i[2], i[11], i[3;3], 1b0 for j/jal
        //   
        //       
    always @ ( * )//immediate_decode
    begin: immediate_decode__comb_code
    reg idecode__immediate_valid__var;
    reg [31:0]idecode__immediate__var;
        combs__imm_signed = ((instruction__data[12]!=1'h0)?64'hffffffffffffffff:64'h0);
        idecode__immediate_valid__var = 1'h1;
        idecode__immediate_shift = instruction__data[6:2];
        combs__imm_ci_v1 = {combs__imm_signed[26:0],instruction__data[6:2]};
        combs__imm_clwsp = {{{{24'h0,instruction__data[3:2]},instruction__data[12]},instruction__data[6:4]},2'h0};
        combs__imm_clui = {{combs__imm_signed[14:0],instruction__data[6:2]},12'h0};
        combs__imm_caddi16sp = {{{{{combs__imm_signed[22:0],instruction__data[4:3]},instruction__data[5]},instruction__data[2]},instruction__data[6]},4'h0};
        combs__imm_caddi4spn = {{{{{22'h0,instruction__data[10:7]},instruction__data[12:11]},instruction__data[5]},instruction__data[6]},2'h0};
        combs__imm_cswsp = {{{24'h0,instruction__data[8:7]},instruction__data[12:9]},2'h0};
        combs__imm_clwsw = {{{{25'h0,instruction__data[5]},instruction__data[12:10]},instruction__data[6]},2'h0};
        combs__imm_cb = {{{{{combs__imm_signed[23:0],instruction__data[6:5]},instruction__data[2]},instruction__data[11:10]},instruction__data[4:3]},1'h0};
        combs__imm_cj = {{{{{{{{combs__imm_signed[20:0],instruction__data[8]},instruction__data[10:9]},instruction__data[6]},instruction__data[7]},instruction__data[2]},instruction__data[11]},instruction__data[5:3]},1'h0};
        idecode__immediate__var = combs__imm_ci_v1;
        case (combs__quadrant) //synopsys parallel_case
        2'h0: // req 1
            begin
            idecode__immediate__var = combs__imm_clwsw;
            case (combs__opc) //synopsys parallel_case
            3'h0: // req 1
                begin
                idecode__immediate__var = combs__imm_caddi4spn;
                end
            3'h2: // req 1
                begin
                idecode__immediate__var = combs__imm_clwsw;
                end
            3'h6: // req 1
                begin
                idecode__immediate__var = combs__imm_clwsw;
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
        2'h1: // req 1
            begin
            idecode__immediate__var = combs__imm_ci_v1;
            case (combs__opc) //synopsys parallel_case
            3'h0: // req 1
                begin
                idecode__immediate__var = combs__imm_ci_v1;
                end
            3'h1: // req 1
                begin
                idecode__immediate__var = combs__imm_cj;
                end
            3'h2: // req 1
                begin
                idecode__immediate__var = combs__imm_ci_v1;
                end
            3'h3: // req 1
                begin
                idecode__immediate__var = combs__imm_clui;
                if ((instruction__data[11:7]==5'h2))
                begin
                    idecode__immediate__var = combs__imm_caddi16sp;
                end //if
                end
            3'h4: // req 1
                begin
                idecode__immediate__var = combs__imm_ci_v1;
                if ((instruction__data[11:10]==2'h3))
                begin
                    idecode__immediate_valid__var = 1'h0;
                end //if
                end
            3'h5: // req 1
                begin
                idecode__immediate__var = combs__imm_cj;
                end
            3'h6: // req 1
                begin
                idecode__immediate__var = combs__imm_cb;
                end
            3'h7: // req 1
                begin
                idecode__immediate__var = combs__imm_cb;
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
        2'h2: // req 1
            begin
            idecode__immediate__var = combs__imm_clwsp;
            case (combs__opc) //synopsys parallel_case
            3'h4: // req 1
                begin
                idecode__immediate_valid__var = 1'h0;
                idecode__immediate__var = 32'h0;
                end
            3'h0: // req 1
                begin
                idecode__immediate__var = combs__imm_clwsp;
                end
            3'h2: // req 1
                begin
                idecode__immediate__var = combs__imm_clwsp;
                end
            3'h6: // req 1
                begin
                idecode__immediate__var = combs__imm_cswsp;
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
        idecode__immediate_valid = idecode__immediate_valid__var;
        idecode__immediate = idecode__immediate__var;
    end //always

    //b instruction_decode combinatorial process
        //   
        //       Decode the compressed instruction operation
        //       Decode the registers based on the instruction opcode class.
        //   
        //       For many instructions there is a 3-bit register decode, which operate
        //       (per table 12.2 in spec v2.2) on actual registers 8 through 15 (5b01000-0b01111)
        //       These are known as the prime register decodes (rs1', rs2', rd').
        //   
        //       
    always @ ( * )//instruction_decode
    begin: instruction_decode__comb_code
    reg [4:0]idecode__rd__var;
    reg [4:0]idecode__rs1__var;
    reg [4:0]idecode__rs2__var;
    reg idecode__rs1_valid__var;
    reg idecode__rs2_valid__var;
    reg idecode__rd_written__var;
    reg [2:0]idecode__csr_access__access__var;
    reg [3:0]idecode__op__var;
    reg idecode__illegal__var;
    reg [3:0]idecode__subop__var;
    reg [3:0]idecode__shift_op__var;
        idecode__ext__dummy = 1'h0;
        idecode__is_compressed = 1'h1;
        idecode__rd__var = combs__rd_q0;
        idecode__rs1__var = combs__rs1;
        idecode__rs2__var = combs__rs2;
        idecode__rs1_valid__var = 1'h0;
        idecode__rs2_valid__var = 1'h0;
        idecode__rd_written__var = 1'h0;
        idecode__csr_access__mode = 3'h0;
        idecode__csr_access__access_cancelled = 1'h0;
        idecode__csr_access__access__var = 3'h0;
        idecode__csr_access__custom__mhartid = 32'h0;
        idecode__csr_access__custom__misa = 32'h0;
        idecode__csr_access__custom__mvendorid = 32'h0;
        idecode__csr_access__custom__marchid = 32'h0;
        idecode__csr_access__custom__mimpid = 32'h0;
        idecode__csr_access__address = 12'h0;
        idecode__csr_access__select = 12'h0;
        idecode__csr_access__write_data = 32'h0;
        idecode__csr_access__access__var = 3'h0;
        idecode__op__var = 4'hf;
        idecode__illegal__var = 1'h1;
        idecode__subop__var = 4'h0;
        idecode__funct7 = 7'h0;
        idecode__shift_op__var = 4'h4;
        case (combs__quadrant) //synopsys parallel_case
        2'h0: // req 1
            begin
            idecode__rd__var = combs__rd_q0;
            idecode__rs1__var = {2'h1,combs__rs1[2:0]};
            idecode__rs2__var = {2'h1,combs__rs2[2:0]};
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = 1'h0;
            idecode__rd_written__var = 1'h1;
            if ((combs__opc[2]!=1'h0))
            begin
                idecode__rs2_valid__var = 1'h1;
                idecode__rd_written__var = 1'h0;
            end //if
            case (combs__opc) //synopsys parallel_case
            3'h0: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h7;
                idecode__subop__var = 4'h0;
                idecode__rs1__var = 5'h2;
                idecode__rs1_valid__var = 1'h1;
                end
            3'h2: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h6;
                idecode__subop__var = 4'h2;
                idecode__rs1_valid__var = 1'h1;
                idecode__rd_written__var = 1'h1;
                end
            3'h6: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h6;
                idecode__subop__var = 4'ha;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h1;
                idecode__rd_written__var = 1'h0;
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
        2'h1: // req 1
            begin
            idecode__rd__var = combs__rd_q12;
            idecode__rs1__var = combs__rs1;
            idecode__rs2__var = {2'h1,combs__rs2[2:0]};
            if ((combs__opc[2]!=1'h0))
            begin
                idecode__rd__var[4:3] = 2'h1;
                idecode__rs1__var[4:3] = 2'h1;
            end //if
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = 1'h0;
            idecode__rd_written__var = 1'h0;
            case (combs__opc) //synopsys parallel_case
            3'h0: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h7;
                idecode__subop__var = 4'h0;
                idecode__rs1_valid__var = 1'h1;
                idecode__rd_written__var = 1'h1;
                end
            3'h1: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h1;
                idecode__rd__var = 5'h1;
                idecode__rd_written__var = 1'h1;
                end
            3'h2: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h7;
                idecode__subop__var = 4'h0;
                idecode__rs1_valid__var = 1'h1;
                idecode__rd_written__var = 1'h1;
                idecode__rs1__var = 5'h0;
                end
            3'h3: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'ha;
                idecode__rd_written__var = 1'h1;
                idecode__subop__var = 4'h0;
                if ((instruction__data[11:7]==5'h2))
                begin
                    idecode__op__var = 4'h7;
                    idecode__rs1_valid__var = 1'h1;
                    idecode__rd_written__var = 1'h1;
                    idecode__rd__var = 5'h2;
                    idecode__rs1__var = 5'h2;
                end //if
                if ((((instruction__data[12]==1'h0)&&(instruction__data[6:2]==5'h0))||(instruction__data[11:7]==5'h0)))
                begin
                    idecode__illegal__var = 1'h1;
                end //if
                end
            3'h4: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h7;
                idecode__subop__var = 4'h7;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h0;
                idecode__rd_written__var = 1'h1;
                case (instruction__data[11:10]) //synopsys parallel_case
                2'h0: // req 1
                    begin
                    idecode__subop__var = 4'h5;
                    idecode__shift_op__var = 4'h4;
                    idecode__rs2_valid__var = 1'h0;
                    end
                2'h1: // req 1
                    begin
                    idecode__subop__var = 4'h5;
                    idecode__shift_op__var = 4'h6;
                    idecode__rs2_valid__var = 1'h0;
                    end
                2'h2: // req 1
                    begin
                    idecode__subop__var = 4'h7;
                    idecode__rs2_valid__var = 1'h0;
                    end
                2'h3: // req 1
                    begin
                    if ((instruction__data[12]!=1'h0))
                    begin
                        idecode__illegal__var = 1'h1;
                    end //if
                    idecode__subop__var = 4'h7;
                    idecode__rs2_valid__var = 1'h1;
                    case (instruction__data[6:5]) //synopsys parallel_case
                    2'h0: // req 1
                        begin
                        idecode__subop__var = 4'h8;
                        end
                    2'h1: // req 1
                        begin
                        idecode__subop__var = 4'h4;
                        end
                    2'h2: // req 1
                        begin
                        idecode__subop__var = 4'h6;
                        end
                    2'h3: // req 1
                        begin
                        idecode__subop__var = 4'h7;
                        end
    //synopsys  translate_off
    //pragma coverage off
                    default:
                        begin
                            if (1)
                            begin
                                $display("%t *********CDL ASSERTION FAILURE:riscv_i32c_decode:instruction_decode: Full switch statement did not cover all values", $time);
                            end
                        end
    //pragma coverage on
    //synopsys  translate_on
                    endcase
                    end
    //synopsys  translate_off
    //pragma coverage off
                default:
                    begin
                        if (1)
                        begin
                            $display("%t *********CDL ASSERTION FAILURE:riscv_i32c_decode:instruction_decode: Full switch statement did not cover all values", $time);
                        end
                    end
    //pragma coverage on
    //synopsys  translate_on
                endcase
                end
            3'h5: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h1;
                idecode__rd_written__var = 1'h0;
                end
            3'h6: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h0;
                idecode__subop__var = 4'h0;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h1;
                idecode__rs2__var = 5'h0;
                idecode__rd_written__var = 1'h0;
                end
            3'h7: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h0;
                idecode__subop__var = 4'h1;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h1;
                idecode__rs2__var = 5'h0;
                idecode__rd_written__var = 1'h0;
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
        2'h2: // req 1
            begin
            idecode__rd__var = combs__rd_q12;
            idecode__rs1__var = combs__rs1;
            idecode__rs2__var = combs__rs2;
            idecode__rs1_valid__var = 1'h1;
            idecode__rs2_valid__var = 1'h0;
            idecode__rd_written__var = 1'h0;
            if ((combs__opc[1:0]!=2'h0))
            begin
                idecode__rs1__var = 5'h2;
            end //if
            case (combs__opc) //synopsys parallel_case
            3'h4: // req 1
                begin
                idecode__illegal__var = 1'h0;
                if ((combs__rs2==5'h0))
                begin
                    idecode__op__var = 4'h2;
                    idecode__rs1_valid__var = 1'h1;
                    idecode__rs2_valid__var = 1'h0;
                    idecode__rd_written__var = 1'h1;
                    if ((instruction__data[12]!=1'h0))
                    begin
                        idecode__rd__var = 5'h1;
                        if ((combs__rs1==5'h0))
                        begin
                            idecode__op__var = 4'h3;
                            idecode__subop__var = 4'h1;
                            idecode__rd_written__var = 1'h0;
                        end //if
                    end //if
                    else
                    
                    begin
                        idecode__rd__var = 5'h0;
                    end //else
                end //if
                else
                
                begin
                    idecode__op__var = 4'h7;
                    idecode__subop__var = 4'h0;
                    idecode__rs1_valid__var = 1'h1;
                    idecode__rs2_valid__var = 1'h1;
                    idecode__rd_written__var = 1'h1;
                    if (!(instruction__data[12]!=1'h0))
                    begin
                        idecode__rs1__var = 5'h0;
                    end //if
                end //else
                end
            3'h0: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h7;
                idecode__subop__var = 4'h1;
                idecode__shift_op__var = 4'h0;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h0;
                idecode__rd_written__var = 1'h1;
                end
            3'h2: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h6;
                idecode__subop__var = 4'h2;
                idecode__rs1__var = 5'h2;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h0;
                idecode__rd_written__var = 1'h1;
                end
            3'h6: // req 1
                begin
                idecode__illegal__var = 1'h0;
                idecode__op__var = 4'h6;
                idecode__subop__var = 4'ha;
                idecode__rs1__var = 5'h2;
                idecode__rs1_valid__var = 1'h1;
                idecode__rs2_valid__var = 1'h1;
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
        if (((riscv_config__e32!=1'h0)||(1'h0!=64'h0)))
        begin
            if (((idecode__rs1_valid__var!=1'h0)&&(idecode__rs1__var[4]!=1'h0)))
            begin
                idecode__illegal__var = 1'h1;
            end //if
            if (((idecode__rs2_valid__var!=1'h0)&&(idecode__rs2__var[4]!=1'h0)))
            begin
                idecode__illegal__var = 1'h1;
            end //if
            if (((idecode__rd_written__var!=1'h0)&&(idecode__rd__var[4]!=1'h0)))
            begin
                idecode__illegal__var = 1'h1;
            end //if
        end //if
        if ((idecode__rs1__var==5'h0))
        begin
            idecode__rs1_valid__var = 1'h0;
        end //if
        if ((idecode__rs2__var==5'h0))
        begin
            idecode__rs2_valid__var = 1'h0;
        end //if
        if ((idecode__rd__var==5'h0))
        begin
            idecode__rd_written__var = 1'h0;
        end //if
        if ((instruction__data[15:0]==16'h0))
        begin
            idecode__illegal__var = 1'h1;
        end //if
        idecode__rd = idecode__rd__var;
        idecode__rs1 = idecode__rs1__var;
        idecode__rs2 = idecode__rs2__var;
        idecode__rs1_valid = idecode__rs1_valid__var;
        idecode__rs2_valid = idecode__rs2_valid__var;
        idecode__rd_written = idecode__rd_written__var;
        idecode__csr_access__access = idecode__csr_access__access__var;
        idecode__op = idecode__op__var;
        idecode__illegal = idecode__illegal__var;
        idecode__subop = idecode__subop__var;
        idecode__shift_op = idecode__shift_op__var;
    end //always

endmodule // riscv_i32c_decode
