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

//a Module riscv_i32c_pipeline3
    //   
    //   This is just the processor pipeline, using thress stages for execution.
    //   
    //   The decode and RFR is performed in the first stage
    //   
    //   The ALU execution (and coprocessor execution) is performed in the second stage
    //   
    //   Memory operations are performed in the third stage
    //   
    //   Register file is written at the end of the third stage; there is a RFW stage to
    //   forward data from RFW back to execution.
    //   
    //   Instruction fetch
    //   -----------------
    //   
    //   The instruction fetch request for the next cycle is put out just after
    //   the ALU stage logic, which may be a long time into the cycle
    //   (althought the design keeps this to a minimum); the fetch data
    //   response presents the instruction fetched at the end of the cycle,
    //   where it is registered for execution.
    //   
    //   The instruction fetch response must then be valid combinatorially
    //   based on the instruction fetch request.
    //   
    //   Data memory access
    //   ------------------
    //   
    //   The data memory request is presented in the ALU stage, for an access
    //   to complete during the memory stage.
    //   
    //   To support simple synchronous memory operation the data memory access
    //   includes valid write data in the same cycle as the request.
    //   
    //   The data memory response is valid one cycle later than a request. This
    //   includes a wait signal. The external memory subsystem, therefore, is a
    //   two stage pipeline. The wait signal controls whether an access
    //   completes, but not if an access can be taken (except indirectly).
    //   
    //   Hence external logic must always either register a request or
    //   guarantee not to assert wait.
    //   
    //   An example implementation of could be
    //       dmem_access_resp.wait = fn ( access_in_progress );
    //       access_can_be_taken = (!access_in_progress.valid) || (!dmem_access_resp.wait);
    //       if (access_can_be_taken) {
    //         access_in_progress <= dmem_access_req;
    //       }
    //   }
    //   
    //   
