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

//a Module riscv_i32_muldiv
    //   
    //   
    //   Multiplication:
    //   
    //   Consider multiplication of two 3-bit numbers a and b (hence octal)
    //   
    //   A straight (unsigned) view of a value X as Xs.Xb  is Xb+4*Xs (Xs is sign bit, Xb remaining bits)
    //   A signed              view of a value X as Xs.Xb  is Xb-4*Xs
    //   Hence one can consider Xsigned = Xunsigned - 8*Xs
    //   
    //   Consider Runsigned = Xunsigned * Yunsigned
    //   Then Xsigned * Ysigned = (Xunsigned - 8*Xs) * (Yunsigned - 8*Ys)
    //                          = (Xunsigned*Yunsigned) + 64*Xs*Ys -8*(Xs*Yunsigned + Ys*Xunsigned)
    //   (mod 64)               = Runsigned             -8*(Xs*Yunsigned + Ys*Xunsigned)  
    //   
    //   Xunsigned * Yunsigned has the following multiplication table:
    //   
    //       0    1    2    3    4    5    6    7    
    //   0   0    0    0    0    0    0    0    0
    //   1   0    1    2    3    4    5    6    7    
    //   2   0    2    4    6   10   12   14   16
    //   3   0    3    6   11   14   17   22   25
    //   4   0    4   10   14   20   24   30   34
    //   5   0    5   12   17   24   31   36   43
    //   6   0    6   14   22   30   36   44   52
    //   7   0    7   16   25   34   43   52   61
    //   
    //   If both are signed then we have the following correction to add -8*(Xs*Yunsigned + Ys*Xunsigned) (in decimal...)
    //   
    //       0    1    2    3    4    5    6    7    
    //   0   0    0    0    0    0    0    0    0
    //   1   0    0    0    0   -8   -8   -8   -8
    //   2   0    0    0    0  -16  -16  -16  -16
    //   3   0    0    0    0  -24  -24  -24  -24
    //   4   0   -8  -16  -24  -64  -72  -80  -88
    //   5   0   -8  -16  -24  -72  -80  -88  -96
    //   6   0   -8  -16  -24  -80  -88  -96 -104
    //   7   0   -8  -16  -24  -88  -96 -104 -112
    //   
    //   And in octal (addition)
    //   
    //       0    1    2    3    4    5    6    7    
    //   0   0    0    0    0    0    0    0    0
    //   1   0    0    0    0   70   70   70   70
    //   2   0    0    0    0   60   60   60   60
    //   3   0    0    0    0   50   50   50   50
    //   4   0   70   60   50    0   70   60   50
    //   5   0   70   60   50   70   60   50   40
    //   6   0   70   60   50   60   50   40   30
    //   7   0   70   60   50   50   40   30   20
    //   
    //   If they are both signed (7==-1, 6==-2, 5=--3, 4==-4) we have the following multiplication table:
    //   
    //       0    1    2    3    4    5    6    7
    //   0   0    0    0    0    0    0    0    0
    //   1   0    1    2    3   74   75   76   77
    //   2   0    2    4    6   70   72   74   76
    //   3   0    3    6   11   64   67   72   75
    //   4   0   74   70   64   20   14   10    4
    //   5   0   75   72   67   14   11    6    3
    //   6   0   76   74   72   10    6    4    2
    //   7   0   77   76   75    4    3    2    1
    //   
    //   If the column (X) in unsigned and the row is signed then we have the following correction to add -8*Ys*Xunsigned (in decimal...)
    //   
    //       0    1    2    3    4    5    6    7    
    //   0   0    0    0    0    0    0    0    0
    //   1   0    0    0    0    0    0    0    0
    //   2   0    0    0    0    0    0    0    0
    //   3   0    0    0    0    0    0    0    0
    //   4   0   -8  -16  -24  -32  -40  -48  -56
    //   5   0   -8  -16  -24  -32  -40  -48  -56
    //   6   0   -8  -16  -24  -32  -40  -48  -56
    //   7   0   -8  -16  -24  -32  -40  -48  -56
    //   
    //   And in octal (addition)
    //   
    //       0    1    2    3    4    5    6    7    
    //   0   0    0    0    0    0    0    0    0
    //   1   0    0    0    0    0    0    0    0
    //   2   0    0    0    0    0    0    0    0
    //   3   0    0    0    0    0    0    0    0
    //   4   0   70   60   50   40   30   20   10
    //   5   0   70   60   50   40   30   20   10
    //   6   0   70   60   50   40   30   20   10
    //   7   0   70   60   50   40   30   20   10
    //   
    //   
    //   Hence the multiplication table:
    //   
    //       0    1    2    3    4    5    6    7
    //   0   0    0    0    0    0    0    0    0
    //   1   0    1    2    3    4    5    6    7
    //   2   0    2    4    6   10   12   14   16
    //   3   0    3    6   11   14   17   22   25
    //   4   0   74   70   64   60   54   50   44
    //   5   0   75   72   67   64   61   56   53
    //   6   0   76   74   72   70   66   64   62
    //   7   0   77   76   75   74   73   72   71
    //   
    //   
    //   Hence the multiplication of two 32-bit numbers X and Y, using a 64-bit accumulator A, can be performed by setting A initially to:
    //   
    //    0 for unsigned*unsigned
    //    -2^32*(X[31]?Y) for X signed Y unsigned
    //    -2^32*(Y[31]?X) for Y signed X unsigned
    //    -2^32*(Y[31]?X[31;0] + X[31]?Y[31;0]) for both signed.
    //   
    //   The operation of the multiply then requires a 64-bit accumulator
    //   
    //   +1 +4 provides 0, 1, 4, 5 (single 35-bit adder)
    //   (stage1_0 = 0; stage1_1 = (3b0,in); stage1_4 = (1b0,in,2b0); stage1_5 = stage1_1 + stage1_4;)
    //   
    //   +1 +4 with optional double provides 0, 2, 8, 10, 1, 3, 9, 11, 4, 6, 12, 14, 5, 7, 13, 15 (one more 36-bit adders)
    //   (0 = 0+0; 2=0+stage1_1_dbl; 3=stage1_1+stage1_1_dbl;
    //   stage2_add_in_0 = mux(stage1_0, stage1_1, stage1_4, stage1_5)
    //   stage2_add_in_1 = mux(stage1_0, stage1_1, stage1_4, stage1_5)<<1
    //   
    //   
    //   Division
    //   
    //   Unsigned division/remainder (column / row)
    //   
    //       0    1    2    3    4    5    6    7
    //   0  7/0  7/0  7/0  7/0  7/0  7/0  7/0  7/0
    //   1  0/0  1/0  2/0  3/0  4/0  5/0  6/0  7/0
    //   2  0/0  0/1  1/0  1/1  2/0  2/1  3/0  3/1
    //   3  0/0  0/1  0/2  1/0  1/1  1/2  2/0  2/1
    //   4  0/0  0/1  0/2  0/3  1/0  1/1  1/2  1/3
    //   5  0/0  0/1  0/2  0/3  0/4  1/0  1/1  1/2
    //   6  0/0  0/1  0/2  0/3  0/4  0/5  1/0  1/1
    //   7  0/0  0/1  0/2  0/3  0/4  0/5  0/6  1/0
    //   
    //   Signed division/remainder (column / row) (x86 except div by 0)
    //   Note: x86, C99 - sign of remainder = sign of dividend
    //   
    //       0    1    2    3    4    5    6    7
    //   0  7/0  7/0  7/0  7/0  7/0  7/0  7/0  7/0
    //   1  0/0  1/0  2/0  3/0  4/0  5/0  6/0  7/0
    //   2  0/0  0/1  1/0  1/1  6/0  7/7  7/0  0/7
    //   3  0/0  0/1  0/2  1/0  7/7  7/0  0/6  0/7
    //   4  0/0  0/1  0/2  0/3  1/0  0/5  0/6  0/7
    //   5  0/0  0/1  0/2  7/0  1/7  1/0  0/6  0/7
    //   6  0/0  0/1  7/0  7/1  2/0  1/7  1/0  0/7
    //   7  0/0  7/0  6/0  5/0  4/0  3/0  2/0  1/0
    //   
    //   For positive/positive one can use unsigned division directly
    //   For negative/negative one can do -d/-r, and negate the remainder
    //   For negative/positive one can do -d/r, then negate the result and the remainder
    //   For positive/negative one can do d/-r, then negate the result
    //   
    //   So the first cycle of a divide prepares 'positive' d and r and records the signs (as required)
    //   
    //   The multiply requires three adders
    //   One 34 bit; one 36 bit, one 64 bit.
    //   Divide requires compare; it could do 3 compares per cycle, or just one to start with
    //   
    //   We have a multiplier register that gets shifted; this can be the divisor that gets shifted
    //   
    //   Multiply then occurs with the following states:
    //   
    //   Init : adder high 0 is zero or abs(a) if signed and a negative; adder high 1 is zero or abs(b) if signed and b negative; a_reg <= rs1, b_reg <= rs2
    //   Step (until completed) : a_reg = a_reg>>4; mult=a_reg&15; shf=stage; adder is shifter + acc, with carry chain. complete if a_reg&15 will be 0
    //   Result valid: accumulator has result (present top or bottom half)
    //   
    //   Divide occurs with the following states:
    //   
    //   Init
    //   Shift
    //   Step (until completed)
    //   Result valid (provides result signing stuff)
    //   
    //   Hence the design is for a data pipeline with (for multiply):
    //   
    //   a_reg - contains multiplier
    //   b_reg - contains multiplicand
    //   accumulator - contains 64-bit result of multiply
    //               - initialize with 0 for unsigned*unsigned; -2^32*(X[31]?Y) for X signed Y unsigned; -2^32*(Y[31]?X) for Y signed X unsigned; -2^32*(Y[31]?X[31;0] + X[31]?Y[31;0]) for both signed
    //   mult_data = b_reg * bottom 4 bits of a_reg
    //   mult_shf  = b_reg * bottom 4 bits of a_reg shifted to be in correct position for accumulation (i.e. shift left by 4*stage)
    //   64-bit adder of accumulator plus mult_shf
    //   
    //   Result is accumulator - pick top or bottom 32 bits as required
    //   
    //   For divide it becomes:
    //   
    //   a_reg - contains abs(a) (if signed) else a (dividend)
    //   b_reg - contains -abs(b) (if signed) else -b (divisor)
    //   accumulator - bottom 32 bits contains remainder (initialized to a_reg)
    //               - top 32 bits contain quotient (initialized to zero)
    //   mult_data = b_reg << bottom 2 bits of stage
    //   mult_shf  = b_reg shifted to be in correct position for subtraction from remainder
    //   32-bit adder of low accumulator plus mult_shf; if >=0 then must update accumulator low and set bit in accumulator high
    //   32-bit 'set bit N of' of high accumulator to build quotient if 
    //   
    //   Quotient result is accumulator high, or negated accumulator high if signed and signs of two inputs differ
    //   Remainder result is accumulator low, or negated accumulator low if signed and dividend input was negative
    //   
    //   
