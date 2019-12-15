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

//a Module riscv_i32c_pipeline
    //   
    //   This is just the processor pipeline, using a single stage for execution.
    //   
    //   The instruction fetch request for the next cycle is put out just after
    //   the ALU stage logic, which may be a long time into the cycle; the
    //   fetch data response presents the instruction fetched at the end of the
    //   cycle, where it is registered for execution.
    //   
    //   The pipeline is then a single stage that takes the fetched
    //   instruction, decodes, fetches register values, and executes the ALU
    //   stage; determining in half a cycle the next instruction fetch, and in
    //   the whole cycle the data memory request, which is valid just before
    //   the end
    //   
    //   A coprocessor is supported; this may be configured to be disabled, in
    //   which case the outputs are driven low and the inputs are coprocessor
    //   response is ignored.
    //   
    //   A coprocessor can implement, for example, the multiply for i32m (using
    //   riscv_i32_muldiv).  Note that since there is not a separate decode
    //   stage the multiply cannot support fused operations
    //   
    //   
module riscv_i32c_pipeline
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
    riscv_config__mem_abort_late,
    csr_read_data,
    coproc_response__cannot_start,
    coproc_response__result,
    coproc_response__result_valid,
    coproc_response__cannot_complete,
    pipeline_fetch_data__valid,
    pipeline_fetch_data__mode,
    pipeline_fetch_data__pc,
    pipeline_fetch_data__instruction__mode,
    pipeline_fetch_data__instruction__data,
    pipeline_fetch_data__instruction__debug__valid,
    pipeline_fetch_data__instruction__debug__debug_op,
    pipeline_fetch_data__instruction__debug__data,
    pipeline_fetch_data__dec_predicted_branch,
    pipeline_fetch_data__dec_pc_if_mispredicted,
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
    pipeline_control__mem__blocked,
    dmem_access_resp__ack_if_seq,
    dmem_access_resp__ack,
    dmem_access_resp__abort_req,
    dmem_access_resp__may_still_abort,
    dmem_access_resp__access_complete,
    dmem_access_resp__read_data,
    reset_n,

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
    pipeline_response__pipeline_empty
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
    input riscv_config__mem_abort_late;
    input [31:0]csr_read_data;
    input coproc_response__cannot_start;
    input [31:0]coproc_response__result;
    input coproc_response__result_valid;
    input coproc_response__cannot_complete;
    input pipeline_fetch_data__valid;
    input [2:0]pipeline_fetch_data__mode;
    input [31:0]pipeline_fetch_data__pc;
    input [2:0]pipeline_fetch_data__instruction__mode;
    input [31:0]pipeline_fetch_data__instruction__data;
    input pipeline_fetch_data__instruction__debug__valid;
    input [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    input [15:0]pipeline_fetch_data__instruction__debug__data;
    input pipeline_fetch_data__dec_predicted_branch;
    input [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;
    input pipeline_control__trap__valid;
    input [2:0]pipeline_control__trap__to_mode;
    input [4:0]pipeline_control__trap__cause;
    input [31:0]pipeline_control__trap__pc;
    input [31:0]pipeline_control__trap__value;
    input pipeline_control__trap__ret;
    input pipeline_control__trap__ebreak_to_dbg;
    input pipeline_control__flush__fetch;
    input pipeline_control__flush__decode;
    input pipeline_control__flush__exec;
    input pipeline_control__flush__mem;
    input pipeline_control__decode__completing;
    input pipeline_control__decode__blocked;
    input pipeline_control__decode__cannot_complete;
    input pipeline_control__exec__completing_cycle;
    input pipeline_control__exec__completing;
    input pipeline_control__exec__blocked_start;
    input pipeline_control__exec__blocked;
    input pipeline_control__exec__mispredicted_branch;
    input [31:0]pipeline_control__exec__pc_if_mispredicted;
    input pipeline_control__mem__blocked;
    input dmem_access_resp__ack_if_seq;
    input dmem_access_resp__ack;
    input dmem_access_resp__abort_req;
    input dmem_access_resp__may_still_abort;
    input dmem_access_resp__access_complete;
    input [31:0]dmem_access_resp__read_data;
    input reset_n;

    //b Outputs
    output pipeline_response__decode__valid;
    output [31:0]pipeline_response__decode__pc;
    output [31:0]pipeline_response__decode__branch_target;
    output [4:0]pipeline_response__decode__idecode__rs1;
    output pipeline_response__decode__idecode__rs1_valid;
    output [4:0]pipeline_response__decode__idecode__rs2;
    output pipeline_response__decode__idecode__rs2_valid;
    output [4:0]pipeline_response__decode__idecode__rd;
    output pipeline_response__decode__idecode__rd_written;
    output [2:0]pipeline_response__decode__idecode__csr_access__mode;
    output pipeline_response__decode__idecode__csr_access__access_cancelled;
    output [2:0]pipeline_response__decode__idecode__csr_access__access;
    output [31:0]pipeline_response__decode__idecode__csr_access__custom__mhartid;
    output [31:0]pipeline_response__decode__idecode__csr_access__custom__misa;
    output [31:0]pipeline_response__decode__idecode__csr_access__custom__mvendorid;
    output [31:0]pipeline_response__decode__idecode__csr_access__custom__marchid;
    output [31:0]pipeline_response__decode__idecode__csr_access__custom__mimpid;
    output [11:0]pipeline_response__decode__idecode__csr_access__address;
    output [11:0]pipeline_response__decode__idecode__csr_access__select;
    output [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    output [31:0]pipeline_response__decode__idecode__immediate;
    output [4:0]pipeline_response__decode__idecode__immediate_shift;
    output pipeline_response__decode__idecode__immediate_valid;
    output [3:0]pipeline_response__decode__idecode__op;
    output [3:0]pipeline_response__decode__idecode__subop;
    output [3:0]pipeline_response__decode__idecode__shift_op;
    output [6:0]pipeline_response__decode__idecode__funct7;
    output pipeline_response__decode__idecode__illegal;
    output pipeline_response__decode__idecode__is_compressed;
    output pipeline_response__decode__idecode__ext__dummy;
    output pipeline_response__decode__enable_branch_prediction;
    output pipeline_response__exec__valid;
    output pipeline_response__exec__cannot_start;
    output pipeline_response__exec__first_cycle;
    output pipeline_response__exec__last_cycle;
    output pipeline_response__exec__interrupt_block;
    output [2:0]pipeline_response__exec__instruction__mode;
    output [31:0]pipeline_response__exec__instruction__data;
    output pipeline_response__exec__instruction__debug__valid;
    output [1:0]pipeline_response__exec__instruction__debug__debug_op;
    output [15:0]pipeline_response__exec__instruction__debug__data;
    output [4:0]pipeline_response__exec__idecode__rs1;
    output pipeline_response__exec__idecode__rs1_valid;
    output [4:0]pipeline_response__exec__idecode__rs2;
    output pipeline_response__exec__idecode__rs2_valid;
    output [4:0]pipeline_response__exec__idecode__rd;
    output pipeline_response__exec__idecode__rd_written;
    output [2:0]pipeline_response__exec__idecode__csr_access__mode;
    output pipeline_response__exec__idecode__csr_access__access_cancelled;
    output [2:0]pipeline_response__exec__idecode__csr_access__access;
    output [31:0]pipeline_response__exec__idecode__csr_access__custom__mhartid;
    output [31:0]pipeline_response__exec__idecode__csr_access__custom__misa;
    output [31:0]pipeline_response__exec__idecode__csr_access__custom__mvendorid;
    output [31:0]pipeline_response__exec__idecode__csr_access__custom__marchid;
    output [31:0]pipeline_response__exec__idecode__csr_access__custom__mimpid;
    output [11:0]pipeline_response__exec__idecode__csr_access__address;
    output [11:0]pipeline_response__exec__idecode__csr_access__select;
    output [31:0]pipeline_response__exec__idecode__csr_access__write_data;
    output [31:0]pipeline_response__exec__idecode__immediate;
    output [4:0]pipeline_response__exec__idecode__immediate_shift;
    output pipeline_response__exec__idecode__immediate_valid;
    output [3:0]pipeline_response__exec__idecode__op;
    output [3:0]pipeline_response__exec__idecode__subop;
    output [3:0]pipeline_response__exec__idecode__shift_op;
    output [6:0]pipeline_response__exec__idecode__funct7;
    output pipeline_response__exec__idecode__illegal;
    output pipeline_response__exec__idecode__is_compressed;
    output pipeline_response__exec__idecode__ext__dummy;
    output [31:0]pipeline_response__exec__rs1;
    output [31:0]pipeline_response__exec__rs2;
    output [31:0]pipeline_response__exec__pc;
    output pipeline_response__exec__predicted_branch;
    output [31:0]pipeline_response__exec__pc_if_mispredicted;
    output pipeline_response__exec__branch_condition_met;
    output pipeline_response__exec__dmem_access_req__valid;
    output [2:0]pipeline_response__exec__dmem_access_req__mode;
    output [4:0]pipeline_response__exec__dmem_access_req__req_type;
    output [31:0]pipeline_response__exec__dmem_access_req__address;
    output pipeline_response__exec__dmem_access_req__sequential;
    output [3:0]pipeline_response__exec__dmem_access_req__byte_enable;
    output [31:0]pipeline_response__exec__dmem_access_req__write_data;
    output [2:0]pipeline_response__exec__csr_access__mode;
    output pipeline_response__exec__csr_access__access_cancelled;
    output [2:0]pipeline_response__exec__csr_access__access;
    output [31:0]pipeline_response__exec__csr_access__custom__mhartid;
    output [31:0]pipeline_response__exec__csr_access__custom__misa;
    output [31:0]pipeline_response__exec__csr_access__custom__mvendorid;
    output [31:0]pipeline_response__exec__csr_access__custom__marchid;
    output [31:0]pipeline_response__exec__csr_access__custom__mimpid;
    output [11:0]pipeline_response__exec__csr_access__address;
    output [11:0]pipeline_response__exec__csr_access__select;
    output [31:0]pipeline_response__exec__csr_access__write_data;
    output pipeline_response__mem__valid;
    output pipeline_response__mem__access_in_progress;
    output [31:0]pipeline_response__mem__pc;
    output [31:0]pipeline_response__mem__addr;
    output pipeline_response__rfw__valid;
    output pipeline_response__rfw__rd_written;
    output [4:0]pipeline_response__rfw__rd;
    output [31:0]pipeline_response__rfw__data;
    output pipeline_response__pipeline_empty;

// output components here

    //b Output combinatorials
    reg pipeline_response__decode__valid;
    reg [31:0]pipeline_response__decode__pc;
    reg [31:0]pipeline_response__decode__branch_target;
    reg [4:0]pipeline_response__decode__idecode__rs1;
    reg pipeline_response__decode__idecode__rs1_valid;
    reg [4:0]pipeline_response__decode__idecode__rs2;
    reg pipeline_response__decode__idecode__rs2_valid;
    reg [4:0]pipeline_response__decode__idecode__rd;
    reg pipeline_response__decode__idecode__rd_written;
    reg [2:0]pipeline_response__decode__idecode__csr_access__mode;
    reg pipeline_response__decode__idecode__csr_access__access_cancelled;
    reg [2:0]pipeline_response__decode__idecode__csr_access__access;
    reg [31:0]pipeline_response__decode__idecode__csr_access__custom__mhartid;
    reg [31:0]pipeline_response__decode__idecode__csr_access__custom__misa;
    reg [31:0]pipeline_response__decode__idecode__csr_access__custom__mvendorid;
    reg [31:0]pipeline_response__decode__idecode__csr_access__custom__marchid;
    reg [31:0]pipeline_response__decode__idecode__csr_access__custom__mimpid;
    reg [11:0]pipeline_response__decode__idecode__csr_access__address;
    reg [11:0]pipeline_response__decode__idecode__csr_access__select;
    reg [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    reg [31:0]pipeline_response__decode__idecode__immediate;
    reg [4:0]pipeline_response__decode__idecode__immediate_shift;
    reg pipeline_response__decode__idecode__immediate_valid;
    reg [3:0]pipeline_response__decode__idecode__op;
    reg [3:0]pipeline_response__decode__idecode__subop;
    reg [3:0]pipeline_response__decode__idecode__shift_op;
    reg [6:0]pipeline_response__decode__idecode__funct7;
    reg pipeline_response__decode__idecode__illegal;
    reg pipeline_response__decode__idecode__is_compressed;
    reg pipeline_response__decode__idecode__ext__dummy;
    reg pipeline_response__decode__enable_branch_prediction;
    reg pipeline_response__exec__valid;
    reg pipeline_response__exec__cannot_start;
    reg pipeline_response__exec__first_cycle;
    reg pipeline_response__exec__last_cycle;
    reg pipeline_response__exec__interrupt_block;
    reg [2:0]pipeline_response__exec__instruction__mode;
    reg [31:0]pipeline_response__exec__instruction__data;
    reg pipeline_response__exec__instruction__debug__valid;
    reg [1:0]pipeline_response__exec__instruction__debug__debug_op;
    reg [15:0]pipeline_response__exec__instruction__debug__data;
    reg [4:0]pipeline_response__exec__idecode__rs1;
    reg pipeline_response__exec__idecode__rs1_valid;
    reg [4:0]pipeline_response__exec__idecode__rs2;
    reg pipeline_response__exec__idecode__rs2_valid;
    reg [4:0]pipeline_response__exec__idecode__rd;
    reg pipeline_response__exec__idecode__rd_written;
    reg [2:0]pipeline_response__exec__idecode__csr_access__mode;
    reg pipeline_response__exec__idecode__csr_access__access_cancelled;
    reg [2:0]pipeline_response__exec__idecode__csr_access__access;
    reg [31:0]pipeline_response__exec__idecode__csr_access__custom__mhartid;
    reg [31:0]pipeline_response__exec__idecode__csr_access__custom__misa;
    reg [31:0]pipeline_response__exec__idecode__csr_access__custom__mvendorid;
    reg [31:0]pipeline_response__exec__idecode__csr_access__custom__marchid;
    reg [31:0]pipeline_response__exec__idecode__csr_access__custom__mimpid;
    reg [11:0]pipeline_response__exec__idecode__csr_access__address;
    reg [11:0]pipeline_response__exec__idecode__csr_access__select;
    reg [31:0]pipeline_response__exec__idecode__csr_access__write_data;
    reg [31:0]pipeline_response__exec__idecode__immediate;
    reg [4:0]pipeline_response__exec__idecode__immediate_shift;
    reg pipeline_response__exec__idecode__immediate_valid;
    reg [3:0]pipeline_response__exec__idecode__op;
    reg [3:0]pipeline_response__exec__idecode__subop;
    reg [3:0]pipeline_response__exec__idecode__shift_op;
    reg [6:0]pipeline_response__exec__idecode__funct7;
    reg pipeline_response__exec__idecode__illegal;
    reg pipeline_response__exec__idecode__is_compressed;
    reg pipeline_response__exec__idecode__ext__dummy;
    reg [31:0]pipeline_response__exec__rs1;
    reg [31:0]pipeline_response__exec__rs2;
    reg [31:0]pipeline_response__exec__pc;
    reg pipeline_response__exec__predicted_branch;
    reg [31:0]pipeline_response__exec__pc_if_mispredicted;
    reg pipeline_response__exec__branch_condition_met;
    reg pipeline_response__exec__dmem_access_req__valid;
    reg [2:0]pipeline_response__exec__dmem_access_req__mode;
    reg [4:0]pipeline_response__exec__dmem_access_req__req_type;
    reg [31:0]pipeline_response__exec__dmem_access_req__address;
    reg pipeline_response__exec__dmem_access_req__sequential;
    reg [3:0]pipeline_response__exec__dmem_access_req__byte_enable;
    reg [31:0]pipeline_response__exec__dmem_access_req__write_data;
    reg [2:0]pipeline_response__exec__csr_access__mode;
    reg pipeline_response__exec__csr_access__access_cancelled;
    reg [2:0]pipeline_response__exec__csr_access__access;
    reg [31:0]pipeline_response__exec__csr_access__custom__mhartid;
    reg [31:0]pipeline_response__exec__csr_access__custom__misa;
    reg [31:0]pipeline_response__exec__csr_access__custom__mvendorid;
    reg [31:0]pipeline_response__exec__csr_access__custom__marchid;
    reg [31:0]pipeline_response__exec__csr_access__custom__mimpid;
    reg [11:0]pipeline_response__exec__csr_access__address;
    reg [11:0]pipeline_response__exec__csr_access__select;
    reg [31:0]pipeline_response__exec__csr_access__write_data;
    reg pipeline_response__mem__valid;
    reg pipeline_response__mem__access_in_progress;
    reg [31:0]pipeline_response__mem__pc;
    reg [31:0]pipeline_response__mem__addr;
    reg pipeline_response__rfw__valid;
    reg pipeline_response__rfw__rd_written;
    reg [4:0]pipeline_response__rfw__rd;
    reg [31:0]pipeline_response__rfw__data;
    reg pipeline_response__pipeline_empty;

    //b Output nets

    //b Internal and output registers
    reg rfw_state__valid;
    reg rfw_state__rd_written;
    reg [4:0]rfw_state__rd;
    reg [31:0]rfw_state__data;
    reg [31:0]decexecrfw_state__pc;
    reg [2:0]decexecrfw_state__mode;
    reg [2:0]decexecrfw_state__instruction__mode;
    reg [31:0]decexecrfw_state__instruction__data;
    reg decexecrfw_state__instruction__debug__valid;
    reg [1:0]decexecrfw_state__instruction__debug__debug_op;
    reg [15:0]decexecrfw_state__instruction__debug__data;
    reg decexecrfw_state__valid;
        //   Register 0 is tied to 0 - so it is written on every cycle to zero...
    reg [31:0]registers[31:0];

    //b Internal combinatorials
    reg [4:0]decexecrfw_combs__idecode__rs1;
    reg decexecrfw_combs__idecode__rs1_valid;
    reg [4:0]decexecrfw_combs__idecode__rs2;
    reg decexecrfw_combs__idecode__rs2_valid;
    reg [4:0]decexecrfw_combs__idecode__rd;
    reg decexecrfw_combs__idecode__rd_written;
    reg [2:0]decexecrfw_combs__idecode__csr_access__mode;
    reg decexecrfw_combs__idecode__csr_access__access_cancelled;
    reg [2:0]decexecrfw_combs__idecode__csr_access__access;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__mhartid;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__misa;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__mvendorid;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__marchid;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__mimpid;
    reg [11:0]decexecrfw_combs__idecode__csr_access__address;
    reg [11:0]decexecrfw_combs__idecode__csr_access__select;
    reg [31:0]decexecrfw_combs__idecode__csr_access__write_data;
    reg [31:0]decexecrfw_combs__idecode__immediate;
    reg [4:0]decexecrfw_combs__idecode__immediate_shift;
    reg decexecrfw_combs__idecode__immediate_valid;
    reg [3:0]decexecrfw_combs__idecode__op;
    reg [3:0]decexecrfw_combs__idecode__subop;
    reg [3:0]decexecrfw_combs__idecode__shift_op;
    reg [6:0]decexecrfw_combs__idecode__funct7;
    reg decexecrfw_combs__idecode__illegal;
    reg decexecrfw_combs__idecode__is_compressed;
    reg decexecrfw_combs__idecode__ext__dummy;
    reg [31:0]decexecrfw_combs__rs1;
    reg [31:0]decexecrfw_combs__rs2;
    reg decexecrfw_combs__exec_committed;
    reg [31:0]decexecrfw_combs__rfw_write_data;
    reg decexecrfw_combs__dmem_exec__valid;
    reg [2:0]decexecrfw_combs__dmem_exec__mode;
    reg [4:0]decexecrfw_combs__dmem_exec__idecode__rs1;
    reg decexecrfw_combs__dmem_exec__idecode__rs1_valid;
    reg [4:0]decexecrfw_combs__dmem_exec__idecode__rs2;
    reg decexecrfw_combs__dmem_exec__idecode__rs2_valid;
    reg [4:0]decexecrfw_combs__dmem_exec__idecode__rd;
    reg decexecrfw_combs__dmem_exec__idecode__rd_written;
    reg [2:0]decexecrfw_combs__dmem_exec__idecode__csr_access__mode;
    reg decexecrfw_combs__dmem_exec__idecode__csr_access__access_cancelled;
    reg [2:0]decexecrfw_combs__dmem_exec__idecode__csr_access__access;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mhartid;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__csr_access__custom__misa;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mvendorid;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__csr_access__custom__marchid;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mimpid;
    reg [11:0]decexecrfw_combs__dmem_exec__idecode__csr_access__address;
    reg [11:0]decexecrfw_combs__dmem_exec__idecode__csr_access__select;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__csr_access__write_data;
    reg [31:0]decexecrfw_combs__dmem_exec__idecode__immediate;
    reg [4:0]decexecrfw_combs__dmem_exec__idecode__immediate_shift;
    reg decexecrfw_combs__dmem_exec__idecode__immediate_valid;
    reg [3:0]decexecrfw_combs__dmem_exec__idecode__op;
    reg [3:0]decexecrfw_combs__dmem_exec__idecode__subop;
    reg [3:0]decexecrfw_combs__dmem_exec__idecode__shift_op;
    reg [6:0]decexecrfw_combs__dmem_exec__idecode__funct7;
    reg decexecrfw_combs__dmem_exec__idecode__illegal;
    reg decexecrfw_combs__dmem_exec__idecode__is_compressed;
    reg decexecrfw_combs__dmem_exec__idecode__ext__dummy;
    reg [31:0]decexecrfw_combs__dmem_exec__arith_result;
    reg [31:0]decexecrfw_combs__dmem_exec__rs2;
    reg decexecrfw_combs__dmem_exec__first_cycle;

    //b Internal nets
    wire [31:0]decexecrfw_alu_result__result;
    wire [31:0]decexecrfw_alu_result__arith_result;
    wire decexecrfw_alu_result__branch_condition_met;
    wire [31:0]decexecrfw_alu_result__branch_target;
    wire [2:0]decexecrfw_alu_result__csr_access__mode;
    wire decexecrfw_alu_result__csr_access__access_cancelled;
    wire [2:0]decexecrfw_alu_result__csr_access__access;
    wire [31:0]decexecrfw_alu_result__csr_access__custom__mhartid;
    wire [31:0]decexecrfw_alu_result__csr_access__custom__misa;
    wire [31:0]decexecrfw_alu_result__csr_access__custom__mvendorid;
    wire [31:0]decexecrfw_alu_result__csr_access__custom__marchid;
    wire [31:0]decexecrfw_alu_result__csr_access__custom__mimpid;
    wire [11:0]decexecrfw_alu_result__csr_access__address;
    wire [11:0]decexecrfw_alu_result__csr_access__select;
    wire [31:0]decexecrfw_alu_result__csr_access__write_data;
    wire [31:0]decexecrfw_dmem_read_data;
        //   Data memory request data
    wire decexecrfw_dmem_request__access__valid;
    wire [2:0]decexecrfw_dmem_request__access__mode;
    wire [4:0]decexecrfw_dmem_request__access__req_type;
    wire [31:0]decexecrfw_dmem_request__access__address;
    wire decexecrfw_dmem_request__access__sequential;
    wire [3:0]decexecrfw_dmem_request__access__byte_enable;
    wire [31:0]decexecrfw_dmem_request__access__write_data;
    wire decexecrfw_dmem_request__load_address_misaligned;
    wire decexecrfw_dmem_request__store_address_misaligned;
    wire decexecrfw_dmem_request__reading;
    wire [1:0]decexecrfw_dmem_request__read_data_rotation;
    wire [3:0]decexecrfw_dmem_request__read_data_byte_clear;
    wire [3:0]decexecrfw_dmem_request__read_data_byte_enable;
    wire decexecrfw_dmem_request__sign_extend_byte;
    wire decexecrfw_dmem_request__sign_extend_half;
    wire decexecrfw_dmem_request__multicycle;
        //   Decode of including using RV32C
    wire [4:0]decexecrfw_idecode_i32c__rs1;
    wire decexecrfw_idecode_i32c__rs1_valid;
    wire [4:0]decexecrfw_idecode_i32c__rs2;
    wire decexecrfw_idecode_i32c__rs2_valid;
    wire [4:0]decexecrfw_idecode_i32c__rd;
    wire decexecrfw_idecode_i32c__rd_written;
    wire [2:0]decexecrfw_idecode_i32c__csr_access__mode;
    wire decexecrfw_idecode_i32c__csr_access__access_cancelled;
    wire [2:0]decexecrfw_idecode_i32c__csr_access__access;
    wire [31:0]decexecrfw_idecode_i32c__csr_access__custom__mhartid;
    wire [31:0]decexecrfw_idecode_i32c__csr_access__custom__misa;
    wire [31:0]decexecrfw_idecode_i32c__csr_access__custom__mvendorid;
    wire [31:0]decexecrfw_idecode_i32c__csr_access__custom__marchid;
    wire [31:0]decexecrfw_idecode_i32c__csr_access__custom__mimpid;
    wire [11:0]decexecrfw_idecode_i32c__csr_access__address;
    wire [11:0]decexecrfw_idecode_i32c__csr_access__select;
    wire [31:0]decexecrfw_idecode_i32c__csr_access__write_data;
    wire [31:0]decexecrfw_idecode_i32c__immediate;
    wire [4:0]decexecrfw_idecode_i32c__immediate_shift;
    wire decexecrfw_idecode_i32c__immediate_valid;
    wire [3:0]decexecrfw_idecode_i32c__op;
    wire [3:0]decexecrfw_idecode_i32c__subop;
    wire [3:0]decexecrfw_idecode_i32c__shift_op;
    wire [6:0]decexecrfw_idecode_i32c__funct7;
    wire decexecrfw_idecode_i32c__illegal;
    wire decexecrfw_idecode_i32c__is_compressed;
    wire decexecrfw_idecode_i32c__ext__dummy;
        //   Decode of instruction including debug
    wire [4:0]decexecrfw_idecode_i32__rs1;
    wire decexecrfw_idecode_i32__rs1_valid;
    wire [4:0]decexecrfw_idecode_i32__rs2;
    wire decexecrfw_idecode_i32__rs2_valid;
    wire [4:0]decexecrfw_idecode_i32__rd;
    wire decexecrfw_idecode_i32__rd_written;
    wire [2:0]decexecrfw_idecode_i32__csr_access__mode;
    wire decexecrfw_idecode_i32__csr_access__access_cancelled;
    wire [2:0]decexecrfw_idecode_i32__csr_access__access;
    wire [31:0]decexecrfw_idecode_i32__csr_access__custom__mhartid;
    wire [31:0]decexecrfw_idecode_i32__csr_access__custom__misa;
    wire [31:0]decexecrfw_idecode_i32__csr_access__custom__mvendorid;
    wire [31:0]decexecrfw_idecode_i32__csr_access__custom__marchid;
    wire [31:0]decexecrfw_idecode_i32__csr_access__custom__mimpid;
    wire [11:0]decexecrfw_idecode_i32__csr_access__address;
    wire [11:0]decexecrfw_idecode_i32__csr_access__select;
    wire [31:0]decexecrfw_idecode_i32__csr_access__write_data;
    wire [31:0]decexecrfw_idecode_i32__immediate;
    wire [4:0]decexecrfw_idecode_i32__immediate_shift;
    wire decexecrfw_idecode_i32__immediate_valid;
    wire [3:0]decexecrfw_idecode_i32__op;
    wire [3:0]decexecrfw_idecode_i32__subop;
    wire [3:0]decexecrfw_idecode_i32__shift_op;
    wire [6:0]decexecrfw_idecode_i32__funct7;
    wire decexecrfw_idecode_i32__illegal;
    wire decexecrfw_idecode_i32__is_compressed;
    wire decexecrfw_idecode_i32__ext__dummy;

    //b Clock gating module instances
    //b Module instances
    riscv_i32_decode decode_i32(
        .riscv_config__mem_abort_late(riscv_config__mem_abort_late),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .instruction__debug__data(decexecrfw_state__instruction__debug__data),
        .instruction__debug__debug_op(decexecrfw_state__instruction__debug__debug_op),
        .instruction__debug__valid(decexecrfw_state__instruction__debug__valid),
        .instruction__data(decexecrfw_state__instruction__data),
        .instruction__mode(decexecrfw_state__instruction__mode),
        .idecode__ext__dummy(            decexecrfw_idecode_i32__ext__dummy),
        .idecode__is_compressed(            decexecrfw_idecode_i32__is_compressed),
        .idecode__illegal(            decexecrfw_idecode_i32__illegal),
        .idecode__funct7(            decexecrfw_idecode_i32__funct7),
        .idecode__shift_op(            decexecrfw_idecode_i32__shift_op),
        .idecode__subop(            decexecrfw_idecode_i32__subop),
        .idecode__op(            decexecrfw_idecode_i32__op),
        .idecode__immediate_valid(            decexecrfw_idecode_i32__immediate_valid),
        .idecode__immediate_shift(            decexecrfw_idecode_i32__immediate_shift),
        .idecode__immediate(            decexecrfw_idecode_i32__immediate),
        .idecode__csr_access__write_data(            decexecrfw_idecode_i32__csr_access__write_data),
        .idecode__csr_access__select(            decexecrfw_idecode_i32__csr_access__select),
        .idecode__csr_access__address(            decexecrfw_idecode_i32__csr_access__address),
        .idecode__csr_access__custom__mimpid(            decexecrfw_idecode_i32__csr_access__custom__mimpid),
        .idecode__csr_access__custom__marchid(            decexecrfw_idecode_i32__csr_access__custom__marchid),
        .idecode__csr_access__custom__mvendorid(            decexecrfw_idecode_i32__csr_access__custom__mvendorid),
        .idecode__csr_access__custom__misa(            decexecrfw_idecode_i32__csr_access__custom__misa),
        .idecode__csr_access__custom__mhartid(            decexecrfw_idecode_i32__csr_access__custom__mhartid),
        .idecode__csr_access__access(            decexecrfw_idecode_i32__csr_access__access),
        .idecode__csr_access__access_cancelled(            decexecrfw_idecode_i32__csr_access__access_cancelled),
        .idecode__csr_access__mode(            decexecrfw_idecode_i32__csr_access__mode),
        .idecode__rd_written(            decexecrfw_idecode_i32__rd_written),
        .idecode__rd(            decexecrfw_idecode_i32__rd),
        .idecode__rs2_valid(            decexecrfw_idecode_i32__rs2_valid),
        .idecode__rs2(            decexecrfw_idecode_i32__rs2),
        .idecode__rs1_valid(            decexecrfw_idecode_i32__rs1_valid),
        .idecode__rs1(            decexecrfw_idecode_i32__rs1)         );
    riscv_i32c_decode decode_i32c(
        .riscv_config__mem_abort_late(riscv_config__mem_abort_late),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .instruction__debug__data(decexecrfw_state__instruction__debug__data),
        .instruction__debug__debug_op(decexecrfw_state__instruction__debug__debug_op),
        .instruction__debug__valid(decexecrfw_state__instruction__debug__valid),
        .instruction__data(decexecrfw_state__instruction__data),
        .instruction__mode(decexecrfw_state__instruction__mode),
        .idecode__ext__dummy(            decexecrfw_idecode_i32c__ext__dummy),
        .idecode__is_compressed(            decexecrfw_idecode_i32c__is_compressed),
        .idecode__illegal(            decexecrfw_idecode_i32c__illegal),
        .idecode__funct7(            decexecrfw_idecode_i32c__funct7),
        .idecode__shift_op(            decexecrfw_idecode_i32c__shift_op),
        .idecode__subop(            decexecrfw_idecode_i32c__subop),
        .idecode__op(            decexecrfw_idecode_i32c__op),
        .idecode__immediate_valid(            decexecrfw_idecode_i32c__immediate_valid),
        .idecode__immediate_shift(            decexecrfw_idecode_i32c__immediate_shift),
        .idecode__immediate(            decexecrfw_idecode_i32c__immediate),
        .idecode__csr_access__write_data(            decexecrfw_idecode_i32c__csr_access__write_data),
        .idecode__csr_access__select(            decexecrfw_idecode_i32c__csr_access__select),
        .idecode__csr_access__address(            decexecrfw_idecode_i32c__csr_access__address),
        .idecode__csr_access__custom__mimpid(            decexecrfw_idecode_i32c__csr_access__custom__mimpid),
        .idecode__csr_access__custom__marchid(            decexecrfw_idecode_i32c__csr_access__custom__marchid),
        .idecode__csr_access__custom__mvendorid(            decexecrfw_idecode_i32c__csr_access__custom__mvendorid),
        .idecode__csr_access__custom__misa(            decexecrfw_idecode_i32c__csr_access__custom__misa),
        .idecode__csr_access__custom__mhartid(            decexecrfw_idecode_i32c__csr_access__custom__mhartid),
        .idecode__csr_access__access(            decexecrfw_idecode_i32c__csr_access__access),
        .idecode__csr_access__access_cancelled(            decexecrfw_idecode_i32c__csr_access__access_cancelled),
        .idecode__csr_access__mode(            decexecrfw_idecode_i32c__csr_access__mode),
        .idecode__rd_written(            decexecrfw_idecode_i32c__rd_written),
        .idecode__rd(            decexecrfw_idecode_i32c__rd),
        .idecode__rs2_valid(            decexecrfw_idecode_i32c__rs2_valid),
        .idecode__rs2(            decexecrfw_idecode_i32c__rs2),
        .idecode__rs1_valid(            decexecrfw_idecode_i32c__rs1_valid),
        .idecode__rs1(            decexecrfw_idecode_i32c__rs1)         );
    riscv_i32_alu alu(
        .rs2(decexecrfw_combs__rs2),
        .rs1(decexecrfw_combs__rs1),
        .pc(decexecrfw_state__pc),
        .idecode__ext__dummy(decexecrfw_combs__idecode__ext__dummy),
        .idecode__is_compressed(decexecrfw_combs__idecode__is_compressed),
        .idecode__illegal(decexecrfw_combs__idecode__illegal),
        .idecode__funct7(decexecrfw_combs__idecode__funct7),
        .idecode__shift_op(decexecrfw_combs__idecode__shift_op),
        .idecode__subop(decexecrfw_combs__idecode__subop),
        .idecode__op(decexecrfw_combs__idecode__op),
        .idecode__immediate_valid(decexecrfw_combs__idecode__immediate_valid),
        .idecode__immediate_shift(decexecrfw_combs__idecode__immediate_shift),
        .idecode__immediate(decexecrfw_combs__idecode__immediate),
        .idecode__csr_access__write_data(decexecrfw_combs__idecode__csr_access__write_data),
        .idecode__csr_access__select(decexecrfw_combs__idecode__csr_access__select),
        .idecode__csr_access__address(decexecrfw_combs__idecode__csr_access__address),
        .idecode__csr_access__custom__mimpid(decexecrfw_combs__idecode__csr_access__custom__mimpid),
        .idecode__csr_access__custom__marchid(decexecrfw_combs__idecode__csr_access__custom__marchid),
        .idecode__csr_access__custom__mvendorid(decexecrfw_combs__idecode__csr_access__custom__mvendorid),
        .idecode__csr_access__custom__misa(decexecrfw_combs__idecode__csr_access__custom__misa),
        .idecode__csr_access__custom__mhartid(decexecrfw_combs__idecode__csr_access__custom__mhartid),
        .idecode__csr_access__access(decexecrfw_combs__idecode__csr_access__access),
        .idecode__csr_access__access_cancelled(decexecrfw_combs__idecode__csr_access__access_cancelled),
        .idecode__csr_access__mode(decexecrfw_combs__idecode__csr_access__mode),
        .idecode__rd_written(decexecrfw_combs__idecode__rd_written),
        .idecode__rd(decexecrfw_combs__idecode__rd),
        .idecode__rs2_valid(decexecrfw_combs__idecode__rs2_valid),
        .idecode__rs2(decexecrfw_combs__idecode__rs2),
        .idecode__rs1_valid(decexecrfw_combs__idecode__rs1_valid),
        .idecode__rs1(decexecrfw_combs__idecode__rs1),
        .alu_result__csr_access__write_data(            decexecrfw_alu_result__csr_access__write_data),
        .alu_result__csr_access__select(            decexecrfw_alu_result__csr_access__select),
        .alu_result__csr_access__address(            decexecrfw_alu_result__csr_access__address),
        .alu_result__csr_access__custom__mimpid(            decexecrfw_alu_result__csr_access__custom__mimpid),
        .alu_result__csr_access__custom__marchid(            decexecrfw_alu_result__csr_access__custom__marchid),
        .alu_result__csr_access__custom__mvendorid(            decexecrfw_alu_result__csr_access__custom__mvendorid),
        .alu_result__csr_access__custom__misa(            decexecrfw_alu_result__csr_access__custom__misa),
        .alu_result__csr_access__custom__mhartid(            decexecrfw_alu_result__csr_access__custom__mhartid),
        .alu_result__csr_access__access(            decexecrfw_alu_result__csr_access__access),
        .alu_result__csr_access__access_cancelled(            decexecrfw_alu_result__csr_access__access_cancelled),
        .alu_result__csr_access__mode(            decexecrfw_alu_result__csr_access__mode),
        .alu_result__branch_target(            decexecrfw_alu_result__branch_target),
        .alu_result__branch_condition_met(            decexecrfw_alu_result__branch_condition_met),
        .alu_result__arith_result(            decexecrfw_alu_result__arith_result),
        .alu_result__result(            decexecrfw_alu_result__result)         );
    riscv_i32_dmem_request dmem_req(
        .dmem_exec__first_cycle(decexecrfw_combs__dmem_exec__first_cycle),
        .dmem_exec__rs2(decexecrfw_combs__dmem_exec__rs2),
        .dmem_exec__arith_result(decexecrfw_combs__dmem_exec__arith_result),
        .dmem_exec__idecode__ext__dummy(decexecrfw_combs__dmem_exec__idecode__ext__dummy),
        .dmem_exec__idecode__is_compressed(decexecrfw_combs__dmem_exec__idecode__is_compressed),
        .dmem_exec__idecode__illegal(decexecrfw_combs__dmem_exec__idecode__illegal),
        .dmem_exec__idecode__funct7(decexecrfw_combs__dmem_exec__idecode__funct7),
        .dmem_exec__idecode__shift_op(decexecrfw_combs__dmem_exec__idecode__shift_op),
        .dmem_exec__idecode__subop(decexecrfw_combs__dmem_exec__idecode__subop),
        .dmem_exec__idecode__op(decexecrfw_combs__dmem_exec__idecode__op),
        .dmem_exec__idecode__immediate_valid(decexecrfw_combs__dmem_exec__idecode__immediate_valid),
        .dmem_exec__idecode__immediate_shift(decexecrfw_combs__dmem_exec__idecode__immediate_shift),
        .dmem_exec__idecode__immediate(decexecrfw_combs__dmem_exec__idecode__immediate),
        .dmem_exec__idecode__csr_access__write_data(decexecrfw_combs__dmem_exec__idecode__csr_access__write_data),
        .dmem_exec__idecode__csr_access__select(decexecrfw_combs__dmem_exec__idecode__csr_access__select),
        .dmem_exec__idecode__csr_access__address(decexecrfw_combs__dmem_exec__idecode__csr_access__address),
        .dmem_exec__idecode__csr_access__custom__mimpid(decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mimpid),
        .dmem_exec__idecode__csr_access__custom__marchid(decexecrfw_combs__dmem_exec__idecode__csr_access__custom__marchid),
        .dmem_exec__idecode__csr_access__custom__mvendorid(decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mvendorid),
        .dmem_exec__idecode__csr_access__custom__misa(decexecrfw_combs__dmem_exec__idecode__csr_access__custom__misa),
        .dmem_exec__idecode__csr_access__custom__mhartid(decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mhartid),
        .dmem_exec__idecode__csr_access__access(decexecrfw_combs__dmem_exec__idecode__csr_access__access),
        .dmem_exec__idecode__csr_access__access_cancelled(decexecrfw_combs__dmem_exec__idecode__csr_access__access_cancelled),
        .dmem_exec__idecode__csr_access__mode(decexecrfw_combs__dmem_exec__idecode__csr_access__mode),
        .dmem_exec__idecode__rd_written(decexecrfw_combs__dmem_exec__idecode__rd_written),
        .dmem_exec__idecode__rd(decexecrfw_combs__dmem_exec__idecode__rd),
        .dmem_exec__idecode__rs2_valid(decexecrfw_combs__dmem_exec__idecode__rs2_valid),
        .dmem_exec__idecode__rs2(decexecrfw_combs__dmem_exec__idecode__rs2),
        .dmem_exec__idecode__rs1_valid(decexecrfw_combs__dmem_exec__idecode__rs1_valid),
        .dmem_exec__idecode__rs1(decexecrfw_combs__dmem_exec__idecode__rs1),
        .dmem_exec__mode(decexecrfw_combs__dmem_exec__mode),
        .dmem_exec__valid(decexecrfw_combs__dmem_exec__valid),
        .dmem_request__multicycle(            decexecrfw_dmem_request__multicycle),
        .dmem_request__sign_extend_half(            decexecrfw_dmem_request__sign_extend_half),
        .dmem_request__sign_extend_byte(            decexecrfw_dmem_request__sign_extend_byte),
        .dmem_request__read_data_byte_enable(            decexecrfw_dmem_request__read_data_byte_enable),
        .dmem_request__read_data_byte_clear(            decexecrfw_dmem_request__read_data_byte_clear),
        .dmem_request__read_data_rotation(            decexecrfw_dmem_request__read_data_rotation),
        .dmem_request__reading(            decexecrfw_dmem_request__reading),
        .dmem_request__store_address_misaligned(            decexecrfw_dmem_request__store_address_misaligned),
        .dmem_request__load_address_misaligned(            decexecrfw_dmem_request__load_address_misaligned),
        .dmem_request__access__write_data(            decexecrfw_dmem_request__access__write_data),
        .dmem_request__access__byte_enable(            decexecrfw_dmem_request__access__byte_enable),
        .dmem_request__access__sequential(            decexecrfw_dmem_request__access__sequential),
        .dmem_request__access__address(            decexecrfw_dmem_request__access__address),
        .dmem_request__access__req_type(            decexecrfw_dmem_request__access__req_type),
        .dmem_request__access__mode(            decexecrfw_dmem_request__access__mode),
        .dmem_request__access__valid(            decexecrfw_dmem_request__access__valid)         );
    riscv_i32_dmem_read_data dmem_data(
        .dmem_access_resp__read_data(dmem_access_resp__read_data),
        .dmem_access_resp__access_complete(dmem_access_resp__access_complete),
        .dmem_access_resp__may_still_abort(dmem_access_resp__may_still_abort),
        .dmem_access_resp__abort_req(dmem_access_resp__abort_req),
        .dmem_access_resp__ack(dmem_access_resp__ack),
        .dmem_access_resp__ack_if_seq(dmem_access_resp__ack_if_seq),
        .last_data(32'h0),
        .dmem_request__multicycle(decexecrfw_dmem_request__multicycle),
        .dmem_request__sign_extend_half(decexecrfw_dmem_request__sign_extend_half),
        .dmem_request__sign_extend_byte(decexecrfw_dmem_request__sign_extend_byte),
        .dmem_request__read_data_byte_enable(decexecrfw_dmem_request__read_data_byte_enable),
        .dmem_request__read_data_byte_clear(decexecrfw_dmem_request__read_data_byte_clear),
        .dmem_request__read_data_rotation(decexecrfw_dmem_request__read_data_rotation),
        .dmem_request__reading(decexecrfw_dmem_request__reading),
        .dmem_request__store_address_misaligned(decexecrfw_dmem_request__store_address_misaligned),
        .dmem_request__load_address_misaligned(decexecrfw_dmem_request__load_address_misaligned),
        .dmem_request__access__write_data(decexecrfw_dmem_request__access__write_data),
        .dmem_request__access__byte_enable(decexecrfw_dmem_request__access__byte_enable),
        .dmem_request__access__sequential(decexecrfw_dmem_request__access__sequential),
        .dmem_request__access__address(decexecrfw_dmem_request__access__address),
        .dmem_request__access__req_type(decexecrfw_dmem_request__access__req_type),
        .dmem_request__access__mode(decexecrfw_dmem_request__access__mode),
        .dmem_request__access__valid(decexecrfw_dmem_request__access__valid),
        .dmem_read_data(            decexecrfw_dmem_read_data)         );
    //b decode_rfr_execute_stage__comb combinatorial process
        //   
        //       The decode/RFR/execute stage performs all of the hard workin the
        //       implementation.
        //   
        //       It first incorporates a program counter (PC) and an instruction
        //       register (IR). The instruction in the IR corresponds to that
        //       PC. Initially (at reset) the IR will not be valid, as an
        //       instruction must first be fetched, so there is a corresponding
        //       valid bit too.
        //   
        //       The IR is decoded as both a RV32C (16-bit) and RV32 (32-bit) in
        //       parallel; the bottom two bits of the instruction register indicate
        //       which is valid for the IR.
        //   
        //       
    always @ ( * )//decode_rfr_execute_stage__comb
    begin: decode_rfr_execute_stage__comb_code
    reg [4:0]decexecrfw_combs__idecode__rs1__var;
    reg decexecrfw_combs__idecode__rs1_valid__var;
    reg [4:0]decexecrfw_combs__idecode__rs2__var;
    reg decexecrfw_combs__idecode__rs2_valid__var;
    reg [4:0]decexecrfw_combs__idecode__rd__var;
    reg decexecrfw_combs__idecode__rd_written__var;
    reg [2:0]decexecrfw_combs__idecode__csr_access__mode__var;
    reg decexecrfw_combs__idecode__csr_access__access_cancelled__var;
    reg [2:0]decexecrfw_combs__idecode__csr_access__access__var;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__mhartid__var;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__misa__var;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__mvendorid__var;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__marchid__var;
    reg [31:0]decexecrfw_combs__idecode__csr_access__custom__mimpid__var;
    reg [11:0]decexecrfw_combs__idecode__csr_access__address__var;
    reg [11:0]decexecrfw_combs__idecode__csr_access__select__var;
    reg [31:0]decexecrfw_combs__idecode__csr_access__write_data__var;
    reg [31:0]decexecrfw_combs__idecode__immediate__var;
    reg [4:0]decexecrfw_combs__idecode__immediate_shift__var;
    reg decexecrfw_combs__idecode__immediate_valid__var;
    reg [3:0]decexecrfw_combs__idecode__op__var;
    reg [3:0]decexecrfw_combs__idecode__subop__var;
    reg [3:0]decexecrfw_combs__idecode__shift_op__var;
    reg [6:0]decexecrfw_combs__idecode__funct7__var;
    reg decexecrfw_combs__idecode__illegal__var;
    reg decexecrfw_combs__idecode__is_compressed__var;
    reg decexecrfw_combs__idecode__ext__dummy__var;
    reg decexecrfw_combs__exec_committed__var;
    reg [31:0]decexecrfw_combs__rfw_write_data__var;
        decexecrfw_combs__idecode__rs1__var = decexecrfw_idecode_i32__rs1;
        decexecrfw_combs__idecode__rs1_valid__var = decexecrfw_idecode_i32__rs1_valid;
        decexecrfw_combs__idecode__rs2__var = decexecrfw_idecode_i32__rs2;
        decexecrfw_combs__idecode__rs2_valid__var = decexecrfw_idecode_i32__rs2_valid;
        decexecrfw_combs__idecode__rd__var = decexecrfw_idecode_i32__rd;
        decexecrfw_combs__idecode__rd_written__var = decexecrfw_idecode_i32__rd_written;
        decexecrfw_combs__idecode__csr_access__mode__var = decexecrfw_idecode_i32__csr_access__mode;
        decexecrfw_combs__idecode__csr_access__access_cancelled__var = decexecrfw_idecode_i32__csr_access__access_cancelled;
        decexecrfw_combs__idecode__csr_access__access__var = decexecrfw_idecode_i32__csr_access__access;
        decexecrfw_combs__idecode__csr_access__custom__mhartid__var = decexecrfw_idecode_i32__csr_access__custom__mhartid;
        decexecrfw_combs__idecode__csr_access__custom__misa__var = decexecrfw_idecode_i32__csr_access__custom__misa;
        decexecrfw_combs__idecode__csr_access__custom__mvendorid__var = decexecrfw_idecode_i32__csr_access__custom__mvendorid;
        decexecrfw_combs__idecode__csr_access__custom__marchid__var = decexecrfw_idecode_i32__csr_access__custom__marchid;
        decexecrfw_combs__idecode__csr_access__custom__mimpid__var = decexecrfw_idecode_i32__csr_access__custom__mimpid;
        decexecrfw_combs__idecode__csr_access__address__var = decexecrfw_idecode_i32__csr_access__address;
        decexecrfw_combs__idecode__csr_access__select__var = decexecrfw_idecode_i32__csr_access__select;
        decexecrfw_combs__idecode__csr_access__write_data__var = decexecrfw_idecode_i32__csr_access__write_data;
        decexecrfw_combs__idecode__immediate__var = decexecrfw_idecode_i32__immediate;
        decexecrfw_combs__idecode__immediate_shift__var = decexecrfw_idecode_i32__immediate_shift;
        decexecrfw_combs__idecode__immediate_valid__var = decexecrfw_idecode_i32__immediate_valid;
        decexecrfw_combs__idecode__op__var = decexecrfw_idecode_i32__op;
        decexecrfw_combs__idecode__subop__var = decexecrfw_idecode_i32__subop;
        decexecrfw_combs__idecode__shift_op__var = decexecrfw_idecode_i32__shift_op;
        decexecrfw_combs__idecode__funct7__var = decexecrfw_idecode_i32__funct7;
        decexecrfw_combs__idecode__illegal__var = decexecrfw_idecode_i32__illegal;
        decexecrfw_combs__idecode__is_compressed__var = decexecrfw_idecode_i32__is_compressed;
        decexecrfw_combs__idecode__ext__dummy__var = decexecrfw_idecode_i32__ext__dummy;
        if ((1'h1&&(riscv_config__i32c!=1'h0)))
        begin
            if ((((1'h0!=64'h0)||!(riscv_config__debug_enable!=1'h0))||!(decexecrfw_state__instruction__debug__valid!=1'h0)))
            begin
                if ((decexecrfw_state__instruction__data[1:0]!=2'h3))
                begin
                    decexecrfw_combs__idecode__rs1__var = decexecrfw_idecode_i32c__rs1;
                    decexecrfw_combs__idecode__rs1_valid__var = decexecrfw_idecode_i32c__rs1_valid;
                    decexecrfw_combs__idecode__rs2__var = decexecrfw_idecode_i32c__rs2;
                    decexecrfw_combs__idecode__rs2_valid__var = decexecrfw_idecode_i32c__rs2_valid;
                    decexecrfw_combs__idecode__rd__var = decexecrfw_idecode_i32c__rd;
                    decexecrfw_combs__idecode__rd_written__var = decexecrfw_idecode_i32c__rd_written;
                    decexecrfw_combs__idecode__csr_access__mode__var = decexecrfw_idecode_i32c__csr_access__mode;
                    decexecrfw_combs__idecode__csr_access__access_cancelled__var = decexecrfw_idecode_i32c__csr_access__access_cancelled;
                    decexecrfw_combs__idecode__csr_access__access__var = decexecrfw_idecode_i32c__csr_access__access;
                    decexecrfw_combs__idecode__csr_access__custom__mhartid__var = decexecrfw_idecode_i32c__csr_access__custom__mhartid;
                    decexecrfw_combs__idecode__csr_access__custom__misa__var = decexecrfw_idecode_i32c__csr_access__custom__misa;
                    decexecrfw_combs__idecode__csr_access__custom__mvendorid__var = decexecrfw_idecode_i32c__csr_access__custom__mvendorid;
                    decexecrfw_combs__idecode__csr_access__custom__marchid__var = decexecrfw_idecode_i32c__csr_access__custom__marchid;
                    decexecrfw_combs__idecode__csr_access__custom__mimpid__var = decexecrfw_idecode_i32c__csr_access__custom__mimpid;
                    decexecrfw_combs__idecode__csr_access__address__var = decexecrfw_idecode_i32c__csr_access__address;
                    decexecrfw_combs__idecode__csr_access__select__var = decexecrfw_idecode_i32c__csr_access__select;
                    decexecrfw_combs__idecode__csr_access__write_data__var = decexecrfw_idecode_i32c__csr_access__write_data;
                    decexecrfw_combs__idecode__immediate__var = decexecrfw_idecode_i32c__immediate;
                    decexecrfw_combs__idecode__immediate_shift__var = decexecrfw_idecode_i32c__immediate_shift;
                    decexecrfw_combs__idecode__immediate_valid__var = decexecrfw_idecode_i32c__immediate_valid;
                    decexecrfw_combs__idecode__op__var = decexecrfw_idecode_i32c__op;
                    decexecrfw_combs__idecode__subop__var = decexecrfw_idecode_i32c__subop;
                    decexecrfw_combs__idecode__shift_op__var = decexecrfw_idecode_i32c__shift_op;
                    decexecrfw_combs__idecode__funct7__var = decexecrfw_idecode_i32c__funct7;
                    decexecrfw_combs__idecode__illegal__var = decexecrfw_idecode_i32c__illegal;
                    decexecrfw_combs__idecode__is_compressed__var = decexecrfw_idecode_i32c__is_compressed;
                    decexecrfw_combs__idecode__ext__dummy__var = decexecrfw_idecode_i32c__ext__dummy;
                end //if
            end //if
        end //if
        decexecrfw_combs__exec_committed__var = decexecrfw_state__valid;
        if ((decexecrfw_combs__idecode__illegal__var!=1'h0))
        begin
            decexecrfw_combs__exec_committed__var = 1'h0;
        end //if
        decexecrfw_combs__rs1 = registers[decexecrfw_combs__idecode__rs1__var];
        decexecrfw_combs__rs2 = registers[decexecrfw_combs__idecode__rs2__var];
        decexecrfw_combs__dmem_exec__valid = decexecrfw_state__valid;
        decexecrfw_combs__dmem_exec__idecode__rs1 = decexecrfw_combs__idecode__rs1__var;
        decexecrfw_combs__dmem_exec__idecode__rs1_valid = decexecrfw_combs__idecode__rs1_valid__var;
        decexecrfw_combs__dmem_exec__idecode__rs2 = decexecrfw_combs__idecode__rs2__var;
        decexecrfw_combs__dmem_exec__idecode__rs2_valid = decexecrfw_combs__idecode__rs2_valid__var;
        decexecrfw_combs__dmem_exec__idecode__rd = decexecrfw_combs__idecode__rd__var;
        decexecrfw_combs__dmem_exec__idecode__rd_written = decexecrfw_combs__idecode__rd_written__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__mode = decexecrfw_combs__idecode__csr_access__mode__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__access_cancelled = decexecrfw_combs__idecode__csr_access__access_cancelled__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__access = decexecrfw_combs__idecode__csr_access__access__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mhartid = decexecrfw_combs__idecode__csr_access__custom__mhartid__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__custom__misa = decexecrfw_combs__idecode__csr_access__custom__misa__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mvendorid = decexecrfw_combs__idecode__csr_access__custom__mvendorid__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__custom__marchid = decexecrfw_combs__idecode__csr_access__custom__marchid__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__custom__mimpid = decexecrfw_combs__idecode__csr_access__custom__mimpid__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__address = decexecrfw_combs__idecode__csr_access__address__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__select = decexecrfw_combs__idecode__csr_access__select__var;
        decexecrfw_combs__dmem_exec__idecode__csr_access__write_data = decexecrfw_combs__idecode__csr_access__write_data__var;
        decexecrfw_combs__dmem_exec__idecode__immediate = decexecrfw_combs__idecode__immediate__var;
        decexecrfw_combs__dmem_exec__idecode__immediate_shift = decexecrfw_combs__idecode__immediate_shift__var;
        decexecrfw_combs__dmem_exec__idecode__immediate_valid = decexecrfw_combs__idecode__immediate_valid__var;
        decexecrfw_combs__dmem_exec__idecode__op = decexecrfw_combs__idecode__op__var;
        decexecrfw_combs__dmem_exec__idecode__subop = decexecrfw_combs__idecode__subop__var;
        decexecrfw_combs__dmem_exec__idecode__shift_op = decexecrfw_combs__idecode__shift_op__var;
        decexecrfw_combs__dmem_exec__idecode__funct7 = decexecrfw_combs__idecode__funct7__var;
        decexecrfw_combs__dmem_exec__idecode__illegal = decexecrfw_combs__idecode__illegal__var;
        decexecrfw_combs__dmem_exec__idecode__is_compressed = decexecrfw_combs__idecode__is_compressed__var;
        decexecrfw_combs__dmem_exec__idecode__ext__dummy = decexecrfw_combs__idecode__ext__dummy__var;
        decexecrfw_combs__dmem_exec__arith_result = decexecrfw_alu_result__arith_result;
        decexecrfw_combs__dmem_exec__rs2 = decexecrfw_combs__rs2;
        decexecrfw_combs__dmem_exec__first_cycle = 1'h1;
        decexecrfw_combs__dmem_exec__mode = decexecrfw_state__mode;
        pipeline_response__decode__valid = decexecrfw_state__valid;
        pipeline_response__decode__pc = decexecrfw_state__pc;
        pipeline_response__decode__idecode__rs1 = decexecrfw_combs__idecode__rs1__var;
        pipeline_response__decode__idecode__rs1_valid = decexecrfw_combs__idecode__rs1_valid__var;
        pipeline_response__decode__idecode__rs2 = decexecrfw_combs__idecode__rs2__var;
        pipeline_response__decode__idecode__rs2_valid = decexecrfw_combs__idecode__rs2_valid__var;
        pipeline_response__decode__idecode__rd = decexecrfw_combs__idecode__rd__var;
        pipeline_response__decode__idecode__rd_written = decexecrfw_combs__idecode__rd_written__var;
        pipeline_response__decode__idecode__csr_access__mode = decexecrfw_combs__idecode__csr_access__mode__var;
        pipeline_response__decode__idecode__csr_access__access_cancelled = decexecrfw_combs__idecode__csr_access__access_cancelled__var;
        pipeline_response__decode__idecode__csr_access__access = decexecrfw_combs__idecode__csr_access__access__var;
        pipeline_response__decode__idecode__csr_access__custom__mhartid = decexecrfw_combs__idecode__csr_access__custom__mhartid__var;
        pipeline_response__decode__idecode__csr_access__custom__misa = decexecrfw_combs__idecode__csr_access__custom__misa__var;
        pipeline_response__decode__idecode__csr_access__custom__mvendorid = decexecrfw_combs__idecode__csr_access__custom__mvendorid__var;
        pipeline_response__decode__idecode__csr_access__custom__marchid = decexecrfw_combs__idecode__csr_access__custom__marchid__var;
        pipeline_response__decode__idecode__csr_access__custom__mimpid = decexecrfw_combs__idecode__csr_access__custom__mimpid__var;
        pipeline_response__decode__idecode__csr_access__address = decexecrfw_combs__idecode__csr_access__address__var;
        pipeline_response__decode__idecode__csr_access__select = decexecrfw_combs__idecode__csr_access__select__var;
        pipeline_response__decode__idecode__csr_access__write_data = decexecrfw_combs__idecode__csr_access__write_data__var;
        pipeline_response__decode__idecode__immediate = decexecrfw_combs__idecode__immediate__var;
        pipeline_response__decode__idecode__immediate_shift = decexecrfw_combs__idecode__immediate_shift__var;
        pipeline_response__decode__idecode__immediate_valid = decexecrfw_combs__idecode__immediate_valid__var;
        pipeline_response__decode__idecode__op = decexecrfw_combs__idecode__op__var;
        pipeline_response__decode__idecode__subop = decexecrfw_combs__idecode__subop__var;
        pipeline_response__decode__idecode__shift_op = decexecrfw_combs__idecode__shift_op__var;
        pipeline_response__decode__idecode__funct7 = decexecrfw_combs__idecode__funct7__var;
        pipeline_response__decode__idecode__illegal = decexecrfw_combs__idecode__illegal__var;
        pipeline_response__decode__idecode__is_compressed = decexecrfw_combs__idecode__is_compressed__var;
        pipeline_response__decode__idecode__ext__dummy = decexecrfw_combs__idecode__ext__dummy__var;
        pipeline_response__decode__branch_target = 32'h0;
        pipeline_response__decode__enable_branch_prediction = 1'h0;
        pipeline_response__exec__valid = decexecrfw_state__valid;
        pipeline_response__exec__first_cycle = 1'h1;
        pipeline_response__exec__last_cycle = 1'h1;
        pipeline_response__exec__interrupt_block = 1'h0;
        pipeline_response__exec__idecode__rs1 = decexecrfw_combs__idecode__rs1__var;
        pipeline_response__exec__idecode__rs1_valid = decexecrfw_combs__idecode__rs1_valid__var;
        pipeline_response__exec__idecode__rs2 = decexecrfw_combs__idecode__rs2__var;
        pipeline_response__exec__idecode__rs2_valid = decexecrfw_combs__idecode__rs2_valid__var;
        pipeline_response__exec__idecode__rd = decexecrfw_combs__idecode__rd__var;
        pipeline_response__exec__idecode__rd_written = decexecrfw_combs__idecode__rd_written__var;
        pipeline_response__exec__idecode__csr_access__mode = decexecrfw_combs__idecode__csr_access__mode__var;
        pipeline_response__exec__idecode__csr_access__access_cancelled = decexecrfw_combs__idecode__csr_access__access_cancelled__var;
        pipeline_response__exec__idecode__csr_access__access = decexecrfw_combs__idecode__csr_access__access__var;
        pipeline_response__exec__idecode__csr_access__custom__mhartid = decexecrfw_combs__idecode__csr_access__custom__mhartid__var;
        pipeline_response__exec__idecode__csr_access__custom__misa = decexecrfw_combs__idecode__csr_access__custom__misa__var;
        pipeline_response__exec__idecode__csr_access__custom__mvendorid = decexecrfw_combs__idecode__csr_access__custom__mvendorid__var;
        pipeline_response__exec__idecode__csr_access__custom__marchid = decexecrfw_combs__idecode__csr_access__custom__marchid__var;
        pipeline_response__exec__idecode__csr_access__custom__mimpid = decexecrfw_combs__idecode__csr_access__custom__mimpid__var;
        pipeline_response__exec__idecode__csr_access__address = decexecrfw_combs__idecode__csr_access__address__var;
        pipeline_response__exec__idecode__csr_access__select = decexecrfw_combs__idecode__csr_access__select__var;
        pipeline_response__exec__idecode__csr_access__write_data = decexecrfw_combs__idecode__csr_access__write_data__var;
        pipeline_response__exec__idecode__immediate = decexecrfw_combs__idecode__immediate__var;
        pipeline_response__exec__idecode__immediate_shift = decexecrfw_combs__idecode__immediate_shift__var;
        pipeline_response__exec__idecode__immediate_valid = decexecrfw_combs__idecode__immediate_valid__var;
        pipeline_response__exec__idecode__op = decexecrfw_combs__idecode__op__var;
        pipeline_response__exec__idecode__subop = decexecrfw_combs__idecode__subop__var;
        pipeline_response__exec__idecode__shift_op = decexecrfw_combs__idecode__shift_op__var;
        pipeline_response__exec__idecode__funct7 = decexecrfw_combs__idecode__funct7__var;
        pipeline_response__exec__idecode__illegal = decexecrfw_combs__idecode__illegal__var;
        pipeline_response__exec__idecode__is_compressed = decexecrfw_combs__idecode__is_compressed__var;
        pipeline_response__exec__idecode__ext__dummy = decexecrfw_combs__idecode__ext__dummy__var;
        pipeline_response__exec__pc = decexecrfw_state__pc;
        pipeline_response__exec__pc_if_mispredicted = decexecrfw_alu_result__branch_target;
        pipeline_response__exec__instruction__mode = decexecrfw_state__instruction__mode;
        pipeline_response__exec__instruction__data = decexecrfw_state__instruction__data;
        pipeline_response__exec__instruction__debug__valid = decexecrfw_state__instruction__debug__valid;
        pipeline_response__exec__instruction__debug__debug_op = decexecrfw_state__instruction__debug__debug_op;
        pipeline_response__exec__instruction__debug__data = decexecrfw_state__instruction__debug__data;
        pipeline_response__exec__predicted_branch = 1'h0;
        pipeline_response__exec__rs1 = decexecrfw_combs__rs1;
        pipeline_response__exec__rs2 = decexecrfw_combs__rs2;
        pipeline_response__exec__dmem_access_req__valid = decexecrfw_dmem_request__access__valid;
        pipeline_response__exec__dmem_access_req__mode = decexecrfw_dmem_request__access__mode;
        pipeline_response__exec__dmem_access_req__req_type = decexecrfw_dmem_request__access__req_type;
        pipeline_response__exec__dmem_access_req__address = decexecrfw_dmem_request__access__address;
        pipeline_response__exec__dmem_access_req__sequential = decexecrfw_dmem_request__access__sequential;
        pipeline_response__exec__dmem_access_req__byte_enable = decexecrfw_dmem_request__access__byte_enable;
        pipeline_response__exec__dmem_access_req__write_data = decexecrfw_dmem_request__access__write_data;
        pipeline_response__exec__csr_access__mode = decexecrfw_alu_result__csr_access__mode;
        pipeline_response__exec__csr_access__access_cancelled = decexecrfw_alu_result__csr_access__access_cancelled;
        pipeline_response__exec__csr_access__access = decexecrfw_alu_result__csr_access__access;
        pipeline_response__exec__csr_access__custom__mhartid = decexecrfw_alu_result__csr_access__custom__mhartid;
        pipeline_response__exec__csr_access__custom__misa = decexecrfw_alu_result__csr_access__custom__misa;
        pipeline_response__exec__csr_access__custom__mvendorid = decexecrfw_alu_result__csr_access__custom__mvendorid;
        pipeline_response__exec__csr_access__custom__marchid = decexecrfw_alu_result__csr_access__custom__marchid;
        pipeline_response__exec__csr_access__custom__mimpid = decexecrfw_alu_result__csr_access__custom__mimpid;
        pipeline_response__exec__csr_access__address = decexecrfw_alu_result__csr_access__address;
        pipeline_response__exec__csr_access__select = decexecrfw_alu_result__csr_access__select;
        pipeline_response__exec__csr_access__write_data = decexecrfw_alu_result__csr_access__write_data;
        pipeline_response__exec__cannot_start = 1'h0;
        pipeline_response__exec__branch_condition_met = decexecrfw_alu_result__branch_condition_met;
        pipeline_response__mem__valid = decexecrfw_state__valid;
        pipeline_response__mem__pc = decexecrfw_state__pc;
        pipeline_response__mem__addr = decexecrfw_dmem_request__access__address;
        pipeline_response__mem__access_in_progress = ((decexecrfw_state__valid!=1'h0)&&(decexecrfw_dmem_request__access__valid!=1'h0));
        pipeline_response__rfw__valid = rfw_state__valid;
        pipeline_response__rfw__rd_written = rfw_state__rd_written;
        pipeline_response__rfw__rd = rfw_state__rd;
        pipeline_response__rfw__data = rfw_state__data;
        pipeline_response__pipeline_empty = !(decexecrfw_state__valid!=1'h0);
        decexecrfw_combs__rfw_write_data__var = (decexecrfw_alu_result__result | coproc_response__result);
        if (((1'h0!=64'h0)||(riscv_config__coproc_disable!=1'h0)))
        begin
            decexecrfw_combs__rfw_write_data__var = decexecrfw_alu_result__result;
        end //if
        if ((decexecrfw_dmem_request__reading!=1'h0))
        begin
            decexecrfw_combs__rfw_write_data__var = decexecrfw_dmem_read_data;
        end //if
        if ((decexecrfw_combs__idecode__csr_access__access__var!=3'h0))
        begin
            decexecrfw_combs__rfw_write_data__var = csr_read_data;
        end //if
        decexecrfw_combs__idecode__rs1 = decexecrfw_combs__idecode__rs1__var;
        decexecrfw_combs__idecode__rs1_valid = decexecrfw_combs__idecode__rs1_valid__var;
        decexecrfw_combs__idecode__rs2 = decexecrfw_combs__idecode__rs2__var;
        decexecrfw_combs__idecode__rs2_valid = decexecrfw_combs__idecode__rs2_valid__var;
        decexecrfw_combs__idecode__rd = decexecrfw_combs__idecode__rd__var;
        decexecrfw_combs__idecode__rd_written = decexecrfw_combs__idecode__rd_written__var;
        decexecrfw_combs__idecode__csr_access__mode = decexecrfw_combs__idecode__csr_access__mode__var;
        decexecrfw_combs__idecode__csr_access__access_cancelled = decexecrfw_combs__idecode__csr_access__access_cancelled__var;
        decexecrfw_combs__idecode__csr_access__access = decexecrfw_combs__idecode__csr_access__access__var;
        decexecrfw_combs__idecode__csr_access__custom__mhartid = decexecrfw_combs__idecode__csr_access__custom__mhartid__var;
        decexecrfw_combs__idecode__csr_access__custom__misa = decexecrfw_combs__idecode__csr_access__custom__misa__var;
        decexecrfw_combs__idecode__csr_access__custom__mvendorid = decexecrfw_combs__idecode__csr_access__custom__mvendorid__var;
        decexecrfw_combs__idecode__csr_access__custom__marchid = decexecrfw_combs__idecode__csr_access__custom__marchid__var;
        decexecrfw_combs__idecode__csr_access__custom__mimpid = decexecrfw_combs__idecode__csr_access__custom__mimpid__var;
        decexecrfw_combs__idecode__csr_access__address = decexecrfw_combs__idecode__csr_access__address__var;
        decexecrfw_combs__idecode__csr_access__select = decexecrfw_combs__idecode__csr_access__select__var;
        decexecrfw_combs__idecode__csr_access__write_data = decexecrfw_combs__idecode__csr_access__write_data__var;
        decexecrfw_combs__idecode__immediate = decexecrfw_combs__idecode__immediate__var;
        decexecrfw_combs__idecode__immediate_shift = decexecrfw_combs__idecode__immediate_shift__var;
        decexecrfw_combs__idecode__immediate_valid = decexecrfw_combs__idecode__immediate_valid__var;
        decexecrfw_combs__idecode__op = decexecrfw_combs__idecode__op__var;
        decexecrfw_combs__idecode__subop = decexecrfw_combs__idecode__subop__var;
        decexecrfw_combs__idecode__shift_op = decexecrfw_combs__idecode__shift_op__var;
        decexecrfw_combs__idecode__funct7 = decexecrfw_combs__idecode__funct7__var;
        decexecrfw_combs__idecode__illegal = decexecrfw_combs__idecode__illegal__var;
        decexecrfw_combs__idecode__is_compressed = decexecrfw_combs__idecode__is_compressed__var;
        decexecrfw_combs__idecode__ext__dummy = decexecrfw_combs__idecode__ext__dummy__var;
        decexecrfw_combs__exec_committed = decexecrfw_combs__exec_committed__var;
        decexecrfw_combs__rfw_write_data = decexecrfw_combs__rfw_write_data__var;
    end //always

    //b decode_rfr_execute_stage__posedge_clk_active_low_reset_n clock process
        //   
        //       The decode/RFR/execute stage performs all of the hard workin the
        //       implementation.
        //   
        //       It first incorporates a program counter (PC) and an instruction
        //       register (IR). The instruction in the IR corresponds to that
        //       PC. Initially (at reset) the IR will not be valid, as an
        //       instruction must first be fetched, so there is a corresponding
        //       valid bit too.
        //   
        //       The IR is decoded as both a RV32C (16-bit) and RV32 (32-bit) in
        //       parallel; the bottom two bits of the instruction register indicate
        //       which is valid for the IR.
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : decode_rfr_execute_stage__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            decexecrfw_state__valid <= 1'h0;
            decexecrfw_state__mode <= 3'h0;
            decexecrfw_state__pc <= 32'h0;
            decexecrfw_state__instruction__mode <= 3'h0;
            decexecrfw_state__instruction__data <= 32'h0;
            decexecrfw_state__instruction__debug__valid <= 1'h0;
            decexecrfw_state__instruction__debug__debug_op <= 2'h0;
            decexecrfw_state__instruction__debug__data <= 16'h0;
            registers[0] <= 32'h0;
            registers[1] <= 32'h0;
            registers[2] <= 32'h0;
            registers[3] <= 32'h0;
            registers[4] <= 32'h0;
            registers[5] <= 32'h0;
            registers[6] <= 32'h0;
            registers[7] <= 32'h0;
            registers[8] <= 32'h0;
            registers[9] <= 32'h0;
            registers[10] <= 32'h0;
            registers[11] <= 32'h0;
            registers[12] <= 32'h0;
            registers[13] <= 32'h0;
            registers[14] <= 32'h0;
            registers[15] <= 32'h0;
            registers[16] <= 32'h0;
            registers[17] <= 32'h0;
            registers[18] <= 32'h0;
            registers[19] <= 32'h0;
            registers[20] <= 32'h0;
            registers[21] <= 32'h0;
            registers[22] <= 32'h0;
            registers[23] <= 32'h0;
            registers[24] <= 32'h0;
            registers[25] <= 32'h0;
            registers[26] <= 32'h0;
            registers[27] <= 32'h0;
            registers[28] <= 32'h0;
            registers[29] <= 32'h0;
            registers[30] <= 32'h0;
            registers[31] <= 32'h0;
            rfw_state__valid <= 1'h0;
            rfw_state__rd_written <= 1'h0;
            rfw_state__rd <= 5'h0;
            rfw_state__data <= 32'h0;
        end
        else if (clk__enable)
        begin
            decexecrfw_state__valid <= 1'h0;
            if (((pipeline_fetch_data__valid!=1'h0)&&!(pipeline_control__flush__fetch!=1'h0)))
            begin
                decexecrfw_state__mode <= pipeline_fetch_data__mode;
                decexecrfw_state__pc <= pipeline_fetch_data__pc;
                decexecrfw_state__instruction__mode <= pipeline_fetch_data__instruction__mode;
                decexecrfw_state__instruction__data <= pipeline_fetch_data__instruction__data;
                decexecrfw_state__instruction__debug__valid <= pipeline_fetch_data__instruction__debug__valid;
                decexecrfw_state__instruction__debug__debug_op <= pipeline_fetch_data__instruction__debug__debug_op;
                decexecrfw_state__instruction__debug__data <= pipeline_fetch_data__instruction__debug__data;
                if (((1'h0!=64'h0)||!(riscv_config__debug_enable!=1'h0)))
                begin
                    decexecrfw_state__instruction__debug__valid <= 1'h0;
                    decexecrfw_state__instruction__debug__debug_op <= 2'h0;
                    decexecrfw_state__instruction__debug__data <= 16'h0;
                end //if
                decexecrfw_state__valid <= 1'h1;
            end //if
            if ((((decexecrfw_combs__exec_committed!=1'h0)&&(decexecrfw_combs__idecode__rd_written!=1'h0))&&!(pipeline_control__flush__exec!=1'h0)))
            begin
                registers[decexecrfw_combs__idecode__rd] <= decexecrfw_combs__rfw_write_data;
            end //if
            registers[0] <= 32'h0;
            rfw_state__valid <= ((decexecrfw_combs__exec_committed!=1'h0)&&!(pipeline_control__flush__exec!=1'h0));
            rfw_state__rd_written <= ((decexecrfw_combs__exec_committed!=1'h0)&&(decexecrfw_combs__idecode__rd_written!=1'h0));
            rfw_state__rd <= decexecrfw_combs__idecode__rd;
            rfw_state__data <= decexecrfw_combs__rfw_write_data;
        end //if
    end //always

endmodule // riscv_i32c_pipeline
