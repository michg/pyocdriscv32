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

//a Module riscv_i32_debug_decode
    //   
    //   Instruction decoder for RISC-V debugger
    //   
module riscv_i32_debug_decode
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

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b idecode_logic combinatorial process
    always @ ( * )//idecode_logic
    begin: idecode_logic__comb_code
    reg [4:0]idecode__rs1__var;
    reg idecode__rs1_valid__var;
    reg [4:0]idecode__rs2__var;
    reg idecode__rs2_valid__var;
    reg [4:0]idecode__rd__var;
    reg idecode__rd_written__var;
    reg [2:0]idecode__csr_access__access__var;
    reg [11:0]idecode__csr_access__address__var;
    reg [31:0]idecode__immediate__var;
    reg idecode__immediate_valid__var;
    reg [3:0]idecode__op__var;
    reg [3:0]idecode__subop__var;
        idecode__rs1__var = 5'h0;
        idecode__rs1_valid__var = 1'h0;
        idecode__rs2__var = 5'h0;
        idecode__rs2_valid__var = 1'h0;
        idecode__rd__var = 5'h0;
        idecode__rd_written__var = 1'h0;
        idecode__csr_access__access_cancelled = 1'h0;
        idecode__csr_access__access__var = 3'h0;
        idecode__csr_access__address__var = 12'h0;
        idecode__csr_access__write_data = 32'h0;
        idecode__immediate__var = 32'h0;
        idecode__immediate_shift = 5'h0;
        idecode__immediate_valid__var = 1'h0;
        idecode__op__var = 4'h0;
        idecode__subop__var = 4'h0;
        idecode__funct7 = 7'h0;
        idecode__minimum_mode = 3'h0;
        idecode__illegal = 1'h0;
        idecode__illegal_pc = 1'h0;
        idecode__is_compressed = 1'h0;
        idecode__ext__dummy = 1'h0;
        if ((riscv_config__i32c!=1'h0))
        begin
            idecode__rs1_valid__var = 1'h0;
        end //if
        idecode__immediate__var = instruction__data;
        idecode__rs1__var = instruction__debug__data[4:0];
        idecode__rs1_valid__var = 1'h1;
        idecode__rs2__var = 5'h0;
        idecode__rs2_valid__var = 1'h0;
        idecode__rd__var = instruction__debug__data[4:0];
        idecode__rd_written__var = 1'h0;
        idecode__immediate_valid__var = 1'h1;
        idecode__op__var = 4'h7;
        idecode__subop__var = 4'h6;
        idecode__csr_access__access__var = 3'h0;
        idecode__csr_access__address__var = instruction__debug__data[11:0];
        if ((instruction__debug__data[12]!=1'h0))
        begin
            case (instruction__debug__debug_op) //synopsys parallel_case
            2'h0: // req 1
                begin
                idecode__rs1_valid__var = 1'h0;
                idecode__immediate_valid__var = 1'h0;
                end
            2'h1: // req 1
                begin
                idecode__rs1__var = 5'h0;
                idecode__rs1_valid__var = 1'h0;
                idecode__immediate_valid__var = 1'h1;
                idecode__rd_written__var = 1'h1;
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_debug_decode:idecode_logic: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //if
        else
        
        begin
            idecode__op__var = 4'h4;
            idecode__subop__var = 4'h6;
            case (instruction__debug__debug_op) //synopsys parallel_case
            2'h0: // req 1
                begin
                idecode__csr_access__access__var = 3'h2;
                idecode__rs1_valid__var = 1'h0;
                idecode__immediate_valid__var = 1'h0;
                end
            2'h1: // req 1
                begin
                idecode__csr_access__access__var = 3'h1;
                idecode__rs1_valid__var = 1'h0;
                idecode__immediate_valid__var = 1'h1;
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_debug_decode:idecode_logic: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //else
        idecode__rs1 = idecode__rs1__var;
        idecode__rs1_valid = idecode__rs1_valid__var;
        idecode__rs2 = idecode__rs2__var;
        idecode__rs2_valid = idecode__rs2_valid__var;
        idecode__rd = idecode__rd__var;
        idecode__rd_written = idecode__rd_written__var;
        idecode__csr_access__access = idecode__csr_access__access__var;
        idecode__csr_access__address = idecode__csr_access__address__var;
        idecode__immediate = idecode__immediate__var;
        idecode__immediate_valid = idecode__immediate_valid__var;
        idecode__op = idecode__op__var;
        idecode__subop = idecode__subop__var;
    end //always

endmodule // riscv_i32_debug_decode