module riscv_i32_muldiv
(
    clk,
    clk__enable,

    riscv_config__i32c,
    riscv_config__e32,
    riscv_config__i32m,
    riscv_config__i32m_fuse,
    riscv_config__debug_enable,
    riscv_config__coproc_disable,
    riscv_config__unaligned_mem,
    coproc_controls__dec_idecode_valid,
    coproc_controls__dec_idecode__rs1,
    coproc_controls__dec_idecode__rs1_valid,
    coproc_controls__dec_idecode__rs2,
    coproc_controls__dec_idecode__rs2_valid,
    coproc_controls__dec_idecode__rd,
    coproc_controls__dec_idecode__rd_written,
    coproc_controls__dec_idecode__csr_access__access_cancelled,
    coproc_controls__dec_idecode__csr_access__access,
    coproc_controls__dec_idecode__csr_access__address,
    coproc_controls__dec_idecode__csr_access__write_data,
    coproc_controls__dec_idecode__immediate,
    coproc_controls__dec_idecode__immediate_shift,
    coproc_controls__dec_idecode__immediate_valid,
    coproc_controls__dec_idecode__op,
    coproc_controls__dec_idecode__subop,
    coproc_controls__dec_idecode__funct7,
    coproc_controls__dec_idecode__minimum_mode,
    coproc_controls__dec_idecode__illegal,
    coproc_controls__dec_idecode__illegal_pc,
    coproc_controls__dec_idecode__is_compressed,
    coproc_controls__dec_idecode__ext__dummy,
    coproc_controls__dec_to_alu_blocked,
    coproc_controls__alu_rs1,
    coproc_controls__alu_rs2,
    coproc_controls__alu_flush_pipeline,
    coproc_controls__alu_cannot_start,
    coproc_controls__alu_cannot_complete,
    reset_n,

    coproc_response__cannot_start,
    coproc_response__result,
    coproc_response__result_valid,
    coproc_response__cannot_complete
);

    //b Clocks
    input clk;
    input clk__enable;

    //b Inputs
    input riscv_config__i32c;
    input riscv_config__e32;
    input riscv_config__i32m;
    input riscv_config__i32m_fuse;
    input riscv_config__debug_enable;
    input riscv_config__coproc_disable;
    input riscv_config__unaligned_mem;
    input coproc_controls__dec_idecode_valid;
    input [4:0]coproc_controls__dec_idecode__rs1;
    input coproc_controls__dec_idecode__rs1_valid;
    input [4:0]coproc_controls__dec_idecode__rs2;
    input coproc_controls__dec_idecode__rs2_valid;
    input [4:0]coproc_controls__dec_idecode__rd;
    input coproc_controls__dec_idecode__rd_written;
    input coproc_controls__dec_idecode__csr_access__access_cancelled;
    input [2:0]coproc_controls__dec_idecode__csr_access__access;
    input [11:0]coproc_controls__dec_idecode__csr_access__address;
    input [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    input [31:0]coproc_controls__dec_idecode__immediate;
    input [4:0]coproc_controls__dec_idecode__immediate_shift;
    input coproc_controls__dec_idecode__immediate_valid;
    input [3:0]coproc_controls__dec_idecode__op;
    input [3:0]coproc_controls__dec_idecode__subop;
    input [6:0]coproc_controls__dec_idecode__funct7;
    input [2:0]coproc_controls__dec_idecode__minimum_mode;
    input coproc_controls__dec_idecode__illegal;
    input coproc_controls__dec_idecode__illegal_pc;
    input coproc_controls__dec_idecode__is_compressed;
    input coproc_controls__dec_idecode__ext__dummy;
    input coproc_controls__dec_to_alu_blocked;
    input [31:0]coproc_controls__alu_rs1;
    input [31:0]coproc_controls__alu_rs2;
    input coproc_controls__alu_flush_pipeline;
    input coproc_controls__alu_cannot_start;
    input coproc_controls__alu_cannot_complete;
    input reset_n;

    //b Outputs
    output coproc_response__cannot_start;
    output [31:0]coproc_response__result;
    output coproc_response__result_valid;
    output coproc_response__cannot_complete;

// output components here

    //b Output combinatorials
    reg coproc_response__cannot_start;
    reg [31:0]coproc_response__result;
    reg coproc_response__result_valid;
    reg coproc_response__cannot_complete;

    //b Output nets

    //b Internal and output registers
        //   State for fusing operations, if supported
    reg [4:0]dec_fuse__rs1;
    reg [4:0]dec_fuse__rs2;
    reg dec_fuse__was_mulh;
    reg dec_fuse__was_divu;
    reg dec_fuse__was_divs;
        //   State for the datapath and state machine
    reg [4:0]dp_state__stage;
    reg [2:0]dp_state__fsm_state;
    reg [31:0]dp_state__areg;
    reg [31:0]dp_state__breg;
    reg [31:0]dp_state__acc_low;
    reg [31:0]dp_state__acc_high;
    reg [1:0]dp_state__op_signed;
    reg dp_state__negate_remainder;
    reg dp_state__negate_result;
    reg [1:0]dp_state__result_type;

    //b Internal combinatorials
        //   Combinatorials used to determine fusing
    reg dec_fuse_combs__match;
        //   Combinatorials used in the module, not exported as the decode
    reg dp_combs__rs1_is_negative;
    reg dp_combs__rs2_is_negative;
    reg [31:0]dp_combs__neg_rs1;
    reg [31:0]dp_combs__neg_rs2;
    reg dp_combs__sel_neg_rs1;
    reg dp_combs__sel_neg_rs2;
    reg [31:0]dp_combs__sel_rs1;
    reg [31:0]dp_combs__sel_rs2;
    reg [4:0]dp_combs__areg_top_bit_set;
    reg [4:0]dp_combs__breg_top_bit_set;
    reg [1:0]dp_combs__sel0123;
    reg [1:0]dp_combs__sel048c;
    reg [35:0]dp_combs__breg_0;
    reg [35:0]dp_combs__breg_1;
    reg [35:0]dp_combs__breg_2;
    reg [35:0]dp_combs__breg_3;
    reg [35:0]dp_combs__breg_4;
    reg [35:0]dp_combs__breg_8;
    reg [35:0]dp_combs__breg_c;
    reg [35:0]dp_combs__mux_0123;
    reg [35:0]dp_combs__mux_048c;
    reg [35:0]dp_combs__mult_data;
    reg [2:0]dp_combs__shift;
    reg [63:0]dp_combs__mult_shf;
    reg [31:0]dp_combs__add_l_in_0;
    reg [31:0]dp_combs__add_l_in_1;
    reg [1:0]dp_combs__add_h_0_src;
    reg [31:0]dp_combs__add_h_in_0;
    reg [1:0]dp_combs__add_h_1_src;
    reg [31:0]dp_combs__add_h_in_1;
    reg [32:0]dp_combs__add_l;
    reg dp_combs__add_l_carry;
    reg dp_combs__acc_carry_low_to_high;
    reg dp_combs__add_h_carry_in;
    reg [32:0]dp_combs__add_h;
    reg dp_combs__add_h_carry;
    reg dp_combs__completed;
    reg dp_combs__result_neg;
    reg [31:0]dp_combs__result_acc;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b rs1_rs2_datapath combinatorial process
        //   
        //       Code to select +/-/abs(rs1) and +/-/abs(rs2)
        //   
        //       This code is all that operates on rs1/rs2.
        //       
    always @ ( * )//rs1_rs2_datapath
    begin: rs1_rs2_datapath__comb_code
    reg [31:0]dp_combs__sel_rs1__var;
    reg [31:0]dp_combs__sel_rs2__var;
    reg [4:0]dp_combs__areg_top_bit_set__var;
    reg [4:0]dp_combs__breg_top_bit_set__var;
        dp_combs__rs1_is_negative = coproc_controls__alu_rs1[31];
        dp_combs__rs2_is_negative = coproc_controls__alu_rs2[31];
        dp_combs__neg_rs1 = -coproc_controls__alu_rs1;
        dp_combs__neg_rs2 = -coproc_controls__alu_rs2;
        dp_combs__sel_rs1__var = coproc_controls__alu_rs1;
        dp_combs__sel_rs2__var = coproc_controls__alu_rs2;
        if ((dp_combs__sel_neg_rs1!=1'h0))
        begin
            dp_combs__sel_rs1__var = dp_combs__neg_rs1;
        end //if
        if ((dp_combs__sel_neg_rs2!=1'h0))
        begin
            dp_combs__sel_rs2__var = dp_combs__neg_rs2;
        end //if
        dp_combs__areg_top_bit_set__var = 5'h0;
        dp_combs__breg_top_bit_set__var = 5'h0;
        if ((dp_state__areg[0]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h0;
        end //if
        if ((dp_state__breg[0]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h0;
        end //if
        if ((dp_state__areg[1]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1;
        end //if
        if ((dp_state__breg[1]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1;
        end //if
        if ((dp_state__areg[2]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h2;
        end //if
        if ((dp_state__breg[2]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h2;
        end //if
        if ((dp_state__areg[3]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h3;
        end //if
        if ((dp_state__breg[3]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h3;
        end //if
        if ((dp_state__areg[4]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h4;
        end //if
        if ((dp_state__breg[4]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h4;
        end //if
        if ((dp_state__areg[5]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h5;
        end //if
        if ((dp_state__breg[5]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h5;
        end //if
        if ((dp_state__areg[6]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h6;
        end //if
        if ((dp_state__breg[6]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h6;
        end //if
        if ((dp_state__areg[7]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h7;
        end //if
        if ((dp_state__breg[7]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h7;
        end //if
        if ((dp_state__areg[8]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h8;
        end //if
        if ((dp_state__breg[8]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h8;
        end //if
        if ((dp_state__areg[9]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h9;
        end //if
        if ((dp_state__breg[9]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h9;
        end //if
        if ((dp_state__areg[10]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'ha;
        end //if
        if ((dp_state__breg[10]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'ha;
        end //if
        if ((dp_state__areg[11]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'hb;
        end //if
        if ((dp_state__breg[11]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'hb;
        end //if
        if ((dp_state__areg[12]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'hc;
        end //if
        if ((dp_state__breg[12]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'hc;
        end //if
        if ((dp_state__areg[13]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'hd;
        end //if
        if ((dp_state__breg[13]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'hd;
        end //if
        if ((dp_state__areg[14]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'he;
        end //if
        if ((dp_state__breg[14]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'he;
        end //if
        if ((dp_state__areg[15]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'hf;
        end //if
        if ((dp_state__breg[15]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'hf;
        end //if
        if ((dp_state__areg[16]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h10;
        end //if
        if ((dp_state__breg[16]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h10;
        end //if
        if ((dp_state__areg[17]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h11;
        end //if
        if ((dp_state__breg[17]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h11;
        end //if
        if ((dp_state__areg[18]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h12;
        end //if
        if ((dp_state__breg[18]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h12;
        end //if
        if ((dp_state__areg[19]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h13;
        end //if
        if ((dp_state__breg[19]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h13;
        end //if
        if ((dp_state__areg[20]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h14;
        end //if
        if ((dp_state__breg[20]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h14;
        end //if
        if ((dp_state__areg[21]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h15;
        end //if
        if ((dp_state__breg[21]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h15;
        end //if
        if ((dp_state__areg[22]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h16;
        end //if
        if ((dp_state__breg[22]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h16;
        end //if
        if ((dp_state__areg[23]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h17;
        end //if
        if ((dp_state__breg[23]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h17;
        end //if
        if ((dp_state__areg[24]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h18;
        end //if
        if ((dp_state__breg[24]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h18;
        end //if
        if ((dp_state__areg[25]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h19;
        end //if
        if ((dp_state__breg[25]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h19;
        end //if
        if ((dp_state__areg[26]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1a;
        end //if
        if ((dp_state__breg[26]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1a;
        end //if
        if ((dp_state__areg[27]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1b;
        end //if
        if ((dp_state__breg[27]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1b;
        end //if
        if ((dp_state__areg[28]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1c;
        end //if
        if ((dp_state__breg[28]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1c;
        end //if
        if ((dp_state__areg[29]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1d;
        end //if
        if ((dp_state__breg[29]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1d;
        end //if
        if ((dp_state__areg[30]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1e;
        end //if
        if ((dp_state__breg[30]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1e;
        end //if
        if ((dp_state__areg[31]!=1'h0))
        begin
            dp_combs__areg_top_bit_set__var = 5'h1f;
        end //if
        if ((dp_state__breg[31]!=1'h0))
        begin
            dp_combs__breg_top_bit_set__var = 5'h1f;
        end //if
        dp_combs__sel_rs1 = dp_combs__sel_rs1__var;
        dp_combs__sel_rs2 = dp_combs__sel_rs2__var;
        dp_combs__areg_top_bit_set = dp_combs__areg_top_bit_set__var;
        dp_combs__breg_top_bit_set = dp_combs__breg_top_bit_set__var;
    end //always

    //b datapath combinatorial process
        //   
        //       mult_data [36 bits] = a 4-bit multiply of breg by sel0123/sel048c
        //       mult_shf  [64 bits] = mult_data << 4*shift
        //       i.e.
        //       mult_shf = breg << N (if sel0123/sel048c has a single bit K set then N=K + shift)
        //       or
        //       mult_shf = (breg * M) << N (M = {sel048c, sel0123})
        //       or
        //       mult_shf = 0 (if sel0123, sel048c = 0)
        //   
        //       add_l = mult_shf[32;0] + acc[32;0]
        //   
        //       For divide step,   add_l is remainder + ((-divisor)<<N)
        //       For multiply step, add_l is acc_l + (breg*(4 bits of areg))
        //   
        //       add_h = 0/-rs1/acc_h + 0/-rs2/shf_h
        //   
        //       For multiply init  add_h is 0/-rs1 + 0/-rs2 as the initial multiplier accumulator
        //       For multiply step, add_h is acc_h + (breg*(4 bits of areg))
        //       For divide shift,  add_h is 0 + 0
        //       For divide step,   add_h is acc_h + 0
        //   
        //       
    always @ ( * )//datapath
    begin: datapath__comb_code
    reg [35:0]dp_combs__mux_0123__var;
    reg [35:0]dp_combs__mux_048c__var;
    reg [63:0]dp_combs__mult_shf__var;
    reg [31:0]dp_combs__add_h_in_0__var;
    reg [31:0]dp_combs__add_h_in_1__var;
        dp_combs__breg_0 = 36'h0;
        dp_combs__breg_1 = {4'h0,dp_state__breg};
        dp_combs__breg_2 = {{3'h0,dp_state__breg},1'h0};
        dp_combs__breg_4 = {{2'h0,dp_state__breg},2'h0};
        dp_combs__breg_8 = {{1'h0,dp_state__breg},3'h0};
        dp_combs__breg_3 = (dp_combs__breg_2+dp_combs__breg_1);
        dp_combs__breg_c = {dp_combs__breg_3[33:0],2'h0};
        dp_combs__mux_0123__var = dp_combs__breg_0;
        case (dp_combs__sel0123) //synopsys parallel_case
        2'h0: // req 1
            begin
            dp_combs__mux_0123__var = dp_combs__breg_0;
            end
        2'h1: // req 1
            begin
            dp_combs__mux_0123__var = dp_combs__breg_1;
            end
        2'h2: // req 1
            begin
            dp_combs__mux_0123__var = dp_combs__breg_2;
            end
        2'h3: // req 1
            begin
            dp_combs__mux_0123__var = dp_combs__breg_3;
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_muldiv:datapath: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        dp_combs__mux_048c__var = dp_combs__breg_0;
        case (dp_combs__sel048c) //synopsys parallel_case
        2'h0: // req 1
            begin
            dp_combs__mux_048c__var = dp_combs__breg_0;
            end
        2'h1: // req 1
            begin
            dp_combs__mux_048c__var = dp_combs__breg_4;
            end
        2'h2: // req 1
            begin
            dp_combs__mux_048c__var = dp_combs__breg_8;
            end
        2'h3: // req 1
            begin
            dp_combs__mux_048c__var = dp_combs__breg_c;
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_muldiv:datapath: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        dp_combs__mult_data = (dp_combs__mux_0123__var+dp_combs__mux_048c__var);
        dp_combs__mult_shf__var = 64'h0;
        case (dp_combs__shift[2:0]) //synopsys parallel_case
        3'h0: // req 1
            begin
            dp_combs__mult_shf__var = {28'h0,dp_combs__mult_data};
            end
        3'h1: // req 1
            begin
            dp_combs__mult_shf__var = {{24'h0,dp_combs__mult_data},4'h0};
            end
        3'h2: // req 1
            begin
            dp_combs__mult_shf__var = {{20'h0,dp_combs__mult_data},8'h0};
            end
        3'h3: // req 1
            begin
            dp_combs__mult_shf__var = {{16'h0,dp_combs__mult_data},12'h0};
            end
        3'h4: // req 1
            begin
            dp_combs__mult_shf__var = {{12'h0,dp_combs__mult_data},16'h0};
            end
        3'h5: // req 1
            begin
            dp_combs__mult_shf__var = {{8'h0,dp_combs__mult_data},20'h0};
            end
        3'h6: // req 1
            begin
            dp_combs__mult_shf__var = {{4'h0,dp_combs__mult_data},24'h0};
            end
        3'h7: // req 1
            begin
            dp_combs__mult_shf__var = {dp_combs__mult_data,28'h0};
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_muldiv:datapath: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        dp_combs__add_l_in_0 = dp_combs__mult_shf__var[31:0];
        dp_combs__add_l_in_1 = dp_state__acc_low;
        dp_combs__add_h_in_0__var = 32'h0;
        case (dp_combs__add_h_0_src) //synopsys parallel_case
        2'h0: // req 1
            begin
            dp_combs__add_h_in_0__var = 32'h0;
            end
        2'h1: // req 1
            begin
            dp_combs__add_h_in_0__var = dp_state__acc_high;
            end
        2'h2: // req 1
            begin
            dp_combs__add_h_in_0__var = dp_combs__neg_rs1;
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
        dp_combs__add_h_in_1__var = 32'h0;
        case (dp_combs__add_h_1_src) //synopsys parallel_case
        2'h0: // req 1
            begin
            dp_combs__add_h_in_1__var = 32'h0;
            end
        2'h1: // req 1
            begin
            dp_combs__add_h_in_1__var = dp_combs__mult_shf__var[63:32];
            end
        2'h2: // req 1
            begin
            dp_combs__add_h_in_1__var = dp_combs__neg_rs2;
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
        dp_combs__add_l = ({1'h0,dp_combs__add_l_in_0}+{1'h0,dp_combs__add_l_in_1});
        dp_combs__add_l_carry = dp_combs__add_l[32];
        dp_combs__add_h_carry_in = ((dp_combs__acc_carry_low_to_high!=1'h0)&&(dp_combs__add_l_carry!=1'h0));
        dp_combs__add_h = (({1'h0,dp_combs__add_h_in_0__var}+{1'h0,dp_combs__add_h_in_1__var})+{32'h0,dp_combs__add_h_carry_in});
        dp_combs__add_h_carry = dp_combs__add_h[32];
        dp_combs__mux_0123 = dp_combs__mux_0123__var;
        dp_combs__mux_048c = dp_combs__mux_048c__var;
        dp_combs__mult_shf = dp_combs__mult_shf__var;
        dp_combs__add_h_in_0 = dp_combs__add_h_in_0__var;
        dp_combs__add_h_in_1 = dp_combs__add_h_in_1__var;
    end //always

    //b control__comb combinatorial process
        //   
        //       
    always @ ( * )//control__comb
    begin: control__comb_code
    reg [1:0]dp_combs__sel0123__var;
    reg [1:0]dp_combs__sel048c__var;
    reg [2:0]dp_combs__shift__var;
    reg [1:0]dp_combs__add_h_0_src__var;
    reg [1:0]dp_combs__add_h_1_src__var;
    reg dp_combs__acc_carry_low_to_high__var;
    reg dp_combs__sel_neg_rs1__var;
    reg dp_combs__sel_neg_rs2__var;
    reg dp_combs__completed__var;
        dp_combs__sel0123__var = dp_state__breg[1:0];
        dp_combs__sel048c__var = dp_state__breg[3:2];
        dp_combs__shift__var = dp_state__stage[2:0];
        dp_combs__add_h_0_src__var = 2'h1;
        dp_combs__add_h_1_src__var = 2'h1;
        dp_combs__acc_carry_low_to_high__var = 1'h0;
        dp_combs__sel_neg_rs1__var = 1'h0;
        dp_combs__sel_neg_rs2__var = 1'h0;
        dp_combs__completed__var = 1'h0;
        case (dp_state__fsm_state) //synopsys parallel_case
        3'h1: // req 1
            begin
            dp_combs__sel0123__var = 2'h0;
            dp_combs__sel048c__var = 2'h0;
            dp_combs__add_h_0_src__var = 2'h0;
            dp_combs__add_h_1_src__var = 2'h0;
            if (((dp_state__op_signed[0]!=1'h0)&&(dp_combs__rs1_is_negative!=1'h0)))
            begin
                dp_combs__add_h_1_src__var = 2'h2;
            end //if
            if (((dp_state__op_signed[1]!=1'h0)&&(dp_combs__rs2_is_negative!=1'h0)))
            begin
                dp_combs__add_h_0_src__var = 2'h2;
            end //if
            end
        3'h2: // req 1
            begin
            dp_combs__sel0123__var = dp_state__areg[1:0];
            dp_combs__sel048c__var = dp_state__areg[3:2];
            dp_combs__shift__var = dp_state__stage[2:0];
            dp_combs__acc_carry_low_to_high__var = 1'h1;
            dp_combs__add_h_0_src__var = 2'h1;
            dp_combs__add_h_1_src__var = 2'h1;
            dp_combs__completed__var = (dp_state__areg[31:4]==28'h0);
            end
        3'h3: // req 1
            begin
            if ((dp_state__op_signed[0]!=1'h0))
            begin
                if ((dp_combs__rs1_is_negative!=1'h0))
                begin
                    dp_combs__sel_neg_rs1__var = 1'h1;
                end //if
                if ((dp_combs__rs2_is_negative!=1'h0))
                begin
                    dp_combs__sel_neg_rs2__var = 1'h1;
                end //if
            end //if
            end
        3'h4: // req 1
            begin
            dp_combs__sel_neg_rs2__var = 1'h1;
            if (((dp_state__op_signed[0]!=1'h0)&&(dp_combs__rs2_is_negative!=1'h0)))
            begin
                dp_combs__sel_neg_rs2__var = 1'h0;
            end //if
            dp_combs__acc_carry_low_to_high__var = 1'h0;
            dp_combs__add_h_0_src__var = 2'h0;
            dp_combs__add_h_1_src__var = 2'h0;
            if ((dp_state__breg==32'h0))
            begin
                dp_combs__completed__var = 1'h1;
            end //if
            if ((dp_combs__breg_top_bit_set>dp_combs__areg_top_bit_set))
            begin
                dp_combs__completed__var = 1'h1;
            end //if
            end
        3'h5: // req 1
            begin
            dp_combs__sel0123__var = 2'h0;
            dp_combs__sel048c__var = 2'h0;
            if ((dp_state__stage[1:0]==2'h0))
            begin
                dp_combs__sel0123__var[0] = 1'h1;
            end //if
            if ((dp_state__stage[1:0]==2'h1))
            begin
                dp_combs__sel0123__var[1] = 1'h1;
            end //if
            if ((dp_state__stage[1:0]==2'h2))
            begin
                dp_combs__sel048c__var[0] = 1'h1;
            end //if
            if ((dp_state__stage[1:0]==2'h3))
            begin
                dp_combs__sel048c__var[1] = 1'h1;
            end //if
            dp_combs__shift__var = dp_state__stage[4:2];
            dp_combs__add_h_0_src__var = 2'h1;
            dp_combs__add_h_1_src__var = 2'h0;
            dp_combs__acc_carry_low_to_high__var = 1'h0;
            if ((dp_state__stage==5'h0))
            begin
                dp_combs__completed__var = 1'h1;
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
        dp_combs__sel0123 = dp_combs__sel0123__var;
        dp_combs__sel048c = dp_combs__sel048c__var;
        dp_combs__shift = dp_combs__shift__var;
        dp_combs__add_h_0_src = dp_combs__add_h_0_src__var;
        dp_combs__add_h_1_src = dp_combs__add_h_1_src__var;
        dp_combs__acc_carry_low_to_high = dp_combs__acc_carry_low_to_high__var;
        dp_combs__sel_neg_rs1 = dp_combs__sel_neg_rs1__var;
        dp_combs__sel_neg_rs2 = dp_combs__sel_neg_rs2__var;
        dp_combs__completed = dp_combs__completed__var;
    end //always

    //b control__posedge_clk_active_low_reset_n clock process
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : control__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            dp_state__stage <= 5'h0;
            dp_state__areg <= 32'h0;
            dp_state__breg <= 32'h0;
            dp_state__acc_low <= 32'h0;
            dp_state__acc_high <= 32'h0;
            dp_state__negate_result <= 1'h0;
            dp_state__negate_remainder <= 1'h0;
        end
        else if (clk__enable)
        begin
            case (dp_state__fsm_state) //synopsys parallel_case
            3'h1: // req 1
                begin
                dp_state__stage <= 5'h0;
                dp_state__areg <= dp_combs__sel_rs1;
                dp_state__breg <= dp_combs__sel_rs2;
                dp_state__acc_low <= 32'h0;
                dp_state__acc_high <= dp_combs__add_h[31:0];
                dp_state__negate_result <= 1'h0;
                dp_state__negate_remainder <= 1'h0;
                end
            3'h2: // req 1
                begin
                dp_state__stage <= (dp_state__stage+5'h1);
                dp_state__areg <= (dp_state__areg>>64'h4);
                dp_state__acc_low <= dp_combs__add_l[31:0];
                dp_state__acc_high <= dp_combs__add_h[31:0];
                end
            3'h3: // req 1
                begin
                dp_state__negate_result <= 1'h0;
                dp_state__negate_remainder <= 1'h0;
                dp_state__areg <= dp_combs__sel_rs1;
                dp_state__breg <= dp_combs__sel_rs2;
                if ((dp_state__op_signed[0]!=1'h0))
                begin
                    if ((dp_combs__rs1_is_negative!=1'h0))
                    begin
                        dp_state__negate_remainder <= 1'h1;
                    end //if
                    if ((dp_combs__rs1_is_negative!=dp_combs__rs2_is_negative))
                    begin
                        dp_state__negate_result <= 1'h1;
                    end //if
                end //if
                end
            3'h4: // req 1
                begin
                dp_state__breg <= dp_combs__sel_rs2;
                dp_state__acc_low <= dp_state__areg;
                dp_state__acc_high <= dp_combs__add_h[31:0];
                if ((dp_state__breg==32'h0))
                begin
                    dp_state__acc_high <= 32'hffffffff;
                    dp_state__negate_result <= 1'h0;
                end //if
                dp_state__stage <= (dp_combs__areg_top_bit_set-dp_combs__breg_top_bit_set);
                if ((dp_combs__breg_top_bit_set>dp_combs__areg_top_bit_set))
                begin
                    dp_state__stage <= 5'h0;
                end //if
                end
            3'h5: // req 1
                begin
                if ((dp_combs__add_l_carry!=1'h0))
                begin
                    dp_state__acc_low <= dp_combs__add_l[31:0];
                    dp_state__acc_high[dp_state__stage] <= 1'h1;
                end //if
                dp_state__stage <= (dp_state__stage-5'h1);
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
    end //always

    //b state_machine__comb combinatorial process
        //   
        //       The state machine is simple enough.
        //   
        //       The starting point is either mul_init or div_init; however, for
        //       mul after mulh and rem[us] after div[us] the second can go
        //       straight to complete.
        //       
    always @ ( * )//state_machine__comb
    begin: state_machine__comb_code
        dec_fuse_combs__match = ((dec_fuse__rs1==coproc_controls__dec_idecode__rs1)&&(dec_fuse__rs2==coproc_controls__dec_idecode__rs2));
    end //always

    //b state_machine__posedge_clk_active_low_reset_n clock process
        //   
        //       The state machine is simple enough.
        //   
        //       The starting point is either mul_init or div_init; however, for
        //       mul after mulh and rem[us] after div[us] the second can go
        //       straight to complete.
        //       
    always @( posedge clk or negedge reset_n)
    begin : state_machine__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            dp_state__fsm_state <= 3'h0;
            dec_fuse__was_mulh <= 1'h0;
            dec_fuse__was_divu <= 1'h0;
            dec_fuse__was_divs <= 1'h0;
            dec_fuse__rs1 <= 5'h0;
            dec_fuse__rs2 <= 5'h0;
            dp_state__op_signed <= 2'h0;
            dp_state__result_type <= 2'h0;
        end
        else if (clk__enable)
        begin
            case (dp_state__fsm_state) //synopsys parallel_case
            3'h0: // req 1
                begin
                dp_state__fsm_state <= dp_state__fsm_state;
                end
            3'h1: // req 1
                begin
                if (!(coproc_controls__alu_cannot_start!=1'h0))
                begin
                    dp_state__fsm_state <= 3'h2;
                end //if
                end
            3'h2: // req 1
                begin
                if ((dp_combs__completed!=1'h0))
                begin
                    dp_state__fsm_state <= 3'h6;
                end //if
                end
            3'h3: // req 1
                begin
                if (!(coproc_controls__alu_cannot_start!=1'h0))
                begin
                    dp_state__fsm_state <= 3'h4;
                end //if
                end
            3'h4: // req 1
                begin
                dp_state__fsm_state <= 3'h5;
                if ((dp_combs__completed!=1'h0))
                begin
                    dp_state__fsm_state <= 3'h6;
                end //if
                end
            3'h5: // req 1
                begin
                if ((dp_combs__completed!=1'h0))
                begin
                    dp_state__fsm_state <= 3'h6;
                end //if
                end
            3'h6: // req 1
                begin
                if (!(coproc_controls__alu_cannot_complete!=1'h0))
                begin
                    dp_state__fsm_state <= 3'h0;
                end //if
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_muldiv:state_machine: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
            if ((!(coproc_controls__dec_to_alu_blocked!=1'h0)&&(coproc_controls__dec_idecode_valid!=1'h0)))
            begin
                dec_fuse__was_mulh <= 1'h0;
                dec_fuse__was_divu <= 1'h0;
                dec_fuse__was_divs <= 1'h0;
                if ((coproc_controls__dec_idecode__op==4'h8))
                begin
                    dec_fuse__rs1 <= coproc_controls__dec_idecode__rs1;
                    dec_fuse__rs2 <= coproc_controls__dec_idecode__rs2;
                    dp_state__op_signed <= 2'h0;
                    dp_state__result_type <= 2'h0;
                    case (coproc_controls__dec_idecode__subop) //synopsys parallel_case
                    4'h0: // req 1
                        begin
                        dp_state__fsm_state <= 3'h1;
                        dp_state__result_type <= 2'h0;
                        if (((dec_fuse__was_mulh!=1'h0)&&(dec_fuse_combs__match!=1'h0)))
                        begin
                            dp_state__fsm_state <= 3'h6;
                        end //if
                        end
                    4'h1: // req 1
                        begin
                        dp_state__fsm_state <= 3'h1;
                        dp_state__result_type <= 2'h1;
                        dp_state__op_signed <= 2'h3;
                        dec_fuse__was_mulh <= 1'h1;
                        end
                    4'h2: // req 1
                        begin
                        dp_state__fsm_state <= 3'h1;
                        dp_state__result_type <= 2'h1;
                        dp_state__op_signed <= 2'h1;
                        dec_fuse__was_mulh <= 1'h1;
                        end
                    4'h3: // req 1
                        begin
                        dp_state__fsm_state <= 3'h1;
                        dp_state__result_type <= 2'h1;
                        dp_state__op_signed <= 2'h0;
                        dec_fuse__was_mulh <= 1'h1;
                        end
                    4'h4: // req 1
                        begin
                        dp_state__fsm_state <= 3'h3;
                        dp_state__result_type <= 2'h1;
                        dp_state__op_signed <= 2'h3;
                        dec_fuse__was_divs <= 1'h1;
                        end
                    4'h5: // req 1
                        begin
                        dp_state__fsm_state <= 3'h3;
                        dp_state__result_type <= 2'h1;
                        dec_fuse__was_divu <= 1'h1;
                        end
                    4'h6: // req 1
                        begin
                        dp_state__fsm_state <= 3'h3;
                        dp_state__result_type <= 2'h0;
                        dp_state__op_signed <= 2'h3;
                        if (((dec_fuse__was_divs!=1'h0)&&(dec_fuse_combs__match!=1'h0)))
                        begin
                            dp_state__fsm_state <= 3'h6;
                        end //if
                        end
                    4'h7: // req 1
                        begin
                        dp_state__fsm_state <= 3'h3;
                        dp_state__result_type <= 2'h0;
                        if (((dec_fuse__was_divu!=1'h0)&&(dec_fuse_combs__match!=1'h0)))
                        begin
                            dp_state__fsm_state <= 3'h6;
                        end //if
                        end
                    default: // req 1
                        begin
                        dp_state__result_type <= 2'h1;
                        end
                    endcase
                    if (((coproc_controls__dec_idecode__rs1==coproc_controls__dec_idecode__rd)||(coproc_controls__dec_idecode__rs2==coproc_controls__dec_idecode__rd)))
                    begin
                        dec_fuse__was_mulh <= 1'h0;
                        dec_fuse__was_divu <= 1'h0;
                        dec_fuse__was_divs <= 1'h0;
                    end //if
                end //if
            end //if
            if ((coproc_controls__alu_flush_pipeline!=1'h0))
            begin
                dp_state__fsm_state <= 3'h0;
                dec_fuse__was_mulh <= 1'h0;
                dec_fuse__was_divu <= 1'h0;
                dec_fuse__was_divs <= 1'h0;
            end //if
            if (((1'h0!=64'h0)||!(riscv_config__i32m_fuse!=1'h0)))
            begin
                dec_fuse__rs1 <= 5'h0;
                dec_fuse__rs2 <= 5'h0;
                dec_fuse__was_mulh <= 1'h0;
                dec_fuse__was_divu <= 1'h0;
                dec_fuse__was_divs <= 1'h0;
            end //if
        end //if
    end //always

    //b outputs combinatorial process
        //   
        //       
    always @ ( * )//outputs
    begin: outputs__comb_code
    reg [31:0]dp_combs__result_acc__var;
    reg dp_combs__result_neg__var;
    reg [31:0]coproc_response__result__var;
    reg coproc_response__cannot_complete__var;
    reg coproc_response__result_valid__var;
        dp_combs__result_acc__var = dp_state__acc_low;
        dp_combs__result_neg__var = dp_state__negate_remainder;
        if ((dp_state__result_type==2'h1))
        begin
            dp_combs__result_acc__var = dp_state__acc_high;
            dp_combs__result_neg__var = dp_state__negate_result;
        end //if
        coproc_response__result__var = dp_combs__result_acc__var;
        if ((dp_combs__result_neg__var!=1'h0))
        begin
            coproc_response__result__var = -dp_combs__result_acc__var;
        end //if
        coproc_response__cannot_complete__var = 1'h0;
        coproc_response__result_valid__var = 1'h1;
        if ((dp_state__fsm_state!=3'h6))
        begin
            coproc_response__result_valid__var = 1'h0;
            coproc_response__result__var = 32'h0;
        end //if
        if (((dp_state__fsm_state!=3'h6)&&(dp_state__fsm_state!=3'h0)))
        begin
            coproc_response__cannot_complete__var = 1'h1;
        end //if
        coproc_response__cannot_start = 1'h0;
        dp_combs__result_acc = dp_combs__result_acc__var;
        dp_combs__result_neg = dp_combs__result_neg__var;
        coproc_response__result = coproc_response__result__var;
        coproc_response__cannot_complete = coproc_response__cannot_complete__var;
        coproc_response__result_valid = coproc_response__result_valid__var;
    end //always

endmodule // riscv_i32_muldiv
