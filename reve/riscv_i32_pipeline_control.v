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

//a Module riscv_i32_pipeline_control
    //   
    //   This is a fully synchronous pipeline debug module supporting the pipelines. 
    //   
    //   It is designed to feed data in to a RISC-V pipeline (being merged with
    //   instruction fetch responses), and it takes commands and reports out to
    //   a RISC-V debug module.
    //   
    //   In debug mode PC=0xfffffffc returns the debug_state.data0 instruction and PC=0 returns ebreak
    //   
    //   
module riscv_i32_pipeline_control
(
    clk,
    clk__enable,

    rv_select,
    debug_mst__valid,
    debug_mst__select,
    debug_mst__mask,
    debug_mst__op,
    debug_mst__arg,
    debug_mst__data,
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
    csrs__cycles,
    csrs__instret,
    csrs__time,
    csrs__mscratch,
    csrs__mepc,
    csrs__mcause,
    csrs__mtval,
    csrs__mtvec__base,
    csrs__mtvec__vectored,
    csrs__mstatus__sd,
    csrs__mstatus__tsr,
    csrs__mstatus__tw,
    csrs__mstatus__tvm,
    csrs__mstatus__mxr,
    csrs__mstatus__sum,
    csrs__mstatus__mprv,
    csrs__mstatus__xs,
    csrs__mstatus__fs,
    csrs__mstatus__mpp,
    csrs__mstatus__spp,
    csrs__mstatus__mpie,
    csrs__mstatus__spie,
    csrs__mstatus__upie,
    csrs__mstatus__mie,
    csrs__mstatus__sie,
    csrs__mstatus__uie,
    csrs__mip__meip,
    csrs__mip__seip,
    csrs__mip__ueip,
    csrs__mip__seip_sw,
    csrs__mip__ueip_sw,
    csrs__mip__mtip,
    csrs__mip__stip,
    csrs__mip__utip,
    csrs__mip__msip,
    csrs__mip__ssip,
    csrs__mip__usip,
    csrs__mie__meip,
    csrs__mie__seip,
    csrs__mie__ueip,
    csrs__mie__mtip,
    csrs__mie__stip,
    csrs__mie__utip,
    csrs__mie__msip,
    csrs__mie__ssip,
    csrs__mie__usip,
    csrs__dcsr__xdebug_ver,
    csrs__dcsr__ebreakm,
    csrs__dcsr__ebreaks,
    csrs__dcsr__ebreaku,
    csrs__dcsr__stepie,
    csrs__dcsr__stopcount,
    csrs__dcsr__stoptime,
    csrs__dcsr__cause,
    csrs__dcsr__mprven,
    csrs__dcsr__nmip,
    csrs__dcsr__step,
    csrs__dcsr__prv,
    csrs__depc,
    csrs__dscratch0,
    csrs__dscratch1,
    riscv_clk_enable,
    reset_n,

    debug_tgt__valid,
    debug_tgt__selected,
    debug_tgt__halted,
    debug_tgt__resumed,
    debug_tgt__hit_breakpoint,
    debug_tgt__op_was_none,
    debug_tgt__resp,
    debug_tgt__data,
    debug_tgt__attention,
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
    pipeline_control__instruction_debug__data
);

    //b Clocks
    input clk;
    input clk__enable;
    wire riscv_clk; // Gated version of clock 'clk' enabled by 'riscv_clk_enable'
    wire riscv_clk__enable;

    //b Inputs
    input [5:0]rv_select;
    input debug_mst__valid;
    input [5:0]debug_mst__select;
    input [5:0]debug_mst__mask;
    input [3:0]debug_mst__op;
    input [15:0]debug_mst__arg;
    input [31:0]debug_mst__data;
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
    input [63:0]csrs__cycles;
    input [63:0]csrs__instret;
    input [63:0]csrs__time;
    input [31:0]csrs__mscratch;
    input [31:0]csrs__mepc;
    input [31:0]csrs__mcause;
    input [31:0]csrs__mtval;
    input [29:0]csrs__mtvec__base;
    input csrs__mtvec__vectored;
    input csrs__mstatus__sd;
    input csrs__mstatus__tsr;
    input csrs__mstatus__tw;
    input csrs__mstatus__tvm;
    input csrs__mstatus__mxr;
    input csrs__mstatus__sum;
    input csrs__mstatus__mprv;
    input [1:0]csrs__mstatus__xs;
    input [1:0]csrs__mstatus__fs;
    input [1:0]csrs__mstatus__mpp;
    input csrs__mstatus__spp;
    input csrs__mstatus__mpie;
    input csrs__mstatus__spie;
    input csrs__mstatus__upie;
    input csrs__mstatus__mie;
    input csrs__mstatus__sie;
    input csrs__mstatus__uie;
    input csrs__mip__meip;
    input csrs__mip__seip;
    input csrs__mip__ueip;
    input csrs__mip__seip_sw;
    input csrs__mip__ueip_sw;
    input csrs__mip__mtip;
    input csrs__mip__stip;
    input csrs__mip__utip;
    input csrs__mip__msip;
    input csrs__mip__ssip;
    input csrs__mip__usip;
    input csrs__mie__meip;
    input csrs__mie__seip;
    input csrs__mie__ueip;
    input csrs__mie__mtip;
    input csrs__mie__stip;
    input csrs__mie__utip;
    input csrs__mie__msip;
    input csrs__mie__ssip;
    input csrs__mie__usip;
    input [3:0]csrs__dcsr__xdebug_ver;
    input csrs__dcsr__ebreakm;
    input csrs__dcsr__ebreaks;
    input csrs__dcsr__ebreaku;
    input csrs__dcsr__stepie;
    input csrs__dcsr__stopcount;
    input csrs__dcsr__stoptime;
    input [2:0]csrs__dcsr__cause;
    input csrs__dcsr__mprven;
    input csrs__dcsr__nmip;
    input csrs__dcsr__step;
    input [1:0]csrs__dcsr__prv;
    input [31:0]csrs__depc;
    input [31:0]csrs__dscratch0;
    input [31:0]csrs__dscratch1;
        //   Clock enable for the RISC-V core
    input riscv_clk_enable;
    input reset_n;

    //b Outputs
    output debug_tgt__valid;
    output [5:0]debug_tgt__selected;
    output debug_tgt__halted;
    output debug_tgt__resumed;
    output debug_tgt__hit_breakpoint;
    output debug_tgt__op_was_none;
    output [1:0]debug_tgt__resp;
    output [31:0]debug_tgt__data;
    output debug_tgt__attention;
    output pipeline_control__valid;
    output [2:0]pipeline_control__fetch_action;
    output [31:0]pipeline_control__fetch_pc;
    output [2:0]pipeline_control__mode;
    output pipeline_control__error;
    output [1:0]pipeline_control__tag;
    output pipeline_control__halt;
    output pipeline_control__ebreak_to_dbg;
    output pipeline_control__interrupt_req;
    output [3:0]pipeline_control__interrupt_number;
    output [2:0]pipeline_control__interrupt_to_mode;
    output [31:0]pipeline_control__instruction_data;
    output pipeline_control__instruction_debug__valid;
    output [1:0]pipeline_control__instruction_debug__debug_op;
    output [15:0]pipeline_control__instruction_debug__data;

