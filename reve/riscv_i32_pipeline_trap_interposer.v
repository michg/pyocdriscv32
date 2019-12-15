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

//a Module riscv_i32_pipeline_trap_interposer
    //   
    //   This module manages trap detection, and setting up of the trap values required.
    //   
module riscv_i32_pipeline_trap_interposer
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

    pipeline_trap_request__valid_from_mem,
    pipeline_trap_request__valid_from_int,
    pipeline_trap_request__valid_from_exec,
    pipeline_trap_request__flushes_exec,
    pipeline_trap_request__to_mode,
    pipeline_trap_request__cause,
    pipeline_trap_request__pc,
    pipeline_trap_request__value,
    pipeline_trap_request__ret,
    pipeline_trap_request__ebreak_to_dbg
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
    output pipeline_trap_request__valid_from_mem;
    output pipeline_trap_request__valid_from_int;
    output pipeline_trap_request__valid_from_exec;
    output pipeline_trap_request__flushes_exec;
    output [2:0]pipeline_trap_request__to_mode;
    output [4:0]pipeline_trap_request__cause;
    output [31:0]pipeline_trap_request__pc;
    output [31:0]pipeline_trap_request__value;
    output pipeline_trap_request__ret;
    output pipeline_trap_request__ebreak_to_dbg;

