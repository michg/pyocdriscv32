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

//a Module riscv_i32_pipeline_control_csr_trace
module riscv_i32_pipeline_control_csr_trace
(

    coproc_response__cannot_start,
    coproc_response__result,
    coproc_response__result_valid,
    coproc_response__cannot_complete,
    riscv_config__i32c,
    riscv_config__e32,
    riscv_config__i32m,
    riscv_config__i32m_fuse,
    riscv_config__debug_enable,
    riscv_config__coproc_disable,
    riscv_config__unaligned_mem,
    pipeline_fetch_data__valid,
    pipeline_fetch_data__pc,
    pipeline_fetch_data__instruction__data,
    pipeline_fetch_data__instruction__debug__valid,
    pipeline_fetch_data__instruction__debug__debug_op,
    pipeline_fetch_data__instruction__debug__data,
    pipeline_fetch_data__dec_flush_pipeline,
    pipeline_fetch_data__dec_predicted_branch,
    pipeline_fetch_data__dec_pc_if_mispredicted,
    pipeline_response__decode__valid,
    pipeline_response__decode__blocked,
    pipeline_response__decode__pc,
    pipeline_response__decode__branch_target,
    pipeline_response__decode__idecode__rs1,
    pipeline_response__decode__idecode__rs1_valid,
    pipeline_response__decode__idecode__rs2,
    pipeline_response__decode__idecode__rs2_valid,
    pipeline_response__decode__idecode__rd,
    pipeline_response__decode__idecode__rd_written,
    pipeline_response__decode__idecode__csr_access__access_cancelled,
    pipeline_response__decode__idecode__csr_access__access,
    pipeline_response__decode__idecode__csr_access__address,
    pipeline_response__decode__idecode__csr_access__write_data,
    pipeline_response__decode__idecode__immediate,
    pipeline_response__decode__idecode__immediate_shift,
    pipeline_response__decode__idecode__immediate_valid,
    pipeline_response__decode__idecode__op,
    pipeline_response__decode__idecode__subop,
    pipeline_response__decode__idecode__funct7,
    pipeline_response__decode__idecode__minimum_mode,
    pipeline_response__decode__idecode__illegal,
    pipeline_response__decode__idecode__illegal_pc,
    pipeline_response__decode__idecode__is_compressed,
    pipeline_response__decode__idecode__ext__dummy,
    pipeline_response__decode__enable_branch_prediction,
    pipeline_response__exec__valid,
    pipeline_response__exec__cannot_start,
    pipeline_response__exec__cannot_complete,
    pipeline_response__exec__interrupt_ack,
    pipeline_response__exec__branch_taken,
    pipeline_response__exec__jalr,
    pipeline_response__exec__trap__valid,
    pipeline_response__exec__trap__to_mode,
    pipeline_response__exec__trap__cause,
    pipeline_response__exec__trap__pc,
    pipeline_response__exec__trap__value,
    pipeline_response__exec__trap__ret,
    pipeline_response__exec__trap__vector,
    pipeline_response__exec__trap__ebreak_to_dbg,
    pipeline_response__exec__is_compressed,
    pipeline_response__exec__instruction__data,
    pipeline_response__exec__instruction__debug__valid,
    pipeline_response__exec__instruction__debug__debug_op,
    pipeline_response__exec__instruction__debug__data,
    pipeline_response__exec__rs1,
    pipeline_response__exec__rs2,
    pipeline_response__exec__pc,
    pipeline_response__exec__predicted_branch,
    pipeline_response__exec__pc_if_mispredicted,
    pipeline_response__rfw__valid,
    pipeline_response__rfw__rd_written,
    pipeline_response__rfw__rd,
    pipeline_response__rfw__data,
    pipeline_response__pipeline_empty,
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
    csr_controls__exec_mode,
    csr_controls__retire,
    csr_controls__timer_value,
    csr_controls__trap__valid,
    csr_controls__trap__to_mode,
    csr_controls__trap__cause,
    csr_controls__trap__pc,
    csr_controls__trap__value,
    csr_controls__trap__ret,
    csr_controls__trap__vector,
    csr_controls__trap__ebreak_to_dbg,
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
    coproc_controls__alu_cannot_complete
);

    //b Clocks

    //b Inputs
    input coproc_response__cannot_start;
    input [31:0]coproc_response__result;
    input coproc_response__result_valid;
    input coproc_response__cannot_complete;
    input riscv_config__i32c;
    input riscv_config__e32;
    input riscv_config__i32m;
    input riscv_config__i32m_fuse;
    input riscv_config__debug_enable;
    input riscv_config__coproc_disable;
    input riscv_config__unaligned_mem;
    input pipeline_fetch_data__valid;
    input [31:0]pipeline_fetch_data__pc;
    input [31:0]pipeline_fetch_data__instruction__data;
    input pipeline_fetch_data__instruction__debug__valid;
    input [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    input [15:0]pipeline_fetch_data__instruction__debug__data;
    input pipeline_fetch_data__dec_flush_pipeline;
    input pipeline_fetch_data__dec_predicted_branch;
    input [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;
    input pipeline_response__decode__valid;
    input pipeline_response__decode__blocked;
    input [31:0]pipeline_response__decode__pc;
    input [31:0]pipeline_response__decode__branch_target;
    input [4:0]pipeline_response__decode__idecode__rs1;
    input pipeline_response__decode__idecode__rs1_valid;
    input [4:0]pipeline_response__decode__idecode__rs2;
    input pipeline_response__decode__idecode__rs2_valid;
    input [4:0]pipeline_response__decode__idecode__rd;
    input pipeline_response__decode__idecode__rd_written;
    input pipeline_response__decode__idecode__csr_access__access_cancelled;
    input [2:0]pipeline_response__decode__idecode__csr_access__access;
    input [11:0]pipeline_response__decode__idecode__csr_access__address;
    input [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    input [31:0]pipeline_response__decode__idecode__immediate;
    input [4:0]pipeline_response__decode__idecode__immediate_shift;
    input pipeline_response__decode__idecode__immediate_valid;
    input [3:0]pipeline_response__decode__idecode__op;
    input [3:0]pipeline_response__decode__idecode__subop;
    input [6:0]pipeline_response__decode__idecode__funct7;
    input [2:0]pipeline_response__decode__idecode__minimum_mode;
    input pipeline_response__decode__idecode__illegal;
    input pipeline_response__decode__idecode__illegal_pc;
    input pipeline_response__decode__idecode__is_compressed;
    input pipeline_response__decode__idecode__ext__dummy;
    input pipeline_response__decode__enable_branch_prediction;
    input pipeline_response__exec__valid;
    input pipeline_response__exec__cannot_start;
    input pipeline_response__exec__cannot_complete;
    input pipeline_response__exec__interrupt_ack;
    input pipeline_response__exec__branch_taken;
    input pipeline_response__exec__jalr;
    input pipeline_response__exec__trap__valid;
    input [2:0]pipeline_response__exec__trap__to_mode;
    input [3:0]pipeline_response__exec__trap__cause;
    input [31:0]pipeline_response__exec__trap__pc;
    input [31:0]pipeline_response__exec__trap__value;
    input pipeline_response__exec__trap__ret;
    input pipeline_response__exec__trap__vector;
    input pipeline_response__exec__trap__ebreak_to_dbg;
    input pipeline_response__exec__is_compressed;
    input [31:0]pipeline_response__exec__instruction__data;
    input pipeline_response__exec__instruction__debug__valid;
    input [1:0]pipeline_response__exec__instruction__debug__debug_op;
    input [15:0]pipeline_response__exec__instruction__debug__data;
    input [31:0]pipeline_response__exec__rs1;
    input [31:0]pipeline_response__exec__rs2;
    input [31:0]pipeline_response__exec__pc;
    input pipeline_response__exec__predicted_branch;
    input [31:0]pipeline_response__exec__pc_if_mispredicted;
    input pipeline_response__rfw__valid;
    input pipeline_response__rfw__rd_written;
    input [4:0]pipeline_response__rfw__rd;
    input [31:0]pipeline_response__rfw__data;
    input pipeline_response__pipeline_empty;
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
    output trace__instr_valid;
    output [2:0]trace__mode;
    output [31:0]trace__instr_pc;
    output [31:0]trace__instruction;
    output trace__branch_taken;
    output [31:0]trace__branch_target;
    output trace__trap;
    output trace__ret;
    output trace__jalr;
    output trace__rfw_retire;
    output trace__rfw_data_valid;
    output [4:0]trace__rfw_rd;
    output [31:0]trace__rfw_data;
    output trace__bkpt_valid;
    output [3:0]trace__bkpt_reason;
    output [2:0]csr_controls__exec_mode;
    output csr_controls__retire;
    output [63:0]csr_controls__timer_value;
    output csr_controls__trap__valid;
    output [2:0]csr_controls__trap__to_mode;
    output [3:0]csr_controls__trap__cause;
    output [31:0]csr_controls__trap__pc;
    output [31:0]csr_controls__trap__value;
    output csr_controls__trap__ret;
    output csr_controls__trap__vector;
    output csr_controls__trap__ebreak_to_dbg;
    output coproc_controls__dec_idecode_valid;
    output [4:0]coproc_controls__dec_idecode__rs1;
    output coproc_controls__dec_idecode__rs1_valid;
    output [4:0]coproc_controls__dec_idecode__rs2;
    output coproc_controls__dec_idecode__rs2_valid;
    output [4:0]coproc_controls__dec_idecode__rd;
    output coproc_controls__dec_idecode__rd_written;
    output coproc_controls__dec_idecode__csr_access__access_cancelled;
    output [2:0]coproc_controls__dec_idecode__csr_access__access;
    output [11:0]coproc_controls__dec_idecode__csr_access__address;
    output [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    output [31:0]coproc_controls__dec_idecode__immediate;
    output [4:0]coproc_controls__dec_idecode__immediate_shift;
    output coproc_controls__dec_idecode__immediate_valid;
    output [3:0]coproc_controls__dec_idecode__op;
    output [3:0]coproc_controls__dec_idecode__subop;
    output [6:0]coproc_controls__dec_idecode__funct7;
    output [2:0]coproc_controls__dec_idecode__minimum_mode;
    output coproc_controls__dec_idecode__illegal;
    output coproc_controls__dec_idecode__illegal_pc;
    output coproc_controls__dec_idecode__is_compressed;
    output coproc_controls__dec_idecode__ext__dummy;
    output coproc_controls__dec_to_alu_blocked;
    output [31:0]coproc_controls__alu_rs1;
    output [31:0]coproc_controls__alu_rs2;
    output coproc_controls__alu_flush_pipeline;
    output coproc_controls__alu_cannot_start;
    output coproc_controls__alu_cannot_complete;

// output components here

    //b Output combinatorials
    reg trace__instr_valid;
    reg [2:0]trace__mode;
    reg [31:0]trace__instr_pc;
    reg [31:0]trace__instruction;
    reg trace__branch_taken;
    reg [31:0]trace__branch_target;
    reg trace__trap;
    reg trace__ret;
    reg trace__jalr;
    reg trace__rfw_retire;
    reg trace__rfw_data_valid;
    reg [4:0]trace__rfw_rd;
    reg [31:0]trace__rfw_data;
    reg trace__bkpt_valid;
    reg [3:0]trace__bkpt_reason;
    reg [2:0]csr_controls__exec_mode;
    reg csr_controls__retire;
    reg [63:0]csr_controls__timer_value;
    reg csr_controls__trap__valid;
    reg [2:0]csr_controls__trap__to_mode;
    reg [3:0]csr_controls__trap__cause;
    reg [31:0]csr_controls__trap__pc;
    reg [31:0]csr_controls__trap__value;
    reg csr_controls__trap__ret;
    reg csr_controls__trap__vector;
    reg csr_controls__trap__ebreak_to_dbg;
    reg coproc_controls__dec_idecode_valid;
    reg [4:0]coproc_controls__dec_idecode__rs1;
    reg coproc_controls__dec_idecode__rs1_valid;
    reg [4:0]coproc_controls__dec_idecode__rs2;
    reg coproc_controls__dec_idecode__rs2_valid;
    reg [4:0]coproc_controls__dec_idecode__rd;
    reg coproc_controls__dec_idecode__rd_written;
    reg coproc_controls__dec_idecode__csr_access__access_cancelled;
    reg [2:0]coproc_controls__dec_idecode__csr_access__access;
    reg [11:0]coproc_controls__dec_idecode__csr_access__address;
    reg [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    reg [31:0]coproc_controls__dec_idecode__immediate;
    reg [4:0]coproc_controls__dec_idecode__immediate_shift;
    reg coproc_controls__dec_idecode__immediate_valid;
    reg [3:0]coproc_controls__dec_idecode__op;
    reg [3:0]coproc_controls__dec_idecode__subop;
    reg [6:0]coproc_controls__dec_idecode__funct7;
    reg [2:0]coproc_controls__dec_idecode__minimum_mode;
    reg coproc_controls__dec_idecode__illegal;
    reg coproc_controls__dec_idecode__illegal_pc;
    reg coproc_controls__dec_idecode__is_compressed;
    reg coproc_controls__dec_idecode__ext__dummy;
    reg coproc_controls__dec_to_alu_blocked;
    reg [31:0]coproc_controls__alu_rs1;
    reg [31:0]coproc_controls__alu_rs2;
    reg coproc_controls__alu_flush_pipeline;
    reg coproc_controls__alu_cannot_start;
    reg coproc_controls__alu_cannot_complete;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
        //   Coprocessor response masked out if configured off
    reg coproc_response_cfg__cannot_start;
    reg [31:0]coproc_response_cfg__result;
    reg coproc_response_cfg__result_valid;
    reg coproc_response_cfg__cannot_complete;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b csr_controls combinatorial process
    always @ ( * )//csr_controls
    begin: csr_controls__comb_code
    reg csr_controls__retire__var;
    reg csr_controls__trap__valid__var;
    reg [2:0]csr_controls__trap__to_mode__var;
    reg [3:0]csr_controls__trap__cause__var;
    reg [31:0]csr_controls__trap__pc__var;
    reg [31:0]csr_controls__trap__value__var;
    reg csr_controls__trap__ret__var;
    reg csr_controls__trap__vector__var;
    reg csr_controls__trap__ebreak_to_dbg__var;
        csr_controls__exec_mode = 3'h0;
        csr_controls__retire__var = 1'h0;
        csr_controls__timer_value = 64'h0;
        csr_controls__trap__valid__var = 1'h0;
        csr_controls__trap__to_mode__var = 3'h0;
        csr_controls__trap__cause__var = 4'h0;
        csr_controls__trap__pc__var = 32'h0;
        csr_controls__trap__value__var = 32'h0;
        csr_controls__trap__ret__var = 1'h0;
        csr_controls__trap__vector__var = 1'h0;
        csr_controls__trap__ebreak_to_dbg__var = 1'h0;
        csr_controls__retire__var = (((pipeline_response__exec__valid!=1'h0)&&!(pipeline_response__exec__cannot_complete!=1'h0))&&!(coproc_response_cfg__cannot_complete!=1'h0));
        csr_controls__trap__valid__var = pipeline_response__exec__trap__valid;
        csr_controls__trap__to_mode__var = pipeline_response__exec__trap__to_mode;
        csr_controls__trap__cause__var = pipeline_response__exec__trap__cause;
        csr_controls__trap__pc__var = pipeline_response__exec__trap__pc;
        csr_controls__trap__value__var = pipeline_response__exec__trap__value;
        csr_controls__trap__ret__var = pipeline_response__exec__trap__ret;
        csr_controls__trap__vector__var = pipeline_response__exec__trap__vector;
        csr_controls__trap__ebreak_to_dbg__var = pipeline_response__exec__trap__ebreak_to_dbg;
        csr_controls__retire = csr_controls__retire__var;
        csr_controls__trap__valid = csr_controls__trap__valid__var;
        csr_controls__trap__to_mode = csr_controls__trap__to_mode__var;
        csr_controls__trap__cause = csr_controls__trap__cause__var;
        csr_controls__trap__pc = csr_controls__trap__pc__var;
        csr_controls__trap__value = csr_controls__trap__value__var;
        csr_controls__trap__ret = csr_controls__trap__ret__var;
        csr_controls__trap__vector = csr_controls__trap__vector__var;
        csr_controls__trap__ebreak_to_dbg = csr_controls__trap__ebreak_to_dbg__var;
    end //always

    //b coprocessor_interface combinatorial process
        //   
        //       Drive the coprocessor controls unless disabled; mirror the pipeline combs
        //   
        //       Probably only legal if there is a decode stage - or if the coprocessor knows there is not
        //       
    always @ ( * )//coprocessor_interface
    begin: coprocessor_interface__comb_code
    reg coproc_response_cfg__cannot_start__var;
    reg [31:0]coproc_response_cfg__result__var;
    reg coproc_response_cfg__result_valid__var;
    reg coproc_response_cfg__cannot_complete__var;
    reg [4:0]coproc_controls__dec_idecode__rs1__var;
    reg coproc_controls__dec_idecode__rs1_valid__var;
    reg [4:0]coproc_controls__dec_idecode__rs2__var;
    reg coproc_controls__dec_idecode__rs2_valid__var;
    reg [4:0]coproc_controls__dec_idecode__rd__var;
    reg coproc_controls__dec_idecode__rd_written__var;
    reg coproc_controls__dec_idecode__csr_access__access_cancelled__var;
    reg [2:0]coproc_controls__dec_idecode__csr_access__access__var;
    reg [11:0]coproc_controls__dec_idecode__csr_access__address__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__write_data__var;
    reg [31:0]coproc_controls__dec_idecode__immediate__var;
    reg [4:0]coproc_controls__dec_idecode__immediate_shift__var;
    reg coproc_controls__dec_idecode__immediate_valid__var;
    reg [3:0]coproc_controls__dec_idecode__op__var;
    reg [3:0]coproc_controls__dec_idecode__subop__var;
    reg [6:0]coproc_controls__dec_idecode__funct7__var;
    reg [2:0]coproc_controls__dec_idecode__minimum_mode__var;
    reg coproc_controls__dec_idecode__illegal__var;
    reg coproc_controls__dec_idecode__illegal_pc__var;
    reg coproc_controls__dec_idecode__is_compressed__var;
    reg coproc_controls__dec_idecode__ext__dummy__var;
    reg coproc_controls__dec_idecode_valid__var;
    reg coproc_controls__dec_to_alu_blocked__var;
    reg [31:0]coproc_controls__alu_rs1__var;
    reg [31:0]coproc_controls__alu_rs2__var;
    reg coproc_controls__alu_flush_pipeline__var;
    reg coproc_controls__alu_cannot_start__var;
    reg coproc_controls__alu_cannot_complete__var;
        coproc_response_cfg__cannot_start__var = coproc_response__cannot_start;
        coproc_response_cfg__result__var = coproc_response__result;
        coproc_response_cfg__result_valid__var = coproc_response__result_valid;
        coproc_response_cfg__cannot_complete__var = coproc_response__cannot_complete;
        if (((1'h0!=64'h0)||(riscv_config__coproc_disable!=1'h0)))
        begin
            coproc_response_cfg__cannot_start__var = 1'h0;
            coproc_response_cfg__result__var = 32'h0;
            coproc_response_cfg__result_valid__var = 1'h0;
            coproc_response_cfg__cannot_complete__var = 1'h0;
        end //if
        coproc_controls__dec_idecode__rs1__var = pipeline_response__decode__idecode__rs1;
        coproc_controls__dec_idecode__rs1_valid__var = pipeline_response__decode__idecode__rs1_valid;
        coproc_controls__dec_idecode__rs2__var = pipeline_response__decode__idecode__rs2;
        coproc_controls__dec_idecode__rs2_valid__var = pipeline_response__decode__idecode__rs2_valid;
        coproc_controls__dec_idecode__rd__var = pipeline_response__decode__idecode__rd;
        coproc_controls__dec_idecode__rd_written__var = pipeline_response__decode__idecode__rd_written;
        coproc_controls__dec_idecode__csr_access__access_cancelled__var = pipeline_response__decode__idecode__csr_access__access_cancelled;
        coproc_controls__dec_idecode__csr_access__access__var = pipeline_response__decode__idecode__csr_access__access;
        coproc_controls__dec_idecode__csr_access__address__var = pipeline_response__decode__idecode__csr_access__address;
        coproc_controls__dec_idecode__csr_access__write_data__var = pipeline_response__decode__idecode__csr_access__write_data;
        coproc_controls__dec_idecode__immediate__var = pipeline_response__decode__idecode__immediate;
        coproc_controls__dec_idecode__immediate_shift__var = pipeline_response__decode__idecode__immediate_shift;
        coproc_controls__dec_idecode__immediate_valid__var = pipeline_response__decode__idecode__immediate_valid;
        coproc_controls__dec_idecode__op__var = pipeline_response__decode__idecode__op;
        coproc_controls__dec_idecode__subop__var = pipeline_response__decode__idecode__subop;
        coproc_controls__dec_idecode__funct7__var = pipeline_response__decode__idecode__funct7;
        coproc_controls__dec_idecode__minimum_mode__var = pipeline_response__decode__idecode__minimum_mode;
        coproc_controls__dec_idecode__illegal__var = pipeline_response__decode__idecode__illegal;
        coproc_controls__dec_idecode__illegal_pc__var = pipeline_response__decode__idecode__illegal_pc;
        coproc_controls__dec_idecode__is_compressed__var = pipeline_response__decode__idecode__is_compressed;
        coproc_controls__dec_idecode__ext__dummy__var = pipeline_response__decode__idecode__ext__dummy;
        coproc_controls__dec_idecode_valid__var = ((pipeline_response__decode__valid!=1'h0)&&!(pipeline_control__interrupt_req!=1'h0));
        coproc_controls__dec_to_alu_blocked__var = ((pipeline_response__exec__cannot_complete!=1'h0)||(coproc_response_cfg__cannot_complete__var!=1'h0));
        coproc_controls__alu_rs1__var = pipeline_response__exec__rs1;
        coproc_controls__alu_rs2__var = pipeline_response__exec__rs2;
        coproc_controls__alu_flush_pipeline__var = pipeline_fetch_data__dec_flush_pipeline;
        coproc_controls__alu_cannot_start__var = ((pipeline_response__exec__cannot_start!=1'h0)||(coproc_response_cfg__cannot_start__var!=1'h0));
        coproc_controls__alu_cannot_complete__var = ((pipeline_response__exec__cannot_complete!=1'h0)||(coproc_response_cfg__cannot_complete__var!=1'h0));
        if (((1'h0!=64'h0)||(riscv_config__coproc_disable!=1'h0)))
        begin
            coproc_controls__dec_idecode_valid__var = 1'h0;
            coproc_controls__dec_idecode__rs1__var = 5'h0;
            coproc_controls__dec_idecode__rs1_valid__var = 1'h0;
            coproc_controls__dec_idecode__rs2__var = 5'h0;
            coproc_controls__dec_idecode__rs2_valid__var = 1'h0;
            coproc_controls__dec_idecode__rd__var = 5'h0;
            coproc_controls__dec_idecode__rd_written__var = 1'h0;
            coproc_controls__dec_idecode__csr_access__access_cancelled__var = 1'h0;
            coproc_controls__dec_idecode__csr_access__access__var = 3'h0;
            coproc_controls__dec_idecode__csr_access__address__var = 12'h0;
            coproc_controls__dec_idecode__csr_access__write_data__var = 32'h0;
            coproc_controls__dec_idecode__immediate__var = 32'h0;
            coproc_controls__dec_idecode__immediate_shift__var = 5'h0;
            coproc_controls__dec_idecode__immediate_valid__var = 1'h0;
            coproc_controls__dec_idecode__op__var = 4'h0;
            coproc_controls__dec_idecode__subop__var = 4'h0;
            coproc_controls__dec_idecode__funct7__var = 7'h0;
            coproc_controls__dec_idecode__minimum_mode__var = 3'h0;
            coproc_controls__dec_idecode__illegal__var = 1'h0;
            coproc_controls__dec_idecode__illegal_pc__var = 1'h0;
            coproc_controls__dec_idecode__is_compressed__var = 1'h0;
            coproc_controls__dec_idecode__ext__dummy__var = 1'h0;
            coproc_controls__dec_to_alu_blocked__var = 1'h0;
            coproc_controls__alu_rs1__var = 32'h0;
            coproc_controls__alu_rs2__var = 32'h0;
            coproc_controls__alu_flush_pipeline__var = 1'h0;
            coproc_controls__alu_cannot_start__var = 1'h0;
            coproc_controls__alu_cannot_complete__var = 1'h0;
        end //if
        coproc_response_cfg__cannot_start = coproc_response_cfg__cannot_start__var;
        coproc_response_cfg__result = coproc_response_cfg__result__var;
        coproc_response_cfg__result_valid = coproc_response_cfg__result_valid__var;
        coproc_response_cfg__cannot_complete = coproc_response_cfg__cannot_complete__var;
        coproc_controls__dec_idecode__rs1 = coproc_controls__dec_idecode__rs1__var;
        coproc_controls__dec_idecode__rs1_valid = coproc_controls__dec_idecode__rs1_valid__var;
        coproc_controls__dec_idecode__rs2 = coproc_controls__dec_idecode__rs2__var;
        coproc_controls__dec_idecode__rs2_valid = coproc_controls__dec_idecode__rs2_valid__var;
        coproc_controls__dec_idecode__rd = coproc_controls__dec_idecode__rd__var;
        coproc_controls__dec_idecode__rd_written = coproc_controls__dec_idecode__rd_written__var;
        coproc_controls__dec_idecode__csr_access__access_cancelled = coproc_controls__dec_idecode__csr_access__access_cancelled__var;
        coproc_controls__dec_idecode__csr_access__access = coproc_controls__dec_idecode__csr_access__access__var;
        coproc_controls__dec_idecode__csr_access__address = coproc_controls__dec_idecode__csr_access__address__var;
        coproc_controls__dec_idecode__csr_access__write_data = coproc_controls__dec_idecode__csr_access__write_data__var;
        coproc_controls__dec_idecode__immediate = coproc_controls__dec_idecode__immediate__var;
        coproc_controls__dec_idecode__immediate_shift = coproc_controls__dec_idecode__immediate_shift__var;
        coproc_controls__dec_idecode__immediate_valid = coproc_controls__dec_idecode__immediate_valid__var;
        coproc_controls__dec_idecode__op = coproc_controls__dec_idecode__op__var;
        coproc_controls__dec_idecode__subop = coproc_controls__dec_idecode__subop__var;
        coproc_controls__dec_idecode__funct7 = coproc_controls__dec_idecode__funct7__var;
        coproc_controls__dec_idecode__minimum_mode = coproc_controls__dec_idecode__minimum_mode__var;
        coproc_controls__dec_idecode__illegal = coproc_controls__dec_idecode__illegal__var;
        coproc_controls__dec_idecode__illegal_pc = coproc_controls__dec_idecode__illegal_pc__var;
        coproc_controls__dec_idecode__is_compressed = coproc_controls__dec_idecode__is_compressed__var;
        coproc_controls__dec_idecode__ext__dummy = coproc_controls__dec_idecode__ext__dummy__var;
        coproc_controls__dec_idecode_valid = coproc_controls__dec_idecode_valid__var;
        coproc_controls__dec_to_alu_blocked = coproc_controls__dec_to_alu_blocked__var;
        coproc_controls__alu_rs1 = coproc_controls__alu_rs1__var;
        coproc_controls__alu_rs2 = coproc_controls__alu_rs2__var;
        coproc_controls__alu_flush_pipeline = coproc_controls__alu_flush_pipeline__var;
        coproc_controls__alu_cannot_start = coproc_controls__alu_cannot_start__var;
        coproc_controls__alu_cannot_complete = coproc_controls__alu_cannot_complete__var;
    end //always

    //b trace combinatorial process
        //   
        //       Map the pipeline output to the trace
        //       
    always @ ( * )//trace
    begin: trace__comb_code
    reg trace__instr_valid__var;
    reg [2:0]trace__mode__var;
    reg [31:0]trace__instr_pc__var;
    reg [31:0]trace__instruction__var;
    reg trace__branch_taken__var;
    reg [31:0]trace__branch_target__var;
    reg trace__trap__var;
    reg trace__ret__var;
    reg trace__jalr__var;
    reg trace__rfw_retire__var;
    reg trace__rfw_data_valid__var;
    reg [4:0]trace__rfw_rd__var;
    reg [31:0]trace__rfw_data__var;
    reg trace__bkpt_valid__var;
    reg [3:0]trace__bkpt_reason__var;
        trace__instr_valid__var = 1'h0;
        trace__mode__var = 3'h0;
        trace__instr_pc__var = 32'h0;
        trace__instruction__var = 32'h0;
        trace__branch_taken__var = 1'h0;
        trace__branch_target__var = 32'h0;
        trace__trap__var = 1'h0;
        trace__ret__var = 1'h0;
        trace__jalr__var = 1'h0;
        trace__rfw_retire__var = 1'h0;
        trace__rfw_data_valid__var = 1'h0;
        trace__rfw_rd__var = 5'h0;
        trace__rfw_data__var = 32'h0;
        trace__bkpt_valid__var = 1'h0;
        trace__bkpt_reason__var = 4'h0;
        trace__instr_valid__var = (((pipeline_response__exec__valid!=1'h0)&&!(pipeline_response__exec__cannot_complete!=1'h0))&&!(coproc_response_cfg__cannot_complete!=1'h0));
        trace__instr_pc__var = pipeline_response__exec__pc;
        trace__mode__var = pipeline_control__mode;
        trace__instruction__var = pipeline_response__exec__instruction__data;
        trace__rfw_retire__var = pipeline_response__rfw__valid;
        trace__rfw_data_valid__var = pipeline_response__rfw__rd_written;
        trace__rfw_rd__var = pipeline_response__rfw__rd;
        trace__rfw_data__var = pipeline_response__rfw__data;
        trace__branch_taken__var = pipeline_response__exec__branch_taken;
        trace__trap__var = pipeline_response__exec__trap__valid;
        trace__ret__var = pipeline_response__exec__trap__ret;
        trace__jalr__var = pipeline_response__exec__jalr;
        trace__branch_target__var = pipeline_fetch_data__pc;
        trace__bkpt_valid__var = 1'h0;
        trace__bkpt_reason__var = 4'h0;
        trace__instr_valid = trace__instr_valid__var;
        trace__mode = trace__mode__var;
        trace__instr_pc = trace__instr_pc__var;
        trace__instruction = trace__instruction__var;
        trace__branch_taken = trace__branch_taken__var;
        trace__branch_target = trace__branch_target__var;
        trace__trap = trace__trap__var;
        trace__ret = trace__ret__var;
        trace__jalr = trace__jalr__var;
        trace__rfw_retire = trace__rfw_retire__var;
        trace__rfw_data_valid = trace__rfw_data_valid__var;
        trace__rfw_rd = trace__rfw_rd__var;
        trace__rfw_data = trace__rfw_data__var;
        trace__bkpt_valid = trace__bkpt_valid__var;
        trace__bkpt_reason = trace__bkpt_reason__var;
    end //always

endmodule // riscv_i32_pipeline_control_csr_trace
