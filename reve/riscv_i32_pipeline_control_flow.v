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

//a Module riscv_i32_pipeline_control_flow
    //   
    //   
    //   
module riscv_i32_pipeline_control_flow
(

    riscv_config__i32c,
    riscv_config__e32,
    riscv_config__i32m,
    riscv_config__i32m_fuse,
    riscv_config__debug_enable,
    riscv_config__coproc_disable,
    riscv_config__unaligned_mem,
    riscv_config__mem_abort_late,
    dmem_access_resp__ack_if_seq,
    dmem_access_resp__ack,
    dmem_access_resp__abort_req,
    dmem_access_resp__may_still_abort,
    dmem_access_resp__access_complete,
    dmem_access_resp__read_data,
    coproc_response__cannot_start,
    coproc_response__result,
    coproc_response__result_valid,
    coproc_response__cannot_complete,
    pipeline_trap_request__valid_from_mem,
    pipeline_trap_request__valid_from_int,
    pipeline_trap_request__valid_from_exec,
    pipeline_trap_request__flushes_exec,
    pipeline_trap_request__to_mode,
    pipeline_trap_request__cause,
    pipeline_trap_request__pc,
    pipeline_trap_request__value,
    pipeline_trap_request__ret,
    pipeline_trap_request__ebreak_to_dbg,
    pipeline_response__decode__valid,
    pipeline_response__decode__pc,
    pipeline_response__decode__branch_target,
    pipeline_response__decode__idecode__rs1,
    pipeline_response__decode__idecode__rs1_valid,
    pipeline_response__decode__idecode__rs2,
    pipeline_response__decode__idecode__rs2_valid,
    pipeline_response__decode__idecode__rd,
    pipeline_response__decode__idecode__rd_written,
    pipeline_response__decode__idecode__csr_access__mode,
    pipeline_response__decode__idecode__csr_access__access_cancelled,
    pipeline_response__decode__idecode__csr_access__access,
    pipeline_response__decode__idecode__csr_access__custom__mhartid,
    pipeline_response__decode__idecode__csr_access__custom__misa,
    pipeline_response__decode__idecode__csr_access__custom__mvendorid,
    pipeline_response__decode__idecode__csr_access__custom__marchid,
    pipeline_response__decode__idecode__csr_access__custom__mimpid,
    pipeline_response__decode__idecode__csr_access__address,
    pipeline_response__decode__idecode__csr_access__select,
    pipeline_response__decode__idecode__csr_access__write_data,
    pipeline_response__decode__idecode__immediate,
    pipeline_response__decode__idecode__immediate_shift,
    pipeline_response__decode__idecode__immediate_valid,
    pipeline_response__decode__idecode__op,
    pipeline_response__decode__idecode__subop,
    pipeline_response__decode__idecode__shift_op,
    pipeline_response__decode__idecode__funct7,
    pipeline_response__decode__idecode__illegal,
    pipeline_response__decode__idecode__is_compressed,
    pipeline_response__decode__idecode__ext__dummy,
    pipeline_response__decode__enable_branch_prediction,
    pipeline_response__exec__valid,
    pipeline_response__exec__cannot_start,
    pipeline_response__exec__first_cycle,
    pipeline_response__exec__last_cycle,
    pipeline_response__exec__interrupt_block,
    pipeline_response__exec__instruction__mode,
    pipeline_response__exec__instruction__data,
    pipeline_response__exec__instruction__debug__valid,
    pipeline_response__exec__instruction__debug__debug_op,
    pipeline_response__exec__instruction__debug__data,
    pipeline_response__exec__idecode__rs1,
    pipeline_response__exec__idecode__rs1_valid,
    pipeline_response__exec__idecode__rs2,
    pipeline_response__exec__idecode__rs2_valid,
    pipeline_response__exec__idecode__rd,
    pipeline_response__exec__idecode__rd_written,
    pipeline_response__exec__idecode__csr_access__mode,
    pipeline_response__exec__idecode__csr_access__access_cancelled,
    pipeline_response__exec__idecode__csr_access__access,
    pipeline_response__exec__idecode__csr_access__custom__mhartid,
    pipeline_response__exec__idecode__csr_access__custom__misa,
    pipeline_response__exec__idecode__csr_access__custom__mvendorid,
    pipeline_response__exec__idecode__csr_access__custom__marchid,
    pipeline_response__exec__idecode__csr_access__custom__mimpid,
    pipeline_response__exec__idecode__csr_access__address,
    pipeline_response__exec__idecode__csr_access__select,
    pipeline_response__exec__idecode__csr_access__write_data,
    pipeline_response__exec__idecode__immediate,
    pipeline_response__exec__idecode__immediate_shift,
    pipeline_response__exec__idecode__immediate_valid,
    pipeline_response__exec__idecode__op,
    pipeline_response__exec__idecode__subop,
    pipeline_response__exec__idecode__shift_op,
    pipeline_response__exec__idecode__funct7,
    pipeline_response__exec__idecode__illegal,
    pipeline_response__exec__idecode__is_compressed,
    pipeline_response__exec__idecode__ext__dummy,
    pipeline_response__exec__rs1,
    pipeline_response__exec__rs2,
    pipeline_response__exec__pc,
    pipeline_response__exec__predicted_branch,
    pipeline_response__exec__pc_if_mispredicted,
    pipeline_response__exec__branch_condition_met,
    pipeline_response__exec__dmem_access_req__valid,
    pipeline_response__exec__dmem_access_req__mode,
    pipeline_response__exec__dmem_access_req__req_type,
    pipeline_response__exec__dmem_access_req__address,
    pipeline_response__exec__dmem_access_req__sequential,
    pipeline_response__exec__dmem_access_req__byte_enable,
    pipeline_response__exec__dmem_access_req__write_data,
    pipeline_response__exec__csr_access__mode,
    pipeline_response__exec__csr_access__access_cancelled,
    pipeline_response__exec__csr_access__access,
    pipeline_response__exec__csr_access__custom__mhartid,
    pipeline_response__exec__csr_access__custom__misa,
    pipeline_response__exec__csr_access__custom__mvendorid,
    pipeline_response__exec__csr_access__custom__marchid,
    pipeline_response__exec__csr_access__custom__mimpid,
    pipeline_response__exec__csr_access__address,
    pipeline_response__exec__csr_access__select,
    pipeline_response__exec__csr_access__write_data,
    pipeline_response__mem__valid,
    pipeline_response__mem__access_in_progress,
    pipeline_response__mem__pc,
    pipeline_response__mem__addr,
    pipeline_response__rfw__valid,
    pipeline_response__rfw__rd_written,
    pipeline_response__rfw__rd,
    pipeline_response__rfw__data,
    pipeline_response__pipeline_empty,
    ifetch_req__flush_pipeline,
    ifetch_req__req_type,
    ifetch_req__address,
    ifetch_req__mode,
    pipeline_state__fetch_action,
    pipeline_state__fetch_pc,
    pipeline_state__mode,
    pipeline_state__error,
    pipeline_state__tag,
    pipeline_state__halt,
    pipeline_state__ebreak_to_dbg,
    pipeline_state__interrupt_req,
    pipeline_state__interrupt_number,
    pipeline_state__interrupt_to_mode,
    pipeline_state__instruction_data,
    pipeline_state__instruction_debug__valid,
    pipeline_state__instruction_debug__debug_op,
    pipeline_state__instruction_debug__data,

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
    csr_controls__trap__ebreak_to_dbg,
    coproc_controls__dec_idecode_valid,
    coproc_controls__dec_idecode__rs1,
    coproc_controls__dec_idecode__rs1_valid,
    coproc_controls__dec_idecode__rs2,
    coproc_controls__dec_idecode__rs2_valid,
    coproc_controls__dec_idecode__rd,
    coproc_controls__dec_idecode__rd_written,
    coproc_controls__dec_idecode__csr_access__mode,
    coproc_controls__dec_idecode__csr_access__access_cancelled,
    coproc_controls__dec_idecode__csr_access__access,
    coproc_controls__dec_idecode__csr_access__custom__mhartid,
    coproc_controls__dec_idecode__csr_access__custom__misa,
    coproc_controls__dec_idecode__csr_access__custom__mvendorid,
    coproc_controls__dec_idecode__csr_access__custom__marchid,
    coproc_controls__dec_idecode__csr_access__custom__mimpid,
    coproc_controls__dec_idecode__csr_access__address,
    coproc_controls__dec_idecode__csr_access__select,
    coproc_controls__dec_idecode__csr_access__write_data,
    coproc_controls__dec_idecode__immediate,
    coproc_controls__dec_idecode__immediate_shift,
    coproc_controls__dec_idecode__immediate_valid,
    coproc_controls__dec_idecode__op,
    coproc_controls__dec_idecode__subop,
    coproc_controls__dec_idecode__shift_op,
    coproc_controls__dec_idecode__funct7,
    coproc_controls__dec_idecode__illegal,
    coproc_controls__dec_idecode__is_compressed,
    coproc_controls__dec_idecode__ext__dummy,
    coproc_controls__dec_to_alu_blocked,
    coproc_controls__alu_rs1,
    coproc_controls__alu_rs2,
    coproc_controls__alu_flush_pipeline,
    coproc_controls__alu_cannot_start,
    coproc_controls__alu_data_not_ready,
    coproc_controls__alu_cannot_complete,
    pipeline_coproc_response__cannot_start,
    pipeline_coproc_response__result,
    pipeline_coproc_response__result_valid,
    pipeline_coproc_response__cannot_complete,
    csr_access__mode,
    csr_access__access_cancelled,
    csr_access__access,
    csr_access__custom__mhartid,
    csr_access__custom__misa,
    csr_access__custom__mvendorid,
    csr_access__custom__marchid,
    csr_access__custom__mimpid,
    csr_access__address,
    csr_access__select,
    csr_access__write_data,
    dmem_access_req__valid,
    dmem_access_req__mode,
    dmem_access_req__req_type,
    dmem_access_req__address,
    dmem_access_req__sequential,
    dmem_access_req__byte_enable,
    dmem_access_req__write_data,
    pipeline_control__trap__valid,
    pipeline_control__trap__to_mode,
    pipeline_control__trap__cause,
    pipeline_control__trap__pc,
    pipeline_control__trap__value,
    pipeline_control__trap__ret,
    pipeline_control__trap__ebreak_to_dbg,
    pipeline_control__flush__fetch,
    pipeline_control__flush__decode,
    pipeline_control__flush__exec,
    pipeline_control__flush__mem,
    pipeline_control__decode__completing,
    pipeline_control__decode__blocked,
    pipeline_control__decode__cannot_complete,
    pipeline_control__exec__completing_cycle,
    pipeline_control__exec__completing,
    pipeline_control__exec__blocked_start,
    pipeline_control__exec__blocked,
    pipeline_control__exec__mispredicted_branch,
    pipeline_control__exec__pc_if_mispredicted,
    pipeline_control__mem__blocked
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
    input dmem_access_resp__ack_if_seq;
    input dmem_access_resp__ack;
    input dmem_access_resp__abort_req;
    input dmem_access_resp__may_still_abort;
    input dmem_access_resp__access_complete;
    input [31:0]dmem_access_resp__read_data;
    input coproc_response__cannot_start;
    input [31:0]coproc_response__result;
    input coproc_response__result_valid;
    input coproc_response__cannot_complete;
    input pipeline_trap_request__valid_from_mem;
    input pipeline_trap_request__valid_from_int;
    input pipeline_trap_request__valid_from_exec;
    input pipeline_trap_request__flushes_exec;
    input [2:0]pipeline_trap_request__to_mode;
    input [4:0]pipeline_trap_request__cause;
    input [31:0]pipeline_trap_request__pc;
    input [31:0]pipeline_trap_request__value;
    input pipeline_trap_request__ret;
    input pipeline_trap_request__ebreak_to_dbg;
    input pipeline_response__decode__valid;
    input [31:0]pipeline_response__decode__pc;
    input [31:0]pipeline_response__decode__branch_target;
    input [4:0]pipeline_response__decode__idecode__rs1;
    input pipeline_response__decode__idecode__rs1_valid;
    input [4:0]pipeline_response__decode__idecode__rs2;
    input pipeline_response__decode__idecode__rs2_valid;
    input [4:0]pipeline_response__decode__idecode__rd;
    input pipeline_response__decode__idecode__rd_written;
    input [2:0]pipeline_response__decode__idecode__csr_access__mode;
    input pipeline_response__decode__idecode__csr_access__access_cancelled;
    input [2:0]pipeline_response__decode__idecode__csr_access__access;
    input [31:0]pipeline_response__decode__idecode__csr_access__custom__mhartid;
    input [31:0]pipeline_response__decode__idecode__csr_access__custom__misa;
    input [31:0]pipeline_response__decode__idecode__csr_access__custom__mvendorid;
    input [31:0]pipeline_response__decode__idecode__csr_access__custom__marchid;
    input [31:0]pipeline_response__decode__idecode__csr_access__custom__mimpid;
    input [11:0]pipeline_response__decode__idecode__csr_access__address;
    input [11:0]pipeline_response__decode__idecode__csr_access__select;
    input [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    input [31:0]pipeline_response__decode__idecode__immediate;
    input [4:0]pipeline_response__decode__idecode__immediate_shift;
    input pipeline_response__decode__idecode__immediate_valid;
    input [3:0]pipeline_response__decode__idecode__op;
    input [3:0]pipeline_response__decode__idecode__subop;
    input [3:0]pipeline_response__decode__idecode__shift_op;
    input [6:0]pipeline_response__decode__idecode__funct7;
    input pipeline_response__decode__idecode__illegal;
    input pipeline_response__decode__idecode__is_compressed;
    input pipeline_response__decode__idecode__ext__dummy;
    input pipeline_response__decode__enable_branch_prediction;
    input pipeline_response__exec__valid;
    input pipeline_response__exec__cannot_start;
    input pipeline_response__exec__first_cycle;
    input pipeline_response__exec__last_cycle;
    input pipeline_response__exec__interrupt_block;
    input [2:0]pipeline_response__exec__instruction__mode;
    input [31:0]pipeline_response__exec__instruction__data;
    input pipeline_response__exec__instruction__debug__valid;
    input [1:0]pipeline_response__exec__instruction__debug__debug_op;
    input [15:0]pipeline_response__exec__instruction__debug__data;
    input [4:0]pipeline_response__exec__idecode__rs1;
    input pipeline_response__exec__idecode__rs1_valid;
    input [4:0]pipeline_response__exec__idecode__rs2;
    input pipeline_response__exec__idecode__rs2_valid;
    input [4:0]pipeline_response__exec__idecode__rd;
    input pipeline_response__exec__idecode__rd_written;
    input [2:0]pipeline_response__exec__idecode__csr_access__mode;
    input pipeline_response__exec__idecode__csr_access__access_cancelled;
    input [2:0]pipeline_response__exec__idecode__csr_access__access;
    input [31:0]pipeline_response__exec__idecode__csr_access__custom__mhartid;
    input [31:0]pipeline_response__exec__idecode__csr_access__custom__misa;
    input [31:0]pipeline_response__exec__idecode__csr_access__custom__mvendorid;
    input [31:0]pipeline_response__exec__idecode__csr_access__custom__marchid;
    input [31:0]pipeline_response__exec__idecode__csr_access__custom__mimpid;
    input [11:0]pipeline_response__exec__idecode__csr_access__address;
    input [11:0]pipeline_response__exec__idecode__csr_access__select;
    input [31:0]pipeline_response__exec__idecode__csr_access__write_data;
    input [31:0]pipeline_response__exec__idecode__immediate;
    input [4:0]pipeline_response__exec__idecode__immediate_shift;
    input pipeline_response__exec__idecode__immediate_valid;
    input [3:0]pipeline_response__exec__idecode__op;
    input [3:0]pipeline_response__exec__idecode__subop;
    input [3:0]pipeline_response__exec__idecode__shift_op;
    input [6:0]pipeline_response__exec__idecode__funct7;
    input pipeline_response__exec__idecode__illegal;
    input pipeline_response__exec__idecode__is_compressed;
    input pipeline_response__exec__idecode__ext__dummy;
    input [31:0]pipeline_response__exec__rs1;
    input [31:0]pipeline_response__exec__rs2;
    input [31:0]pipeline_response__exec__pc;
    input pipeline_response__exec__predicted_branch;
    input [31:0]pipeline_response__exec__pc_if_mispredicted;
    input pipeline_response__exec__branch_condition_met;
    input pipeline_response__exec__dmem_access_req__valid;
    input [2:0]pipeline_response__exec__dmem_access_req__mode;
    input [4:0]pipeline_response__exec__dmem_access_req__req_type;
    input [31:0]pipeline_response__exec__dmem_access_req__address;
    input pipeline_response__exec__dmem_access_req__sequential;
    input [3:0]pipeline_response__exec__dmem_access_req__byte_enable;
    input [31:0]pipeline_response__exec__dmem_access_req__write_data;
    input [2:0]pipeline_response__exec__csr_access__mode;
    input pipeline_response__exec__csr_access__access_cancelled;
    input [2:0]pipeline_response__exec__csr_access__access;
    input [31:0]pipeline_response__exec__csr_access__custom__mhartid;
    input [31:0]pipeline_response__exec__csr_access__custom__misa;
    input [31:0]pipeline_response__exec__csr_access__custom__mvendorid;
    input [31:0]pipeline_response__exec__csr_access__custom__marchid;
    input [31:0]pipeline_response__exec__csr_access__custom__mimpid;
    input [11:0]pipeline_response__exec__csr_access__address;
    input [11:0]pipeline_response__exec__csr_access__select;
    input [31:0]pipeline_response__exec__csr_access__write_data;
    input pipeline_response__mem__valid;
    input pipeline_response__mem__access_in_progress;
    input [31:0]pipeline_response__mem__pc;
    input [31:0]pipeline_response__mem__addr;
    input pipeline_response__rfw__valid;
    input pipeline_response__rfw__rd_written;
    input [4:0]pipeline_response__rfw__rd;
    input [31:0]pipeline_response__rfw__data;
    input pipeline_response__pipeline_empty;
    input ifetch_req__flush_pipeline;
    input [2:0]ifetch_req__req_type;
    input [31:0]ifetch_req__address;
    input [2:0]ifetch_req__mode;
    input [2:0]pipeline_state__fetch_action;
    input [31:0]pipeline_state__fetch_pc;
    input [2:0]pipeline_state__mode;
    input pipeline_state__error;
    input [1:0]pipeline_state__tag;
    input pipeline_state__halt;
    input pipeline_state__ebreak_to_dbg;
    input pipeline_state__interrupt_req;
    input [3:0]pipeline_state__interrupt_number;
    input [2:0]pipeline_state__interrupt_to_mode;
    input [31:0]pipeline_state__instruction_data;
    input pipeline_state__instruction_debug__valid;
    input [1:0]pipeline_state__instruction_debug__debug_op;
    input [15:0]pipeline_state__instruction_debug__data;

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
    output [4:0]csr_controls__trap__cause;
    output [31:0]csr_controls__trap__pc;
    output [31:0]csr_controls__trap__value;
    output csr_controls__trap__ret;
    output csr_controls__trap__ebreak_to_dbg;
    output coproc_controls__dec_idecode_valid;
    output [4:0]coproc_controls__dec_idecode__rs1;
    output coproc_controls__dec_idecode__rs1_valid;
    output [4:0]coproc_controls__dec_idecode__rs2;
    output coproc_controls__dec_idecode__rs2_valid;
    output [4:0]coproc_controls__dec_idecode__rd;
    output coproc_controls__dec_idecode__rd_written;
    output [2:0]coproc_controls__dec_idecode__csr_access__mode;
    output coproc_controls__dec_idecode__csr_access__access_cancelled;
    output [2:0]coproc_controls__dec_idecode__csr_access__access;
    output [31:0]coproc_controls__dec_idecode__csr_access__custom__mhartid;
    output [31:0]coproc_controls__dec_idecode__csr_access__custom__misa;
    output [31:0]coproc_controls__dec_idecode__csr_access__custom__mvendorid;
    output [31:0]coproc_controls__dec_idecode__csr_access__custom__marchid;
    output [31:0]coproc_controls__dec_idecode__csr_access__custom__mimpid;
    output [11:0]coproc_controls__dec_idecode__csr_access__address;
    output [11:0]coproc_controls__dec_idecode__csr_access__select;
    output [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    output [31:0]coproc_controls__dec_idecode__immediate;
    output [4:0]coproc_controls__dec_idecode__immediate_shift;
    output coproc_controls__dec_idecode__immediate_valid;
    output [3:0]coproc_controls__dec_idecode__op;
    output [3:0]coproc_controls__dec_idecode__subop;
    output [3:0]coproc_controls__dec_idecode__shift_op;
    output [6:0]coproc_controls__dec_idecode__funct7;
    output coproc_controls__dec_idecode__illegal;
    output coproc_controls__dec_idecode__is_compressed;
    output coproc_controls__dec_idecode__ext__dummy;
    output coproc_controls__dec_to_alu_blocked;
    output [31:0]coproc_controls__alu_rs1;
    output [31:0]coproc_controls__alu_rs2;
    output coproc_controls__alu_flush_pipeline;
    output coproc_controls__alu_cannot_start;
    output coproc_controls__alu_data_not_ready;
    output coproc_controls__alu_cannot_complete;
    output pipeline_coproc_response__cannot_start;
    output [31:0]pipeline_coproc_response__result;
    output pipeline_coproc_response__result_valid;
    output pipeline_coproc_response__cannot_complete;
    output [2:0]csr_access__mode;
    output csr_access__access_cancelled;
    output [2:0]csr_access__access;
    output [31:0]csr_access__custom__mhartid;
    output [31:0]csr_access__custom__misa;
    output [31:0]csr_access__custom__mvendorid;
    output [31:0]csr_access__custom__marchid;
    output [31:0]csr_access__custom__mimpid;
    output [11:0]csr_access__address;
    output [11:0]csr_access__select;
    output [31:0]csr_access__write_data;
    output dmem_access_req__valid;
    output [2:0]dmem_access_req__mode;
    output [4:0]dmem_access_req__req_type;
    output [31:0]dmem_access_req__address;
    output dmem_access_req__sequential;
    output [3:0]dmem_access_req__byte_enable;
    output [31:0]dmem_access_req__write_data;
    output pipeline_control__trap__valid;
    output [2:0]pipeline_control__trap__to_mode;
    output [4:0]pipeline_control__trap__cause;
    output [31:0]pipeline_control__trap__pc;
    output [31:0]pipeline_control__trap__value;
    output pipeline_control__trap__ret;
    output pipeline_control__trap__ebreak_to_dbg;
    output pipeline_control__flush__fetch;
    output pipeline_control__flush__decode;
    output pipeline_control__flush__exec;
    output pipeline_control__flush__mem;
    output pipeline_control__decode__completing;
    output pipeline_control__decode__blocked;
    output pipeline_control__decode__cannot_complete;
    output pipeline_control__exec__completing_cycle;
    output pipeline_control__exec__completing;
    output pipeline_control__exec__blocked_start;
    output pipeline_control__exec__blocked;
    output pipeline_control__exec__mispredicted_branch;
    output [31:0]pipeline_control__exec__pc_if_mispredicted;
    output pipeline_control__mem__blocked;

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
    reg [4:0]csr_controls__trap__cause;
    reg [31:0]csr_controls__trap__pc;
    reg [31:0]csr_controls__trap__value;
    reg csr_controls__trap__ret;
    reg csr_controls__trap__ebreak_to_dbg;
    reg coproc_controls__dec_idecode_valid;
    reg [4:0]coproc_controls__dec_idecode__rs1;
    reg coproc_controls__dec_idecode__rs1_valid;
    reg [4:0]coproc_controls__dec_idecode__rs2;
    reg coproc_controls__dec_idecode__rs2_valid;
    reg [4:0]coproc_controls__dec_idecode__rd;
    reg coproc_controls__dec_idecode__rd_written;
    reg [2:0]coproc_controls__dec_idecode__csr_access__mode;
    reg coproc_controls__dec_idecode__csr_access__access_cancelled;
    reg [2:0]coproc_controls__dec_idecode__csr_access__access;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__mhartid;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__misa;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__mvendorid;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__marchid;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__mimpid;
    reg [11:0]coproc_controls__dec_idecode__csr_access__address;
    reg [11:0]coproc_controls__dec_idecode__csr_access__select;
    reg [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    reg [31:0]coproc_controls__dec_idecode__immediate;
    reg [4:0]coproc_controls__dec_idecode__immediate_shift;
    reg coproc_controls__dec_idecode__immediate_valid;
    reg [3:0]coproc_controls__dec_idecode__op;
    reg [3:0]coproc_controls__dec_idecode__subop;
    reg [3:0]coproc_controls__dec_idecode__shift_op;
    reg [6:0]coproc_controls__dec_idecode__funct7;
    reg coproc_controls__dec_idecode__illegal;
    reg coproc_controls__dec_idecode__is_compressed;
    reg coproc_controls__dec_idecode__ext__dummy;
    reg coproc_controls__dec_to_alu_blocked;
    reg [31:0]coproc_controls__alu_rs1;
    reg [31:0]coproc_controls__alu_rs2;
    reg coproc_controls__alu_flush_pipeline;
    reg coproc_controls__alu_cannot_start;
    reg coproc_controls__alu_data_not_ready;
    reg coproc_controls__alu_cannot_complete;
    reg pipeline_coproc_response__cannot_start;
    reg [31:0]pipeline_coproc_response__result;
    reg pipeline_coproc_response__result_valid;
    reg pipeline_coproc_response__cannot_complete;
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
    reg dmem_access_req__valid;
    reg [2:0]dmem_access_req__mode;
    reg [4:0]dmem_access_req__req_type;
    reg [31:0]dmem_access_req__address;
    reg dmem_access_req__sequential;
    reg [3:0]dmem_access_req__byte_enable;
    reg [31:0]dmem_access_req__write_data;
    reg pipeline_control__trap__valid;
    reg [2:0]pipeline_control__trap__to_mode;
    reg [4:0]pipeline_control__trap__cause;
    reg [31:0]pipeline_control__trap__pc;
    reg [31:0]pipeline_control__trap__value;
    reg pipeline_control__trap__ret;
    reg pipeline_control__trap__ebreak_to_dbg;
    reg pipeline_control__flush__fetch;
    reg pipeline_control__flush__decode;
    reg pipeline_control__flush__exec;
    reg pipeline_control__flush__mem;
    reg pipeline_control__decode__completing;
    reg pipeline_control__decode__blocked;
    reg pipeline_control__decode__cannot_complete;
    reg pipeline_control__exec__completing_cycle;
    reg pipeline_control__exec__completing;
    reg pipeline_control__exec__blocked_start;
    reg pipeline_control__exec__blocked;
    reg pipeline_control__exec__mispredicted_branch;
    reg [31:0]pipeline_control__exec__pc_if_mispredicted;
    reg pipeline_control__mem__blocked;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg control_flow_combs__branch_taken;
    reg control_flow_combs__jalr;
    reg control_flow_combs__mem_cannot_start;
    reg control_flow_combs__mem_cannot_complete;
    reg control_flow_combs__dmem_blocked;
    reg control_flow_combs__exec_cannot_start;
    reg control_flow_combs__exec_cannot_complete;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b pipeline_blocking combinatorial process
    always @ ( * )//pipeline_blocking
    begin: pipeline_blocking__comb_code
    reg control_flow_combs__mem_cannot_complete__var;
    reg control_flow_combs__mem_cannot_start__var;
    reg control_flow_combs__dmem_blocked__var;
    reg control_flow_combs__exec_cannot_complete__var;
    reg pipeline_control__exec__blocked_start__var;
    reg pipeline_control__exec__completing_cycle__var;
        control_flow_combs__mem_cannot_complete__var = 1'h0;
        control_flow_combs__mem_cannot_start__var = 1'h0;
        if (((pipeline_response__mem__valid!=1'h0)&&(pipeline_response__mem__access_in_progress!=1'h0)))
        begin
            if (!(dmem_access_resp__access_complete!=1'h0))
            begin
                control_flow_combs__mem_cannot_complete__var = 1'h1;
            end //if
            if (!(dmem_access_resp__may_still_abort!=1'h0))
            begin
                control_flow_combs__mem_cannot_start__var = 1'h1;
            end //if
        end //if
        if ((1'h0||!(riscv_config__mem_abort_late!=1'h0)))
        begin
            control_flow_combs__mem_cannot_start__var = 1'h0;
        end //if
        control_flow_combs__dmem_blocked__var = 1'h0;
        if ((pipeline_response__exec__dmem_access_req__valid!=1'h0))
        begin
            control_flow_combs__dmem_blocked__var = 1'h1;
            if ((dmem_access_resp__ack!=1'h0))
            begin
                control_flow_combs__dmem_blocked__var = 1'h0;
            end //if
            else
            
            begin
                if (((pipeline_response__exec__dmem_access_req__sequential!=1'h0)&&(dmem_access_resp__ack_if_seq!=1'h0)))
                begin
                    control_flow_combs__dmem_blocked__var = 1'h0;
                end //if
            end //else
        end //if
        control_flow_combs__exec_cannot_start = ((((control_flow_combs__mem_cannot_start__var!=1'h0)||(pipeline_response__exec__cannot_start!=1'h0))||(control_flow_combs__dmem_blocked__var!=1'h0))||(pipeline_coproc_response__cannot_start!=1'h0));
        control_flow_combs__exec_cannot_complete__var = (((control_flow_combs__mem_cannot_complete__var!=1'h0)||!(pipeline_response__exec__last_cycle!=1'h0))||(pipeline_coproc_response__cannot_complete!=1'h0));
        if ((((pipeline_response__exec__first_cycle!=1'h0)&&(pipeline_response__exec__valid!=1'h0))&&(control_flow_combs__exec_cannot_start!=1'h0)))
        begin
            control_flow_combs__exec_cannot_complete__var = 1'h1;
        end //if
        pipeline_control__mem__blocked = control_flow_combs__mem_cannot_complete__var;
        pipeline_control__exec__blocked_start__var = 1'h0;
        pipeline_control__exec__completing_cycle__var = 1'h1;
        if ((((pipeline_response__exec__first_cycle!=1'h0)&&(pipeline_response__exec__valid!=1'h0))&&(control_flow_combs__exec_cannot_start!=1'h0)))
        begin
            pipeline_control__exec__blocked_start__var = 1'h1;
            pipeline_control__exec__completing_cycle__var = 1'h0;
        end //if
        pipeline_control__exec__completing = ((pipeline_response__exec__valid!=1'h0)&&!(control_flow_combs__exec_cannot_complete__var!=1'h0));
        pipeline_control__exec__blocked = ((pipeline_response__exec__valid!=1'h0)&&(control_flow_combs__exec_cannot_complete__var!=1'h0));
        pipeline_control__decode__cannot_complete = ((pipeline_response__decode__valid!=1'h0)&&(pipeline_control__exec__blocked!=1'h0));
        pipeline_control__decode__completing = ((pipeline_response__decode__valid!=1'h0)&&!(pipeline_control__decode__cannot_complete!=1'h0));
        pipeline_control__decode__blocked = ((pipeline_response__decode__valid!=1'h0)&&(pipeline_control__decode__cannot_complete!=1'h0));
        control_flow_combs__mem_cannot_complete = control_flow_combs__mem_cannot_complete__var;
        control_flow_combs__mem_cannot_start = control_flow_combs__mem_cannot_start__var;
        control_flow_combs__dmem_blocked = control_flow_combs__dmem_blocked__var;
        control_flow_combs__exec_cannot_complete = control_flow_combs__exec_cannot_complete__var;
        pipeline_control__exec__blocked_start = pipeline_control__exec__blocked_start__var;
        pipeline_control__exec__completing_cycle = pipeline_control__exec__completing_cycle__var;
    end //always

    //b control_flow_code combinatorial process
    always @ ( * )//control_flow_code
    begin: control_flow_code__comb_code
    reg control_flow_combs__branch_taken__var;
    reg control_flow_combs__jalr__var;
        control_flow_combs__branch_taken__var = 1'h0;
        control_flow_combs__jalr__var = 1'h0;
        pipeline_control__exec__pc_if_mispredicted = pipeline_response__exec__pc_if_mispredicted;
        case (pipeline_response__exec__idecode__op) //synopsys parallel_case
        4'h0: // req 1
            begin
            control_flow_combs__branch_taken__var = pipeline_response__exec__branch_condition_met;
            end
        4'h1: // req 1
            begin
            control_flow_combs__branch_taken__var = 1'h1;
            end
        4'h2: // req 1
            begin
            control_flow_combs__branch_taken__var = 1'h1;
            control_flow_combs__jalr__var = 1'h1;
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
        if ((!(pipeline_response__exec__valid!=1'h0)||(pipeline_control__exec__blocked!=1'h0)))
        begin
            control_flow_combs__branch_taken__var = 1'h0;
        end //if
        pipeline_control__exec__mispredicted_branch = ((pipeline_control__exec__completing!=1'h0)&&(control_flow_combs__branch_taken__var!=pipeline_response__exec__predicted_branch));
        control_flow_combs__branch_taken = control_flow_combs__branch_taken__var;
        control_flow_combs__jalr = control_flow_combs__jalr__var;
    end //always

    //b code combinatorial process
    always @ ( * )//code
    begin: code__comb_code
    reg dmem_access_req__valid__var;
    reg csr_access__access_cancelled__var;
    reg [2:0]csr_access__access__var;
    reg pipeline_control__flush__decode__var;
    reg pipeline_control__flush__fetch__var;
        dmem_access_req__valid__var = pipeline_response__exec__dmem_access_req__valid;
        dmem_access_req__mode = pipeline_response__exec__dmem_access_req__mode;
        dmem_access_req__req_type = pipeline_response__exec__dmem_access_req__req_type;
        dmem_access_req__address = pipeline_response__exec__dmem_access_req__address;
        dmem_access_req__sequential = pipeline_response__exec__dmem_access_req__sequential;
        dmem_access_req__byte_enable = pipeline_response__exec__dmem_access_req__byte_enable;
        dmem_access_req__write_data = pipeline_response__exec__dmem_access_req__write_data;
        if (!(pipeline_control__exec__completing_cycle!=1'h0))
        begin
            dmem_access_req__valid__var = 1'h0;
        end //if
        csr_access__mode = pipeline_response__exec__csr_access__mode;
        csr_access__access_cancelled__var = pipeline_response__exec__csr_access__access_cancelled;
        csr_access__access__var = pipeline_response__exec__csr_access__access;
        csr_access__custom__mhartid = pipeline_response__exec__csr_access__custom__mhartid;
        csr_access__custom__misa = pipeline_response__exec__csr_access__custom__misa;
        csr_access__custom__mvendorid = pipeline_response__exec__csr_access__custom__mvendorid;
        csr_access__custom__marchid = pipeline_response__exec__csr_access__custom__marchid;
        csr_access__custom__mimpid = pipeline_response__exec__csr_access__custom__mimpid;
        csr_access__address = pipeline_response__exec__csr_access__address;
        csr_access__select = pipeline_response__exec__csr_access__select;
        csr_access__write_data = pipeline_response__exec__csr_access__write_data;
        if ((!(pipeline_response__exec__valid!=1'h0)||(pipeline_response__exec__idecode__illegal!=1'h0)))
        begin
            csr_access__access__var = 3'h0;
        end //if
        pipeline_control__trap__valid = (((pipeline_trap_request__valid_from_int!=1'h0)||(pipeline_trap_request__valid_from_mem!=1'h0))||((pipeline_trap_request__valid_from_exec!=1'h0)&&!(pipeline_control__exec__blocked!=1'h0)));
        pipeline_control__trap__to_mode = pipeline_trap_request__to_mode;
        pipeline_control__trap__cause = pipeline_trap_request__cause;
        pipeline_control__trap__pc = pipeline_trap_request__pc;
        pipeline_control__trap__value = pipeline_trap_request__value;
        pipeline_control__trap__ret = pipeline_trap_request__ret;
        pipeline_control__trap__ebreak_to_dbg = pipeline_trap_request__ebreak_to_dbg;
        pipeline_control__flush__decode__var = ifetch_req__flush_pipeline;
        pipeline_control__flush__fetch__var = 1'h0;
        pipeline_control__flush__exec = ((pipeline_control__trap__valid!=1'h0)&&(pipeline_trap_request__flushes_exec!=1'h0));
        pipeline_control__flush__mem = pipeline_trap_request__valid_from_mem;
        if ((pipeline_control__exec__mispredicted_branch!=1'h0))
        begin
            pipeline_control__flush__fetch__var = 1'h1;
            pipeline_control__flush__decode__var = 1'h1;
        end //if
        if ((pipeline_control__trap__valid!=1'h0))
        begin
            pipeline_control__flush__fetch__var = 1'h1;
            pipeline_control__flush__decode__var = 1'h1;
        end //if
        if ((pipeline_state__instruction_debug__valid!=1'h0))
        begin
            pipeline_control__flush__fetch__var = 1'h0;
        end //if
        csr_access__access_cancelled__var = (pipeline_control__flush__exec | pipeline_control__exec__blocked);
        dmem_access_req__valid = dmem_access_req__valid__var;
        csr_access__access_cancelled = csr_access__access_cancelled__var;
        csr_access__access = csr_access__access__var;
        pipeline_control__flush__decode = pipeline_control__flush__decode__var;
        pipeline_control__flush__fetch = pipeline_control__flush__fetch__var;
    end //always

    //b csr_controls combinatorial process
    always @ ( * )//csr_controls
    begin: csr_controls__comb_code
    reg [2:0]csr_controls__exec_mode__var;
    reg csr_controls__retire__var;
    reg csr_controls__trap__valid__var;
    reg [2:0]csr_controls__trap__to_mode__var;
    reg [4:0]csr_controls__trap__cause__var;
    reg [31:0]csr_controls__trap__pc__var;
    reg [31:0]csr_controls__trap__value__var;
    reg csr_controls__trap__ret__var;
    reg csr_controls__trap__ebreak_to_dbg__var;
        csr_controls__exec_mode__var = 3'h0;
        csr_controls__retire__var = 1'h0;
        csr_controls__timer_value = 64'h0;
        csr_controls__trap__valid__var = 1'h0;
        csr_controls__trap__to_mode__var = 3'h0;
        csr_controls__trap__cause__var = 5'h0;
        csr_controls__trap__pc__var = 32'h0;
        csr_controls__trap__value__var = 32'h0;
        csr_controls__trap__ret__var = 1'h0;
        csr_controls__trap__ebreak_to_dbg__var = 1'h0;
        csr_controls__exec_mode__var = pipeline_state__mode;
        csr_controls__retire__var = (((pipeline_response__exec__valid!=1'h0)&&!(pipeline_control__exec__blocked!=1'h0))&&!(pipeline_control__flush__exec!=1'h0));
        csr_controls__trap__valid__var = pipeline_control__trap__valid;
        csr_controls__trap__to_mode__var = pipeline_control__trap__to_mode;
        csr_controls__trap__cause__var = pipeline_control__trap__cause;
        csr_controls__trap__pc__var = pipeline_control__trap__pc;
        csr_controls__trap__value__var = pipeline_control__trap__value;
        csr_controls__trap__ret__var = pipeline_control__trap__ret;
        csr_controls__trap__ebreak_to_dbg__var = pipeline_control__trap__ebreak_to_dbg;
        csr_controls__exec_mode = csr_controls__exec_mode__var;
        csr_controls__retire = csr_controls__retire__var;
        csr_controls__trap__valid = csr_controls__trap__valid__var;
        csr_controls__trap__to_mode = csr_controls__trap__to_mode__var;
        csr_controls__trap__cause = csr_controls__trap__cause__var;
        csr_controls__trap__pc = csr_controls__trap__pc__var;
        csr_controls__trap__value = csr_controls__trap__value__var;
        csr_controls__trap__ret = csr_controls__trap__ret__var;
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
    reg [4:0]coproc_controls__dec_idecode__rs1__var;
    reg coproc_controls__dec_idecode__rs1_valid__var;
    reg [4:0]coproc_controls__dec_idecode__rs2__var;
    reg coproc_controls__dec_idecode__rs2_valid__var;
    reg [4:0]coproc_controls__dec_idecode__rd__var;
    reg coproc_controls__dec_idecode__rd_written__var;
    reg [2:0]coproc_controls__dec_idecode__csr_access__mode__var;
    reg coproc_controls__dec_idecode__csr_access__access_cancelled__var;
    reg [2:0]coproc_controls__dec_idecode__csr_access__access__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__mhartid__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__misa__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__mvendorid__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__marchid__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__custom__mimpid__var;
    reg [11:0]coproc_controls__dec_idecode__csr_access__address__var;
    reg [11:0]coproc_controls__dec_idecode__csr_access__select__var;
    reg [31:0]coproc_controls__dec_idecode__csr_access__write_data__var;
    reg [31:0]coproc_controls__dec_idecode__immediate__var;
    reg [4:0]coproc_controls__dec_idecode__immediate_shift__var;
    reg coproc_controls__dec_idecode__immediate_valid__var;
    reg [3:0]coproc_controls__dec_idecode__op__var;
    reg [3:0]coproc_controls__dec_idecode__subop__var;
    reg [3:0]coproc_controls__dec_idecode__shift_op__var;
    reg [6:0]coproc_controls__dec_idecode__funct7__var;
    reg coproc_controls__dec_idecode__illegal__var;
    reg coproc_controls__dec_idecode__is_compressed__var;
    reg coproc_controls__dec_idecode__ext__dummy__var;
    reg coproc_controls__dec_idecode_valid__var;
    reg coproc_controls__dec_to_alu_blocked__var;
    reg [31:0]coproc_controls__alu_rs1__var;
    reg [31:0]coproc_controls__alu_rs2__var;
    reg coproc_controls__alu_data_not_ready__var;
    reg coproc_controls__alu_flush_pipeline__var;
    reg coproc_controls__alu_cannot_start__var;
    reg coproc_controls__alu_cannot_complete__var;
    reg pipeline_coproc_response__cannot_start__var;
    reg [31:0]pipeline_coproc_response__result__var;
    reg pipeline_coproc_response__result_valid__var;
    reg pipeline_coproc_response__cannot_complete__var;
        coproc_controls__dec_idecode__rs1__var = pipeline_response__decode__idecode__rs1;
        coproc_controls__dec_idecode__rs1_valid__var = pipeline_response__decode__idecode__rs1_valid;
        coproc_controls__dec_idecode__rs2__var = pipeline_response__decode__idecode__rs2;
        coproc_controls__dec_idecode__rs2_valid__var = pipeline_response__decode__idecode__rs2_valid;
        coproc_controls__dec_idecode__rd__var = pipeline_response__decode__idecode__rd;
        coproc_controls__dec_idecode__rd_written__var = pipeline_response__decode__idecode__rd_written;
        coproc_controls__dec_idecode__csr_access__mode__var = pipeline_response__decode__idecode__csr_access__mode;
        coproc_controls__dec_idecode__csr_access__access_cancelled__var = pipeline_response__decode__idecode__csr_access__access_cancelled;
        coproc_controls__dec_idecode__csr_access__access__var = pipeline_response__decode__idecode__csr_access__access;
        coproc_controls__dec_idecode__csr_access__custom__mhartid__var = pipeline_response__decode__idecode__csr_access__custom__mhartid;
        coproc_controls__dec_idecode__csr_access__custom__misa__var = pipeline_response__decode__idecode__csr_access__custom__misa;
        coproc_controls__dec_idecode__csr_access__custom__mvendorid__var = pipeline_response__decode__idecode__csr_access__custom__mvendorid;
        coproc_controls__dec_idecode__csr_access__custom__marchid__var = pipeline_response__decode__idecode__csr_access__custom__marchid;
        coproc_controls__dec_idecode__csr_access__custom__mimpid__var = pipeline_response__decode__idecode__csr_access__custom__mimpid;
        coproc_controls__dec_idecode__csr_access__address__var = pipeline_response__decode__idecode__csr_access__address;
        coproc_controls__dec_idecode__csr_access__select__var = pipeline_response__decode__idecode__csr_access__select;
        coproc_controls__dec_idecode__csr_access__write_data__var = pipeline_response__decode__idecode__csr_access__write_data;
        coproc_controls__dec_idecode__immediate__var = pipeline_response__decode__idecode__immediate;
        coproc_controls__dec_idecode__immediate_shift__var = pipeline_response__decode__idecode__immediate_shift;
        coproc_controls__dec_idecode__immediate_valid__var = pipeline_response__decode__idecode__immediate_valid;
        coproc_controls__dec_idecode__op__var = pipeline_response__decode__idecode__op;
        coproc_controls__dec_idecode__subop__var = pipeline_response__decode__idecode__subop;
        coproc_controls__dec_idecode__shift_op__var = pipeline_response__decode__idecode__shift_op;
        coproc_controls__dec_idecode__funct7__var = pipeline_response__decode__idecode__funct7;
        coproc_controls__dec_idecode__illegal__var = pipeline_response__decode__idecode__illegal;
        coproc_controls__dec_idecode__is_compressed__var = pipeline_response__decode__idecode__is_compressed;
        coproc_controls__dec_idecode__ext__dummy__var = pipeline_response__decode__idecode__ext__dummy;
        coproc_controls__dec_idecode_valid__var = ((pipeline_response__decode__valid!=1'h0)&&!(pipeline_state__interrupt_req!=1'h0));
        coproc_controls__dec_to_alu_blocked__var = pipeline_control__decode__blocked;
        coproc_controls__alu_rs1__var = pipeline_response__exec__rs1;
        coproc_controls__alu_rs2__var = pipeline_response__exec__rs2;
        coproc_controls__alu_data_not_ready__var = pipeline_response__exec__cannot_start;
        coproc_controls__alu_flush_pipeline__var = pipeline_control__flush__decode;
        coproc_controls__alu_cannot_start__var = control_flow_combs__exec_cannot_start;
        coproc_controls__alu_cannot_complete__var = control_flow_combs__exec_cannot_complete;
        pipeline_coproc_response__cannot_start__var = coproc_response__cannot_start;
        pipeline_coproc_response__result__var = coproc_response__result;
        pipeline_coproc_response__result_valid__var = coproc_response__result_valid;
        pipeline_coproc_response__cannot_complete__var = coproc_response__cannot_complete;
        if (((1'h0!=64'h0)||(riscv_config__coproc_disable!=1'h0)))
        begin
            coproc_controls__dec_idecode_valid__var = 1'h0;
            coproc_controls__dec_idecode__rs1__var = 5'h0;
            coproc_controls__dec_idecode__rs1_valid__var = 1'h0;
            coproc_controls__dec_idecode__rs2__var = 5'h0;
            coproc_controls__dec_idecode__rs2_valid__var = 1'h0;
            coproc_controls__dec_idecode__rd__var = 5'h0;
            coproc_controls__dec_idecode__rd_written__var = 1'h0;
            coproc_controls__dec_idecode__csr_access__mode__var = 3'h0;
            coproc_controls__dec_idecode__csr_access__access_cancelled__var = 1'h0;
            coproc_controls__dec_idecode__csr_access__access__var = 3'h0;
            coproc_controls__dec_idecode__csr_access__custom__mhartid__var = 32'h0;
            coproc_controls__dec_idecode__csr_access__custom__misa__var = 32'h0;
            coproc_controls__dec_idecode__csr_access__custom__mvendorid__var = 32'h0;
            coproc_controls__dec_idecode__csr_access__custom__marchid__var = 32'h0;
            coproc_controls__dec_idecode__csr_access__custom__mimpid__var = 32'h0;
            coproc_controls__dec_idecode__csr_access__address__var = 12'h0;
            coproc_controls__dec_idecode__csr_access__select__var = 12'h0;
            coproc_controls__dec_idecode__csr_access__write_data__var = 32'h0;
            coproc_controls__dec_idecode__immediate__var = 32'h0;
            coproc_controls__dec_idecode__immediate_shift__var = 5'h0;
            coproc_controls__dec_idecode__immediate_valid__var = 1'h0;
            coproc_controls__dec_idecode__op__var = 4'h0;
            coproc_controls__dec_idecode__subop__var = 4'h0;
            coproc_controls__dec_idecode__shift_op__var = 4'h0;
            coproc_controls__dec_idecode__funct7__var = 7'h0;
            coproc_controls__dec_idecode__illegal__var = 1'h0;
            coproc_controls__dec_idecode__is_compressed__var = 1'h0;
            coproc_controls__dec_idecode__ext__dummy__var = 1'h0;
            coproc_controls__dec_to_alu_blocked__var = 1'h0;
            coproc_controls__alu_rs1__var = 32'h0;
            coproc_controls__alu_rs2__var = 32'h0;
            coproc_controls__alu_flush_pipeline__var = 1'h0;
            coproc_controls__alu_cannot_start__var = 1'h0;
            coproc_controls__alu_data_not_ready__var = 1'h0;
            coproc_controls__alu_cannot_complete__var = 1'h0;
            pipeline_coproc_response__cannot_start__var = 1'h0;
            pipeline_coproc_response__result__var = 32'h0;
            pipeline_coproc_response__result_valid__var = 1'h0;
            pipeline_coproc_response__cannot_complete__var = 1'h0;
        end //if
        coproc_controls__dec_idecode__rs1 = coproc_controls__dec_idecode__rs1__var;
        coproc_controls__dec_idecode__rs1_valid = coproc_controls__dec_idecode__rs1_valid__var;
        coproc_controls__dec_idecode__rs2 = coproc_controls__dec_idecode__rs2__var;
        coproc_controls__dec_idecode__rs2_valid = coproc_controls__dec_idecode__rs2_valid__var;
        coproc_controls__dec_idecode__rd = coproc_controls__dec_idecode__rd__var;
        coproc_controls__dec_idecode__rd_written = coproc_controls__dec_idecode__rd_written__var;
        coproc_controls__dec_idecode__csr_access__mode = coproc_controls__dec_idecode__csr_access__mode__var;
        coproc_controls__dec_idecode__csr_access__access_cancelled = coproc_controls__dec_idecode__csr_access__access_cancelled__var;
        coproc_controls__dec_idecode__csr_access__access = coproc_controls__dec_idecode__csr_access__access__var;
        coproc_controls__dec_idecode__csr_access__custom__mhartid = coproc_controls__dec_idecode__csr_access__custom__mhartid__var;
        coproc_controls__dec_idecode__csr_access__custom__misa = coproc_controls__dec_idecode__csr_access__custom__misa__var;
        coproc_controls__dec_idecode__csr_access__custom__mvendorid = coproc_controls__dec_idecode__csr_access__custom__mvendorid__var;
        coproc_controls__dec_idecode__csr_access__custom__marchid = coproc_controls__dec_idecode__csr_access__custom__marchid__var;
        coproc_controls__dec_idecode__csr_access__custom__mimpid = coproc_controls__dec_idecode__csr_access__custom__mimpid__var;
        coproc_controls__dec_idecode__csr_access__address = coproc_controls__dec_idecode__csr_access__address__var;
        coproc_controls__dec_idecode__csr_access__select = coproc_controls__dec_idecode__csr_access__select__var;
        coproc_controls__dec_idecode__csr_access__write_data = coproc_controls__dec_idecode__csr_access__write_data__var;
        coproc_controls__dec_idecode__immediate = coproc_controls__dec_idecode__immediate__var;
        coproc_controls__dec_idecode__immediate_shift = coproc_controls__dec_idecode__immediate_shift__var;
        coproc_controls__dec_idecode__immediate_valid = coproc_controls__dec_idecode__immediate_valid__var;
        coproc_controls__dec_idecode__op = coproc_controls__dec_idecode__op__var;
        coproc_controls__dec_idecode__subop = coproc_controls__dec_idecode__subop__var;
        coproc_controls__dec_idecode__shift_op = coproc_controls__dec_idecode__shift_op__var;
        coproc_controls__dec_idecode__funct7 = coproc_controls__dec_idecode__funct7__var;
        coproc_controls__dec_idecode__illegal = coproc_controls__dec_idecode__illegal__var;
        coproc_controls__dec_idecode__is_compressed = coproc_controls__dec_idecode__is_compressed__var;
        coproc_controls__dec_idecode__ext__dummy = coproc_controls__dec_idecode__ext__dummy__var;
        coproc_controls__dec_idecode_valid = coproc_controls__dec_idecode_valid__var;
        coproc_controls__dec_to_alu_blocked = coproc_controls__dec_to_alu_blocked__var;
        coproc_controls__alu_rs1 = coproc_controls__alu_rs1__var;
        coproc_controls__alu_rs2 = coproc_controls__alu_rs2__var;
        coproc_controls__alu_data_not_ready = coproc_controls__alu_data_not_ready__var;
        coproc_controls__alu_flush_pipeline = coproc_controls__alu_flush_pipeline__var;
        coproc_controls__alu_cannot_start = coproc_controls__alu_cannot_start__var;
        coproc_controls__alu_cannot_complete = coproc_controls__alu_cannot_complete__var;
        pipeline_coproc_response__cannot_start = pipeline_coproc_response__cannot_start__var;
        pipeline_coproc_response__result = pipeline_coproc_response__result__var;
        pipeline_coproc_response__result_valid = pipeline_coproc_response__result_valid__var;
        pipeline_coproc_response__cannot_complete = pipeline_coproc_response__cannot_complete__var;
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
        trace__instr_valid__var = (((pipeline_response__exec__valid!=1'h0)&&(pipeline_control__exec__completing!=1'h0))&&!(pipeline_control__flush__exec!=1'h0));
        trace__instr_pc__var = pipeline_response__exec__pc;
        trace__mode__var = pipeline_state__mode;
        trace__instruction__var = pipeline_response__exec__instruction__data;
        trace__rfw_retire__var = pipeline_response__rfw__valid;
        trace__rfw_data_valid__var = pipeline_response__rfw__rd_written;
        trace__rfw_rd__var = pipeline_response__rfw__rd;
        trace__rfw_data__var = pipeline_response__rfw__data;
        trace__branch_taken__var = control_flow_combs__branch_taken;
        trace__trap__var = ((pipeline_control__trap__valid!=1'h0)&&!(pipeline_control__trap__ret!=1'h0));
        trace__ret__var = pipeline_control__trap__ret;
        trace__jalr__var = control_flow_combs__jalr;
        trace__branch_target__var = ifetch_req__address;
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

endmodule // riscv_i32_pipeline_control_flow