// output components here

    //b Output combinatorials
    reg debug_tgt__valid;
    reg [5:0]debug_tgt__selected;
    reg debug_tgt__halted;
    reg debug_tgt__resumed;
    reg debug_tgt__hit_breakpoint;
    reg debug_tgt__op_was_none;
    reg [1:0]debug_tgt__resp;
    reg [31:0]debug_tgt__data;
    reg debug_tgt__attention;
    reg pipeline_control__valid;
    reg [2:0]pipeline_control__fetch_action;
    reg [31:0]pipeline_control__fetch_pc;
    reg [2:0]pipeline_control__mode;
    reg pipeline_control__error;
    reg [1:0]pipeline_control__tag;
    reg pipeline_control__halt;
    reg pipeline_control__ebreak_to_dbg;
    reg pipeline_control__interrupt_req;
    reg [3:0]pipeline_control__interrupt_number;
    reg [2:0]pipeline_control__interrupt_to_mode;
    reg [31:0]pipeline_control__instruction_data;
    reg pipeline_control__instruction_debug__valid;
    reg [1:0]pipeline_control__instruction_debug__debug_op;
    reg [15:0]pipeline_control__instruction_debug__data;

    //b Output nets

    //b Internal and output registers
        //   ifetch_state is on the RISC-V clock; debug_state must only uses ifetch_state with correct handshakes
    reg [1:0]ifetch_state__state;
    reg [2:0]ifetch_state__mode;
    reg [31:0]ifetch_state__pc;
    reg ifetch_state__halt_req;
        //   debug_state must be on the constantly running clock, as the debug interface is shared between cores
    reg [2:0]debug_state__control__fsm_state;
    reg debug_state__control__halt_req;
    reg debug_state__control__resume_req;
    reg debug_state__control__exec_progbuf_req;
    reg debug_state__control__halted;
    reg debug_state__control__resumed;
    reg debug_state__control__attention;
    reg debug_state__control__hit_breakpoint;
    reg [15:0]debug_state__control__arg;
    reg [1:0]debug_state__control__resp;
    reg [31:0]debug_state__control__data0;
    reg debug_state__control__instruction_debug_valid;
    reg [1:0]debug_state__control__instruction_debug_op;
    reg [5:0]debug_state__control__rv_select;
    reg debug_state__control__waiting_for_read_write;
    reg debug_state__control__read_write_completed;
    reg debug_state__drive__attention;
    reg debug_state__drive__response;

    //b Internal combinatorials
    reg ifetch_combs__debug_disabled;
    reg [2:0]ifetch_combs__fetch_action;
    reg ifetch_combs__interrupt_req;
    reg [3:0]ifetch_combs__interrupt_number;
    reg debug_combs__mst_valid;

    //b Internal nets

    //b Clock gating module instances
    assign riscv_clk__enable = (clk__enable && riscv_clk_enable);
    //b Module instances
    //b debug_state_machine__comb combinatorial process
        //   
        //       This logic contains the target of the debug interface, which is
        //       used to control the fetch state machine running in the RISC-V
        //       clock domain.
        //   
        //       It implements some state that is updated by the debug interface;
        //       this causes a state machine to operate, causing some interaction
        //       with the fetch state machine, which permits this state machine to
        //       complete and return a result on the debug interface as a response.
        //   
        //       If no debug support is present then this logic becomes static and
        //       is synthesized out.
        //       
    always @ ( * )//debug_state_machine__comb
    begin: debug_state_machine__comb_code
    reg debug_combs__mst_valid__var;
        debug_combs__mst_valid__var = debug_mst__valid;
        if ((debug_mst__select!=rv_select))
        begin
            debug_combs__mst_valid__var = 1'h0;
        end //if
        debug_combs__mst_valid = debug_combs__mst_valid__var;
    end //always

    //b debug_state_machine__posedge_clk_active_low_reset_n clock process
        //   
        //       This logic contains the target of the debug interface, which is
        //       used to control the fetch state machine running in the RISC-V
        //       clock domain.
        //   
        //       It implements some state that is updated by the debug interface;
        //       this causes a state machine to operate, causing some interaction
        //       with the fetch state machine, which permits this state machine to
        //       complete and return a result on the debug interface as a response.
        //   
        //       If no debug support is present then this logic becomes static and
        //       is synthesized out.
        //       
    always @( posedge clk or negedge reset_n)
    begin : debug_state_machine__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            debug_state__control__instruction_debug_valid <= 1'h0;
            debug_state__control__attention <= 1'h0;
            debug_state__control__attention <= 1'h1;
            debug_state__control__halt_req <= 1'h0;
            debug_state__control__resume_req <= 1'h0;
            debug_state__control__arg <= 16'h0;
            debug_state__control__data0 <= 32'h0;
            debug_state__control__instruction_debug_op <= 2'h0;
            debug_state__control__waiting_for_read_write <= 1'h0;
            debug_state__control__exec_progbuf_req <= 1'h0;
            debug_state__control__read_write_completed <= 1'h0;
            debug_state__control__resp <= 2'h0;
            debug_state__control__resumed <= 1'h0;
            debug_state__control__resumed <= 1'h0;
            debug_state__control__fsm_state <= 3'h0;
            debug_state__control__fsm_state <= 3'h2;
            debug_state__control__hit_breakpoint <= 1'h0;
            debug_state__control__halted <= 1'h0;
            debug_state__control__halted <= 1'h1;
            debug_state__control__rv_select <= 6'h0;
        end
        else if (clk__enable)
        begin
            if ((riscv_clk_enable!=1'h0))
            begin
                debug_state__control__instruction_debug_valid <= 1'h0;
            end //if
            if ((debug_combs__mst_valid!=1'h0))
            begin
                debug_state__control__attention <= 1'h0;
                case (debug_mst__op) //synopsys parallel_case
                4'h0: // req 1
                    begin
                    debug_state__control__attention <= 1'h0;
                    end
                4'h1: // req 1
                    begin
                    debug_state__control__halt_req <= debug_mst__arg[0];
                    debug_state__control__resume_req <= debug_mst__arg[1];
                    end
                4'h2: // req 1
                    begin
                    debug_state__control__arg <= debug_mst__arg;
                    debug_state__control__data0 <= debug_mst__data;
                    debug_state__control__instruction_debug_valid <= 1'h1;
                    debug_state__control__instruction_debug_op <= 2'h0;
                    debug_state__control__waiting_for_read_write <= 1'h1;
                    end
                4'h3: // req 1
                    begin
                    debug_state__control__arg <= debug_mst__arg;
                    debug_state__control__instruction_debug_valid <= 1'h1;
                    debug_state__control__instruction_debug_op <= 2'h1;
                    debug_state__control__waiting_for_read_write <= 1'h1;
                    debug_state__control__data0 <= debug_mst__data;
                    end
                4'h5: // req 1
                    begin
                    debug_state__control__data0 <= debug_mst__data;
                    debug_state__control__exec_progbuf_req <= 1'h1;
                    end
    //synopsys  translate_off
    //pragma coverage off
                default:
                    begin
                        if (1)
                        begin
                            $display("%t *********CDL ASSERTION FAILURE:riscv_i32_pipeline_control:debug_state_machine: Full switch statement did not cover all values", $time);
                        end
                    end
    //pragma coverage on
    //synopsys  translate_on
                endcase
            end //if
            if (((pipeline_response__rfw__valid!=1'h0)&&(debug_state__control__waiting_for_read_write!=1'h0)))
            begin
                debug_state__control__data0 <= pipeline_response__rfw__data;
                debug_state__control__waiting_for_read_write <= 1'h0;
                debug_state__control__read_write_completed <= 1'h1;
                debug_state__control__resp <= 2'h1;
                debug_state__control__attention <= 1'h1;
            end //if
            if (((debug_state__control__resumed!=1'h0)&&!(debug_state__control__resume_req!=1'h0)))
            begin
                debug_state__control__resumed <= 1'h0;
                debug_state__control__attention <= 1'h1;
            end //if
            if (((debug_state__control__read_write_completed!=1'h0)&&(debug_state__drive__response!=1'h0)))
            begin
                debug_state__control__read_write_completed <= 1'h0;
                debug_state__control__resp <= 2'h0;
            end //if
            case (debug_state__control__fsm_state) //synopsys parallel_case
            3'h0: // req 1
                begin
                if ((debug_state__control__halt_req!=1'h0))
                begin
                    debug_state__control__fsm_state <= 3'h1;
                end //if
                if (((ifetch_state__state==2'h0)&&(riscv_clk_enable!=1'h0)))
                begin
                    debug_state__control__fsm_state <= 3'h1;
                    debug_state__control__hit_breakpoint <= 1'h0;
                end //if
                end
            3'h1: // req 1
                begin
                if (((ifetch_state__state==2'h0)&&(riscv_clk_enable!=1'h0)))
                begin
                    debug_state__control__fsm_state <= 3'h2;
                    debug_state__control__halted <= 1'h1;
                    debug_state__control__attention <= 1'h1;
                    debug_state__control__hit_breakpoint <= 1'h0;
                end //if
                end
            3'h2: // req 1
                begin
                if (((debug_state__control__resume_req!=1'h0)&&!(debug_state__control__resumed!=1'h0)))
                begin
                    debug_state__control__fsm_state <= 3'h3;
                end //if
                if ((debug_state__control__exec_progbuf_req!=1'h0))
                begin
                    debug_state__control__exec_progbuf_req <= 1'h0;
                    debug_state__control__fsm_state <= 3'h4;
                end //if
                end
            3'h4: // req 1
                begin
                if (((ifetch_state__state!=2'h0)&&(riscv_clk_enable!=1'h0)))
                begin
                    debug_state__control__fsm_state <= 3'h5;
                end //if
                end
            3'h5: // req 1
                begin
                if (((ifetch_state__state==2'h0)&&(riscv_clk_enable!=1'h0)))
                begin
                    debug_state__control__fsm_state <= 3'h2;
                end //if
                end
            3'h3: // req 1
                begin
                if (((ifetch_state__state!=2'h0)&&(riscv_clk_enable!=1'h0)))
                begin
                    debug_state__control__fsm_state <= 3'h0;
                    debug_state__control__hit_breakpoint <= 1'h0;
                    debug_state__control__halted <= 1'h0;
                    debug_state__control__resumed <= 1'h1;
                    debug_state__control__attention <= 1'h1;
                end //if
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_pipeline_control:debug_state_machine: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
            if ((rv_select!=6'h0))
            begin
                debug_state__control__rv_select <= rv_select;
            end //if
            if ((ifetch_combs__debug_disabled!=1'h0))
            begin
                debug_state__control__fsm_state <= debug_state__control__fsm_state;
                debug_state__control__halt_req <= debug_state__control__halt_req;
                debug_state__control__resume_req <= debug_state__control__resume_req;
                debug_state__control__exec_progbuf_req <= debug_state__control__exec_progbuf_req;
                debug_state__control__halted <= debug_state__control__halted;
                debug_state__control__resumed <= debug_state__control__resumed;
                debug_state__control__attention <= debug_state__control__attention;
                debug_state__control__hit_breakpoint <= debug_state__control__hit_breakpoint;
                debug_state__control__arg <= debug_state__control__arg;
                debug_state__control__resp <= debug_state__control__resp;
                debug_state__control__data0 <= debug_state__control__data0;
                debug_state__control__instruction_debug_valid <= debug_state__control__instruction_debug_valid;
                debug_state__control__instruction_debug_op <= debug_state__control__instruction_debug_op;
                debug_state__control__rv_select <= debug_state__control__rv_select;
                debug_state__control__waiting_for_read_write <= debug_state__control__waiting_for_read_write;
                debug_state__control__read_write_completed <= debug_state__control__read_write_completed;
            end //if
        end //if
    end //always

    //b pipeline_control_logic__comb combinatorial process
        //   
        //       The instruction fetch request derives from the
        //       decode/execute stage (the instruction address that is required
        //       next) and presents that to the outside world.
        //   
        //       This request may be for any 16-bit aligned address, and two
        //       successive 16-bit words from that request must be presented,
        //       aligned to bit 0.
        //   
        //       If the decode/execute stage is invalid (i.e. it does not have a
        //       valid instruction to decode) then the current PC is requested.
        //       
    always @ ( * )//pipeline_control_logic__comb
    begin: pipeline_control_logic__comb_code
    reg ifetch_combs__interrupt_req__var;
    reg [3:0]ifetch_combs__interrupt_number__var;
    reg [2:0]ifetch_combs__fetch_action__var;
        ifetch_combs__debug_disabled = (1'h0||!(riscv_config__debug_enable!=1'h0));
        ifetch_combs__interrupt_req__var = 1'h0;
        ifetch_combs__interrupt_number__var = 4'h0;
        if (((csrs__mip__mtip & csrs__mie__mtip)!=1'h0))
        begin
            ifetch_combs__interrupt_req__var = csrs__mstatus__mie;
            ifetch_combs__interrupt_number__var = 4'h7;
        end //if
        if (((csrs__mip__msip & csrs__mie__msip)!=1'h0))
        begin
            ifetch_combs__interrupt_req__var = csrs__mstatus__mie;
            ifetch_combs__interrupt_number__var = 4'h3;
        end //if
        if (((csrs__mip__meip & csrs__mie__meip)!=1'h0))
        begin
            ifetch_combs__interrupt_req__var = csrs__mstatus__mie;
            ifetch_combs__interrupt_number__var = 4'hb;
        end //if
        ifetch_combs__fetch_action__var = 3'h0;
        case (ifetch_state__state) //synopsys parallel_case
        2'h0: // req 1
            begin
            if ((debug_state__control__waiting_for_read_write!=1'h0))
            begin
                ifetch_combs__fetch_action__var = 3'h1;
            end //if
            end
        2'h1: // req 1
            begin
            ifetch_combs__fetch_action__var = 3'h4;
            if ((ifetch_state__state==2'h1))
            begin
                ifetch_combs__fetch_action__var = 3'h2;
            end //if
            if ((ifetch_state__state==2'h2))
            begin
                ifetch_combs__fetch_action__var = 3'h3;
            end //if
            end
        2'h3: // req 1
            begin
            ifetch_combs__fetch_action__var = 3'h4;
            if ((ifetch_state__state==2'h1))
            begin
                ifetch_combs__fetch_action__var = 3'h2;
            end //if
            if ((ifetch_state__state==2'h2))
            begin
                ifetch_combs__fetch_action__var = 3'h3;
            end //if
            end
        2'h2: // req 1
            begin
            ifetch_combs__fetch_action__var = 3'h4;
            if ((ifetch_state__state==2'h1))
            begin
                ifetch_combs__fetch_action__var = 3'h2;
            end //if
            if ((ifetch_state__state==2'h2))
            begin
                ifetch_combs__fetch_action__var = 3'h3;
            end //if
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_pipeline_control:pipeline_control_logic: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        ifetch_combs__interrupt_req = ifetch_combs__interrupt_req__var;
        ifetch_combs__interrupt_number = ifetch_combs__interrupt_number__var;
        ifetch_combs__fetch_action = ifetch_combs__fetch_action__var;
    end //always

    //b pipeline_control_logic__posedge_riscv_clk_active_low_reset_n clock process
        //   
        //       The instruction fetch request derives from the
        //       decode/execute stage (the instruction address that is required
        //       next) and presents that to the outside world.
        //   
        //       This request may be for any 16-bit aligned address, and two
        //       successive 16-bit words from that request must be presented,
        //       aligned to bit 0.
        //   
        //       If the decode/execute stage is invalid (i.e. it does not have a
        //       valid instruction to decode) then the current PC is requested.
        //       
    always @( posedge clk or negedge reset_n)
    begin : pipeline_control_logic__posedge_riscv_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            ifetch_state__halt_req <= 1'h0;
            ifetch_state__state <= 2'h0;
            ifetch_state__state <= 2'h0;
            ifetch_state__pc <= 32'h0;
            ifetch_state__pc <= 32'h0;
            ifetch_state__mode <= 3'h0;
            ifetch_state__mode <= 3'h3;
        end
        else if (riscv_clk__enable)
        begin
            ifetch_state__halt_req <= 1'h0;
            case (ifetch_state__state) //synopsys parallel_case
            2'h0: // req 1
                begin
                if ((debug_state__control__fsm_state==3'h3))
                begin
                    ifetch_state__state <= 2'h1;
                    ifetch_state__pc <= csrs__depc;
                    ifetch_state__mode <= 3'h3;
                end //if
                if ((debug_state__control__fsm_state==3'h4))
                begin
                    ifetch_state__state <= 2'h1;
                    ifetch_state__pc <= 32'hffffff00;
                    ifetch_state__mode <= 3'h7;
                end //if
                if ((ifetch_combs__debug_disabled!=1'h0))
                begin
                    ifetch_state__state <= 2'h1;
                    ifetch_state__pc <= 32'h0;
                    ifetch_state__mode <= 3'h3;
                end //if
                end
            2'h1: // req 1
                begin
                ifetch_state__state <= 2'h2;
                ifetch_state__pc <= pipeline_fetch_data__pc;
                if (((pipeline_fetch_data__valid!=1'h0)&&!(pipeline_response__decode__blocked!=1'h0)))
                begin
                    ifetch_state__pc <= pipeline_fetch_data__pc;
                    ifetch_state__state <= 2'h3;
                end //if
                if ((debug_state__control__fsm_state==3'h1))
                begin
                    ifetch_state__halt_req <= !(ifetch_combs__debug_disabled!=1'h0);
                end //if
                if (((csrs__dcsr__step!=1'h0)&&(pipeline_response__exec__valid!=1'h0)))
                begin
                    ifetch_state__halt_req <= 1'h1;
                end //if
                if (((pipeline_response__exec__valid!=1'h0)&&(pipeline_response__exec__branch_taken!=pipeline_response__exec__predicted_branch)))
                begin
                    ifetch_state__pc <= pipeline_response__exec__pc_if_mispredicted;
                    ifetch_state__state <= 2'h1;
                end //if
                if ((pipeline_response__exec__trap__ret!=1'h0))
                begin
                    ifetch_state__pc <= csrs__mepc;
                    ifetch_state__state <= 2'h1;
                    ifetch_state__mode <= 3'h3;
                end //if
                if ((pipeline_response__exec__trap__valid!=1'h0))
                begin
                    if ((pipeline_control__interrupt_to_mode==3'h7))
                    begin
                        ifetch_state__halt_req <= 1'h0;
                        ifetch_state__state <= 2'h0;
                    end //if
                    else
                    
                    begin
                        if ((pipeline_response__exec__trap__ebreak_to_dbg!=1'h0))
                        begin
                            ifetch_state__state <= 2'h0;
                        end //if
                        else
                        
                        begin
                            ifetch_state__state <= 2'h1;
                        end //else
                    end //else
                    ifetch_state__mode <= pipeline_control__interrupt_to_mode;
                    ifetch_state__pc <= {csrs__mtvec__base,2'h0};
                end //if
                end
            2'h3: // req 1
                begin
                ifetch_state__state <= 2'h2;
                ifetch_state__pc <= pipeline_fetch_data__pc;
                if (((pipeline_fetch_data__valid!=1'h0)&&!(pipeline_response__decode__blocked!=1'h0)))
                begin
                    ifetch_state__pc <= pipeline_fetch_data__pc;
                    ifetch_state__state <= 2'h3;
                end //if
                if ((debug_state__control__fsm_state==3'h1))
                begin
                    ifetch_state__halt_req <= !(ifetch_combs__debug_disabled!=1'h0);
                end //if
                if (((csrs__dcsr__step!=1'h0)&&(pipeline_response__exec__valid!=1'h0)))
                begin
                    ifetch_state__halt_req <= 1'h1;
                end //if
                if (((pipeline_response__exec__valid!=1'h0)&&(pipeline_response__exec__branch_taken!=pipeline_response__exec__predicted_branch)))
                begin
                    ifetch_state__pc <= pipeline_response__exec__pc_if_mispredicted;
                    ifetch_state__state <= 2'h1;
                end //if
                if ((pipeline_response__exec__trap__ret!=1'h0))
                begin
                    ifetch_state__pc <= csrs__mepc;
                    ifetch_state__state <= 2'h1;
                    ifetch_state__mode <= 3'h3;
                end //if
                if ((pipeline_response__exec__trap__valid!=1'h0))
                begin
                    if ((pipeline_control__interrupt_to_mode==3'h7))
                    begin
                        ifetch_state__halt_req <= 1'h0;
                        ifetch_state__state <= 2'h0;
                    end //if
                    else
                    
                    begin
                        if ((pipeline_response__exec__trap__ebreak_to_dbg!=1'h0))
                        begin
                            ifetch_state__state <= 2'h0;
                        end //if
                        else
                        
                        begin
                            ifetch_state__state <= 2'h1;
                        end //else
                    end //else
                    ifetch_state__mode <= pipeline_control__interrupt_to_mode;
                    ifetch_state__pc <= {csrs__mtvec__base,2'h0};
                end //if
                end
            2'h2: // req 1
                begin
                ifetch_state__state <= 2'h2;
                ifetch_state__pc <= pipeline_fetch_data__pc;
                if (((pipeline_fetch_data__valid!=1'h0)&&!(pipeline_response__decode__blocked!=1'h0)))
                begin
                    ifetch_state__pc <= pipeline_fetch_data__pc;
                    ifetch_state__state <= 2'h3;
                end //if
                if ((debug_state__control__fsm_state==3'h1))
                begin
                    ifetch_state__halt_req <= !(ifetch_combs__debug_disabled!=1'h0);
                end //if
                if (((csrs__dcsr__step!=1'h0)&&(pipeline_response__exec__valid!=1'h0)))
                begin
                    ifetch_state__halt_req <= 1'h1;
                end //if
                if (((pipeline_response__exec__valid!=1'h0)&&(pipeline_response__exec__branch_taken!=pipeline_response__exec__predicted_branch)))
                begin
                    ifetch_state__pc <= pipeline_response__exec__pc_if_mispredicted;
                    ifetch_state__state <= 2'h1;
                end //if
                if ((pipeline_response__exec__trap__ret!=1'h0))
                begin
                    ifetch_state__pc <= csrs__mepc;
                    ifetch_state__state <= 2'h1;
                    ifetch_state__mode <= 3'h3;
                end //if
                if ((pipeline_response__exec__trap__valid!=1'h0))
                begin
                    if ((pipeline_control__interrupt_to_mode==3'h7))
                    begin
                        ifetch_state__halt_req <= 1'h0;
                        ifetch_state__state <= 2'h0;
                    end //if
                    else
                    
                    begin
                        if ((pipeline_response__exec__trap__ebreak_to_dbg!=1'h0))
                        begin
                            ifetch_state__state <= 2'h0;
                        end //if
                        else
                        
                        begin
                            ifetch_state__state <= 2'h1;
                        end //else
                    end //else
                    ifetch_state__mode <= pipeline_control__interrupt_to_mode;
                    ifetch_state__pc <= {csrs__mtvec__base,2'h0};
                end //if
                end
    //synopsys  translate_off
    //pragma coverage off
            default:
                begin
                    if (1)
                    begin
                        $display("%t *********CDL ASSERTION FAILURE:riscv_i32_pipeline_control:pipeline_control_logic: Full switch statement did not cover all values", $time);
                    end
                end
    //pragma coverage on
    //synopsys  translate_on
            endcase
        end //if
    end //always

    //b pc_logic combinatorial process
    always @ ( * )//pc_logic
    begin: pc_logic__comb_code
    reg pipeline_control__valid__var;
    reg [2:0]pipeline_control__fetch_action__var;
    reg [31:0]pipeline_control__fetch_pc__var;
    reg [2:0]pipeline_control__mode__var;
    reg pipeline_control__ebreak_to_dbg__var;
    reg pipeline_control__interrupt_req__var;
    reg [3:0]pipeline_control__interrupt_number__var;
    reg [2:0]pipeline_control__interrupt_to_mode__var;
    reg [31:0]pipeline_control__instruction_data__var;
    reg pipeline_control__instruction_debug__valid__var;
    reg [1:0]pipeline_control__instruction_debug__debug_op__var;
    reg [15:0]pipeline_control__instruction_debug__data__var;
        pipeline_control__valid__var = 1'h0;
        pipeline_control__fetch_action__var = 3'h0;
        pipeline_control__fetch_pc__var = 32'h0;
        pipeline_control__mode__var = 3'h0;
        pipeline_control__error = 1'h0;
        pipeline_control__tag = 2'h0;
        pipeline_control__halt = 1'h0;
        pipeline_control__ebreak_to_dbg__var = 1'h0;
        pipeline_control__interrupt_req__var = 1'h0;
        pipeline_control__interrupt_number__var = 4'h0;
        pipeline_control__interrupt_to_mode__var = 3'h0;
        pipeline_control__instruction_data__var = 32'h0;
        pipeline_control__instruction_debug__valid__var = 1'h0;
        pipeline_control__instruction_debug__debug_op__var = 2'h0;
        pipeline_control__instruction_debug__data__var = 16'h0;
        pipeline_control__valid__var = 1'h1;
        pipeline_control__fetch_pc__var = ifetch_state__pc;
        pipeline_control__fetch_action__var = ifetch_combs__fetch_action;
        pipeline_control__mode__var = ifetch_state__mode;
        pipeline_control__ebreak_to_dbg__var = 1'h0;
        case (ifetch_state__mode) //synopsys parallel_case
        3'h7: // req 1
            begin
            pipeline_control__ebreak_to_dbg__var = 1'h1;
            end
        3'h3: // req 1
            begin
            pipeline_control__ebreak_to_dbg__var = csrs__dcsr__ebreakm;
            end
        3'h1: // req 1
            begin
            pipeline_control__ebreak_to_dbg__var = csrs__dcsr__ebreaks;
            end
        3'h0: // req 1
            begin
            pipeline_control__ebreak_to_dbg__var = csrs__dcsr__ebreaku;
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:riscv_i32_pipeline_control:pc_logic: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        if ((ifetch_combs__debug_disabled!=1'h0))
        begin
            pipeline_control__ebreak_to_dbg__var = 1'h0;
        end //if
        pipeline_control__interrupt_req__var = ((ifetch_combs__interrupt_req!=1'h0)||(ifetch_state__halt_req!=1'h0));
        pipeline_control__interrupt_number__var = ifetch_combs__interrupt_number;
        pipeline_control__interrupt_to_mode__var = ((ifetch_state__halt_req!=1'h0)?3'h7:ifetch_state__mode);
        pipeline_control__instruction_data__var = debug_state__control__data0;
        pipeline_control__instruction_debug__valid__var = debug_state__control__instruction_debug_valid;
        pipeline_control__instruction_debug__debug_op__var = debug_state__control__instruction_debug_op;
        pipeline_control__instruction_debug__data__var = debug_state__control__arg;
        pipeline_control__valid = pipeline_control__valid__var;
        pipeline_control__fetch_action = pipeline_control__fetch_action__var;
        pipeline_control__fetch_pc = pipeline_control__fetch_pc__var;
        pipeline_control__mode = pipeline_control__mode__var;
        pipeline_control__ebreak_to_dbg = pipeline_control__ebreak_to_dbg__var;
        pipeline_control__interrupt_req = pipeline_control__interrupt_req__var;
        pipeline_control__interrupt_number = pipeline_control__interrupt_number__var;
        pipeline_control__interrupt_to_mode = pipeline_control__interrupt_to_mode__var;
        pipeline_control__instruction_data = pipeline_control__instruction_data__var;
        pipeline_control__instruction_debug__valid = pipeline_control__instruction_debug__valid__var;
        pipeline_control__instruction_debug__debug_op = pipeline_control__instruction_debug__debug_op__var;
        pipeline_control__instruction_debug__data = pipeline_control__instruction_debug__data__var;
    end //always

    //b debug_response_driving__comb combinatorial process
        //   
        //       
    always @ ( * )//debug_response_driving__comb
    begin: debug_response_driving__comb_code
    reg debug_tgt__valid__var;
    reg [5:0]debug_tgt__selected__var;
    reg debug_tgt__halted__var;
    reg debug_tgt__resumed__var;
    reg debug_tgt__hit_breakpoint__var;
    reg debug_tgt__op_was_none__var;
    reg [1:0]debug_tgt__resp__var;
    reg [31:0]debug_tgt__data__var;
    reg debug_tgt__attention__var;
        debug_tgt__valid__var = 1'h0;
        debug_tgt__selected__var = 6'h0;
        debug_tgt__halted__var = 1'h0;
        debug_tgt__resumed__var = 1'h0;
        debug_tgt__hit_breakpoint__var = 1'h0;
        debug_tgt__op_was_none__var = 1'h0;
        debug_tgt__resp__var = 2'h0;
        debug_tgt__data__var = 32'h0;
        debug_tgt__attention__var = 1'h0;
        if ((debug_state__drive__attention!=1'h0))
        begin
            debug_tgt__attention__var = debug_state__control__attention;
        end //if
        if ((debug_state__drive__response!=1'h0))
        begin
            debug_tgt__valid__var = 1'h1;
            debug_tgt__selected__var = debug_state__control__rv_select;
            debug_tgt__halted__var = debug_state__control__halted;
            debug_tgt__resumed__var = debug_state__control__resumed;
            debug_tgt__hit_breakpoint__var = debug_state__control__hit_breakpoint;
            debug_tgt__resp__var = debug_state__control__resp;
            debug_tgt__data__var = debug_state__control__data0;
        end //if
        if ((ifetch_combs__debug_disabled!=1'h0))
        begin
            debug_tgt__valid__var = 1'h0;
            debug_tgt__selected__var = 6'h0;
            debug_tgt__halted__var = 1'h0;
            debug_tgt__resumed__var = 1'h0;
            debug_tgt__hit_breakpoint__var = 1'h0;
            debug_tgt__op_was_none__var = 1'h0;
            debug_tgt__resp__var = 2'h0;
            debug_tgt__data__var = 32'h0;
            debug_tgt__attention__var = 1'h0;
        end //if
        debug_tgt__valid = debug_tgt__valid__var;
        debug_tgt__selected = debug_tgt__selected__var;
        debug_tgt__halted = debug_tgt__halted__var;
        debug_tgt__resumed = debug_tgt__resumed__var;
        debug_tgt__hit_breakpoint = debug_tgt__hit_breakpoint__var;
        debug_tgt__op_was_none = debug_tgt__op_was_none__var;
        debug_tgt__resp = debug_tgt__resp__var;
        debug_tgt__data = debug_tgt__data__var;
        debug_tgt__attention = debug_tgt__attention__var;
    end //always

    //b debug_response_driving__posedge_clk_active_low_reset_n clock process
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : debug_response_driving__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            debug_state__drive__attention <= 1'h0;
            debug_state__drive__response <= 1'h0;
        end
        else if (clk__enable)
        begin
            debug_state__drive__attention <= 1'h0;
            debug_state__drive__response <= 1'h0;
            if (((debug_mst__mask & rv_select)==debug_mst__select))
            begin
                debug_state__drive__attention <= 1'h1;
            end //if
            if (((debug_mst__valid!=1'h0)&&(rv_select==debug_mst__select)))
            begin
                debug_state__drive__response <= 1'h1;
            end //if
            if ((ifetch_combs__debug_disabled!=1'h0))
            begin
                debug_state__drive__attention <= 1'h0;
                debug_state__drive__response <= 1'h0;
            end //if
        end //if
    end //always

endmodule // riscv_i32_pipeline_control
