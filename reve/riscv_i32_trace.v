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

//a Module riscv_i32_trace
    //   
    //   Trace instruction execution
    //   
module riscv_i32_trace
(
    clk,
    clk__enable,

    trace__instr_valid,
    trace__mode,
    trace__instr_pc,
    trace__instruction,
    trace__branch_taken,
    trace__branch_target,
    trace__trap,
    trace__ret,
    trace__jalr,
    trace__rfw_retire,
    trace__rfw_data_valid,
    trace__rfw_rd,
    trace__rfw_data,
    trace__bkpt_valid,
    trace__bkpt_reason,
    riscv_clk_enable,
    reset_n

);

    //b Clocks
        //   Free-running clock
    input clk;
    input clk__enable;

    //b Inputs
        //   Trace signals
    input trace__instr_valid;
    input [2:0]trace__mode;
    input [31:0]trace__instr_pc;
    input [31:0]trace__instruction;
    input trace__branch_taken;
    input [31:0]trace__branch_target;
    input trace__trap;
    input trace__ret;
    input trace__jalr;
    input trace__rfw_retire;
    input trace__rfw_data_valid;
    input [4:0]trace__rfw_rd;
    input [31:0]trace__rfw_data;
    input trace__bkpt_valid;
    input [3:0]trace__bkpt_reason;
        //   asserted if the RISC-V ticks on this edge
    input riscv_clk_enable;
        //   Active low reset
    input reset_n;

    //b Outputs

// output components here

    //b Output combinatorials

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
endmodule // riscv_i32_trace