// output components here

    //b Output combinatorials
    reg pipeline_trap_request__valid_from_mem;
    reg pipeline_trap_request__valid_from_int;
    reg pipeline_trap_request__valid_from_exec;
    reg pipeline_trap_request__flushes_exec;
    reg [2:0]pipeline_trap_request__to_mode;
    reg [4:0]pipeline_trap_request__cause;
    reg [31:0]pipeline_trap_request__pc;
    reg [31:0]pipeline_trap_request__value;
    reg pipeline_trap_request__ret;
    reg pipeline_trap_request__ebreak_to_dbg;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg control_flow_branch_taken;
        //   Trap from exec stage
    reg exec_trap__valid_from_mem;
    reg exec_trap__valid_from_int;
    reg exec_trap__valid_from_exec;
    reg exec_trap__flushes_exec;
    reg [2:0]exec_trap__to_mode;
    reg [4:0]exec_trap__cause;
    reg [31:0]exec_trap__pc;
    reg [31:0]exec_trap__value;
    reg exec_trap__ret;
    reg exec_trap__ebreak_to_dbg;
        //   Trap from interrupt
    reg interrupt_trap__valid_from_mem;
    reg interrupt_trap__valid_from_int;
    reg interrupt_trap__valid_from_exec;
    reg interrupt_trap__flushes_exec;
    reg [2:0]interrupt_trap__to_mode;
    reg [4:0]interrupt_trap__cause;
    reg [31:0]interrupt_trap__pc;
    reg [31:0]interrupt_trap__value;
    reg interrupt_trap__ret;
    reg interrupt_trap__ebreak_to_dbg;
        //   Trap from memory aborts
    reg memory_trap__valid_from_mem;
    reg memory_trap__valid_from_int;
    reg memory_trap__valid_from_exec;
    reg memory_trap__flushes_exec;
    reg [2:0]memory_trap__to_mode;
    reg [4:0]memory_trap__cause;
    reg [31:0]memory_trap__pc;
    reg [31:0]memory_trap__value;
    reg memory_trap__ret;
    reg memory_trap__ebreak_to_dbg;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b memory_abort combinatorial process
    always @ ( * )//memory_abort
    begin: memory_abort__comb_code
    reg memory_trap__valid_from_mem__var;
    reg memory_trap__valid_from_int__var;
    reg memory_trap__valid_from_exec__var;
    reg memory_trap__flushes_exec__var;
    reg [2:0]memory_trap__to_mode__var;
    reg [4:0]memory_trap__cause__var;
    reg [31:0]memory_trap__pc__var;
    reg [31:0]memory_trap__value__var;
    reg memory_trap__ret__var;
    reg memory_trap__ebreak_to_dbg__var;
        memory_trap__valid_from_mem__var = 1'h0;
        memory_trap__valid_from_int__var = 1'h0;
        memory_trap__valid_from_exec__var = 1'h0;
        memory_trap__flushes_exec__var = 1'h0;
        memory_trap__to_mode__var = 3'h0;
        memory_trap__cause__var = 5'h0;
        memory_trap__pc__var = 32'h0;
        memory_trap__value__var = 32'h0;
        memory_trap__ret__var = 1'h0;
        memory_trap__ebreak_to_dbg__var = 1'h0;
        memory_trap__to_mode__var = 3'h3;
        memory_trap__cause__var = 5'h7;
        memory_trap__pc__var = pipeline_response__mem__pc;
        memory_trap__value__var = pipeline_response__mem__addr;
        memory_trap__flushes_exec__var = 1'h1;
        if ((dmem_access_resp__abort_req!=1'h0))
        begin
            memory_trap__valid_from_mem__var = 1'h1;
        end //if
        if ((1'h0!=64'h0))
        begin
            memory_trap__valid_from_mem__var = 1'h0;
            memory_trap__valid_from_int__var = 1'h0;
            memory_trap__valid_from_exec__var = 1'h0;
            memory_trap__flushes_exec__var = 1'h0;
            memory_trap__to_mode__var = 3'h0;
            memory_trap__cause__var = 5'h0;
            memory_trap__pc__var = 32'h0;
            memory_trap__value__var = 32'h0;
            memory_trap__ret__var = 1'h0;
            memory_trap__ebreak_to_dbg__var = 1'h0;
        end //if
        if ((riscv_config__mem_abort_late!=1'h0))
        begin
            memory_trap__valid_from_mem__var = memory_trap__valid_from_mem__var;
            memory_trap__valid_from_int__var = memory_trap__valid_from_int__var;
            memory_trap__valid_from_exec__var = memory_trap__valid_from_exec__var;
            memory_trap__flushes_exec__var = memory_trap__flushes_exec__var;
            memory_trap__to_mode__var = memory_trap__to_mode__var;
            memory_trap__cause__var = memory_trap__cause__var;
            memory_trap__pc__var = memory_trap__pc__var;
            memory_trap__value__var = memory_trap__value__var;
            memory_trap__ret__var = memory_trap__ret__var;
            memory_trap__ebreak_to_dbg__var = memory_trap__ebreak_to_dbg__var;
        end //if
        memory_trap__valid_from_mem = memory_trap__valid_from_mem__var;
        memory_trap__valid_from_int = memory_trap__valid_from_int__var;
        memory_trap__valid_from_exec = memory_trap__valid_from_exec__var;
        memory_trap__flushes_exec = memory_trap__flushes_exec__var;
        memory_trap__to_mode = memory_trap__to_mode__var;
        memory_trap__cause = memory_trap__cause__var;
        memory_trap__pc = memory_trap__pc__var;
        memory_trap__value = memory_trap__value__var;
        memory_trap__ret = memory_trap__ret__var;
        memory_trap__ebreak_to_dbg = memory_trap__ebreak_to_dbg__var;
    end //always

    //b detect_interrupt combinatorial process
    always @ ( * )//detect_interrupt
    begin: detect_interrupt__comb_code
    reg interrupt_trap__valid_from_int__var;
    reg interrupt_trap__flushes_exec__var;
    reg [2:0]interrupt_trap__to_mode__var;
    reg [4:0]interrupt_trap__cause__var;
    reg [31:0]interrupt_trap__pc__var;
    reg [31:0]interrupt_trap__value__var;
        interrupt_trap__valid_from_mem = 1'h0;
        interrupt_trap__valid_from_int__var = 1'h0;
        interrupt_trap__valid_from_exec = 1'h0;
        interrupt_trap__flushes_exec__var = 1'h0;
        interrupt_trap__to_mode__var = 3'h0;
        interrupt_trap__cause__var = 5'h0;
        interrupt_trap__pc__var = 32'h0;
        interrupt_trap__value__var = 32'h0;
        interrupt_trap__ret = 1'h0;
        interrupt_trap__ebreak_to_dbg = 1'h0;
        interrupt_trap__cause__var = 5'h10;
        interrupt_trap__cause__var[3:0] = pipeline_state__interrupt_number;
        interrupt_trap__value__var = pipeline_state__fetch_pc;
        interrupt_trap__to_mode__var = pipeline_state__interrupt_to_mode;
        interrupt_trap__flushes_exec__var = 1'h1;
        if ((pipeline_response__decode__valid!=1'h0))
        begin
            interrupt_trap__value__var = pipeline_response__decode__pc;
        end //if
        if ((pipeline_response__exec__valid!=1'h0))
        begin
            interrupt_trap__value__var = pipeline_response__exec__pc;
        end //if
        interrupt_trap__pc__var = interrupt_trap__value__var;
        interrupt_trap__valid_from_int__var = pipeline_state__interrupt_req;
        if (((pipeline_response__exec__valid!=1'h0)&&(pipeline_response__exec__interrupt_block!=1'h0)))
        begin
            interrupt_trap__valid_from_int__var = 1'h0;
        end //if
        interrupt_trap__valid_from_int = interrupt_trap__valid_from_int__var;
        interrupt_trap__flushes_exec = interrupt_trap__flushes_exec__var;
        interrupt_trap__to_mode = interrupt_trap__to_mode__var;
        interrupt_trap__cause = interrupt_trap__cause__var;
        interrupt_trap__pc = interrupt_trap__pc__var;
        interrupt_trap__value = interrupt_trap__value__var;
    end //always

    //b exec_stage_abort_detection combinatorial process
    always @ ( * )//exec_stage_abort_detection
    begin: exec_stage_abort_detection__comb_code
    reg exec_trap__valid_from_exec__var;
    reg exec_trap__flushes_exec__var;
    reg [2:0]exec_trap__to_mode__var;
    reg [4:0]exec_trap__cause__var;
    reg [31:0]exec_trap__pc__var;
    reg [31:0]exec_trap__value__var;
    reg exec_trap__ret__var;
    reg exec_trap__ebreak_to_dbg__var;
    reg control_flow_branch_taken__var;
        exec_trap__valid_from_mem = 1'h0;
        exec_trap__valid_from_int = 1'h0;
        exec_trap__valid_from_exec__var = 1'h0;
        exec_trap__flushes_exec__var = 1'h0;
        exec_trap__to_mode__var = 3'h0;
        exec_trap__cause__var = 5'h0;
        exec_trap__pc__var = 32'h0;
        exec_trap__value__var = 32'h0;
        exec_trap__ret__var = 1'h0;
        exec_trap__ebreak_to_dbg__var = 1'h0;
        exec_trap__to_mode__var = 3'h3;
        exec_trap__pc__var = pipeline_response__exec__pc;
        case (pipeline_response__exec__idecode__op) //synopsys parallel_case
        4'h3: // req 1
            begin
            if ((pipeline_response__exec__idecode__subop==4'h2))
            begin
                exec_trap__valid_from_exec__var = 1'h1;
                exec_trap__ret__var = 1'h1;
                exec_trap__cause__var = 5'h0;
            end //if
            if ((pipeline_response__exec__idecode__subop==4'h0))
            begin
                exec_trap__valid_from_exec__var = 1'h1;
                exec_trap__cause__var = 5'hb;
            end //if
            if ((pipeline_response__exec__idecode__subop==4'h1))
            begin
                exec_trap__valid_from_exec__var = 1'h1;
                exec_trap__ebreak_to_dbg__var = pipeline_state__ebreak_to_dbg;
                exec_trap__cause__var = 5'h3;
                exec_trap__value__var = pipeline_response__exec__pc;
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
        control_flow_branch_taken__var = 1'h0;
        case (pipeline_response__exec__idecode__op) //synopsys parallel_case
        4'h0: // req 1
            begin
            control_flow_branch_taken__var = pipeline_response__exec__branch_condition_met;
            end
        4'h1: // req 1
            begin
            control_flow_branch_taken__var = 1'h1;
            end
        4'h2: // req 1
            begin
            control_flow_branch_taken__var = 1'h1;
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
        if ((pipeline_response__exec__valid!=1'h0))
        begin
            if ((pipeline_response__exec__idecode__illegal!=1'h0))
            begin
                exec_trap__valid_from_exec__var = 1'h1;
                exec_trap__ret__var = 1'h0;
                exec_trap__ebreak_to_dbg__var = 1'h0;
                exec_trap__cause__var = 5'h2;
                exec_trap__value__var = pipeline_response__exec__instruction__data;
                exec_trap__flushes_exec__var = 1'h1;
            end //if
            if (((((1'h0!=64'h0)||!(riscv_config__i32c!=1'h0))&&(control_flow_branch_taken__var!=1'h0))&&(pipeline_response__exec__pc_if_mispredicted[1]!=1'h0)))
            begin
                exec_trap__valid_from_exec__var = 1'h1;
                exec_trap__ret__var = 1'h0;
                exec_trap__ebreak_to_dbg__var = 1'h0;
                exec_trap__cause__var = 5'h0;
                exec_trap__flushes_exec__var = 1'h1;
            end //if
        end //if
        if (!(pipeline_response__exec__valid!=1'h0))
        begin
            exec_trap__valid_from_exec__var = 1'h0;
        end //if
        exec_trap__valid_from_exec = exec_trap__valid_from_exec__var;
        exec_trap__flushes_exec = exec_trap__flushes_exec__var;
        exec_trap__to_mode = exec_trap__to_mode__var;
        exec_trap__cause = exec_trap__cause__var;
        exec_trap__pc = exec_trap__pc__var;
        exec_trap__value = exec_trap__value__var;
        exec_trap__ret = exec_trap__ret__var;
        exec_trap__ebreak_to_dbg = exec_trap__ebreak_to_dbg__var;
        control_flow_branch_taken = control_flow_branch_taken__var;
    end //always

    //b combine_code combinatorial process
    always @ ( * )//combine_code
    begin: combine_code__comb_code
    reg pipeline_trap_request__valid_from_mem__var;
    reg pipeline_trap_request__valid_from_int__var;
    reg pipeline_trap_request__valid_from_exec__var;
    reg pipeline_trap_request__flushes_exec__var;
    reg [2:0]pipeline_trap_request__to_mode__var;
    reg [4:0]pipeline_trap_request__cause__var;
    reg [31:0]pipeline_trap_request__pc__var;
    reg [31:0]pipeline_trap_request__value__var;
    reg pipeline_trap_request__ret__var;
    reg pipeline_trap_request__ebreak_to_dbg__var;
        pipeline_trap_request__valid_from_mem__var = exec_trap__valid_from_mem;
        pipeline_trap_request__valid_from_int__var = exec_trap__valid_from_int;
        pipeline_trap_request__valid_from_exec__var = exec_trap__valid_from_exec;
        pipeline_trap_request__flushes_exec__var = exec_trap__flushes_exec;
        pipeline_trap_request__to_mode__var = exec_trap__to_mode;
        pipeline_trap_request__cause__var = exec_trap__cause;
        pipeline_trap_request__pc__var = exec_trap__pc;
        pipeline_trap_request__value__var = exec_trap__value;
        pipeline_trap_request__ret__var = exec_trap__ret;
        pipeline_trap_request__ebreak_to_dbg__var = exec_trap__ebreak_to_dbg;
        if ((memory_trap__valid_from_mem!=1'h0))
        begin
            pipeline_trap_request__valid_from_mem__var = memory_trap__valid_from_mem;
            pipeline_trap_request__valid_from_int__var = memory_trap__valid_from_int;
            pipeline_trap_request__valid_from_exec__var = memory_trap__valid_from_exec;
            pipeline_trap_request__flushes_exec__var = memory_trap__flushes_exec;
            pipeline_trap_request__to_mode__var = memory_trap__to_mode;
            pipeline_trap_request__cause__var = memory_trap__cause;
            pipeline_trap_request__pc__var = memory_trap__pc;
            pipeline_trap_request__value__var = memory_trap__value;
            pipeline_trap_request__ret__var = memory_trap__ret;
            pipeline_trap_request__ebreak_to_dbg__var = memory_trap__ebreak_to_dbg;
        end //if
        else
        
        begin
            if ((interrupt_trap__valid_from_int!=1'h0))
            begin
                pipeline_trap_request__valid_from_mem__var = interrupt_trap__valid_from_mem;
                pipeline_trap_request__valid_from_int__var = interrupt_trap__valid_from_int;
                pipeline_trap_request__valid_from_exec__var = interrupt_trap__valid_from_exec;
                pipeline_trap_request__flushes_exec__var = interrupt_trap__flushes_exec;
                pipeline_trap_request__to_mode__var = interrupt_trap__to_mode;
                pipeline_trap_request__cause__var = interrupt_trap__cause;
                pipeline_trap_request__pc__var = interrupt_trap__pc;
                pipeline_trap_request__value__var = interrupt_trap__value;
                pipeline_trap_request__ret__var = interrupt_trap__ret;
                pipeline_trap_request__ebreak_to_dbg__var = interrupt_trap__ebreak_to_dbg;
            end //if
        end //else
        pipeline_trap_request__valid_from_mem = pipeline_trap_request__valid_from_mem__var;
        pipeline_trap_request__valid_from_int = pipeline_trap_request__valid_from_int__var;
        pipeline_trap_request__valid_from_exec = pipeline_trap_request__valid_from_exec__var;
        pipeline_trap_request__flushes_exec = pipeline_trap_request__flushes_exec__var;
        pipeline_trap_request__to_mode = pipeline_trap_request__to_mode__var;
        pipeline_trap_request__cause = pipeline_trap_request__cause__var;
        pipeline_trap_request__pc = pipeline_trap_request__pc__var;
        pipeline_trap_request__value = pipeline_trap_request__value__var;
        pipeline_trap_request__ret = pipeline_trap_request__ret__var;
        pipeline_trap_request__ebreak_to_dbg = pipeline_trap_request__ebreak_to_dbg__var;
    end //always

endmodule // riscv_i32_pipeline_trap_interposer
