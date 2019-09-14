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

//a Module riscv_i32_control_flow
    //   
    //   
    //   
module riscv_i32_control_flow
(

    control_data__interrupt_ack,
    control_data__valid,
    control_data__exec_committed,
    control_data__first_cycle,
    control_data__idecode__rs1,
    control_data__idecode__rs1_valid,
    control_data__idecode__rs2,
    control_data__idecode__rs2_valid,
    control_data__idecode__rd,
    control_data__idecode__rd_written,
    control_data__idecode__csr_access__access_cancelled,
    control_data__idecode__csr_access__access,
    control_data__idecode__csr_access__address,
    control_data__idecode__csr_access__write_data,
    control_data__idecode__immediate,
    control_data__idecode__immediate_shift,
    control_data__idecode__immediate_valid,
    control_data__idecode__op,
    control_data__idecode__subop,
    control_data__idecode__funct7,
    control_data__idecode__minimum_mode,
    control_data__idecode__illegal,
    control_data__idecode__illegal_pc,
    control_data__idecode__is_compressed,
    control_data__idecode__ext__dummy,
    control_data__pc,
    control_data__instruction_data,
    control_data__alu_result__result,
    control_data__alu_result__arith_result,
    control_data__alu_result__branch_condition_met,
    control_data__alu_result__branch_target,
    control_data__alu_result__csr_access__access_cancelled,
    control_data__alu_result__csr_access__access,
    control_data__alu_result__csr_access__address,
    control_data__alu_result__csr_access__write_data,
    pipeline_control__valid,
    pipeline_control__fetch_action,
    pipeline_control__fetch_pc,
    pipeline_control__mode,
    pipeline_control__error,
    pipeline_control__tag,
    pipeline_control__halt,
    pipeline_control__ebreak_to_dbg,
    pipeline_control__interrupt_req,
    pipeline_control__interrupt_number,
    pipeline_control__interrupt_to_mode,
    pipeline_control__instruction_data,
    pipeline_control__instruction_debug__valid,
    pipeline_control__instruction_debug__debug_op,
    pipeline_control__instruction_debug__data,

    control_flow__async_cancel,
    control_flow__branch_taken,
    control_flow__jalr,
    control_flow__next_pc,
    control_flow__trap__valid,
    control_flow__trap__to_mode,
    control_flow__trap__cause,
    control_flow__trap__pc,
    control_flow__trap__value,
    control_flow__trap__ret,
    control_flow__trap__vector,
    control_flow__trap__ebreak_to_dbg
);

    //b Clocks

    //b Inputs
    input control_data__interrupt_ack;
    input control_data__valid;
    input control_data__exec_committed;
    input control_data__first_cycle;
    input [4:0]control_data__idecode__rs1;
    input control_data__idecode__rs1_valid;
    input [4:0]control_data__idecode__rs2;
    input control_data__idecode__rs2_valid;
    input [4:0]control_data__idecode__rd;
    input control_data__idecode__rd_written;
    input control_data__idecode__csr_access__access_cancelled;
    input [2:0]control_data__idecode__csr_access__access;
    input [11:0]control_data__idecode__csr_access__address;
    input [31:0]control_data__idecode__csr_access__write_data;
    input [31:0]control_data__idecode__immediate;
    input [4:0]control_data__idecode__immediate_shift;
    input control_data__idecode__immediate_valid;
    input [3:0]control_data__idecode__op;
    input [3:0]control_data__idecode__subop;
    input [6:0]control_data__idecode__funct7;
    input [2:0]control_data__idecode__minimum_mode;
    input control_data__idecode__illegal;
    input control_data__idecode__illegal_pc;
    input control_data__idecode__is_compressed;
    input control_data__idecode__ext__dummy;
    input [31:0]control_data__pc;
    input [31:0]control_data__instruction_data;
    input [31:0]control_data__alu_result__result;
    input [31:0]control_data__alu_result__arith_result;
    input control_data__alu_result__branch_condition_met;
    input [31:0]control_data__alu_result__branch_target;
    input control_data__alu_result__csr_access__access_cancelled;
    input [2:0]control_data__alu_result__csr_access__access;
    input [11:0]control_data__alu_result__csr_access__address;
    input [31:0]control_data__alu_result__csr_access__write_data;
    input pipeline_control__valid;
    input [2:0]pipeline_control__fetch_action;
    input [31:0]pipeline_control__fetch_pc;
    input [2:0]pipeline_control__mode;
    input pipeline_control__error;
    input [1:0]pipeline_control__tag;
    input pipeline_control__halt;
    input pipeline_control__ebreak_to_dbg;
    input pipeline_control__interrupt_req;
    input [3:0]pipeline_control__interrupt_number;
    input [2:0]pipeline_control__interrupt_to_mode;
    input [31:0]pipeline_control__instruction_data;
    input pipeline_control__instruction_debug__valid;
    input [1:0]pipeline_control__instruction_debug__debug_op;
    input [15:0]pipeline_control__instruction_debug__data;

    //b Outputs
    output control_flow__async_cancel;
    output control_flow__branch_taken;
    output control_flow__jalr;
    output [31:0]control_flow__next_pc;
    output control_flow__trap__valid;
    output [2:0]control_flow__trap__to_mode;
    output [3:0]control_flow__trap__cause;
    output [31:0]control_flow__trap__pc;
    output [31:0]control_flow__trap__value;
    output control_flow__trap__ret;
    output control_flow__trap__vector;
    output control_flow__trap__ebreak_to_dbg;

