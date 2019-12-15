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
        //   CSR access before select decode
    reg [2:0]csr_access__mode;
    reg csr_access__access_cancelled;
    reg [2:0]csr_access__access;
    reg [31:0]csr_access__custom__mhartid;
    reg [31:0]csr_access__custom__misa;
    reg [31:0]csr_access__custom__mvendorid;
    reg [31:0]csr_access__custom__marchid;
    reg [31:0]csr_access__custom__mimpid;
    reg [11:0]csr_access__address;
    reg [11:0]csr_access__select;
    reg [31:0]csr_access__write_data;
    reg [4:0]idecode_debug__rs1;
    reg idecode_debug__rs1_valid;
    reg [4:0]idecode_debug__rs2;
    reg idecode_debug__rs2_valid;
    reg [4:0]idecode_debug__rd;
    reg idecode_debug__rd_written;
    reg [2:0]idecode_debug__csr_access__mode;
    reg idecode_debug__csr_access__access_cancelled;
    reg [2:0]idecode_debug__csr_access__access;
    reg [31:0]idecode_debug__csr_access__custom__mhartid;
    reg [31:0]idecode_debug__csr_access__custom__misa;
    reg [31:0]idecode_debug__csr_access__custom__mvendorid;
    reg [31:0]idecode_debug__csr_access__custom__marchid;
    reg [31:0]idecode_debug__csr_access__custom__mimpid;
    reg [11:0]idecode_debug__csr_access__address;
    reg [11:0]idecode_debug__csr_access__select;
    reg [31:0]idecode_debug__csr_access__write_data;
    reg [31:0]idecode_debug__immediate;
    reg [4:0]idecode_debug__immediate_shift;
    reg idecode_debug__immediate_valid;
    reg [3:0]idecode_debug__op;
    reg [3:0]idecode_debug__subop;
    reg [3:0]idecode_debug__shift_op;
    reg [6:0]idecode_debug__funct7;
    reg idecode_debug__illegal;
    reg idecode_debug__is_compressed;
    reg idecode_debug__ext__dummy;
    reg [4:0]idecode_inst__rs1;
    reg idecode_inst__rs1_valid;
    reg [4:0]idecode_inst__rs2;
    reg idecode_inst__rs2_valid;
    reg [4:0]idecode_inst__rd;
    reg idecode_inst__rd_written;
    reg [2:0]idecode_inst__csr_access__mode;
    reg idecode_inst__csr_access__access_cancelled;
    reg [2:0]idecode_inst__csr_access__access;
    reg [31:0]idecode_inst__csr_access__custom__mhartid;
    reg [31:0]idecode_inst__csr_access__custom__misa;
    reg [31:0]idecode_inst__csr_access__custom__mvendorid;
    reg [31:0]idecode_inst__csr_access__custom__marchid;
    reg [31:0]idecode_inst__csr_access__custom__mimpid;
    reg [11:0]idecode_inst__csr_access__address;
    reg [11:0]idecode_inst__csr_access__select;
    reg [31:0]idecode_inst__csr_access__write_data;
    reg [31:0]idecode_inst__immediate;
    reg [4:0]idecode_inst__immediate_shift;
    reg idecode_inst__immediate_valid;
    reg [3:0]idecode_inst__op;
    reg [3:0]idecode_inst__subop;
    reg [3:0]idecode_inst__shift_op;
    reg [6:0]idecode_inst__funct7;
    reg idecode_inst__illegal;
    reg idecode_inst__is_compressed;
    reg idecode_inst__ext__dummy;
        //   Combinatorials used in the module, not exported as the decode
    reg combs__use_debug;
    reg [1:0]combs__must_be_ones;
    reg combs__is_imm_op;
    reg [4:0]combs__opc;
    reg [6:0]combs__funct7;
    reg [2:0]combs__funct3;
    reg [31:0]combs__imm_signed;
    reg combs__rs1_nonzero;

    //b Internal nets
        //   CSR decode (select and illegal_access) IF it were a system instruction
    wire csr_decode__illegal_access;
    wire [11:0]csr_decode__csr_select;

    //b Clock gating module instances
    //b Module instances
    riscv_csrs_decode csrs_decode_i32(
        .csr_access__write_data(csr_access__write_data),
        .csr_access__select(csr_access__select),
        .csr_access__address(csr_access__address),
        .csr_access__custom__mimpid(csr_access__custom__mimpid),
        .csr_access__custom__marchid(csr_access__custom__marchid),
        .csr_access__custom__mvendorid(csr_access__custom__mvendorid),
        .csr_access__custom__misa(csr_access__custom__misa),
        .csr_access__custom__mhartid(csr_access__custom__mhartid),
        .csr_access__access(csr_access__access),
        .csr_access__access_cancelled(csr_access__access_cancelled),
        .csr_access__mode(csr_access__mode),
        .csr_decode__csr_select(            csr_decode__csr_select),
        .csr_decode__illegal_access(            csr_decode__illegal_access)         );
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
    reg combs__use_debug__var;
        combs__use_debug__var = instruction__debug__valid;
        if (((1'h0!=64'h0)||!(riscv_config__debug_enable!=1'h0)))
        begin
            combs__use_debug__var = 1'h0;
        end //if
        combs__must_be_ones = instruction__data[1:0];
        combs__opc = instruction__data[6:2];
        idecode_inst__rd = instruction__data[11:7];
        combs__funct3 = instruction__data[14:12];
        idecode_inst__rs1 = instruction__data[19:15];
        idecode_inst__rs2 = instruction__data[24:20];
        combs__funct7 = instruction__data[31:25];
        combs__use_debug = combs__use_debug__var;
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
    reg idecode_inst__immediate_valid__var;
    reg [31:0]idecode_inst__immediate__var;
        combs__imm_signed = ((combs__funct7[6]!=1'h0)?64'hffffffffffffffff:64'h0);
        idecode_inst__immediate_valid__var = 1'h0;
        idecode_inst__immediate_shift = idecode_inst__rs2;
        idecode_inst__immediate__var = {{combs__imm_signed[19:0],combs__funct7},idecode_inst__rs2};
        case (combs__opc) //synopsys parallel_case
        5'h4: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            end
        5'h0: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            end
        5'h19: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            end
        5'h8: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            idecode_inst__immediate__var = {{combs__imm_signed[19:0],combs__funct7},idecode_inst__rd};
            end
        5'h18: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            idecode_inst__immediate__var = {{{{{combs__imm_signed[18:0],combs__funct7[6]},idecode_inst__rd[0]},combs__funct7[5:0]},idecode_inst__rd[4:1]},1'h0};
            end
        5'h1b: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            idecode_inst__immediate__var = {{{{{{{combs__imm_signed[10:0],combs__funct7[6]},idecode_inst__rs1},combs__funct3},idecode_inst__rs2[0]},combs__funct7[5:0]},idecode_inst__rs2[4:1]},1'h0};
            end
        5'hd: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            idecode_inst__immediate__var = {{{{combs__funct7,idecode_inst__rs2},idecode_inst__rs1},combs__funct3},12'h0};
            end
        5'h5: // req 1
            begin
            idecode_inst__immediate_valid__var = 1'h1;
            idecode_inst__immediate__var = {{{{combs__funct7,idecode_inst__rs2},idecode_inst__rs1},combs__funct3},12'h0};
            end
        5'h1c: // req 1
            begin
            idecode_inst__immediate_valid__var = instruction__data[14];
            idecode_inst__immediate__var = {27'h0,idecode_inst__rs1};
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
        idecode_inst__immediate_valid = idecode_inst__immediate_valid__var;
        idecode_inst__immediate = idecode_inst__immediate__var;
    end //always

    //b csr_access_decode combinatorial process
    always @ ( * )//csr_access_decode
    begin: csr_access_decode__comb_code
    reg [2:0]csr_access__mode__var;
    reg [2:0]csr_access__access__var;
    reg [11:0]csr_access__address__var;
        csr_access__mode__var = 3'h0;
        csr_access__access_cancelled = 1'h0;
        csr_access__access__var = 3'h0;
        csr_access__custom__mhartid = 32'h0;
        csr_access__custom__misa = 32'h0;
        csr_access__custom__mvendorid = 32'h0;
        csr_access__custom__marchid = 32'h0;
        csr_access__custom__mimpid = 32'h0;
        csr_access__address__var = 12'h0;
        csr_access__select = 12'h0;
        csr_access__write_data = 32'h0;
        csr_access__address__var = instruction__data[31:20];
        csr_access__mode__var = instruction__mode;
        csr_access__access__var = 3'h0;
        case (combs__funct3[1:0]) //synopsys parallel_case
        2'h1: // req 1
            begin
            csr_access__access__var = 3'h3;
            if ((idecode_inst__rd==5'h0))
            begin
                csr_access__access__var = 3'h1;
            end //if
            end
        2'h2: // req 1
            begin
            csr_access__access__var = 3'h6;
            if (!(combs__rs1_nonzero!=1'h0))
            begin
                csr_access__access__var = 3'h2;
            end //if
            end
        2'h3: // req 1
            begin
            csr_access__access__var = 3'h7;
            if (!(combs__rs1_nonzero!=1'h0))
            begin
                csr_access__access__var = 3'h2;
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
        if ((combs__use_debug!=1'h0))
        begin
            csr_access__mode__var = 3'h7;
            csr_access__address__var = instruction__debug__data[11:0];
            if (!(instruction__debug__data[12]!=1'h0))
            begin
                csr_access__access__var = 3'h2;
                if ((instruction__debug__debug_op==2'h1))
                begin
                    csr_access__access__var = 3'h1;
                end //if
            end //if
        end //if
        csr_access__mode = csr_access__mode__var;
        csr_access__access = csr_access__access__var;
        csr_access__address = csr_access__address__var;
    end //always

    //b instruction_decode combinatorial process
        //   
        //       Decode the instruction
        //       
    always @ ( * )//instruction_decode
    begin: instruction_decode__comb_code
    reg idecode_inst__rs1_valid__var;
    reg idecode_inst__rs2_valid__var;
    reg idecode_inst__rd_written__var;
    reg [2:0]idecode_inst__csr_access__access__var;
    reg [11:0]idecode_inst__csr_access__select__var;
    reg [3:0]idecode_inst__op__var;
    reg idecode_inst__illegal__var;
    reg [3:0]idecode_inst__subop__var;
    reg [3:0]idecode_inst__shift_op__var;
        idecode_inst__ext__dummy = 1'h0;
        idecode_inst__is_compressed = 1'h0;
        idecode_inst__rs1_valid__var = 1'h0;
        idecode_inst__rs2_valid__var = 1'h0;
        idecode_inst__rd_written__var = 1'h0;
        idecode_inst__csr_access__mode = csr_access__mode;
        idecode_inst__csr_access__access_cancelled = csr_access__access_cancelled;
        idecode_inst__csr_access__access__var = csr_access__access;
        idecode_inst__csr_access__custom__mhartid = csr_access__custom__mhartid;
        idecode_inst__csr_access__custom__misa = csr_access__custom__misa;
        idecode_inst__csr_access__custom__mvendorid = csr_access__custom__mvendorid;
        idecode_inst__csr_access__custom__marchid = csr_access__custom__marchid;
        idecode_inst__csr_access__custom__mimpid = csr_access__custom__mimpid;
        idecode_inst__csr_access__address = csr_access__address;
        idecode_inst__csr_access__select__var = csr_access__select;
        idecode_inst__csr_access__write_data = csr_access__write_data;
        idecode_inst__csr_access__access__var = 3'h0;
        idecode_inst__csr_access__select__var = csr_decode__csr_select;
        combs__is_imm_op = (combs__opc==5'h4);
        idecode_inst__op__var = 4'hf;
        idecode_inst__illegal__var = 1'h1;
        idecode_inst__subop__var = 4'h0;
        idecode_inst__funct7 = combs__funct7;
        combs__rs1_nonzero = (idecode_inst__rs1!=5'h0);
        idecode_inst__shift_op__var = 4'h0;
        case (combs__funct7[6:5]) //synopsys parallel_case
        2'h0: // req 1
            begin
            idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h0:4'h4);
            end
        2'h1: // req 1
            begin
            idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h0:4'h6);
            end
        2'h2: // req 1
            begin
            idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h3:4'h7);
            end
        2'h3: // req 1
            begin
            idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h1:4'h5);
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
        if ((1'h1!=64'h0))
        begin
            case (combs__funct7[6:3]) //synopsys parallel_case
            4'h0: // req 1
                begin
                idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h0:4'h4);
                end
            4'h4: // req 1
                begin
                idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h0:4'h6);
                end
            4'h8: // req 1
                begin
                idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h1:4'h5);
                end
            4'h9: // req 1
                begin
                idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h3:4'h7);
                end
            4'ha: // req 1
                begin
                idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'hc:4'ha);
                end
            4'hc: // req 1
                begin
                idecode_inst__shift_op__var = ((combs__funct3==3'h1)?4'h9:4'h9);
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
        case (combs__opc) //synopsys parallel_case
        5'hd: // req 1
            begin
            idecode_inst__op__var = 4'ha;
            idecode_inst__rd_written__var = 1'h1;
            idecode_inst__illegal__var = 1'h0;
            end
        5'h5: // req 1
            begin
            idecode_inst__op__var = 4'h9;
            idecode_inst__rd_written__var = 1'h1;
            idecode_inst__illegal__var = 1'h0;
            end
        5'h1b: // req 1
            begin
            idecode_inst__op__var = 4'h1;
            idecode_inst__rd_written__var = 1'h1;
            idecode_inst__illegal__var = 1'h0;
            end
        5'h19: // req 1
            begin
            idecode_inst__op__var = 4'h2;
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rd_written__var = 1'h1;
            idecode_inst__illegal__var = 1'h0;
            end
        5'h0: // req 1
            begin
            idecode_inst__op__var = 4'h6;
            idecode_inst__subop__var = {1'h0,combs__funct3};
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rd_written__var = 1'h1;
            idecode_inst__illegal__var = 1'h0;
            end
        5'h8: // req 1
            begin
            idecode_inst__op__var = 4'h6;
            idecode_inst__subop__var = {1'h1,combs__funct3};
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rs2_valid__var = 1'h1;
            idecode_inst__illegal__var = 1'h0;
            end
        5'h18: // req 1
            begin
            idecode_inst__op__var = 4'h0;
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rs2_valid__var = 1'h1;
            idecode_inst__subop__var = 4'hf;
            idecode_inst__illegal__var = 1'h0;
            case (combs__funct3) //synopsys parallel_case
            3'h0: // req 1
                begin
                idecode_inst__subop__var = 4'h0;
                end
            3'h1: // req 1
                begin
                idecode_inst__subop__var = 4'h1;
                end
            3'h4: // req 1
                begin
                idecode_inst__subop__var = 4'h2;
                end
            3'h6: // req 1
                begin
                idecode_inst__subop__var = 4'h4;
                end
            3'h5: // req 1
                begin
                idecode_inst__subop__var = 4'h3;
                end
            3'h7: // req 1
                begin
                idecode_inst__subop__var = 4'h5;
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
            idecode_inst__op__var = 4'h7;
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rs2_valid__var = !(combs__is_imm_op!=1'h0);
            idecode_inst__rd_written__var = 1'h1;
            if (((combs__funct7==7'h1)&&!(combs__is_imm_op!=1'h0)))
            begin
                if ((1'h1&&(riscv_config__i32m!=1'h0)))
                begin
                    idecode_inst__illegal__var = 1'h0;
                    idecode_inst__op__var = 4'h8;
                    case (combs__funct3) //synopsys parallel_case
                    3'h0: // req 1
                        begin
                        idecode_inst__subop__var = 4'h0;
                        end
                    3'h1: // req 1
                        begin
                        idecode_inst__subop__var = 4'h1;
                        end
                    3'h2: // req 1
                        begin
                        idecode_inst__subop__var = 4'h2;
                        end
                    3'h3: // req 1
                        begin
                        idecode_inst__subop__var = 4'h3;
                        end
                    3'h4: // req 1
                        begin
                        idecode_inst__subop__var = 4'h4;
                        end
                    3'h5: // req 1
                        begin
                        idecode_inst__subop__var = 4'h5;
                        end
                    3'h6: // req 1
                        begin
                        idecode_inst__subop__var = 4'h6;
                        end
                    3'h7: // req 1
                        begin
                        idecode_inst__subop__var = 4'h7;
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
                idecode_inst__illegal__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7!=7'h0))&&(combs__funct7!=7'h20));
                case (combs__funct3) //synopsys parallel_case
                3'h0: // req 1
                    begin
                    idecode_inst__subop__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7[5]!=1'h0))?4'h8:4'h0);
                    end
                3'h2: // req 1
                    begin
                    idecode_inst__subop__var = 4'h2;
                    end
                3'h3: // req 1
                    begin
                    idecode_inst__subop__var = 4'h3;
                    end
                3'h4: // req 1
                    begin
                    idecode_inst__subop__var = 4'h4;
                    end
                3'h6: // req 1
                    begin
                    idecode_inst__subop__var = 4'h6;
                    end
                3'h7: // req 1
                    begin
                    idecode_inst__subop__var = 4'h7;
                    end
                3'h1: // req 1
                    begin
                    idecode_inst__illegal__var = (combs__funct7!=7'h0);
                    idecode_inst__subop__var = 4'h1;
                    if ((1'h1!=64'h0))
                    begin
                        if ((combs__funct7[6]!=1'h0))
                        begin
                            idecode_inst__illegal__var = 1'h0;
                        end //if
                    end //if
                    end
                3'h5: // req 1
                    begin
                    idecode_inst__illegal__var = ((combs__funct7!=7'h0)&&(combs__funct7!=7'h20));
                    idecode_inst__subop__var = 4'h5;
                    if ((1'h1!=64'h0))
                    begin
                        if ((combs__funct7[6]!=1'h0))
                        begin
                            idecode_inst__illegal__var = 1'h0;
                        end //if
                    end //if
                    end
                default: // req 1
                    begin
                    idecode_inst__illegal__var = 1'h1;
                    end
                endcase
            end //else
            end
        5'h4: // req 1
            begin
            idecode_inst__op__var = 4'h7;
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rs2_valid__var = !(combs__is_imm_op!=1'h0);
            idecode_inst__rd_written__var = 1'h1;
            if (((combs__funct7==7'h1)&&!(combs__is_imm_op!=1'h0)))
            begin
                if ((1'h1&&(riscv_config__i32m!=1'h0)))
                begin
                    idecode_inst__illegal__var = 1'h0;
                    idecode_inst__op__var = 4'h8;
                    case (combs__funct3) //synopsys parallel_case
                    3'h0: // req 1
                        begin
                        idecode_inst__subop__var = 4'h0;
                        end
                    3'h1: // req 1
                        begin
                        idecode_inst__subop__var = 4'h1;
                        end
                    3'h2: // req 1
                        begin
                        idecode_inst__subop__var = 4'h2;
                        end
                    3'h3: // req 1
                        begin
                        idecode_inst__subop__var = 4'h3;
                        end
                    3'h4: // req 1
                        begin
                        idecode_inst__subop__var = 4'h4;
                        end
                    3'h5: // req 1
                        begin
                        idecode_inst__subop__var = 4'h5;
                        end
                    3'h6: // req 1
                        begin
                        idecode_inst__subop__var = 4'h6;
                        end
                    3'h7: // req 1
                        begin
                        idecode_inst__subop__var = 4'h7;
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
                idecode_inst__illegal__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7!=7'h0))&&(combs__funct7!=7'h20));
                case (combs__funct3) //synopsys parallel_case
                3'h0: // req 1
                    begin
                    idecode_inst__subop__var = ((!(combs__is_imm_op!=1'h0)&&(combs__funct7[5]!=1'h0))?4'h8:4'h0);
                    end
                3'h2: // req 1
                    begin
                    idecode_inst__subop__var = 4'h2;
                    end
                3'h3: // req 1
                    begin
                    idecode_inst__subop__var = 4'h3;
                    end
                3'h4: // req 1
                    begin
                    idecode_inst__subop__var = 4'h4;
                    end
                3'h6: // req 1
                    begin
                    idecode_inst__subop__var = 4'h6;
                    end
                3'h7: // req 1
                    begin
                    idecode_inst__subop__var = 4'h7;
                    end
                3'h1: // req 1
                    begin
                    idecode_inst__illegal__var = (combs__funct7!=7'h0);
                    idecode_inst__subop__var = 4'h1;
                    if ((1'h1!=64'h0))
                    begin
                        if ((combs__funct7[6]!=1'h0))
                        begin
                            idecode_inst__illegal__var = 1'h0;
                        end //if
                    end //if
                    end
                3'h5: // req 1
                    begin
                    idecode_inst__illegal__var = ((combs__funct7!=7'h0)&&(combs__funct7!=7'h20));
                    idecode_inst__subop__var = 4'h5;
                    if ((1'h1!=64'h0))
                    begin
                        if ((combs__funct7[6]!=1'h0))
                        begin
                            idecode_inst__illegal__var = 1'h0;
                        end //if
                    end //if
                    end
                default: // req 1
                    begin
                    idecode_inst__illegal__var = 1'h1;
                    end
                endcase
            end //else
            end
        5'h3: // req 1
            begin
            idecode_inst__illegal__var = 1'h0;
            idecode_inst__op__var = 4'h5;
            idecode_inst__subop__var = ((combs__funct3[0]!=1'h0)?4'h1:4'h0);
            end
        5'h1c: // req 1
            begin
            idecode_inst__op__var = 4'h3;
            idecode_inst__rs1_valid__var = 1'h1;
            idecode_inst__rd_written__var = 1'h1;
            idecode_inst__csr_access__access__var = csr_access__access;
            idecode_inst__illegal__var = csr_decode__illegal_access;
            case (combs__funct3[1:0]) //synopsys parallel_case
            2'h1: // req 1
                begin
                idecode_inst__op__var = 4'h4;
                idecode_inst__subop__var = 4'h1;
                end
            2'h2: // req 1
                begin
                idecode_inst__op__var = 4'h4;
                idecode_inst__subop__var = 4'h2;
                end
            2'h3: // req 1
                begin
                idecode_inst__op__var = 4'h4;
                idecode_inst__subop__var = 4'h3;
                end
            2'h0: // req 1
                begin
                idecode_inst__op__var = 4'h3;
                case (instruction__data[31:20]) //synopsys parallel_case
                12'h0: // req 1
                    begin
                    idecode_inst__subop__var = 4'h0;
                    end
                12'h1: // req 1
                    begin
                    idecode_inst__subop__var = 4'h1;
                    end
                12'h302: // req 1
                    begin
                    idecode_inst__subop__var = 4'h2;
                    idecode_inst__illegal__var = (instruction__mode<3'h3);
                    end
                12'h105: // req 1
                    begin
                    idecode_inst__subop__var = 4'h3;
                    idecode_inst__illegal__var = (instruction__mode<3'h3);
                    end
                default: // req 1
                    begin
                    idecode_inst__illegal__var = 1'h1;
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
            if (1'h1)
            begin
                idecode_inst__illegal__var = 1'h0;
                idecode_inst__op__var = 4'hb;
                idecode_inst__subop__var = {1'h0,combs__funct3};
                idecode_inst__rs1_valid__var = 1'h1;
                if (1'h1)
                begin
                    idecode_inst__rs2_valid__var = 1'h1;
                end //if
                if (1'h0)
                begin
                    idecode_inst__rd_written__var = 1'h1;
                end //if
            end //if
            end
        5'ha: // req 1
            begin
            if (1'h1)
            begin
                idecode_inst__illegal__var = 1'h0;
                idecode_inst__op__var = 4'hc;
                idecode_inst__subop__var = {1'h0,combs__funct3};
                idecode_inst__rs1_valid__var = 1'h1;
                if (1'h1)
                begin
                    idecode_inst__rs2_valid__var = 1'h1;
                end //if
                if (1'h0)
                begin
                    idecode_inst__rd_written__var = 1'h1;
                end //if
            end //if
            end
        5'h16: // req 1
            begin
            if (1'h0)
            begin
                idecode_inst__illegal__var = 1'h0;
                idecode_inst__op__var = 4'hd;
                idecode_inst__subop__var = {1'h0,combs__funct3};
                idecode_inst__rs1_valid__var = 1'h1;
                if (1'h1)
                begin
                    idecode_inst__rs2_valid__var = 1'h1;
                end //if
                if (1'h0)
                begin
                    idecode_inst__rd_written__var = 1'h1;
                end //if
            end //if
            end
        5'h1e: // req 1
            begin
            if (1'h0)
            begin
                idecode_inst__illegal__var = 1'h0;
                idecode_inst__op__var = 4'he;
                idecode_inst__subop__var = {1'h0,combs__funct3};
                idecode_inst__rs1_valid__var = 1'h1;
                if (1'h1)
                begin
                    idecode_inst__rs2_valid__var = 1'h1;
                end //if
                if (1'h0)
                begin
                    idecode_inst__rd_written__var = 1'h1;
                end //if
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
            idecode_inst__illegal__var = 1'h1;
        end //if
        if ((idecode_inst__rs1==5'h0))
        begin
            idecode_inst__rs1_valid__var = 1'h0;
        end //if
        if ((idecode_inst__rs2==5'h0))
        begin
            idecode_inst__rs2_valid__var = 1'h0;
        end //if
        if ((idecode_inst__rd==5'h0))
        begin
            idecode_inst__rd_written__var = 1'h0;
        end //if
        if (((riscv_config__e32!=1'h0)||(1'h0!=64'h0)))
        begin
            if (((idecode_inst__rs1_valid__var!=1'h0)&&(idecode_inst__rs1[4]!=1'h0)))
            begin
                idecode_inst__illegal__var = 1'h1;
            end //if
            if (((idecode_inst__rs2_valid__var!=1'h0)&&(idecode_inst__rs2[4]!=1'h0)))
            begin
                idecode_inst__illegal__var = 1'h1;
            end //if
            if (((idecode_inst__rd_written__var!=1'h0)&&(idecode_inst__rd[4]!=1'h0)))
            begin
                idecode_inst__illegal__var = 1'h1;
            end //if
        end //if
        idecode_inst__rs1_valid = idecode_inst__rs1_valid__var;
        idecode_inst__rs2_valid = idecode_inst__rs2_valid__var;
        idecode_inst__rd_written = idecode_inst__rd_written__var;
        idecode_inst__csr_access__access = idecode_inst__csr_access__access__var;
        idecode_inst__csr_access__select = idecode_inst__csr_access__select__var;
        idecode_inst__op = idecode_inst__op__var;
        idecode_inst__illegal = idecode_inst__illegal__var;
        idecode_inst__subop = idecode_inst__subop__var;
        idecode_inst__shift_op = idecode_inst__shift_op__var;
    end //always

    //b debug_decode combinatorial process
    always @ ( * )//debug_decode
    begin: debug_decode__comb_code
    reg [4:0]idecode_debug__rs1__var;
    reg idecode_debug__rs1_valid__var;
    reg [4:0]idecode_debug__rs2__var;
    reg idecode_debug__rs2_valid__var;
    reg [4:0]idecode_debug__rd__var;
    reg idecode_debug__rd_written__var;
    reg [2:0]idecode_debug__csr_access__access__var;
    reg [11:0]idecode_debug__csr_access__address__var;
    reg [11:0]idecode_debug__csr_access__select__var;
    reg [31:0]idecode_debug__immediate__var;
    reg idecode_debug__immediate_valid__var;
    reg [3:0]idecode_debug__op__var;
    reg [3:0]idecode_debug__subop__var;
        idecode_debug__rs1__var = 5'h0;
        idecode_debug__rs1_valid__var = 1'h0;
        idecode_debug__rs2__var = 5'h0;
        idecode_debug__rs2_valid__var = 1'h0;
        idecode_debug__rd__var = 5'h0;
        idecode_debug__rd_written__var = 1'h0;
        idecode_debug__csr_access__mode = 3'h0;
        idecode_debug__csr_access__access_cancelled = 1'h0;
        idecode_debug__csr_access__access__var = 3'h0;
        idecode_debug__csr_access__custom__mhartid = 32'h0;
        idecode_debug__csr_access__custom__misa = 32'h0;
        idecode_debug__csr_access__custom__mvendorid = 32'h0;
        idecode_debug__csr_access__custom__marchid = 32'h0;
        idecode_debug__csr_access__custom__mimpid = 32'h0;
        idecode_debug__csr_access__address__var = 12'h0;
        idecode_debug__csr_access__select__var = 12'h0;
        idecode_debug__csr_access__write_data = 32'h0;
        idecode_debug__immediate__var = 32'h0;
        idecode_debug__immediate_shift = 5'h0;
        idecode_debug__immediate_valid__var = 1'h0;
        idecode_debug__op__var = 4'h0;
        idecode_debug__subop__var = 4'h0;
        idecode_debug__shift_op = 4'h0;
        idecode_debug__funct7 = 7'h0;
        idecode_debug__illegal = 1'h0;
        idecode_debug__is_compressed = 1'h0;
        idecode_debug__ext__dummy = 1'h0;
        idecode_debug__immediate__var = instruction__data;
        idecode_debug__rs1__var = instruction__debug__data[4:0];
        idecode_debug__rs1_valid__var = 1'h1;
        idecode_debug__rs2__var = 5'h0;
        idecode_debug__rs2_valid__var = 1'h0;
        idecode_debug__rd__var = instruction__debug__data[4:0];
        idecode_debug__rd_written__var = 1'h0;
        idecode_debug__immediate_valid__var = 1'h1;
        idecode_debug__op__var = 4'h7;
        idecode_debug__subop__var = 4'h6;
        idecode_debug__csr_access__access__var = 3'h0;
        idecode_debug__csr_access__address__var = instruction__debug__data[11:0];
        idecode_debug__csr_access__select__var = csr_decode__csr_select;
        if ((instruction__debug__data[12]!=1'h0))
        begin
            case (instruction__debug__debug_op) //synopsys parallel_case
            2'h0: // req 1
                begin
                idecode_debug__rs1_valid__var = 1'h0;
                idecode_debug__immediate_valid__var = 1'h0;
                end
            2'h1: // req 1
                begin
                idecode_debug__rs1__var = 5'h0;
                idecode_debug__rs1_valid__var = 1'h0;
                idecode_debug__immediate_valid__var = 1'h1;
                idecode_debug__rd_written__var = 1'h1;
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_decode:debug_decode: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //if
        else
        
        begin
            idecode_debug__op__var = 4'h4;
            idecode_debug__subop__var = 4'h6;
            case (instruction__debug__debug_op) //synopsys parallel_case
            2'h0: // req 1
                begin
                idecode_debug__csr_access__access__var = 3'h2;
                idecode_debug__rs1_valid__var = 1'h0;
                idecode_debug__immediate_valid__var = 1'h0;
                end
            2'h1: // req 1
                begin
                idecode_debug__csr_access__access__var = 3'h1;
                idecode_debug__rs1_valid__var = 1'h0;
                idecode_debug__immediate_valid__var = 1'h1;
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_decode:debug_decode: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //else
        idecode_debug__rs1 = idecode_debug__rs1__var;
        idecode_debug__rs1_valid = idecode_debug__rs1_valid__var;
        idecode_debug__rs2 = idecode_debug__rs2__var;
        idecode_debug__rs2_valid = idecode_debug__rs2_valid__var;
        idecode_debug__rd = idecode_debug__rd__var;
        idecode_debug__rd_written = idecode_debug__rd_written__var;
        idecode_debug__csr_access__access = idecode_debug__csr_access__access__var;
        idecode_debug__csr_access__address = idecode_debug__csr_access__address__var;
        idecode_debug__csr_access__select = idecode_debug__csr_access__select__var;
        idecode_debug__immediate = idecode_debug__immediate__var;
        idecode_debug__immediate_valid = idecode_debug__immediate_valid__var;
        idecode_debug__op = idecode_debug__op__var;
        idecode_debug__subop = idecode_debug__subop__var;
    end //always

    //b select_output combinatorial process
    always @ ( * )//select_output
    begin: select_output__comb_code
    reg [4:0]idecode__rs1__var;
    reg idecode__rs1_valid__var;
    reg [4:0]idecode__rs2__var;
    reg idecode__rs2_valid__var;
    reg [4:0]idecode__rd__var;
    reg idecode__rd_written__var;
    reg [2:0]idecode__csr_access__mode__var;
    reg idecode__csr_access__access_cancelled__var;
    reg [2:0]idecode__csr_access__access__var;
    reg [31:0]idecode__csr_access__custom__mhartid__var;
    reg [31:0]idecode__csr_access__custom__misa__var;
    reg [31:0]idecode__csr_access__custom__mvendorid__var;
    reg [31:0]idecode__csr_access__custom__marchid__var;
    reg [31:0]idecode__csr_access__custom__mimpid__var;
    reg [11:0]idecode__csr_access__address__var;
    reg [11:0]idecode__csr_access__select__var;
    reg [31:0]idecode__csr_access__write_data__var;
    reg [31:0]idecode__immediate__var;
    reg [4:0]idecode__immediate_shift__var;
    reg idecode__immediate_valid__var;
    reg [3:0]idecode__op__var;
    reg [3:0]idecode__subop__var;
    reg [3:0]idecode__shift_op__var;
    reg [6:0]idecode__funct7__var;
    reg idecode__illegal__var;
    reg idecode__is_compressed__var;
    reg idecode__ext__dummy__var;
        idecode__rs1__var = idecode_inst__rs1;
        idecode__rs1_valid__var = idecode_inst__rs1_valid;
        idecode__rs2__var = idecode_inst__rs2;
        idecode__rs2_valid__var = idecode_inst__rs2_valid;
        idecode__rd__var = idecode_inst__rd;
        idecode__rd_written__var = idecode_inst__rd_written;
        idecode__csr_access__mode__var = idecode_inst__csr_access__mode;
        idecode__csr_access__access_cancelled__var = idecode_inst__csr_access__access_cancelled;
        idecode__csr_access__access__var = idecode_inst__csr_access__access;
        idecode__csr_access__custom__mhartid__var = idecode_inst__csr_access__custom__mhartid;
        idecode__csr_access__custom__misa__var = idecode_inst__csr_access__custom__misa;
        idecode__csr_access__custom__mvendorid__var = idecode_inst__csr_access__custom__mvendorid;
        idecode__csr_access__custom__marchid__var = idecode_inst__csr_access__custom__marchid;
        idecode__csr_access__custom__mimpid__var = idecode_inst__csr_access__custom__mimpid;
        idecode__csr_access__address__var = idecode_inst__csr_access__address;
        idecode__csr_access__select__var = idecode_inst__csr_access__select;
        idecode__csr_access__write_data__var = idecode_inst__csr_access__write_data;
        idecode__immediate__var = idecode_inst__immediate;
        idecode__immediate_shift__var = idecode_inst__immediate_shift;
        idecode__immediate_valid__var = idecode_inst__immediate_valid;
        idecode__op__var = idecode_inst__op;
        idecode__subop__var = idecode_inst__subop;
        idecode__shift_op__var = idecode_inst__shift_op;
        idecode__funct7__var = idecode_inst__funct7;
        idecode__illegal__var = idecode_inst__illegal;
        idecode__is_compressed__var = idecode_inst__is_compressed;
        idecode__ext__dummy__var = idecode_inst__ext__dummy;
        if ((combs__use_debug!=1'h0))
        begin
            idecode__rs1__var = idecode_debug__rs1;
            idecode__rs1_valid__var = idecode_debug__rs1_valid;
            idecode__rs2__var = idecode_debug__rs2;
            idecode__rs2_valid__var = idecode_debug__rs2_valid;
            idecode__rd__var = idecode_debug__rd;
            idecode__rd_written__var = idecode_debug__rd_written;
            idecode__csr_access__mode__var = idecode_debug__csr_access__mode;
            idecode__csr_access__access_cancelled__var = idecode_debug__csr_access__access_cancelled;
            idecode__csr_access__access__var = idecode_debug__csr_access__access;
            idecode__csr_access__custom__mhartid__var = idecode_debug__csr_access__custom__mhartid;
            idecode__csr_access__custom__misa__var = idecode_debug__csr_access__custom__misa;
            idecode__csr_access__custom__mvendorid__var = idecode_debug__csr_access__custom__mvendorid;
            idecode__csr_access__custom__marchid__var = idecode_debug__csr_access__custom__marchid;
            idecode__csr_access__custom__mimpid__var = idecode_debug__csr_access__custom__mimpid;
            idecode__csr_access__address__var = idecode_debug__csr_access__address;
            idecode__csr_access__select__var = idecode_debug__csr_access__select;
            idecode__csr_access__write_data__var = idecode_debug__csr_access__write_data;
            idecode__immediate__var = idecode_debug__immediate;
            idecode__immediate_shift__var = idecode_debug__immediate_shift;
            idecode__immediate_valid__var = idecode_debug__immediate_valid;
            idecode__op__var = idecode_debug__op;
            idecode__subop__var = idecode_debug__subop;
            idecode__shift_op__var = idecode_debug__shift_op;
            idecode__funct7__var = idecode_debug__funct7;
            idecode__illegal__var = idecode_debug__illegal;
            idecode__is_compressed__var = idecode_debug__is_compressed;
            idecode__ext__dummy__var = idecode_debug__ext__dummy;
        end //if
        idecode__rs1 = idecode__rs1__var;
        idecode__rs1_valid = idecode__rs1_valid__var;
        idecode__rs2 = idecode__rs2__var;
        idecode__rs2_valid = idecode__rs2_valid__var;
        idecode__rd = idecode__rd__var;
        idecode__rd_written = idecode__rd_written__var;
        idecode__csr_access__mode = idecode__csr_access__mode__var;
        idecode__csr_access__access_cancelled = idecode__csr_access__access_cancelled__var;
        idecode__csr_access__access = idecode__csr_access__access__var;
        idecode__csr_access__custom__mhartid = idecode__csr_access__custom__mhartid__var;
        idecode__csr_access__custom__misa = idecode__csr_access__custom__misa__var;
        idecode__csr_access__custom__mvendorid = idecode__csr_access__custom__mvendorid__var;
        idecode__csr_access__custom__marchid = idecode__csr_access__custom__marchid__var;
        idecode__csr_access__custom__mimpid = idecode__csr_access__custom__mimpid__var;
        idecode__csr_access__address = idecode__csr_access__address__var;
        idecode__csr_access__select = idecode__csr_access__select__var;
        idecode__csr_access__write_data = idecode__csr_access__write_data__var;
        idecode__immediate = idecode__immediate__var;
        idecode__immediate_shift = idecode__immediate_shift__var;
        idecode__immediate_valid = idecode__immediate_valid__var;
        idecode__op = idecode__op__var;
        idecode__subop = idecode__subop__var;
        idecode__shift_op = idecode__shift_op__var;
        idecode__funct7 = idecode__funct7__var;
        idecode__illegal = idecode__illegal__var;
        idecode__is_compressed = idecode__is_compressed__var;
        idecode__ext__dummy = idecode__ext__dummy__var;
    end //always

endmodule // riscv_i32_decode