module riscv_i32c_pipeline3
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
    csr_read_data,
    coproc_response__cannot_start,
    coproc_response__result,
    coproc_response__result_valid,
    coproc_response__cannot_complete,
    pipeline_fetch_data__valid,
    pipeline_fetch_data__pc,
    pipeline_fetch_data__instruction__data,
    pipeline_fetch_data__instruction__debug__valid,
    pipeline_fetch_data__instruction__debug__debug_op,
    pipeline_fetch_data__instruction__debug__data,
    pipeline_fetch_data__dec_flush_pipeline,
    pipeline_fetch_data__dec_predicted_branch,
    pipeline_fetch_data__dec_pc_if_mispredicted,
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
    dmem_access_resp__ack_if_seq,
    dmem_access_resp__ack,
    dmem_access_resp__abort_req,
    dmem_access_resp__read_data_valid,
    dmem_access_resp__read_data,
    reset_n,

    csr_access__access_cancelled,
    csr_access__access,
    csr_access__address,
    csr_access__write_data,
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
    dmem_access_req__valid,
    dmem_access_req__req_type,
    dmem_access_req__address,
    dmem_access_req__sequential,
    dmem_access_req__byte_enable,
    dmem_access_req__write_data
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
    input [31:0]csr_read_data;
    input coproc_response__cannot_start;
    input [31:0]coproc_response__result;
    input coproc_response__result_valid;
    input coproc_response__cannot_complete;
    input pipeline_fetch_data__valid;
    input [31:0]pipeline_fetch_data__pc;
    input [31:0]pipeline_fetch_data__instruction__data;
    input pipeline_fetch_data__instruction__debug__valid;
    input [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    input [15:0]pipeline_fetch_data__instruction__debug__data;
    input pipeline_fetch_data__dec_flush_pipeline;
    input pipeline_fetch_data__dec_predicted_branch;
    input [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;
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
    input dmem_access_resp__ack_if_seq;
    input dmem_access_resp__ack;
    input dmem_access_resp__abort_req;
    input dmem_access_resp__read_data_valid;
    input [31:0]dmem_access_resp__read_data;
    input reset_n;

    //b Outputs
    output csr_access__access_cancelled;
    output [2:0]csr_access__access;
    output [11:0]csr_access__address;
    output [31:0]csr_access__write_data;
    output pipeline_response__decode__valid;
    output pipeline_response__decode__blocked;
    output [31:0]pipeline_response__decode__pc;
    output [31:0]pipeline_response__decode__branch_target;
    output [4:0]pipeline_response__decode__idecode__rs1;
    output pipeline_response__decode__idecode__rs1_valid;
    output [4:0]pipeline_response__decode__idecode__rs2;
    output pipeline_response__decode__idecode__rs2_valid;
    output [4:0]pipeline_response__decode__idecode__rd;
    output pipeline_response__decode__idecode__rd_written;
    output pipeline_response__decode__idecode__csr_access__access_cancelled;
    output [2:0]pipeline_response__decode__idecode__csr_access__access;
    output [11:0]pipeline_response__decode__idecode__csr_access__address;
    output [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    output [31:0]pipeline_response__decode__idecode__immediate;
    output [4:0]pipeline_response__decode__idecode__immediate_shift;
    output pipeline_response__decode__idecode__immediate_valid;
    output [3:0]pipeline_response__decode__idecode__op;
    output [3:0]pipeline_response__decode__idecode__subop;
    output [6:0]pipeline_response__decode__idecode__funct7;
    output [2:0]pipeline_response__decode__idecode__minimum_mode;
    output pipeline_response__decode__idecode__illegal;
    output pipeline_response__decode__idecode__illegal_pc;
    output pipeline_response__decode__idecode__is_compressed;
    output pipeline_response__decode__idecode__ext__dummy;
    output pipeline_response__decode__enable_branch_prediction;
    output pipeline_response__exec__valid;
    output pipeline_response__exec__cannot_start;
    output pipeline_response__exec__cannot_complete;
    output pipeline_response__exec__interrupt_ack;
    output pipeline_response__exec__branch_taken;
    output pipeline_response__exec__jalr;
    output pipeline_response__exec__trap__valid;
    output [2:0]pipeline_response__exec__trap__to_mode;
    output [3:0]pipeline_response__exec__trap__cause;
    output [31:0]pipeline_response__exec__trap__pc;
    output [31:0]pipeline_response__exec__trap__value;
    output pipeline_response__exec__trap__ret;
    output pipeline_response__exec__trap__vector;
    output pipeline_response__exec__trap__ebreak_to_dbg;
    output pipeline_response__exec__is_compressed;
    output [31:0]pipeline_response__exec__instruction__data;
    output pipeline_response__exec__instruction__debug__valid;
    output [1:0]pipeline_response__exec__instruction__debug__debug_op;
    output [15:0]pipeline_response__exec__instruction__debug__data;
    output [31:0]pipeline_response__exec__rs1;
    output [31:0]pipeline_response__exec__rs2;
    output [31:0]pipeline_response__exec__pc;
    output pipeline_response__exec__predicted_branch;
    output [31:0]pipeline_response__exec__pc_if_mispredicted;
    output pipeline_response__rfw__valid;
    output pipeline_response__rfw__rd_written;
    output [4:0]pipeline_response__rfw__rd;
    output [31:0]pipeline_response__rfw__data;
    output pipeline_response__pipeline_empty;
    output dmem_access_req__valid;
    output [4:0]dmem_access_req__req_type;
    output [31:0]dmem_access_req__address;
    output dmem_access_req__sequential;
    output [3:0]dmem_access_req__byte_enable;
    output [31:0]dmem_access_req__write_data;

// output components here

    //b Output combinatorials
    reg csr_access__access_cancelled;
    reg [2:0]csr_access__access;
    reg [11:0]csr_access__address;
    reg [31:0]csr_access__write_data;
    reg pipeline_response__decode__valid;
    reg pipeline_response__decode__blocked;
    reg [31:0]pipeline_response__decode__pc;
    reg [31:0]pipeline_response__decode__branch_target;
    reg [4:0]pipeline_response__decode__idecode__rs1;
    reg pipeline_response__decode__idecode__rs1_valid;
    reg [4:0]pipeline_response__decode__idecode__rs2;
    reg pipeline_response__decode__idecode__rs2_valid;
    reg [4:0]pipeline_response__decode__idecode__rd;
    reg pipeline_response__decode__idecode__rd_written;
    reg pipeline_response__decode__idecode__csr_access__access_cancelled;
    reg [2:0]pipeline_response__decode__idecode__csr_access__access;
    reg [11:0]pipeline_response__decode__idecode__csr_access__address;
    reg [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    reg [31:0]pipeline_response__decode__idecode__immediate;
    reg [4:0]pipeline_response__decode__idecode__immediate_shift;
    reg pipeline_response__decode__idecode__immediate_valid;
    reg [3:0]pipeline_response__decode__idecode__op;
    reg [3:0]pipeline_response__decode__idecode__subop;
    reg [6:0]pipeline_response__decode__idecode__funct7;
    reg [2:0]pipeline_response__decode__idecode__minimum_mode;
    reg pipeline_response__decode__idecode__illegal;
    reg pipeline_response__decode__idecode__illegal_pc;
    reg pipeline_response__decode__idecode__is_compressed;
    reg pipeline_response__decode__idecode__ext__dummy;
    reg pipeline_response__decode__enable_branch_prediction;
    reg pipeline_response__exec__valid;
    reg pipeline_response__exec__cannot_start;
    reg pipeline_response__exec__cannot_complete;
    reg pipeline_response__exec__interrupt_ack;
    reg pipeline_response__exec__branch_taken;
    reg pipeline_response__exec__jalr;
    reg pipeline_response__exec__trap__valid;
    reg [2:0]pipeline_response__exec__trap__to_mode;
    reg [3:0]pipeline_response__exec__trap__cause;
    reg [31:0]pipeline_response__exec__trap__pc;
    reg [31:0]pipeline_response__exec__trap__value;
    reg pipeline_response__exec__trap__ret;
    reg pipeline_response__exec__trap__vector;
    reg pipeline_response__exec__trap__ebreak_to_dbg;
    reg pipeline_response__exec__is_compressed;
    reg [31:0]pipeline_response__exec__instruction__data;
    reg pipeline_response__exec__instruction__debug__valid;
    reg [1:0]pipeline_response__exec__instruction__debug__debug_op;
    reg [15:0]pipeline_response__exec__instruction__debug__data;
    reg [31:0]pipeline_response__exec__rs1;
    reg [31:0]pipeline_response__exec__rs2;
    reg [31:0]pipeline_response__exec__pc;
    reg pipeline_response__exec__predicted_branch;
    reg [31:0]pipeline_response__exec__pc_if_mispredicted;
    reg pipeline_response__rfw__valid;
    reg pipeline_response__rfw__rd_written;
    reg [4:0]pipeline_response__rfw__rd;
    reg [31:0]pipeline_response__rfw__data;
    reg pipeline_response__pipeline_empty;
    reg dmem_access_req__valid;
    reg [4:0]dmem_access_req__req_type;
    reg [31:0]dmem_access_req__address;
    reg dmem_access_req__sequential;
    reg [3:0]dmem_access_req__byte_enable;
    reg [31:0]dmem_access_req__write_data;

    //b Output nets

    //b Internal and output registers
    reg rfw_state__valid;
    reg [31:0]rfw_state__mem_result;
    reg rfw_state__rd_written;
    reg [4:0]rfw_state__rd;
    reg mem_state__valid;
    reg [31:0]mem_state__alu_result;
    reg mem_state__rd_written;
    reg mem_state__rd_from_mem;
    reg [4:0]mem_state__rd;
    reg mem_state__dmem_request__access__valid;
    reg [4:0]mem_state__dmem_request__access__req_type;
    reg [31:0]mem_state__dmem_request__access__address;
    reg mem_state__dmem_request__access__sequential;
    reg [3:0]mem_state__dmem_request__access__byte_enable;
    reg [31:0]mem_state__dmem_request__access__write_data;
    reg mem_state__dmem_request__load_address_misaligned;
    reg mem_state__dmem_request__store_address_misaligned;
    reg mem_state__dmem_request__reading;
    reg [1:0]mem_state__dmem_request__read_data_rotation;
    reg [3:0]mem_state__dmem_request__read_data_byte_clear;
    reg [3:0]mem_state__dmem_request__read_data_byte_enable;
    reg mem_state__dmem_request__sign_extend_byte;
    reg mem_state__dmem_request__sign_extend_half;
    reg mem_state__dmem_request__multicycle;
    reg alu_state__valid;
    reg alu_state__first_cycle;
    reg [4:0]alu_state__idecode__rs1;
    reg alu_state__idecode__rs1_valid;
    reg [4:0]alu_state__idecode__rs2;
    reg alu_state__idecode__rs2_valid;
    reg [4:0]alu_state__idecode__rd;
    reg alu_state__idecode__rd_written;
    reg alu_state__idecode__csr_access__access_cancelled;
    reg [2:0]alu_state__idecode__csr_access__access;
    reg [11:0]alu_state__idecode__csr_access__address;
    reg [31:0]alu_state__idecode__csr_access__write_data;
    reg [31:0]alu_state__idecode__immediate;
    reg [4:0]alu_state__idecode__immediate_shift;
    reg alu_state__idecode__immediate_valid;
    reg [3:0]alu_state__idecode__op;
    reg [3:0]alu_state__idecode__subop;
    reg [6:0]alu_state__idecode__funct7;
    reg [2:0]alu_state__idecode__minimum_mode;
    reg alu_state__idecode__illegal;
    reg alu_state__idecode__illegal_pc;
    reg alu_state__idecode__is_compressed;
    reg alu_state__idecode__ext__dummy;
    reg [31:0]alu_state__pc;
    reg [31:0]alu_state__pc_if_mispredicted;
    reg alu_state__predicted_branch;
    reg alu_state__rs1_from_alu;
    reg alu_state__rs1_from_mem;
    reg alu_state__rs2_from_alu;
    reg alu_state__rs2_from_mem;
    reg [31:0]alu_state__rs1;
    reg [31:0]alu_state__rs2;
    reg [31:0]alu_state__instruction__data;
    reg alu_state__instruction__debug__valid;
    reg [1:0]alu_state__instruction__debug__debug_op;
    reg [15:0]alu_state__instruction__debug__data;
    reg [31:0]dec_state__pc;
    reg [31:0]dec_state__instruction__data;
    reg dec_state__instruction__debug__valid;
    reg [1:0]dec_state__instruction__debug__debug_op;
    reg [15:0]dec_state__instruction__debug__data;
    reg dec_state__valid;
        //   Register 0 is tied to 0 - so it is written on every cycle to zero...
    reg [31:0]registers[31:0];

    //b Internal combinatorials
        //   Coprocessor response masked out if configured off
    reg coproc_response_cfg__cannot_start;
    reg [31:0]coproc_response_cfg__result;
    reg coproc_response_cfg__result_valid;
    reg coproc_response_cfg__cannot_complete;
    reg [31:0]mem_combs__result_data;
    reg alu_combs__valid_legal;
    reg alu_combs__blocked_by_mem;
    reg alu_combs__cannot_start;
    reg alu_combs__cannot_complete;
    reg [31:0]alu_combs__rs1;
    reg [31:0]alu_combs__rs2;
    reg [4:0]alu_combs__dmem_exec__idecode__rs1;
    reg alu_combs__dmem_exec__idecode__rs1_valid;
    reg [4:0]alu_combs__dmem_exec__idecode__rs2;
    reg alu_combs__dmem_exec__idecode__rs2_valid;
    reg [4:0]alu_combs__dmem_exec__idecode__rd;
    reg alu_combs__dmem_exec__idecode__rd_written;
    reg alu_combs__dmem_exec__idecode__csr_access__access_cancelled;
    reg [2:0]alu_combs__dmem_exec__idecode__csr_access__access;
    reg [11:0]alu_combs__dmem_exec__idecode__csr_access__address;
    reg [31:0]alu_combs__dmem_exec__idecode__csr_access__write_data;
    reg [31:0]alu_combs__dmem_exec__idecode__immediate;
    reg [4:0]alu_combs__dmem_exec__idecode__immediate_shift;
    reg alu_combs__dmem_exec__idecode__immediate_valid;
    reg [3:0]alu_combs__dmem_exec__idecode__op;
    reg [3:0]alu_combs__dmem_exec__idecode__subop;
    reg [6:0]alu_combs__dmem_exec__idecode__funct7;
    reg [2:0]alu_combs__dmem_exec__idecode__minimum_mode;
    reg alu_combs__dmem_exec__idecode__illegal;
    reg alu_combs__dmem_exec__idecode__illegal_pc;
    reg alu_combs__dmem_exec__idecode__is_compressed;
    reg alu_combs__dmem_exec__idecode__ext__dummy;
    reg [31:0]alu_combs__dmem_exec__arith_result;
    reg [31:0]alu_combs__dmem_exec__rs2;
    reg alu_combs__dmem_exec__exec_committed;
    reg alu_combs__dmem_exec__first_cycle;
    reg alu_combs__csr_access__access_cancelled;
    reg [2:0]alu_combs__csr_access__access;
    reg [11:0]alu_combs__csr_access__address;
    reg [31:0]alu_combs__csr_access__write_data;
    reg [31:0]alu_combs__result_data;
    reg alu_combs__control_data__interrupt_ack;
    reg alu_combs__control_data__valid;
    reg alu_combs__control_data__exec_committed;
    reg alu_combs__control_data__first_cycle;
    reg [4:0]alu_combs__control_data__idecode__rs1;
    reg alu_combs__control_data__idecode__rs1_valid;
    reg [4:0]alu_combs__control_data__idecode__rs2;
    reg alu_combs__control_data__idecode__rs2_valid;
    reg [4:0]alu_combs__control_data__idecode__rd;
    reg alu_combs__control_data__idecode__rd_written;
    reg alu_combs__control_data__idecode__csr_access__access_cancelled;
    reg [2:0]alu_combs__control_data__idecode__csr_access__access;
    reg [11:0]alu_combs__control_data__idecode__csr_access__address;
    reg [31:0]alu_combs__control_data__idecode__csr_access__write_data;
    reg [31:0]alu_combs__control_data__idecode__immediate;
    reg [4:0]alu_combs__control_data__idecode__immediate_shift;
    reg alu_combs__control_data__idecode__immediate_valid;
    reg [3:0]alu_combs__control_data__idecode__op;
    reg [3:0]alu_combs__control_data__idecode__subop;
    reg [6:0]alu_combs__control_data__idecode__funct7;
    reg [2:0]alu_combs__control_data__idecode__minimum_mode;
    reg alu_combs__control_data__idecode__illegal;
    reg alu_combs__control_data__idecode__illegal_pc;
    reg alu_combs__control_data__idecode__is_compressed;
    reg alu_combs__control_data__idecode__ext__dummy;
    reg [31:0]alu_combs__control_data__pc;
    reg [31:0]alu_combs__control_data__instruction_data;
    reg [31:0]alu_combs__control_data__alu_result__result;
    reg [31:0]alu_combs__control_data__alu_result__arith_result;
    reg alu_combs__control_data__alu_result__branch_condition_met;
    reg [31:0]alu_combs__control_data__alu_result__branch_target;
    reg alu_combs__control_data__alu_result__csr_access__access_cancelled;
    reg [2:0]alu_combs__control_data__alu_result__csr_access__access;
    reg [11:0]alu_combs__control_data__alu_result__csr_access__address;
    reg [31:0]alu_combs__control_data__alu_result__csr_access__write_data;
    reg [4:0]dec_combs__idecode__rs1;
    reg dec_combs__idecode__rs1_valid;
    reg [4:0]dec_combs__idecode__rs2;
    reg dec_combs__idecode__rs2_valid;
    reg [4:0]dec_combs__idecode__rd;
    reg dec_combs__idecode__rd_written;
    reg dec_combs__idecode__csr_access__access_cancelled;
    reg [2:0]dec_combs__idecode__csr_access__access;
    reg [11:0]dec_combs__idecode__csr_access__address;
    reg [31:0]dec_combs__idecode__csr_access__write_data;
    reg [31:0]dec_combs__idecode__immediate;
    reg [4:0]dec_combs__idecode__immediate_shift;
    reg dec_combs__idecode__immediate_valid;
    reg [3:0]dec_combs__idecode__op;
    reg [3:0]dec_combs__idecode__subop;
    reg [6:0]dec_combs__idecode__funct7;
    reg [2:0]dec_combs__idecode__minimum_mode;
    reg dec_combs__idecode__illegal;
    reg dec_combs__idecode__illegal_pc;
    reg dec_combs__idecode__is_compressed;
    reg dec_combs__idecode__ext__dummy;
    reg [31:0]dec_combs__rs1;
    reg [31:0]dec_combs__rs2;
    reg dec_combs__rs1_from_alu;
    reg dec_combs__rs1_from_mem;
    reg dec_combs__rs2_from_alu;
    reg dec_combs__rs2_from_mem;

    //b Internal nets
    wire [31:0]mem_combs_dmem_read_data;
        //   Data memory request data
    wire alu_combs_dmem_request__access__valid;
    wire [4:0]alu_combs_dmem_request__access__req_type;
    wire [31:0]alu_combs_dmem_request__access__address;
    wire alu_combs_dmem_request__access__sequential;
    wire [3:0]alu_combs_dmem_request__access__byte_enable;
    wire [31:0]alu_combs_dmem_request__access__write_data;
    wire alu_combs_dmem_request__load_address_misaligned;
    wire alu_combs_dmem_request__store_address_misaligned;
    wire alu_combs_dmem_request__reading;
    wire [1:0]alu_combs_dmem_request__read_data_rotation;
    wire [3:0]alu_combs_dmem_request__read_data_byte_clear;
    wire [3:0]alu_combs_dmem_request__read_data_byte_enable;
    wire alu_combs_dmem_request__sign_extend_byte;
    wire alu_combs_dmem_request__sign_extend_half;
    wire alu_combs_dmem_request__multicycle;
    wire alu_control_flow__async_cancel;
    wire alu_control_flow__branch_taken;
    wire alu_control_flow__jalr;
    wire [31:0]alu_control_flow__next_pc;
    wire alu_control_flow__trap__valid;
    wire [2:0]alu_control_flow__trap__to_mode;
    wire [3:0]alu_control_flow__trap__cause;
    wire [31:0]alu_control_flow__trap__pc;
    wire [31:0]alu_control_flow__trap__value;
    wire alu_control_flow__trap__ret;
    wire alu_control_flow__trap__vector;
    wire alu_control_flow__trap__ebreak_to_dbg;
    wire [31:0]alu_result__result;
    wire [31:0]alu_result__arith_result;
    wire alu_result__branch_condition_met;
    wire [31:0]alu_result__branch_target;
    wire alu_result__csr_access__access_cancelled;
    wire [2:0]alu_result__csr_access__access;
    wire [11:0]alu_result__csr_access__address;
    wire [31:0]alu_result__csr_access__write_data;
    wire [4:0]idecode_debug__rs1;
    wire idecode_debug__rs1_valid;
    wire [4:0]idecode_debug__rs2;
    wire idecode_debug__rs2_valid;
    wire [4:0]idecode_debug__rd;
    wire idecode_debug__rd_written;
    wire idecode_debug__csr_access__access_cancelled;
    wire [2:0]idecode_debug__csr_access__access;
    wire [11:0]idecode_debug__csr_access__address;
    wire [31:0]idecode_debug__csr_access__write_data;
    wire [31:0]idecode_debug__immediate;
    wire [4:0]idecode_debug__immediate_shift;
    wire idecode_debug__immediate_valid;
    wire [3:0]idecode_debug__op;
    wire [3:0]idecode_debug__subop;
    wire [6:0]idecode_debug__funct7;
    wire [2:0]idecode_debug__minimum_mode;
    wire idecode_debug__illegal;
    wire idecode_debug__illegal_pc;
    wire idecode_debug__is_compressed;
    wire idecode_debug__ext__dummy;
    wire [4:0]idecode_i32c__rs1;
    wire idecode_i32c__rs1_valid;
    wire [4:0]idecode_i32c__rs2;
    wire idecode_i32c__rs2_valid;
    wire [4:0]idecode_i32c__rd;
    wire idecode_i32c__rd_written;
    wire idecode_i32c__csr_access__access_cancelled;
    wire [2:0]idecode_i32c__csr_access__access;
    wire [11:0]idecode_i32c__csr_access__address;
    wire [31:0]idecode_i32c__csr_access__write_data;
    wire [31:0]idecode_i32c__immediate;
    wire [4:0]idecode_i32c__immediate_shift;
    wire idecode_i32c__immediate_valid;
    wire [3:0]idecode_i32c__op;
    wire [3:0]idecode_i32c__subop;
    wire [6:0]idecode_i32c__funct7;
    wire [2:0]idecode_i32c__minimum_mode;
    wire idecode_i32c__illegal;
    wire idecode_i32c__illegal_pc;
    wire idecode_i32c__is_compressed;
    wire idecode_i32c__ext__dummy;
    wire [4:0]idecode_i32__rs1;
    wire idecode_i32__rs1_valid;
    wire [4:0]idecode_i32__rs2;
    wire idecode_i32__rs2_valid;
    wire [4:0]idecode_i32__rd;
    wire idecode_i32__rd_written;
    wire idecode_i32__csr_access__access_cancelled;
    wire [2:0]idecode_i32__csr_access__access;
    wire [11:0]idecode_i32__csr_access__address;
    wire [31:0]idecode_i32__csr_access__write_data;
    wire [31:0]idecode_i32__immediate;
    wire [4:0]idecode_i32__immediate_shift;
    wire idecode_i32__immediate_valid;
    wire [3:0]idecode_i32__op;
    wire [3:0]idecode_i32__subop;
    wire [6:0]idecode_i32__funct7;
    wire [2:0]idecode_i32__minimum_mode;
    wire idecode_i32__illegal;
    wire idecode_i32__illegal_pc;
    wire idecode_i32__is_compressed;
    wire idecode_i32__ext__dummy;

    //b Clock gating module instances
    //b Module instances
    riscv_i32_decode decode_i32(
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .instruction__debug__data(dec_state__instruction__debug__data),
        .instruction__debug__debug_op(dec_state__instruction__debug__debug_op),
        .instruction__debug__valid(dec_state__instruction__debug__valid),
        .instruction__data(dec_state__instruction__data),
        .idecode__ext__dummy(            idecode_i32__ext__dummy),
        .idecode__is_compressed(            idecode_i32__is_compressed),
        .idecode__illegal_pc(            idecode_i32__illegal_pc),
        .idecode__illegal(            idecode_i32__illegal),
        .idecode__minimum_mode(            idecode_i32__minimum_mode),
        .idecode__funct7(            idecode_i32__funct7),
        .idecode__subop(            idecode_i32__subop),
        .idecode__op(            idecode_i32__op),
        .idecode__immediate_valid(            idecode_i32__immediate_valid),
        .idecode__immediate_shift(            idecode_i32__immediate_shift),
        .idecode__immediate(            idecode_i32__immediate),
        .idecode__csr_access__write_data(            idecode_i32__csr_access__write_data),
        .idecode__csr_access__address(            idecode_i32__csr_access__address),
        .idecode__csr_access__access(            idecode_i32__csr_access__access),
        .idecode__csr_access__access_cancelled(            idecode_i32__csr_access__access_cancelled),
        .idecode__rd_written(            idecode_i32__rd_written),
        .idecode__rd(            idecode_i32__rd),
        .idecode__rs2_valid(            idecode_i32__rs2_valid),
        .idecode__rs2(            idecode_i32__rs2),
        .idecode__rs1_valid(            idecode_i32__rs1_valid),
        .idecode__rs1(            idecode_i32__rs1)         );
    riscv_i32c_decode decode_i32c(
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .instruction__debug__data(dec_state__instruction__debug__data),
        .instruction__debug__debug_op(dec_state__instruction__debug__debug_op),
        .instruction__debug__valid(dec_state__instruction__debug__valid),
        .instruction__data(dec_state__instruction__data),
        .idecode__ext__dummy(            idecode_i32c__ext__dummy),
        .idecode__is_compressed(            idecode_i32c__is_compressed),
        .idecode__illegal_pc(            idecode_i32c__illegal_pc),
        .idecode__illegal(            idecode_i32c__illegal),
        .idecode__minimum_mode(            idecode_i32c__minimum_mode),
        .idecode__funct7(            idecode_i32c__funct7),
        .idecode__subop(            idecode_i32c__subop),
        .idecode__op(            idecode_i32c__op),
        .idecode__immediate_valid(            idecode_i32c__immediate_valid),
        .idecode__immediate_shift(            idecode_i32c__immediate_shift),
        .idecode__immediate(            idecode_i32c__immediate),
        .idecode__csr_access__write_data(            idecode_i32c__csr_access__write_data),
        .idecode__csr_access__address(            idecode_i32c__csr_access__address),
        .idecode__csr_access__access(            idecode_i32c__csr_access__access),
        .idecode__csr_access__access_cancelled(            idecode_i32c__csr_access__access_cancelled),
        .idecode__rd_written(            idecode_i32c__rd_written),
        .idecode__rd(            idecode_i32c__rd),
        .idecode__rs2_valid(            idecode_i32c__rs2_valid),
        .idecode__rs2(            idecode_i32c__rs2),
        .idecode__rs1_valid(            idecode_i32c__rs1_valid),
        .idecode__rs1(            idecode_i32c__rs1)         );
    riscv_i32_debug_decode decode_i32_debug(
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .instruction__debug__data(dec_state__instruction__debug__data),
        .instruction__debug__debug_op(dec_state__instruction__debug__debug_op),
        .instruction__debug__valid(dec_state__instruction__debug__valid),
        .instruction__data(dec_state__instruction__data),
        .idecode__ext__dummy(            idecode_debug__ext__dummy),
        .idecode__is_compressed(            idecode_debug__is_compressed),
        .idecode__illegal_pc(            idecode_debug__illegal_pc),
        .idecode__illegal(            idecode_debug__illegal),
        .idecode__minimum_mode(            idecode_debug__minimum_mode),
        .idecode__funct7(            idecode_debug__funct7),
        .idecode__subop(            idecode_debug__subop),
        .idecode__op(            idecode_debug__op),
        .idecode__immediate_valid(            idecode_debug__immediate_valid),
        .idecode__immediate_shift(            idecode_debug__immediate_shift),
        .idecode__immediate(            idecode_debug__immediate),
        .idecode__csr_access__write_data(            idecode_debug__csr_access__write_data),
        .idecode__csr_access__address(            idecode_debug__csr_access__address),
        .idecode__csr_access__access(            idecode_debug__csr_access__access),
        .idecode__csr_access__access_cancelled(            idecode_debug__csr_access__access_cancelled),
        .idecode__rd_written(            idecode_debug__rd_written),
        .idecode__rd(            idecode_debug__rd),
        .idecode__rs2_valid(            idecode_debug__rs2_valid),
        .idecode__rs2(            idecode_debug__rs2),
        .idecode__rs1_valid(            idecode_debug__rs1_valid),
        .idecode__rs1(            idecode_debug__rs1)         );
    riscv_i32_alu alu(
        .rs2(alu_combs__rs2),
        .rs1(alu_combs__rs1),
        .pc(alu_state__pc),
        .idecode__ext__dummy(alu_state__idecode__ext__dummy),
        .idecode__is_compressed(alu_state__idecode__is_compressed),
        .idecode__illegal_pc(alu_state__idecode__illegal_pc),
        .idecode__illegal(alu_state__idecode__illegal),
        .idecode__minimum_mode(alu_state__idecode__minimum_mode),
        .idecode__funct7(alu_state__idecode__funct7),
        .idecode__subop(alu_state__idecode__subop),
        .idecode__op(alu_state__idecode__op),
        .idecode__immediate_valid(alu_state__idecode__immediate_valid),
        .idecode__immediate_shift(alu_state__idecode__immediate_shift),
        .idecode__immediate(alu_state__idecode__immediate),
        .idecode__csr_access__write_data(alu_state__idecode__csr_access__write_data),
        .idecode__csr_access__address(alu_state__idecode__csr_access__address),
        .idecode__csr_access__access(alu_state__idecode__csr_access__access),
        .idecode__csr_access__access_cancelled(alu_state__idecode__csr_access__access_cancelled),
        .idecode__rd_written(alu_state__idecode__rd_written),
        .idecode__rd(alu_state__idecode__rd),
        .idecode__rs2_valid(alu_state__idecode__rs2_valid),
        .idecode__rs2(alu_state__idecode__rs2),
        .idecode__rs1_valid(alu_state__idecode__rs1_valid),
        .idecode__rs1(alu_state__idecode__rs1),
        .alu_result__csr_access__write_data(            alu_result__csr_access__write_data),
        .alu_result__csr_access__address(            alu_result__csr_access__address),
        .alu_result__csr_access__access(            alu_result__csr_access__access),
        .alu_result__csr_access__access_cancelled(            alu_result__csr_access__access_cancelled),
        .alu_result__branch_target(            alu_result__branch_target),
        .alu_result__branch_condition_met(            alu_result__branch_condition_met),
        .alu_result__arith_result(            alu_result__arith_result),
        .alu_result__result(            alu_result__result)         );
    riscv_i32_dmem_request dmem_req(
        .dmem_exec__first_cycle(alu_combs__dmem_exec__first_cycle),
        .dmem_exec__exec_committed(alu_combs__dmem_exec__exec_committed),
        .dmem_exec__rs2(alu_combs__dmem_exec__rs2),
        .dmem_exec__arith_result(alu_combs__dmem_exec__arith_result),
        .dmem_exec__idecode__ext__dummy(alu_combs__dmem_exec__idecode__ext__dummy),
        .dmem_exec__idecode__is_compressed(alu_combs__dmem_exec__idecode__is_compressed),
        .dmem_exec__idecode__illegal_pc(alu_combs__dmem_exec__idecode__illegal_pc),
        .dmem_exec__idecode__illegal(alu_combs__dmem_exec__idecode__illegal),
        .dmem_exec__idecode__minimum_mode(alu_combs__dmem_exec__idecode__minimum_mode),
        .dmem_exec__idecode__funct7(alu_combs__dmem_exec__idecode__funct7),
        .dmem_exec__idecode__subop(alu_combs__dmem_exec__idecode__subop),
        .dmem_exec__idecode__op(alu_combs__dmem_exec__idecode__op),
        .dmem_exec__idecode__immediate_valid(alu_combs__dmem_exec__idecode__immediate_valid),
        .dmem_exec__idecode__immediate_shift(alu_combs__dmem_exec__idecode__immediate_shift),
        .dmem_exec__idecode__immediate(alu_combs__dmem_exec__idecode__immediate),
        .dmem_exec__idecode__csr_access__write_data(alu_combs__dmem_exec__idecode__csr_access__write_data),
        .dmem_exec__idecode__csr_access__address(alu_combs__dmem_exec__idecode__csr_access__address),
        .dmem_exec__idecode__csr_access__access(alu_combs__dmem_exec__idecode__csr_access__access),
        .dmem_exec__idecode__csr_access__access_cancelled(alu_combs__dmem_exec__idecode__csr_access__access_cancelled),
        .dmem_exec__idecode__rd_written(alu_combs__dmem_exec__idecode__rd_written),
        .dmem_exec__idecode__rd(alu_combs__dmem_exec__idecode__rd),
        .dmem_exec__idecode__rs2_valid(alu_combs__dmem_exec__idecode__rs2_valid),
        .dmem_exec__idecode__rs2(alu_combs__dmem_exec__idecode__rs2),
        .dmem_exec__idecode__rs1_valid(alu_combs__dmem_exec__idecode__rs1_valid),
        .dmem_exec__idecode__rs1(alu_combs__dmem_exec__idecode__rs1),
        .dmem_request__multicycle(            alu_combs_dmem_request__multicycle),
        .dmem_request__sign_extend_half(            alu_combs_dmem_request__sign_extend_half),
        .dmem_request__sign_extend_byte(            alu_combs_dmem_request__sign_extend_byte),
        .dmem_request__read_data_byte_enable(            alu_combs_dmem_request__read_data_byte_enable),
        .dmem_request__read_data_byte_clear(            alu_combs_dmem_request__read_data_byte_clear),
        .dmem_request__read_data_rotation(            alu_combs_dmem_request__read_data_rotation),
        .dmem_request__reading(            alu_combs_dmem_request__reading),
        .dmem_request__store_address_misaligned(            alu_combs_dmem_request__store_address_misaligned),
        .dmem_request__load_address_misaligned(            alu_combs_dmem_request__load_address_misaligned),
        .dmem_request__access__write_data(            alu_combs_dmem_request__access__write_data),
        .dmem_request__access__byte_enable(            alu_combs_dmem_request__access__byte_enable),
        .dmem_request__access__sequential(            alu_combs_dmem_request__access__sequential),
        .dmem_request__access__address(            alu_combs_dmem_request__access__address),
        .dmem_request__access__req_type(            alu_combs_dmem_request__access__req_type),
        .dmem_request__access__valid(            alu_combs_dmem_request__access__valid)         );
    riscv_i32_control_flow control_flow(
        .control_data__alu_result__csr_access__write_data(alu_combs__control_data__alu_result__csr_access__write_data),
        .control_data__alu_result__csr_access__address(alu_combs__control_data__alu_result__csr_access__address),
        .control_data__alu_result__csr_access__access(alu_combs__control_data__alu_result__csr_access__access),
        .control_data__alu_result__csr_access__access_cancelled(alu_combs__control_data__alu_result__csr_access__access_cancelled),
        .control_data__alu_result__branch_target(alu_combs__control_data__alu_result__branch_target),
        .control_data__alu_result__branch_condition_met(alu_combs__control_data__alu_result__branch_condition_met),
        .control_data__alu_result__arith_result(alu_combs__control_data__alu_result__arith_result),
        .control_data__alu_result__result(alu_combs__control_data__alu_result__result),
        .control_data__instruction_data(alu_combs__control_data__instruction_data),
        .control_data__pc(alu_combs__control_data__pc),
        .control_data__idecode__ext__dummy(alu_combs__control_data__idecode__ext__dummy),
        .control_data__idecode__is_compressed(alu_combs__control_data__idecode__is_compressed),
        .control_data__idecode__illegal_pc(alu_combs__control_data__idecode__illegal_pc),
        .control_data__idecode__illegal(alu_combs__control_data__idecode__illegal),
        .control_data__idecode__minimum_mode(alu_combs__control_data__idecode__minimum_mode),
        .control_data__idecode__funct7(alu_combs__control_data__idecode__funct7),
        .control_data__idecode__subop(alu_combs__control_data__idecode__subop),
        .control_data__idecode__op(alu_combs__control_data__idecode__op),
        .control_data__idecode__immediate_valid(alu_combs__control_data__idecode__immediate_valid),
        .control_data__idecode__immediate_shift(alu_combs__control_data__idecode__immediate_shift),
        .control_data__idecode__immediate(alu_combs__control_data__idecode__immediate),
        .control_data__idecode__csr_access__write_data(alu_combs__control_data__idecode__csr_access__write_data),
        .control_data__idecode__csr_access__address(alu_combs__control_data__idecode__csr_access__address),
        .control_data__idecode__csr_access__access(alu_combs__control_data__idecode__csr_access__access),
        .control_data__idecode__csr_access__access_cancelled(alu_combs__control_data__idecode__csr_access__access_cancelled),
        .control_data__idecode__rd_written(alu_combs__control_data__idecode__rd_written),
        .control_data__idecode__rd(alu_combs__control_data__idecode__rd),
        .control_data__idecode__rs2_valid(alu_combs__control_data__idecode__rs2_valid),
        .control_data__idecode__rs2(alu_combs__control_data__idecode__rs2),
        .control_data__idecode__rs1_valid(alu_combs__control_data__idecode__rs1_valid),
        .control_data__idecode__rs1(alu_combs__control_data__idecode__rs1),
        .control_data__first_cycle(alu_combs__control_data__first_cycle),
        .control_data__exec_committed(alu_combs__control_data__exec_committed),
        .control_data__valid(alu_combs__control_data__valid),
        .control_data__interrupt_ack(alu_combs__control_data__interrupt_ack),
        .pipeline_control__instruction_debug__data(pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(pipeline_control__halt),
        .pipeline_control__tag(pipeline_control__tag),
        .pipeline_control__error(pipeline_control__error),
        .pipeline_control__mode(pipeline_control__mode),
        .pipeline_control__fetch_pc(pipeline_control__fetch_pc),
        .pipeline_control__fetch_action(pipeline_control__fetch_action),
        .pipeline_control__valid(pipeline_control__valid),
        .control_flow__trap__ebreak_to_dbg(            alu_control_flow__trap__ebreak_to_dbg),
        .control_flow__trap__vector(            alu_control_flow__trap__vector),
        .control_flow__trap__ret(            alu_control_flow__trap__ret),
        .control_flow__trap__value(            alu_control_flow__trap__value),
        .control_flow__trap__pc(            alu_control_flow__trap__pc),
        .control_flow__trap__cause(            alu_control_flow__trap__cause),
        .control_flow__trap__to_mode(            alu_control_flow__trap__to_mode),
        .control_flow__trap__valid(            alu_control_flow__trap__valid),
        .control_flow__next_pc(            alu_control_flow__next_pc),
        .control_flow__jalr(            alu_control_flow__jalr),
        .control_flow__branch_taken(            alu_control_flow__branch_taken),
        .control_flow__async_cancel(            alu_control_flow__async_cancel)         );
    riscv_i32_dmem_read_data dmem_data(
        .dmem_access_resp__read_data(dmem_access_resp__read_data),
        .dmem_access_resp__read_data_valid(dmem_access_resp__read_data_valid),
        .dmem_access_resp__abort_req(dmem_access_resp__abort_req),
        .dmem_access_resp__ack(dmem_access_resp__ack),
        .dmem_access_resp__ack_if_seq(dmem_access_resp__ack_if_seq),
        .last_data(mem_state__alu_result),
        .dmem_request__multicycle(mem_state__dmem_request__multicycle),
        .dmem_request__sign_extend_half(mem_state__dmem_request__sign_extend_half),
        .dmem_request__sign_extend_byte(mem_state__dmem_request__sign_extend_byte),
        .dmem_request__read_data_byte_enable(mem_state__dmem_request__read_data_byte_enable),
        .dmem_request__read_data_byte_clear(mem_state__dmem_request__read_data_byte_clear),
        .dmem_request__read_data_rotation(mem_state__dmem_request__read_data_rotation),
        .dmem_request__reading(mem_state__dmem_request__reading),
        .dmem_request__store_address_misaligned(mem_state__dmem_request__store_address_misaligned),
        .dmem_request__load_address_misaligned(mem_state__dmem_request__load_address_misaligned),
        .dmem_request__access__write_data(mem_state__dmem_request__access__write_data),
        .dmem_request__access__byte_enable(mem_state__dmem_request__access__byte_enable),
        .dmem_request__access__sequential(mem_state__dmem_request__access__sequential),
        .dmem_request__access__address(mem_state__dmem_request__access__address),
        .dmem_request__access__req_type(mem_state__dmem_request__access__req_type),
        .dmem_request__access__valid(mem_state__dmem_request__access__valid),
        .dmem_read_data(            mem_combs_dmem_read_data)         );
    //b decode_rfr_stage__comb combinatorial process
        //   
        //       The decode/RFR stage decodes an instruction, follows unconditional
        //       branches and backward conditional branches (to generate the next
        //       PC as far as decode is concerned), determines register forwarding
        //       required, reads the register file.
        //       
    always @ ( * )//decode_rfr_stage__comb
    begin: decode_rfr_stage__comb_code
    reg [4:0]dec_combs__idecode__rs1__var;
    reg dec_combs__idecode__rs1_valid__var;
    reg [4:0]dec_combs__idecode__rs2__var;
    reg dec_combs__idecode__rs2_valid__var;
    reg [4:0]dec_combs__idecode__rd__var;
    reg dec_combs__idecode__rd_written__var;
    reg dec_combs__idecode__csr_access__access_cancelled__var;
    reg [2:0]dec_combs__idecode__csr_access__access__var;
    reg [11:0]dec_combs__idecode__csr_access__address__var;
    reg [31:0]dec_combs__idecode__csr_access__write_data__var;
    reg [31:0]dec_combs__idecode__immediate__var;
    reg [4:0]dec_combs__idecode__immediate_shift__var;
    reg dec_combs__idecode__immediate_valid__var;
    reg [3:0]dec_combs__idecode__op__var;
    reg [3:0]dec_combs__idecode__subop__var;
    reg [6:0]dec_combs__idecode__funct7__var;
    reg [2:0]dec_combs__idecode__minimum_mode__var;
    reg dec_combs__idecode__illegal__var;
    reg dec_combs__idecode__illegal_pc__var;
    reg dec_combs__idecode__is_compressed__var;
    reg dec_combs__idecode__ext__dummy__var;
    reg dec_combs__rs1_from_alu__var;
    reg dec_combs__rs1_from_mem__var;
    reg dec_combs__rs2_from_alu__var;
    reg dec_combs__rs2_from_mem__var;
        pipeline_response__decode__blocked = (((dec_state__valid!=1'h0)&&(alu_state__valid!=1'h0))&&(alu_combs__cannot_complete!=1'h0));
        dec_combs__idecode__rs1__var = idecode_i32__rs1;
        dec_combs__idecode__rs1_valid__var = idecode_i32__rs1_valid;
        dec_combs__idecode__rs2__var = idecode_i32__rs2;
        dec_combs__idecode__rs2_valid__var = idecode_i32__rs2_valid;
        dec_combs__idecode__rd__var = idecode_i32__rd;
        dec_combs__idecode__rd_written__var = idecode_i32__rd_written;
        dec_combs__idecode__csr_access__access_cancelled__var = idecode_i32__csr_access__access_cancelled;
        dec_combs__idecode__csr_access__access__var = idecode_i32__csr_access__access;
        dec_combs__idecode__csr_access__address__var = idecode_i32__csr_access__address;
        dec_combs__idecode__csr_access__write_data__var = idecode_i32__csr_access__write_data;
        dec_combs__idecode__immediate__var = idecode_i32__immediate;
        dec_combs__idecode__immediate_shift__var = idecode_i32__immediate_shift;
        dec_combs__idecode__immediate_valid__var = idecode_i32__immediate_valid;
        dec_combs__idecode__op__var = idecode_i32__op;
        dec_combs__idecode__subop__var = idecode_i32__subop;
        dec_combs__idecode__funct7__var = idecode_i32__funct7;
        dec_combs__idecode__minimum_mode__var = idecode_i32__minimum_mode;
        dec_combs__idecode__illegal__var = idecode_i32__illegal;
        dec_combs__idecode__illegal_pc__var = idecode_i32__illegal_pc;
        dec_combs__idecode__is_compressed__var = idecode_i32__is_compressed;
        dec_combs__idecode__ext__dummy__var = idecode_i32__ext__dummy;
        if ((1'h1&&(riscv_config__i32c!=1'h0)))
        begin
            if ((dec_state__instruction__data[1:0]!=2'h3))
            begin
                dec_combs__idecode__rs1__var = idecode_i32c__rs1;
                dec_combs__idecode__rs1_valid__var = idecode_i32c__rs1_valid;
                dec_combs__idecode__rs2__var = idecode_i32c__rs2;
                dec_combs__idecode__rs2_valid__var = idecode_i32c__rs2_valid;
                dec_combs__idecode__rd__var = idecode_i32c__rd;
                dec_combs__idecode__rd_written__var = idecode_i32c__rd_written;
                dec_combs__idecode__csr_access__access_cancelled__var = idecode_i32c__csr_access__access_cancelled;
                dec_combs__idecode__csr_access__access__var = idecode_i32c__csr_access__access;
                dec_combs__idecode__csr_access__address__var = idecode_i32c__csr_access__address;
                dec_combs__idecode__csr_access__write_data__var = idecode_i32c__csr_access__write_data;
                dec_combs__idecode__immediate__var = idecode_i32c__immediate;
                dec_combs__idecode__immediate_shift__var = idecode_i32c__immediate_shift;
                dec_combs__idecode__immediate_valid__var = idecode_i32c__immediate_valid;
                dec_combs__idecode__op__var = idecode_i32c__op;
                dec_combs__idecode__subop__var = idecode_i32c__subop;
                dec_combs__idecode__funct7__var = idecode_i32c__funct7;
                dec_combs__idecode__minimum_mode__var = idecode_i32c__minimum_mode;
                dec_combs__idecode__illegal__var = idecode_i32c__illegal;
                dec_combs__idecode__illegal_pc__var = idecode_i32c__illegal_pc;
                dec_combs__idecode__is_compressed__var = idecode_i32c__is_compressed;
                dec_combs__idecode__ext__dummy__var = idecode_i32c__ext__dummy;
            end //if
        end //if
        if (((1'h1&&(riscv_config__debug_enable!=1'h0))&&(dec_state__instruction__debug__valid!=1'h0)))
        begin
            dec_combs__idecode__rs1__var = idecode_debug__rs1;
            dec_combs__idecode__rs1_valid__var = idecode_debug__rs1_valid;
            dec_combs__idecode__rs2__var = idecode_debug__rs2;
            dec_combs__idecode__rs2_valid__var = idecode_debug__rs2_valid;
            dec_combs__idecode__rd__var = idecode_debug__rd;
            dec_combs__idecode__rd_written__var = idecode_debug__rd_written;
            dec_combs__idecode__csr_access__access_cancelled__var = idecode_debug__csr_access__access_cancelled;
            dec_combs__idecode__csr_access__access__var = idecode_debug__csr_access__access;
            dec_combs__idecode__csr_access__address__var = idecode_debug__csr_access__address;
            dec_combs__idecode__csr_access__write_data__var = idecode_debug__csr_access__write_data;
            dec_combs__idecode__immediate__var = idecode_debug__immediate;
            dec_combs__idecode__immediate_shift__var = idecode_debug__immediate_shift;
            dec_combs__idecode__immediate_valid__var = idecode_debug__immediate_valid;
            dec_combs__idecode__op__var = idecode_debug__op;
            dec_combs__idecode__subop__var = idecode_debug__subop;
            dec_combs__idecode__funct7__var = idecode_debug__funct7;
            dec_combs__idecode__minimum_mode__var = idecode_debug__minimum_mode;
            dec_combs__idecode__illegal__var = idecode_debug__illegal;
            dec_combs__idecode__illegal_pc__var = idecode_debug__illegal_pc;
            dec_combs__idecode__is_compressed__var = idecode_debug__is_compressed;
            dec_combs__idecode__ext__dummy__var = idecode_debug__ext__dummy;
        end //if
        dec_combs__rs1 = registers[dec_combs__idecode__rs1__var];
        dec_combs__rs2 = registers[dec_combs__idecode__rs2__var];
        pipeline_response__decode__valid = dec_state__valid;
        pipeline_response__decode__pc = dec_state__pc;
        pipeline_response__decode__idecode__rs1 = dec_combs__idecode__rs1__var;
        pipeline_response__decode__idecode__rs1_valid = dec_combs__idecode__rs1_valid__var;
        pipeline_response__decode__idecode__rs2 = dec_combs__idecode__rs2__var;
        pipeline_response__decode__idecode__rs2_valid = dec_combs__idecode__rs2_valid__var;
        pipeline_response__decode__idecode__rd = dec_combs__idecode__rd__var;
        pipeline_response__decode__idecode__rd_written = dec_combs__idecode__rd_written__var;
        pipeline_response__decode__idecode__csr_access__access_cancelled = dec_combs__idecode__csr_access__access_cancelled__var;
        pipeline_response__decode__idecode__csr_access__access = dec_combs__idecode__csr_access__access__var;
        pipeline_response__decode__idecode__csr_access__address = dec_combs__idecode__csr_access__address__var;
        pipeline_response__decode__idecode__csr_access__write_data = dec_combs__idecode__csr_access__write_data__var;
        pipeline_response__decode__idecode__immediate = dec_combs__idecode__immediate__var;
        pipeline_response__decode__idecode__immediate_shift = dec_combs__idecode__immediate_shift__var;
        pipeline_response__decode__idecode__immediate_valid = dec_combs__idecode__immediate_valid__var;
        pipeline_response__decode__idecode__op = dec_combs__idecode__op__var;
        pipeline_response__decode__idecode__subop = dec_combs__idecode__subop__var;
        pipeline_response__decode__idecode__funct7 = dec_combs__idecode__funct7__var;
        pipeline_response__decode__idecode__minimum_mode = dec_combs__idecode__minimum_mode__var;
        pipeline_response__decode__idecode__illegal = dec_combs__idecode__illegal__var;
        pipeline_response__decode__idecode__illegal_pc = dec_combs__idecode__illegal_pc__var;
        pipeline_response__decode__idecode__is_compressed = dec_combs__idecode__is_compressed__var;
        pipeline_response__decode__idecode__ext__dummy = dec_combs__idecode__ext__dummy__var;
        pipeline_response__decode__branch_target = (dec_state__pc+dec_combs__idecode__immediate__var);
        pipeline_response__decode__enable_branch_prediction = 1'h1;
        dec_combs__rs1_from_alu__var = 1'h0;
        dec_combs__rs1_from_mem__var = 1'h0;
        dec_combs__rs2_from_alu__var = 1'h0;
        dec_combs__rs2_from_mem__var = 1'h0;
        if (((mem_state__rd==dec_combs__idecode__rs1__var)&&(mem_state__rd_written!=1'h0)))
        begin
            dec_combs__rs1_from_mem__var = 1'h1;
        end //if
        if (((alu_state__idecode__rd==dec_combs__idecode__rs1__var)&&(alu_state__idecode__rd_written!=1'h0)))
        begin
            dec_combs__rs1_from_alu__var = 1'h1;
        end //if
        if (((mem_state__rd==dec_combs__idecode__rs2__var)&&(mem_state__rd_written!=1'h0)))
        begin
            dec_combs__rs2_from_mem__var = 1'h1;
        end //if
        if (((alu_state__idecode__rd==dec_combs__idecode__rs2__var)&&(alu_state__idecode__rd_written!=1'h0)))
        begin
            dec_combs__rs2_from_alu__var = 1'h1;
        end //if
        dec_combs__idecode__rs1 = dec_combs__idecode__rs1__var;
        dec_combs__idecode__rs1_valid = dec_combs__idecode__rs1_valid__var;
        dec_combs__idecode__rs2 = dec_combs__idecode__rs2__var;
        dec_combs__idecode__rs2_valid = dec_combs__idecode__rs2_valid__var;
        dec_combs__idecode__rd = dec_combs__idecode__rd__var;
        dec_combs__idecode__rd_written = dec_combs__idecode__rd_written__var;
        dec_combs__idecode__csr_access__access_cancelled = dec_combs__idecode__csr_access__access_cancelled__var;
        dec_combs__idecode__csr_access__access = dec_combs__idecode__csr_access__access__var;
        dec_combs__idecode__csr_access__address = dec_combs__idecode__csr_access__address__var;
        dec_combs__idecode__csr_access__write_data = dec_combs__idecode__csr_access__write_data__var;
        dec_combs__idecode__immediate = dec_combs__idecode__immediate__var;
        dec_combs__idecode__immediate_shift = dec_combs__idecode__immediate_shift__var;
        dec_combs__idecode__immediate_valid = dec_combs__idecode__immediate_valid__var;
        dec_combs__idecode__op = dec_combs__idecode__op__var;
        dec_combs__idecode__subop = dec_combs__idecode__subop__var;
        dec_combs__idecode__funct7 = dec_combs__idecode__funct7__var;
        dec_combs__idecode__minimum_mode = dec_combs__idecode__minimum_mode__var;
        dec_combs__idecode__illegal = dec_combs__idecode__illegal__var;
        dec_combs__idecode__illegal_pc = dec_combs__idecode__illegal_pc__var;
        dec_combs__idecode__is_compressed = dec_combs__idecode__is_compressed__var;
        dec_combs__idecode__ext__dummy = dec_combs__idecode__ext__dummy__var;
        dec_combs__rs1_from_alu = dec_combs__rs1_from_alu__var;
        dec_combs__rs1_from_mem = dec_combs__rs1_from_mem__var;
        dec_combs__rs2_from_alu = dec_combs__rs2_from_alu__var;
        dec_combs__rs2_from_mem = dec_combs__rs2_from_mem__var;
    end //always

    //b decode_rfr_stage__posedge_clk_active_low_reset_n clock process
        //   
        //       The decode/RFR stage decodes an instruction, follows unconditional
        //       branches and backward conditional branches (to generate the next
        //       PC as far as decode is concerned), determines register forwarding
        //       required, reads the register file.
        //       
    always @( posedge clk or negedge reset_n)
    begin : decode_rfr_stage__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            dec_state__valid <= 1'h0;
            dec_state__pc <= 32'h0;
            dec_state__instruction__data <= 32'h0;
            dec_state__instruction__debug__valid <= 1'h0;
            dec_state__instruction__debug__debug_op <= 2'h0;
            dec_state__instruction__debug__data <= 16'h0;
        end
        else if (clk__enable)
        begin
            dec_state__valid <= 1'h0;
            if (((pipeline_response__decode__blocked!=1'h0)&&!(pipeline_fetch_data__dec_flush_pipeline!=1'h0)))
            begin
                dec_state__pc <= dec_state__pc;
                dec_state__instruction__data <= dec_state__instruction__data;
                dec_state__instruction__debug__valid <= dec_state__instruction__debug__valid;
                dec_state__instruction__debug__debug_op <= dec_state__instruction__debug__debug_op;
                dec_state__instruction__debug__data <= dec_state__instruction__debug__data;
                dec_state__valid <= dec_state__valid;
            end //if
            else
            
            begin
                if ((pipeline_fetch_data__valid!=1'h0))
                begin
                    dec_state__valid <= 1'h1;
                    dec_state__pc <= pipeline_fetch_data__pc;
                    dec_state__instruction__data <= pipeline_fetch_data__instruction__data;
                    dec_state__instruction__debug__valid <= pipeline_fetch_data__instruction__debug__valid;
                    dec_state__instruction__debug__debug_op <= pipeline_fetch_data__instruction__debug__debug_op;
                    dec_state__instruction__debug__data <= pipeline_fetch_data__instruction__debug__data;
                    if (((1'h0!=64'h0)||!(riscv_config__debug_enable!=1'h0)))
                    begin
                        dec_state__instruction__debug__valid <= 1'h0;
                        dec_state__instruction__debug__debug_op <= 2'h0;
                        dec_state__instruction__debug__data <= 16'h0;
                    end //if
                end //if
            end //else
    //synopsys  translate_off
    //pragma coverage off
            if ( !((!(mem_state__rd_written!=1'h0)||(mem_state__valid!=1'h0))) )
            begin
            $display( "%d ASSERTION FAILED:Mem state rd_written must only be asserted if valid is too",
                $time );
            end //if
    //pragma coverage on
    //synopsys  translate_on
    //synopsys  translate_off
    //pragma coverage off
            if ( !((!(alu_state__idecode__rd_written!=1'h0)||(alu_state__valid!=1'h0))) )
            begin
            $display( "%d ASSERTION FAILED:ALU state rd_written must only be asserted if valid is too",
                $time );
            end //if
    //pragma coverage on
    //synopsys  translate_on
        end //if
    end //always

    //b alu_stage clock process
        //   
        //       The ALU stage does data forwarding, ALU operation, conditional branches, CSR accesses, memory request
        //       
    always @( posedge clk or negedge reset_n)
    begin : alu_stage__code
        if (reset_n==1'b0)
        begin
            alu_state__valid <= 1'h0;
            alu_state__idecode__rd_written <= 1'h0;
            alu_state__first_cycle <= 1'h0;
            alu_state__idecode__rs1 <= 5'h0;
            alu_state__idecode__rs1_valid <= 1'h0;
            alu_state__idecode__rs2 <= 5'h0;
            alu_state__idecode__rs2_valid <= 1'h0;
            alu_state__idecode__rd <= 5'h0;
            alu_state__idecode__csr_access__access_cancelled <= 1'h0;
            alu_state__idecode__csr_access__access <= 3'h0;
            alu_state__idecode__csr_access__address <= 12'h0;
            alu_state__idecode__csr_access__write_data <= 32'h0;
            alu_state__idecode__immediate <= 32'h0;
            alu_state__idecode__immediate_shift <= 5'h0;
            alu_state__idecode__immediate_valid <= 1'h0;
            alu_state__idecode__op <= 4'h0;
            alu_state__idecode__subop <= 4'h0;
            alu_state__idecode__funct7 <= 7'h0;
            alu_state__idecode__minimum_mode <= 3'h0;
            alu_state__idecode__illegal <= 1'h0;
            alu_state__idecode__illegal_pc <= 1'h0;
            alu_state__idecode__is_compressed <= 1'h0;
            alu_state__idecode__ext__dummy <= 1'h0;
            alu_state__pc <= 32'h0;
            alu_state__pc_if_mispredicted <= 32'h0;
            alu_state__predicted_branch <= 1'h0;
            alu_state__rs1_from_alu <= 1'h0;
            alu_state__rs1_from_mem <= 1'h0;
            alu_state__rs2_from_alu <= 1'h0;
            alu_state__rs2_from_mem <= 1'h0;
            alu_state__rs1 <= 32'h0;
            alu_state__rs2 <= 32'h0;
            alu_state__instruction__data <= 32'h0;
            alu_state__instruction__debug__valid <= 1'h0;
            alu_state__instruction__debug__debug_op <= 2'h0;
            alu_state__instruction__debug__data <= 16'h0;
        end
        else if (clk__enable)
        begin
            alu_state__valid <= 1'h0;
            alu_state__idecode__rd_written <= 1'h0;
            if (((alu_combs__cannot_complete!=1'h0)&&!(alu_control_flow__async_cancel!=1'h0)))
            begin
                if (!(alu_combs__cannot_start!=1'h0))
                begin
                    alu_state__first_cycle <= 1'h0;
                end //if
                alu_state__valid <= alu_state__valid;
                alu_state__first_cycle <= alu_state__first_cycle;
                alu_state__idecode__rs1 <= alu_state__idecode__rs1;
                alu_state__idecode__rs1_valid <= alu_state__idecode__rs1_valid;
                alu_state__idecode__rs2 <= alu_state__idecode__rs2;
                alu_state__idecode__rs2_valid <= alu_state__idecode__rs2_valid;
                alu_state__idecode__rd <= alu_state__idecode__rd;
                alu_state__idecode__rd_written <= alu_state__idecode__rd_written;
                alu_state__idecode__csr_access__access_cancelled <= alu_state__idecode__csr_access__access_cancelled;
                alu_state__idecode__csr_access__access <= alu_state__idecode__csr_access__access;
                alu_state__idecode__csr_access__address <= alu_state__idecode__csr_access__address;
                alu_state__idecode__csr_access__write_data <= alu_state__idecode__csr_access__write_data;
                alu_state__idecode__immediate <= alu_state__idecode__immediate;
                alu_state__idecode__immediate_shift <= alu_state__idecode__immediate_shift;
                alu_state__idecode__immediate_valid <= alu_state__idecode__immediate_valid;
                alu_state__idecode__op <= alu_state__idecode__op;
                alu_state__idecode__subop <= alu_state__idecode__subop;
                alu_state__idecode__funct7 <= alu_state__idecode__funct7;
                alu_state__idecode__minimum_mode <= alu_state__idecode__minimum_mode;
                alu_state__idecode__illegal <= alu_state__idecode__illegal;
                alu_state__idecode__illegal_pc <= alu_state__idecode__illegal_pc;
                alu_state__idecode__is_compressed <= alu_state__idecode__is_compressed;
                alu_state__idecode__ext__dummy <= alu_state__idecode__ext__dummy;
                alu_state__pc <= alu_state__pc;
                alu_state__pc_if_mispredicted <= alu_state__pc_if_mispredicted;
                alu_state__predicted_branch <= alu_state__predicted_branch;
                alu_state__rs1_from_alu <= alu_state__rs1_from_alu;
                alu_state__rs1_from_mem <= alu_state__rs1_from_mem;
                alu_state__rs2_from_alu <= alu_state__rs2_from_alu;
                alu_state__rs2_from_mem <= alu_state__rs2_from_mem;
                alu_state__rs1 <= alu_state__rs1;
                alu_state__rs2 <= alu_state__rs2;
                alu_state__instruction__data <= alu_state__instruction__data;
                alu_state__instruction__debug__valid <= alu_state__instruction__debug__valid;
                alu_state__instruction__debug__debug_op <= alu_state__instruction__debug__debug_op;
                alu_state__instruction__debug__data <= alu_state__instruction__debug__data;
                alu_state__rs1_from_alu <= 1'h0;
                alu_state__rs2_from_alu <= 1'h0;
                alu_state__rs1_from_mem <= alu_state__rs1_from_alu;
                alu_state__rs2_from_mem <= alu_state__rs2_from_alu;
                if ((alu_state__rs1_from_mem!=1'h0))
                begin
                    alu_state__rs1 <= rfw_state__mem_result;
                end //if
                if ((alu_state__rs2_from_mem!=1'h0))
                begin
                    alu_state__rs2 <= rfw_state__mem_result;
                end //if
            end //if
            else
            
            begin
                if ((pipeline_fetch_data__dec_flush_pipeline!=1'h0))
                begin
                    alu_state__valid <= 1'h0;
                    alu_state__pc_if_mispredicted <= pipeline_fetch_data__dec_pc_if_mispredicted;
                    alu_state__predicted_branch <= pipeline_fetch_data__dec_predicted_branch;
                end //if
                else
                
                begin
                    if ((dec_state__valid!=1'h0))
                    begin
                        alu_state__valid <= 1'h1;
                        alu_state__first_cycle <= 1'h1;
                        alu_state__idecode__rs1 <= dec_combs__idecode__rs1;
                        alu_state__idecode__rs1_valid <= dec_combs__idecode__rs1_valid;
                        alu_state__idecode__rs2 <= dec_combs__idecode__rs2;
                        alu_state__idecode__rs2_valid <= dec_combs__idecode__rs2_valid;
                        alu_state__idecode__rd <= dec_combs__idecode__rd;
                        alu_state__idecode__rd_written <= dec_combs__idecode__rd_written;
                        alu_state__idecode__csr_access__access_cancelled <= dec_combs__idecode__csr_access__access_cancelled;
                        alu_state__idecode__csr_access__access <= dec_combs__idecode__csr_access__access;
                        alu_state__idecode__csr_access__address <= dec_combs__idecode__csr_access__address;
                        alu_state__idecode__csr_access__write_data <= dec_combs__idecode__csr_access__write_data;
                        alu_state__idecode__immediate <= dec_combs__idecode__immediate;
                        alu_state__idecode__immediate_shift <= dec_combs__idecode__immediate_shift;
                        alu_state__idecode__immediate_valid <= dec_combs__idecode__immediate_valid;
                        alu_state__idecode__op <= dec_combs__idecode__op;
                        alu_state__idecode__subop <= dec_combs__idecode__subop;
                        alu_state__idecode__funct7 <= dec_combs__idecode__funct7;
                        alu_state__idecode__minimum_mode <= dec_combs__idecode__minimum_mode;
                        alu_state__idecode__illegal <= dec_combs__idecode__illegal;
                        alu_state__idecode__illegal_pc <= dec_combs__idecode__illegal_pc;
                        alu_state__idecode__is_compressed <= dec_combs__idecode__is_compressed;
                        alu_state__idecode__ext__dummy <= dec_combs__idecode__ext__dummy;
                        alu_state__pc <= dec_state__pc;
                        alu_state__pc_if_mispredicted <= pipeline_fetch_data__dec_pc_if_mispredicted;
                        alu_state__predicted_branch <= pipeline_fetch_data__dec_predicted_branch;
                        alu_state__rs1 <= dec_combs__rs1;
                        alu_state__rs2 <= dec_combs__rs2;
                        alu_state__rs1_from_alu <= dec_combs__rs1_from_alu;
                        alu_state__rs1_from_mem <= dec_combs__rs1_from_mem;
                        alu_state__rs2_from_alu <= dec_combs__rs2_from_alu;
                        alu_state__rs2_from_mem <= dec_combs__rs2_from_mem;
                        alu_state__instruction__data <= dec_state__instruction__data;
                        alu_state__instruction__debug__valid <= dec_state__instruction__debug__valid;
                        alu_state__instruction__debug__debug_op <= dec_state__instruction__debug__debug_op;
                        alu_state__instruction__debug__data <= dec_state__instruction__debug__data;
                    end //if
                end //else
            end //else
        end //if
    end //always

    //b alu_stage_logic combinatorial process
        //   
        //       The ALU stage does data forwarding, ALU operation, conditional branches, CSR accesses, memory request
        //       
    always @ ( * )//alu_stage_logic
    begin: alu_stage_logic__comb_code
    reg coproc_response_cfg__cannot_start__var;
    reg [31:0]coproc_response_cfg__result__var;
    reg coproc_response_cfg__result_valid__var;
    reg coproc_response_cfg__cannot_complete__var;
    reg [31:0]alu_combs__rs1__var;
    reg alu_combs__blocked_by_mem__var;
    reg [31:0]alu_combs__rs2__var;
    reg alu_combs__csr_access__access_cancelled__var;
    reg [2:0]alu_combs__csr_access__access__var;
    reg [31:0]alu_combs__result_data__var;
    reg [31:0]alu_combs__control_data__pc__var;
        alu_combs__valid_legal = ((alu_state__valid!=1'h0)&&!(alu_state__idecode__illegal!=1'h0));
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
        alu_combs__rs1__var = alu_state__rs1;
        alu_combs__blocked_by_mem__var = 1'h0;
        if ((alu_state__rs1_from_mem!=1'h0))
        begin
            alu_combs__rs1__var = rfw_state__mem_result;
        end //if
        if ((alu_state__rs1_from_alu!=1'h0))
        begin
            alu_combs__rs1__var = mem_state__alu_result;
            if ((mem_state__rd_from_mem!=1'h0))
            begin
                alu_combs__blocked_by_mem__var = alu_state__idecode__rs1_valid;
            end //if
        end //if
        alu_combs__rs2__var = alu_state__rs2;
        if ((alu_state__rs2_from_mem!=1'h0))
        begin
            alu_combs__rs2__var = rfw_state__mem_result;
        end //if
        if ((alu_state__rs2_from_alu!=1'h0))
        begin
            alu_combs__rs2__var = mem_state__alu_result;
            if ((mem_state__rd_from_mem!=1'h0))
            begin
                alu_combs__blocked_by_mem__var = alu_state__idecode__rs2_valid;
            end //if
        end //if
        alu_combs__cannot_start = ((alu_combs__blocked_by_mem__var!=1'h0)||(coproc_response_cfg__cannot_start__var!=1'h0));
        alu_combs__cannot_complete = ((alu_combs__cannot_start!=1'h0)||(coproc_response_cfg__cannot_complete__var!=1'h0));
        alu_combs__csr_access__access_cancelled__var = alu_result__csr_access__access_cancelled;
        alu_combs__csr_access__access__var = alu_result__csr_access__access;
        alu_combs__csr_access__address = alu_result__csr_access__address;
        alu_combs__csr_access__write_data = alu_result__csr_access__write_data;
        if (!(alu_combs__valid_legal!=1'h0))
        begin
            alu_combs__csr_access__access__var = 3'h0;
        end //if
        alu_combs__csr_access__access_cancelled__var = alu_control_flow__async_cancel;
        csr_access__access_cancelled = alu_combs__csr_access__access_cancelled__var;
        csr_access__access = alu_combs__csr_access__access__var;
        csr_access__address = alu_combs__csr_access__address;
        csr_access__write_data = alu_combs__csr_access__write_data;
        alu_combs__result_data__var = (alu_result__result | coproc_response_cfg__result__var);
        if ((coproc_response_cfg__result_valid__var!=1'h0))
        begin
            alu_combs__result_data__var = coproc_response_cfg__result__var;
        end //if
        if ((alu_state__idecode__csr_access__access!=3'h0))
        begin
            alu_combs__result_data__var = csr_read_data;
        end //if
        alu_combs__dmem_exec__idecode__rs1 = alu_state__idecode__rs1;
        alu_combs__dmem_exec__idecode__rs1_valid = alu_state__idecode__rs1_valid;
        alu_combs__dmem_exec__idecode__rs2 = alu_state__idecode__rs2;
        alu_combs__dmem_exec__idecode__rs2_valid = alu_state__idecode__rs2_valid;
        alu_combs__dmem_exec__idecode__rd = alu_state__idecode__rd;
        alu_combs__dmem_exec__idecode__rd_written = alu_state__idecode__rd_written;
        alu_combs__dmem_exec__idecode__csr_access__access_cancelled = alu_state__idecode__csr_access__access_cancelled;
        alu_combs__dmem_exec__idecode__csr_access__access = alu_state__idecode__csr_access__access;
        alu_combs__dmem_exec__idecode__csr_access__address = alu_state__idecode__csr_access__address;
        alu_combs__dmem_exec__idecode__csr_access__write_data = alu_state__idecode__csr_access__write_data;
        alu_combs__dmem_exec__idecode__immediate = alu_state__idecode__immediate;
        alu_combs__dmem_exec__idecode__immediate_shift = alu_state__idecode__immediate_shift;
        alu_combs__dmem_exec__idecode__immediate_valid = alu_state__idecode__immediate_valid;
        alu_combs__dmem_exec__idecode__op = alu_state__idecode__op;
        alu_combs__dmem_exec__idecode__subop = alu_state__idecode__subop;
        alu_combs__dmem_exec__idecode__funct7 = alu_state__idecode__funct7;
        alu_combs__dmem_exec__idecode__minimum_mode = alu_state__idecode__minimum_mode;
        alu_combs__dmem_exec__idecode__illegal = alu_state__idecode__illegal;
        alu_combs__dmem_exec__idecode__illegal_pc = alu_state__idecode__illegal_pc;
        alu_combs__dmem_exec__idecode__is_compressed = alu_state__idecode__is_compressed;
        alu_combs__dmem_exec__idecode__ext__dummy = alu_state__idecode__ext__dummy;
        alu_combs__dmem_exec__arith_result = alu_result__arith_result;
        alu_combs__dmem_exec__rs2 = alu_combs__rs2__var;
        alu_combs__dmem_exec__exec_committed = ((alu_state__valid!=1'h0)&&!(alu_control_flow__async_cancel!=1'h0));
        alu_combs__dmem_exec__first_cycle = 1'h1;
        dmem_access_req__valid = alu_combs_dmem_request__access__valid;
        dmem_access_req__req_type = alu_combs_dmem_request__access__req_type;
        dmem_access_req__address = alu_combs_dmem_request__access__address;
        dmem_access_req__sequential = alu_combs_dmem_request__access__sequential;
        dmem_access_req__byte_enable = alu_combs_dmem_request__access__byte_enable;
        dmem_access_req__write_data = alu_combs_dmem_request__access__write_data;
        alu_combs__control_data__instruction_data = alu_state__instruction__data;
        alu_combs__control_data__pc__var = alu_state__pc;
        alu_combs__control_data__alu_result__result = alu_result__result;
        alu_combs__control_data__alu_result__arith_result = alu_result__arith_result;
        alu_combs__control_data__alu_result__branch_condition_met = alu_result__branch_condition_met;
        alu_combs__control_data__alu_result__branch_target = alu_result__branch_target;
        alu_combs__control_data__alu_result__csr_access__access_cancelled = alu_result__csr_access__access_cancelled;
        alu_combs__control_data__alu_result__csr_access__access = alu_result__csr_access__access;
        alu_combs__control_data__alu_result__csr_access__address = alu_result__csr_access__address;
        alu_combs__control_data__alu_result__csr_access__write_data = alu_result__csr_access__write_data;
        alu_combs__control_data__interrupt_ack = 1'h1;
        alu_combs__control_data__valid = alu_state__valid;
        alu_combs__control_data__exec_committed = ((alu_state__valid!=1'h0)&&!(alu_combs__blocked_by_mem__var!=1'h0));
        alu_combs__control_data__idecode__rs1 = alu_state__idecode__rs1;
        alu_combs__control_data__idecode__rs1_valid = alu_state__idecode__rs1_valid;
        alu_combs__control_data__idecode__rs2 = alu_state__idecode__rs2;
        alu_combs__control_data__idecode__rs2_valid = alu_state__idecode__rs2_valid;
        alu_combs__control_data__idecode__rd = alu_state__idecode__rd;
        alu_combs__control_data__idecode__rd_written = alu_state__idecode__rd_written;
        alu_combs__control_data__idecode__csr_access__access_cancelled = alu_state__idecode__csr_access__access_cancelled;
        alu_combs__control_data__idecode__csr_access__access = alu_state__idecode__csr_access__access;
        alu_combs__control_data__idecode__csr_access__address = alu_state__idecode__csr_access__address;
        alu_combs__control_data__idecode__csr_access__write_data = alu_state__idecode__csr_access__write_data;
        alu_combs__control_data__idecode__immediate = alu_state__idecode__immediate;
        alu_combs__control_data__idecode__immediate_shift = alu_state__idecode__immediate_shift;
        alu_combs__control_data__idecode__immediate_valid = alu_state__idecode__immediate_valid;
        alu_combs__control_data__idecode__op = alu_state__idecode__op;
        alu_combs__control_data__idecode__subop = alu_state__idecode__subop;
        alu_combs__control_data__idecode__funct7 = alu_state__idecode__funct7;
        alu_combs__control_data__idecode__minimum_mode = alu_state__idecode__minimum_mode;
        alu_combs__control_data__idecode__illegal = alu_state__idecode__illegal;
        alu_combs__control_data__idecode__illegal_pc = alu_state__idecode__illegal_pc;
        alu_combs__control_data__idecode__is_compressed = alu_state__idecode__is_compressed;
        alu_combs__control_data__idecode__ext__dummy = alu_state__idecode__ext__dummy;
        alu_combs__control_data__first_cycle = 1'h1;
        if (!(alu_state__valid!=1'h0))
        begin
            alu_combs__control_data__pc__var = ((dec_state__valid!=1'h0)?dec_state__pc:pipeline_control__fetch_pc);
        end //if
        pipeline_response__exec__valid = alu_state__valid;
        pipeline_response__exec__cannot_start = alu_combs__blocked_by_mem__var;
        pipeline_response__exec__cannot_complete = ((alu_combs__blocked_by_mem__var!=1'h0)||(alu_control_flow__async_cancel!=1'h0));
        pipeline_response__exec__interrupt_ack = pipeline_control__interrupt_req;
        pipeline_response__exec__is_compressed = alu_state__idecode__is_compressed;
        pipeline_response__exec__pc = alu_state__pc;
        pipeline_response__exec__rs1 = alu_combs__rs1__var;
        pipeline_response__exec__rs2 = alu_combs__rs2__var;
        pipeline_response__exec__instruction__data = alu_state__instruction__data;
        pipeline_response__exec__instruction__debug__valid = alu_state__instruction__debug__valid;
        pipeline_response__exec__instruction__debug__debug_op = alu_state__instruction__debug__debug_op;
        pipeline_response__exec__instruction__debug__data = alu_state__instruction__debug__data;
        pipeline_response__exec__predicted_branch = alu_state__predicted_branch;
        pipeline_response__exec__pc_if_mispredicted = ((alu_control_flow__jalr!=1'h0)?alu_result__branch_target:alu_state__pc_if_mispredicted);
        pipeline_response__exec__branch_taken = alu_control_flow__branch_taken;
        pipeline_response__exec__jalr = ((alu_control_flow__jalr!=1'h0)&&(alu_state__idecode__rs1!=5'h0));
        pipeline_response__exec__trap__valid = alu_control_flow__trap__valid;
        pipeline_response__exec__trap__to_mode = alu_control_flow__trap__to_mode;
        pipeline_response__exec__trap__cause = alu_control_flow__trap__cause;
        pipeline_response__exec__trap__pc = alu_control_flow__trap__pc;
        pipeline_response__exec__trap__value = alu_control_flow__trap__value;
        pipeline_response__exec__trap__ret = alu_control_flow__trap__ret;
        pipeline_response__exec__trap__vector = alu_control_flow__trap__vector;
        pipeline_response__exec__trap__ebreak_to_dbg = alu_control_flow__trap__ebreak_to_dbg;
        pipeline_response__rfw__valid = rfw_state__valid;
        pipeline_response__rfw__rd_written = rfw_state__rd_written;
        pipeline_response__rfw__rd = rfw_state__rd;
        pipeline_response__rfw__data = rfw_state__mem_result;
        pipeline_response__pipeline_empty = (((!(dec_state__valid!=1'h0)&&!(alu_state__valid!=1'h0))&&!(mem_state__valid!=1'h0))&&!(rfw_state__valid!=1'h0));
        coproc_response_cfg__cannot_start = coproc_response_cfg__cannot_start__var;
        coproc_response_cfg__result = coproc_response_cfg__result__var;
        coproc_response_cfg__result_valid = coproc_response_cfg__result_valid__var;
        coproc_response_cfg__cannot_complete = coproc_response_cfg__cannot_complete__var;
        alu_combs__rs1 = alu_combs__rs1__var;
        alu_combs__blocked_by_mem = alu_combs__blocked_by_mem__var;
        alu_combs__rs2 = alu_combs__rs2__var;
        alu_combs__csr_access__access_cancelled = alu_combs__csr_access__access_cancelled__var;
        alu_combs__csr_access__access = alu_combs__csr_access__access__var;
        alu_combs__result_data = alu_combs__result_data__var;
        alu_combs__control_data__pc = alu_combs__control_data__pc__var;
    end //always

    //b memory_stage__comb combinatorial process
        //   
        //       The memory access stage is when the memory is performing a read
        //   
        //       When unaligned accesses are supported this will merge two reads
        //       using multiple cycles
        //   
        //       This is a single cycle, with committed transactions only being
        //       valid
        //   
        //       If the memory is performing a read then the memory data is rotated
        //       and presented as the result; otherwise the ALU result is passed
        //       through.
        //   
        //       
    always @ ( * )//memory_stage__comb
    begin: memory_stage__comb_code
    reg [31:0]mem_combs__result_data__var;
        mem_combs__result_data__var = mem_state__alu_result;
        if ((mem_state__dmem_request__reading!=1'h0))
        begin
            mem_combs__result_data__var = mem_combs_dmem_read_data;
        end //if
        mem_combs__result_data = mem_combs__result_data__var;
    end //always

    //b memory_stage__posedge_clk_active_low_reset_n clock process
        //   
        //       The memory access stage is when the memory is performing a read
        //   
        //       When unaligned accesses are supported this will merge two reads
        //       using multiple cycles
        //   
        //       This is a single cycle, with committed transactions only being
        //       valid
        //   
        //       If the memory is performing a read then the memory data is rotated
        //       and presented as the result; otherwise the ALU result is passed
        //       through.
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : memory_stage__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            mem_state__valid <= 1'h0;
            mem_state__rd_written <= 1'h0;
            mem_state__rd_from_mem <= 1'h0;
            mem_state__dmem_request__access__valid <= 1'h0;
            mem_state__dmem_request__access__req_type <= 5'h0;
            mem_state__dmem_request__access__address <= 32'h0;
            mem_state__dmem_request__access__sequential <= 1'h0;
            mem_state__dmem_request__access__byte_enable <= 4'h0;
            mem_state__dmem_request__access__write_data <= 32'h0;
            mem_state__dmem_request__load_address_misaligned <= 1'h0;
            mem_state__dmem_request__store_address_misaligned <= 1'h0;
            mem_state__dmem_request__reading <= 1'h0;
            mem_state__dmem_request__read_data_rotation <= 2'h0;
            mem_state__dmem_request__read_data_byte_clear <= 4'h0;
            mem_state__dmem_request__read_data_byte_enable <= 4'h0;
            mem_state__dmem_request__sign_extend_byte <= 1'h0;
            mem_state__dmem_request__sign_extend_half <= 1'h0;
            mem_state__dmem_request__multicycle <= 1'h0;
            mem_state__rd <= 5'h0;
            mem_state__alu_result <= 32'h0;
        end
        else if (clk__enable)
        begin
            mem_state__valid <= 1'h0;
            mem_state__rd_written <= 1'h0;
            mem_state__rd_from_mem <= 1'h0;
            if ((((alu_combs__valid_legal!=1'h0)&&!(alu_combs__cannot_complete!=1'h0))&&!(alu_control_flow__async_cancel!=1'h0)))
            begin
                mem_state__valid <= 1'h1;
                mem_state__dmem_request__access__valid <= alu_combs_dmem_request__access__valid;
                mem_state__dmem_request__access__req_type <= alu_combs_dmem_request__access__req_type;
                mem_state__dmem_request__access__address <= alu_combs_dmem_request__access__address;
                mem_state__dmem_request__access__sequential <= alu_combs_dmem_request__access__sequential;
                mem_state__dmem_request__access__byte_enable <= alu_combs_dmem_request__access__byte_enable;
                mem_state__dmem_request__access__write_data <= alu_combs_dmem_request__access__write_data;
                mem_state__dmem_request__load_address_misaligned <= alu_combs_dmem_request__load_address_misaligned;
                mem_state__dmem_request__store_address_misaligned <= alu_combs_dmem_request__store_address_misaligned;
                mem_state__dmem_request__reading <= alu_combs_dmem_request__reading;
                mem_state__dmem_request__read_data_rotation <= alu_combs_dmem_request__read_data_rotation;
                mem_state__dmem_request__read_data_byte_clear <= alu_combs_dmem_request__read_data_byte_clear;
                mem_state__dmem_request__read_data_byte_enable <= alu_combs_dmem_request__read_data_byte_enable;
                mem_state__dmem_request__sign_extend_byte <= alu_combs_dmem_request__sign_extend_byte;
                mem_state__dmem_request__sign_extend_half <= alu_combs_dmem_request__sign_extend_half;
                mem_state__dmem_request__multicycle <= alu_combs_dmem_request__multicycle;
                if (((alu_combs_dmem_request__reading!=1'h0)&&(alu_state__idecode__rd_written!=1'h0)))
                begin
                    mem_state__rd_from_mem <= 1'h1;
                end //if
                mem_state__rd_written <= alu_state__idecode__rd_written;
                mem_state__rd <= alu_state__idecode__rd;
                mem_state__alu_result <= alu_combs__result_data;
            end //if
        end //if
    end //always

    //b rfw_stage clock process
        //   
        //       The RFW stage takes the memory read data and memory stage internal data,
        //       and combines them, preparing the result for the register file (written at the end of the clock)
        //       
    always @( posedge clk or negedge reset_n)
    begin : rfw_stage__code
        if (reset_n==1'b0)
        begin
            rfw_state__valid <= 1'h0;
            rfw_state__rd_written <= 1'h0;
            rfw_state__rd <= 5'h0;
            rfw_state__mem_result <= 32'h0;
            registers[0] <= 32'hffffffff;
            registers[1] <= 32'hffffffff;
            registers[2] <= 32'hffffffff;
            registers[3] <= 32'hffffffff;
            registers[4] <= 32'hffffffff;
            registers[5] <= 32'hffffffff;
            registers[6] <= 32'hffffffff;
            registers[7] <= 32'hffffffff;
            registers[8] <= 32'hffffffff;
            registers[9] <= 32'hffffffff;
            registers[10] <= 32'hffffffff;
            registers[11] <= 32'hffffffff;
            registers[12] <= 32'hffffffff;
            registers[13] <= 32'hffffffff;
            registers[14] <= 32'hffffffff;
            registers[15] <= 32'hffffffff;
            registers[16] <= 32'hffffffff;
            registers[17] <= 32'hffffffff;
            registers[18] <= 32'hffffffff;
            registers[19] <= 32'hffffffff;
            registers[20] <= 32'hffffffff;
            registers[21] <= 32'hffffffff;
            registers[22] <= 32'hffffffff;
            registers[23] <= 32'hffffffff;
            registers[24] <= 32'hffffffff;
            registers[25] <= 32'hffffffff;
            registers[26] <= 32'hffffffff;
            registers[27] <= 32'hffffffff;
            registers[28] <= 32'hffffffff;
            registers[29] <= 32'hffffffff;
            registers[30] <= 32'hffffffff;
            registers[31] <= 32'hffffffff;
        end
        else if (clk__enable)
        begin
            rfw_state__valid <= 1'h0;
            rfw_state__rd_written <= 1'h0;
            if ((mem_state__valid!=1'h0))
            begin
                rfw_state__valid <= 1'h1;
                rfw_state__rd_written <= mem_state__rd_written;
                rfw_state__rd <= mem_state__rd;
                rfw_state__mem_result <= mem_combs__result_data;
                if ((mem_state__rd_written!=1'h0))
                begin
                    registers[mem_state__rd] <= mem_combs__result_data;
                end //if
            end //if
            registers[0] <= 32'h0;
        end //if
    end //always

endmodule // riscv_i32c_pipeline3