// output components here

    //b Output combinatorials
    reg control_flow__async_cancel;
    reg control_flow__branch_taken;
    reg control_flow__jalr;
    reg [31:0]control_flow__next_pc;
    reg control_flow__trap__valid;
    reg [2:0]control_flow__trap__to_mode;
    reg [3:0]control_flow__trap__cause;
    reg [31:0]control_flow__trap__pc;
    reg [31:0]control_flow__trap__value;
    reg control_flow__trap__ret;
    reg control_flow__trap__vector;
    reg control_flow__trap__ebreak_to_dbg;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b code combinatorial process
    always @ ( * )//code
    begin: code__comb_code
    reg control_flow__trap__valid__var;
    reg [2:0]control_flow__trap__to_mode__var;
    reg [3:0]control_flow__trap__cause__var;
    reg [31:0]control_flow__trap__pc__var;
    reg [31:0]control_flow__trap__value__var;
    reg control_flow__trap__ret__var;
    reg control_flow__trap__ebreak_to_dbg__var;
    reg control_flow__branch_taken__var;
    reg control_flow__jalr__var;
    reg control_flow__async_cancel__var;
        control_flow__trap__valid__var = 1'h0;
        control_flow__trap__to_mode__var = 3'h0;
        control_flow__trap__cause__var = 4'h0;
        control_flow__trap__pc__var = 32'h0;
        control_flow__trap__value__var = 32'h0;
        control_flow__trap__ret__var = 1'h0;
        control_flow__trap__vector = 1'h0;
        control_flow__trap__ebreak_to_dbg__var = 1'h0;
        control_flow__branch_taken__var = 1'h0;
        control_flow__jalr__var = 1'h0;
        control_flow__next_pc = 32'h0;
        control_flow__trap__pc__var = control_data__pc;
        control_flow__async_cancel__var = 1'h0;
        control_flow__trap__to_mode__var = pipeline_control__interrupt_to_mode;
        case (control_data__idecode__op) //synopsys parallel_case
        4'h0: // req 1
            begin
            control_flow__branch_taken__var = control_data__alu_result__branch_condition_met;
            end
        4'h1: // req 1
            begin
            control_flow__branch_taken__var = 1'h1;
            end
        4'h2: // req 1
            begin
            control_flow__branch_taken__var = 1'h1;
            control_flow__jalr__var = 1'h1;
            end
        4'h3: // req 1
            begin
            if ((control_data__idecode__subop==4'h2))
            begin
                control_flow__trap__ret__var = 1'h1;
                control_flow__trap__cause__var = 4'h0;
            end //if
            if ((control_data__idecode__subop==4'h0))
            begin
                control_flow__trap__valid__var = 1'h1;
                control_flow__trap__cause__var = 4'hb;
            end //if
            if ((control_data__idecode__subop==4'h1))
            begin
                control_flow__trap__valid__var = 1'h1;
                control_flow__trap__ebreak_to_dbg__var = pipeline_control__ebreak_to_dbg;
                control_flow__trap__cause__var = 4'h3;
                control_flow__trap__value__var = control_data__pc;
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
        if (!(control_data__exec_committed!=1'h0))
        begin
            control_flow__trap__valid__var = 1'h0;
            control_flow__trap__ret__var = 1'h0;
            control_flow__trap__ebreak_to_dbg__var = 1'h0;
            control_flow__branch_taken__var = 1'h0;
        end //if
        if (((control_data__valid!=1'h0)&&(control_data__idecode__illegal!=1'h0)))
        begin
            control_flow__trap__valid__var = 1'h1;
            control_flow__trap__ret__var = 1'h0;
            control_flow__trap__cause__var = 4'h2;
            control_flow__trap__value__var = control_data__instruction_data;
        end //if
        if (((control_data__valid!=1'h0)&&(control_data__idecode__illegal_pc!=1'h0)))
        begin
            control_flow__trap__valid__var = 1'h1;
            control_flow__trap__ret__var = 1'h0;
            control_flow__trap__cause__var = 4'h0;
            control_flow__trap__value__var = control_data__pc;
        end //if
        if (((pipeline_control__interrupt_req!=1'h0)&&(control_data__interrupt_ack!=1'h0)))
        begin
            control_flow__async_cancel__var = 1'h1;
            control_flow__trap__valid__var = 1'h1;
            control_flow__trap__ret__var = 1'h0;
            control_flow__trap__cause__var = 4'hf;
            control_flow__trap__cause__var[3:0] = pipeline_control__interrupt_number;
            control_flow__trap__value__var = control_data__pc;
        end //if
        control_flow__trap__valid = control_flow__trap__valid__var;
        control_flow__trap__to_mode = control_flow__trap__to_mode__var;
        control_flow__trap__cause = control_flow__trap__cause__var;
        control_flow__trap__pc = control_flow__trap__pc__var;
        control_flow__trap__value = control_flow__trap__value__var;
        control_flow__trap__ret = control_flow__trap__ret__var;
        control_flow__trap__ebreak_to_dbg = control_flow__trap__ebreak_to_dbg__var;
        control_flow__branch_taken = control_flow__branch_taken__var;
        control_flow__jalr = control_flow__jalr__var;
        control_flow__async_cancel = control_flow__async_cancel__var;
    end //always

endmodule // riscv_i32_control_flow
