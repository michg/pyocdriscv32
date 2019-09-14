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

//a Module tb_riscv_i32mc_pipeline3
module top
(
    clk,
    //clk__enable,
    jtag_tck,
    //jtag_tck__enable,
    tdo,
    jtag_tdi,
    jtag_tms,
    //jtag__ntrst,
	 //tck_enable,
    reset_n

);

    //b Clocks
    input clk;
    //input clk__enable;
    
    wire clk__enable;
    assign clk__enable = 1'b1;
    
    wire riscv_clk; // Gated version of clock 'clk' enabled by 'riscv_clk_cycle_2'
    wire riscv_clk__enable;
    input jtag_tck;
    
    wire jtag_tck__enable;
    assign jtag_tck__enable = 1'b1;
    
    output tdo;
    input  jtag_tdi;
    input jtag_tms;
    
    wire jtag__ntrst;
    assign jtag__ntrst = 1'b1;
    
    wire tck_enable;
    assign tck_enable = 1'b1;
	 
    wire jtag_tck_gated; // Gated version of clock 'jtag_tck' enabled by 'tck_enable_fix'
    wire jtag_tck_gated__enable;

    //b Inputs
    input reset_n;

    //b Outputs

// output components here

    //b Output combinatorials

    //b Output nets

    //b Internal and output registers
    reg [31:0]dmem_write_data;
    reg [13:0]dmem_address;
    reg dmem_read_not_write;
    reg dmem_select;
    reg [31:0]last_imem_mem_read_data;
    reg riscv_clk_cycle_2;
    reg riscv_clk_cycle_1;
    reg riscv_clk_cycle_0;
    reg [1:0]clk_divider;

    //b Internal combinatorials
    reg riscv_clk_enable;
    reg irqs__nmi;
    reg irqs__meip;
    reg irqs__seip;
    reg irqs__ueip;
    reg irqs__mtip;
    reg irqs__msip;
    reg [63:0]irqs__time;
    reg riscv_config__i32c;
    reg riscv_config__e32;
    reg riscv_config__i32m;
    reg riscv_config__i32m_fuse;
    reg riscv_config__debug_enable;
    reg riscv_config__coproc_disable;
    reg riscv_config__unaligned_mem;
    reg rv_imem_access_resp__valid;
    reg rv_imem_access_resp__debug;
    reg [31:0]rv_imem_access_resp__data;
    reg [2:0]rv_imem_access_resp__mode;
    reg rv_imem_access_resp__error;
    reg [1:0]rv_imem_access_resp__tag;
    reg imem_access_req__flush_pipeline;
    reg [2:0]imem_access_req__req_type;
    reg imem_access_req__debug_fetch;
    reg [31:0]imem_access_req__address;
    reg [2:0]imem_access_req__mode;
    reg imem_access_req__predicted_branch;
    reg [31:0]imem_access_req__pc_if_mispredicted;
    reg dmem_access_resp__ack_if_seq;
    reg dmem_access_resp__ack;
    reg dmem_access_resp__abort_req;
    reg dmem_access_resp__read_data_valid;
    reg [31:0]dmem_access_resp__read_data;
    reg debug_tgt__valid;
    reg [5:0]debug_tgt__selected;
    reg debug_tgt__halted;
    reg debug_tgt__resumed;
    reg debug_tgt__hit_breakpoint;
    reg debug_tgt__op_was_none;
    reg [1:0]debug_tgt__resp;
    reg [31:0]debug_tgt__data;
    reg debug_tgt__attention;
    reg tck_enable_fix;

    //b Internal nets
    wire trace__instr_valid;
    wire [2:0]trace__mode;
    wire [31:0]trace__instr_pc;
    wire [31:0]trace__instruction;
    wire trace__branch_taken;
    wire [31:0]trace__branch_target;
    wire trace__trap;
    wire trace__ret;
    wire trace__jalr;
    wire trace__rfw_retire;
    wire trace__rfw_data_valid;
    wire [4:0]trace__rfw_rd;
    wire [31:0]trace__rfw_data;
    wire trace__bkpt_valid;
    wire [3:0]trace__bkpt_reason;
    wire coproc_response__cannot_start;
    wire [31:0]coproc_response__result;
    wire coproc_response__result_valid;
    wire coproc_response__cannot_complete;
    wire coproc_controls__dec_idecode_valid;
    wire [4:0]coproc_controls__dec_idecode__rs1;
    wire coproc_controls__dec_idecode__rs1_valid;
    wire [4:0]coproc_controls__dec_idecode__rs2;
    wire coproc_controls__dec_idecode__rs2_valid;
    wire [4:0]coproc_controls__dec_idecode__rd;
    wire coproc_controls__dec_idecode__rd_written;
    wire coproc_controls__dec_idecode__csr_access__access_cancelled;
    wire [2:0]coproc_controls__dec_idecode__csr_access__access;
    wire [11:0]coproc_controls__dec_idecode__csr_access__address;
    wire [31:0]coproc_controls__dec_idecode__csr_access__write_data;
    wire [31:0]coproc_controls__dec_idecode__immediate;
    wire [4:0]coproc_controls__dec_idecode__immediate_shift;
    wire coproc_controls__dec_idecode__immediate_valid;
    wire [3:0]coproc_controls__dec_idecode__op;
    wire [3:0]coproc_controls__dec_idecode__subop;
    wire [6:0]coproc_controls__dec_idecode__funct7;
    wire [2:0]coproc_controls__dec_idecode__minimum_mode;
    wire coproc_controls__dec_idecode__illegal;
    wire coproc_controls__dec_idecode__illegal_pc;
    wire coproc_controls__dec_idecode__is_compressed;
    wire coproc_controls__dec_idecode__ext__dummy;
    wire coproc_controls__dec_to_alu_blocked;
    wire [31:0]coproc_controls__alu_rs1;
    wire [31:0]coproc_controls__alu_rs2;
    wire coproc_controls__alu_flush_pipeline;
    wire coproc_controls__alu_cannot_start;
    wire coproc_controls__alu_cannot_complete;
    wire [31:0]main_mem_read_data;
    wire [31:0]imem_mem_read_data;
    wire pipeline_fetch_data__valid;
    wire [31:0]pipeline_fetch_data__pc;
    wire [31:0]pipeline_fetch_data__instruction__data;
    wire pipeline_fetch_data__instruction__debug__valid;
    wire [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    wire [15:0]pipeline_fetch_data__instruction__debug__data;
    wire pipeline_fetch_data__dec_flush_pipeline;
    wire pipeline_fetch_data__dec_predicted_branch;
    wire [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;
    wire pipeline_response__decode__valid;
    wire pipeline_response__decode__blocked;
    wire [31:0]pipeline_response__decode__pc;
    wire [31:0]pipeline_response__decode__branch_target;
    wire [4:0]pipeline_response__decode__idecode__rs1;
    wire pipeline_response__decode__idecode__rs1_valid;
    wire [4:0]pipeline_response__decode__idecode__rs2;
    wire pipeline_response__decode__idecode__rs2_valid;
    wire [4:0]pipeline_response__decode__idecode__rd;
    wire pipeline_response__decode__idecode__rd_written;
    wire pipeline_response__decode__idecode__csr_access__access_cancelled;
    wire [2:0]pipeline_response__decode__idecode__csr_access__access;
    wire [11:0]pipeline_response__decode__idecode__csr_access__address;
    wire [31:0]pipeline_response__decode__idecode__csr_access__write_data;
    wire [31:0]pipeline_response__decode__idecode__immediate;
    wire [4:0]pipeline_response__decode__idecode__immediate_shift;
    wire pipeline_response__decode__idecode__immediate_valid;
    wire [3:0]pipeline_response__decode__idecode__op;
    wire [3:0]pipeline_response__decode__idecode__subop;
    wire [6:0]pipeline_response__decode__idecode__funct7;
    wire [2:0]pipeline_response__decode__idecode__minimum_mode;
    wire pipeline_response__decode__idecode__illegal;
    wire pipeline_response__decode__idecode__illegal_pc;
    wire pipeline_response__decode__idecode__is_compressed;
    wire pipeline_response__decode__idecode__ext__dummy;
    wire pipeline_response__decode__enable_branch_prediction;
    wire pipeline_response__exec__valid;
    wire pipeline_response__exec__cannot_start;
    wire pipeline_response__exec__cannot_complete;
    wire pipeline_response__exec__interrupt_ack;
    wire pipeline_response__exec__branch_taken;
    wire pipeline_response__exec__jalr;
    wire pipeline_response__exec__trap__valid;
    wire [2:0]pipeline_response__exec__trap__to_mode;
    wire [3:0]pipeline_response__exec__trap__cause;
    wire [31:0]pipeline_response__exec__trap__pc;
    wire [31:0]pipeline_response__exec__trap__value;
    wire pipeline_response__exec__trap__ret;
    wire pipeline_response__exec__trap__vector;
    wire pipeline_response__exec__trap__ebreak_to_dbg;
    wire pipeline_response__exec__is_compressed;
    wire [31:0]pipeline_response__exec__instruction__data;
    wire pipeline_response__exec__instruction__debug__valid;
    wire [1:0]pipeline_response__exec__instruction__debug__debug_op;
    wire [15:0]pipeline_response__exec__instruction__debug__data;
    wire [31:0]pipeline_response__exec__rs1;
    wire [31:0]pipeline_response__exec__rs2;
    wire [31:0]pipeline_response__exec__pc;
    wire pipeline_response__exec__predicted_branch;
    wire [31:0]pipeline_response__exec__pc_if_mispredicted;
    wire pipeline_response__rfw__valid;
    wire pipeline_response__rfw__rd_written;
    wire [4:0]pipeline_response__rfw__rd;
    wire [31:0]pipeline_response__rfw__data;
    wire pipeline_response__pipeline_empty;
    wire pipeline_control__valid;
    wire [2:0]pipeline_control__fetch_action;
    wire [31:0]pipeline_control__fetch_pc;
    wire [2:0]pipeline_control__mode;
    wire pipeline_control__error;
    wire [1:0]pipeline_control__tag;
    wire pipeline_control__halt;
    wire pipeline_control__ebreak_to_dbg;
    wire pipeline_control__interrupt_req;
    wire [3:0]pipeline_control__interrupt_number;
    wire [2:0]pipeline_control__interrupt_to_mode;
    wire [31:0]pipeline_control__instruction_data;
    wire pipeline_control__instruction_debug__valid;
    wire [1:0]pipeline_control__instruction_debug__debug_op;
    wire [15:0]pipeline_control__instruction_debug__data;
    wire [63:0]csrs__cycles;
    wire [63:0]csrs__instret;
    wire [63:0]csrs__time;
    wire [31:0]csrs__mscratch;
    wire [31:0]csrs__mepc;
    wire [31:0]csrs__mcause;
    wire [31:0]csrs__mtval;
    wire [29:0]csrs__mtvec__base;
    wire csrs__mtvec__vectored;
    wire csrs__mstatus__sd;
    wire csrs__mstatus__tsr;
    wire csrs__mstatus__tw;
    wire csrs__mstatus__tvm;
    wire csrs__mstatus__mxr;
    wire csrs__mstatus__sum;
    wire csrs__mstatus__mprv;
    wire [1:0]csrs__mstatus__xs;
    wire [1:0]csrs__mstatus__fs;
    wire [1:0]csrs__mstatus__mpp;
    wire csrs__mstatus__spp;
    wire csrs__mstatus__mpie;
    wire csrs__mstatus__spie;
    wire csrs__mstatus__upie;
    wire csrs__mstatus__mie;
    wire csrs__mstatus__sie;
    wire csrs__mstatus__uie;
    wire csrs__mip__meip;
    wire csrs__mip__seip;
    wire csrs__mip__ueip;
    wire csrs__mip__seip_sw;
    wire csrs__mip__ueip_sw;
    wire csrs__mip__mtip;
    wire csrs__mip__stip;
    wire csrs__mip__utip;
    wire csrs__mip__msip;
    wire csrs__mip__ssip;
    wire csrs__mip__usip;
    wire csrs__mie__meip;
    wire csrs__mie__seip;
    wire csrs__mie__ueip;
    wire csrs__mie__mtip;
    wire csrs__mie__stip;
    wire csrs__mie__utip;
    wire csrs__mie__msip;
    wire csrs__mie__ssip;
    wire csrs__mie__usip;
    wire [3:0]csrs__dcsr__xdebug_ver;
    wire csrs__dcsr__ebreakm;
    wire csrs__dcsr__ebreaks;
    wire csrs__dcsr__ebreaku;
    wire csrs__dcsr__stepie;
    wire csrs__dcsr__stopcount;
    wire csrs__dcsr__stoptime;
    wire [2:0]csrs__dcsr__cause;
    wire csrs__dcsr__mprven;
    wire csrs__dcsr__nmip;
    wire csrs__dcsr__step;
    wire [1:0]csrs__dcsr__prv;
    wire [31:0]csrs__depc;
    wire [31:0]csrs__dscratch0;
    wire [31:0]csrs__dscratch1;
    wire csr_access__access_cancelled;
    wire [2:0]csr_access__access;
    wire [11:0]csr_access__address;
    wire [31:0]csr_access__write_data;
    wire [31:0]csr_data__read_data;
    wire csr_data__take_interrupt;
    wire [2:0]csr_data__interrupt_mode;
    wire [3:0]csr_data__interrupt_cause;
    wire csr_data__illegal_access;
    wire [2:0]csr_controls__exec_mode;
    wire csr_controls__retire;
    wire [63:0]csr_controls__timer_value;
    wire csr_controls__trap__valid;
    wire [2:0]csr_controls__trap__to_mode;
    wire [3:0]csr_controls__trap__cause;
    wire [31:0]csr_controls__trap__pc;
    wire [31:0]csr_controls__trap__value;
    wire csr_controls__trap__ret;
    wire csr_controls__trap__vector;
    wire csr_controls__trap__ebreak_to_dbg;
    wire rv_imem_access_req__flush_pipeline;
    wire [2:0]rv_imem_access_req__req_type;
    wire rv_imem_access_req__debug_fetch;
    wire [31:0]rv_imem_access_req__address;
    wire [2:0]rv_imem_access_req__mode;
    wire rv_imem_access_req__predicted_branch;
    wire [31:0]rv_imem_access_req__pc_if_mispredicted;
    wire dmem_access_req__valid;
    wire [4:0]dmem_access_req__req_type;
    wire [31:0]dmem_access_req__address;
    wire dmem_access_req__sequential;
    wire [3:0]dmem_access_req__byte_enable;
    wire [31:0]dmem_access_req__write_data;
    wire debug_tgt0__valid;
    wire [5:0]debug_tgt0__selected;
    wire debug_tgt0__halted;
    wire debug_tgt0__resumed;
    wire debug_tgt0__hit_breakpoint;
    wire debug_tgt0__op_was_none;
    wire [1:0]debug_tgt0__resp;
    wire [31:0]debug_tgt0__data;
    wire debug_tgt0__attention;
    wire debug_mst__valid;
    wire [5:0]debug_mst__select;
    wire [5:0]debug_mst__mask;
    wire [3:0]debug_mst__op;
    wire [15:0]debug_mst__arg;
    wire [31:0]debug_mst__data;
        //   APB response
    wire [31:0]apb_response__prdata;
    wire apb_response__pready;
    wire apb_response__perr;
        //   APB request
    wire [31:0]apb_request__paddr;
    wire apb_request__penable;
    wire apb_request__psel;
    wire apb_request__pwrite;
    wire [31:0]apb_request__pwdata;
    //wire tck_enable;
    wire [49:0]dr_out;
    wire [49:0]dr_tdi_mask;
    wire [49:0]dr_in;
    wire [1:0]dr_action;
    wire [4:0]ir;
    //wire tdo;
    //wire jtag__ntrst;
    //wire jtag__tms;
    //wire jtag__tdi;

    //b Clock gating module instances
    assign riscv_clk__enable = (clk__enable && riscv_clk_cycle_2);
    assign jtag_tck_gated__enable = (jtag_tck__enable && tck_enable_fix);
    //b Module instances
    se_sram_srw_16384x32 imem(
        .sram_clock(clk),
        .sram_clock__enable(1'b1),
        .write_data(32'h0),
        .address(imem_access_req__address[15:2]),
        .write_enable(1'h1),
        .read_not_write(1'h1),
        .select(((imem_access_req__req_type!=3'h0) & ((riscv_clk_cycle_0!=1'h0)||(riscv_clk_cycle_1!=1'h0)))),
        .data_out(            imem_mem_read_data)         );
    se_sram_srw_16384x32_we8 dmem(
        .sram_clock(clk),
        .sram_clock__enable(1'b1),
        .write_data(dmem_write_data),
        .address(dmem_address),
        .write_enable(4'hf),
        .read_not_write(dmem_read_not_write),
        .select(dmem_select),
        .data_out(            main_mem_read_data)         );
    /*se_test_harness th(
        .clk(jtag_tck),
        .clk__enable(1'b1),
        .tdo(tdo),
        .tck_enable(            tck_enable),
        .jtag__tdi(            jtag__tdi),
        .jtag__tms(            jtag__tms),
        .jtag__ntrst(            jtag__ntrst)         );*/
    jtag_tap tap(
        .jtag_tck(jtag_tck),
        .jtag_tck__enable(jtag_tck_gated__enable),
        .dr_out(dr_out),
        .dr_tdi_mask(dr_tdi_mask),
        .jtag__tdi(jtag_tdi),
        .jtag__tms(jtag_tms),
        .jtag__ntrst(jtag__ntrst),
        .reset_n(reset_n),
        .dr_in(            dr_in),
        .dr_action(            dr_action),
        .ir(            ir),
        .tdo(            tdo)         );
    riscv_jtag_apb_dm dm_apb(
        .apb_clock(clk),
        .apb_clock__enable(1'b1),
        .jtag_tck(jtag_tck),
        .jtag_tck__enable(jtag_tck_gated__enable),
        .apb_response__perr(apb_response__perr),
        .apb_response__pready(apb_response__pready),
        .apb_response__prdata(apb_response__prdata),
        .dr_in(dr_in),
        .dr_action(dr_action),
        .ir(ir),
        .reset_n(reset_n),
        .apb_request__pwdata(            apb_request__pwdata),
        .apb_request__pwrite(            apb_request__pwrite),
        .apb_request__psel(            apb_request__psel),
        .apb_request__penable(            apb_request__penable),
        .apb_request__paddr(            apb_request__paddr),
        .dr_out(            dr_out),
        .dr_tdi_mask(            dr_tdi_mask)         );
    riscv_i32_debug dm(
        .clk(clk),
        .clk__enable(1'b1),
        .debug_tgt__attention(debug_tgt__attention),
        .debug_tgt__data(debug_tgt__data),
        .debug_tgt__resp(debug_tgt__resp),
        .debug_tgt__op_was_none(debug_tgt__op_was_none),
        .debug_tgt__hit_breakpoint(debug_tgt__hit_breakpoint),
        .debug_tgt__resumed(debug_tgt__resumed),
        .debug_tgt__halted(debug_tgt__halted),
        .debug_tgt__selected(debug_tgt__selected),
        .debug_tgt__valid(debug_tgt__valid),
        .apb_request__pwdata(apb_request__pwdata),
        .apb_request__pwrite(apb_request__pwrite),
        .apb_request__psel(apb_request__psel),
        .apb_request__penable(apb_request__penable),
        .apb_request__paddr(apb_request__paddr),
        .reset_n(reset_n),
        .debug_mst__data(            debug_mst__data),
        .debug_mst__arg(            debug_mst__arg),
        .debug_mst__op(            debug_mst__op),
        .debug_mst__mask(            debug_mst__mask),
        .debug_mst__select(            debug_mst__select),
        .debug_mst__valid(            debug_mst__valid),
        .apb_response__perr(            apb_response__perr),
        .apb_response__pready(            apb_response__pready),
        .apb_response__prdata(            apb_response__prdata)         );
    riscv_i32_pipeline_control pc(
        .clk(clk),
        .clk__enable(1'b1),
        .rv_select(6'h0),
        .debug_mst__data(debug_mst__data),
        .debug_mst__arg(debug_mst__arg),
        .debug_mst__op(debug_mst__op),
        .debug_mst__mask(debug_mst__mask),
        .debug_mst__select(debug_mst__select),
        .debug_mst__valid(debug_mst__valid),
        .trace__bkpt_reason(trace__bkpt_reason),
        .trace__bkpt_valid(trace__bkpt_valid),
        .trace__rfw_data(trace__rfw_data),
        .trace__rfw_rd(trace__rfw_rd),
        .trace__rfw_data_valid(trace__rfw_data_valid),
        .trace__rfw_retire(trace__rfw_retire),
        .trace__jalr(trace__jalr),
        .trace__ret(trace__ret),
        .trace__trap(trace__trap),
        .trace__branch_target(trace__branch_target),
        .trace__branch_taken(trace__branch_taken),
        .trace__instruction(trace__instruction),
        .trace__instr_pc(trace__instr_pc),
        .trace__mode(trace__mode),
        .trace__instr_valid(trace__instr_valid),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .pipeline_fetch_data__dec_pc_if_mispredicted(pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(pipeline_fetch_data__valid),
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__jalr(pipeline_response__exec__jalr),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__minimum_mode(pipeline_response__decode__idecode__minimum_mode),
        .pipeline_response__decode__idecode__funct7(pipeline_response__decode__idecode__funct7),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__pc(pipeline_response__decode__pc),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
        .csrs__dscratch1(csrs__dscratch1),
        .csrs__dscratch0(csrs__dscratch0),
        .csrs__depc(csrs__depc),
        .csrs__dcsr__prv(csrs__dcsr__prv),
        .csrs__dcsr__step(csrs__dcsr__step),
        .csrs__dcsr__nmip(csrs__dcsr__nmip),
        .csrs__dcsr__mprven(csrs__dcsr__mprven),
        .csrs__dcsr__cause(csrs__dcsr__cause),
        .csrs__dcsr__stoptime(csrs__dcsr__stoptime),
        .csrs__dcsr__stopcount(csrs__dcsr__stopcount),
        .csrs__dcsr__stepie(csrs__dcsr__stepie),
        .csrs__dcsr__ebreaku(csrs__dcsr__ebreaku),
        .csrs__dcsr__ebreaks(csrs__dcsr__ebreaks),
        .csrs__dcsr__ebreakm(csrs__dcsr__ebreakm),
        .csrs__dcsr__xdebug_ver(csrs__dcsr__xdebug_ver),
        .csrs__mie__usip(csrs__mie__usip),
        .csrs__mie__ssip(csrs__mie__ssip),
        .csrs__mie__msip(csrs__mie__msip),
        .csrs__mie__utip(csrs__mie__utip),
        .csrs__mie__stip(csrs__mie__stip),
        .csrs__mie__mtip(csrs__mie__mtip),
        .csrs__mie__ueip(csrs__mie__ueip),
        .csrs__mie__seip(csrs__mie__seip),
        .csrs__mie__meip(csrs__mie__meip),
        .csrs__mip__usip(csrs__mip__usip),
        .csrs__mip__ssip(csrs__mip__ssip),
        .csrs__mip__msip(csrs__mip__msip),
        .csrs__mip__utip(csrs__mip__utip),
        .csrs__mip__stip(csrs__mip__stip),
        .csrs__mip__mtip(csrs__mip__mtip),
        .csrs__mip__ueip_sw(csrs__mip__ueip_sw),
        .csrs__mip__seip_sw(csrs__mip__seip_sw),
        .csrs__mip__ueip(csrs__mip__ueip),
        .csrs__mip__seip(csrs__mip__seip),
        .csrs__mip__meip(csrs__mip__meip),
        .csrs__mstatus__uie(csrs__mstatus__uie),
        .csrs__mstatus__sie(csrs__mstatus__sie),
        .csrs__mstatus__mie(csrs__mstatus__mie),
        .csrs__mstatus__upie(csrs__mstatus__upie),
        .csrs__mstatus__spie(csrs__mstatus__spie),
        .csrs__mstatus__mpie(csrs__mstatus__mpie),
        .csrs__mstatus__spp(csrs__mstatus__spp),
        .csrs__mstatus__mpp(csrs__mstatus__mpp),
        .csrs__mstatus__fs(csrs__mstatus__fs),
        .csrs__mstatus__xs(csrs__mstatus__xs),
        .csrs__mstatus__mprv(csrs__mstatus__mprv),
        .csrs__mstatus__sum(csrs__mstatus__sum),
        .csrs__mstatus__mxr(csrs__mstatus__mxr),
        .csrs__mstatus__tvm(csrs__mstatus__tvm),
        .csrs__mstatus__tw(csrs__mstatus__tw),
        .csrs__mstatus__tsr(csrs__mstatus__tsr),
        .csrs__mstatus__sd(csrs__mstatus__sd),
        .csrs__mtvec__vectored(csrs__mtvec__vectored),
        .csrs__mtvec__base(csrs__mtvec__base),
        .csrs__mtval(csrs__mtval),
        .csrs__mcause(csrs__mcause),
        .csrs__mepc(csrs__mepc),
        .csrs__mscratch(csrs__mscratch),
        .csrs__time(csrs__time),
        .csrs__instret(csrs__instret),
        .csrs__cycles(csrs__cycles),
        .riscv_clk_enable(riscv_clk_enable),
        .reset_n(reset_n),
        .debug_tgt__attention(            debug_tgt0__attention),
        .debug_tgt__data(            debug_tgt0__data),
        .debug_tgt__resp(            debug_tgt0__resp),
        .debug_tgt__op_was_none(            debug_tgt0__op_was_none),
        .debug_tgt__hit_breakpoint(            debug_tgt0__hit_breakpoint),
        .debug_tgt__resumed(            debug_tgt0__resumed),
        .debug_tgt__halted(            debug_tgt0__halted),
        .debug_tgt__selected(            debug_tgt0__selected),
        .debug_tgt__valid(            debug_tgt0__valid),
        .pipeline_control__instruction_debug__data(            pipeline_control__instruction_debug__data),
        .pipeline_control__instruction_debug__debug_op(            pipeline_control__instruction_debug__debug_op),
        .pipeline_control__instruction_debug__valid(            pipeline_control__instruction_debug__valid),
        .pipeline_control__instruction_data(            pipeline_control__instruction_data),
        .pipeline_control__interrupt_to_mode(            pipeline_control__interrupt_to_mode),
        .pipeline_control__interrupt_number(            pipeline_control__interrupt_number),
        .pipeline_control__interrupt_req(            pipeline_control__interrupt_req),
        .pipeline_control__ebreak_to_dbg(            pipeline_control__ebreak_to_dbg),
        .pipeline_control__halt(            pipeline_control__halt),
        .pipeline_control__tag(            pipeline_control__tag),
        .pipeline_control__error(            pipeline_control__error),
        .pipeline_control__mode(            pipeline_control__mode),
        .pipeline_control__fetch_pc(            pipeline_control__fetch_pc),
        .pipeline_control__fetch_action(            pipeline_control__fetch_action),
        .pipeline_control__valid(            pipeline_control__valid)         );
    riscv_i32_pipeline_control_fetch_req pc_fetch_req(
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__jalr(pipeline_response__exec__jalr),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__minimum_mode(pipeline_response__decode__idecode__minimum_mode),
        .pipeline_response__decode__idecode__funct7(pipeline_response__decode__idecode__funct7),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__pc(pipeline_response__decode__pc),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
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
        .ifetch_req__pc_if_mispredicted(            rv_imem_access_req__pc_if_mispredicted),
        .ifetch_req__predicted_branch(            rv_imem_access_req__predicted_branch),
        .ifetch_req__mode(            rv_imem_access_req__mode),
        .ifetch_req__address(            rv_imem_access_req__address),
        .ifetch_req__debug_fetch(            rv_imem_access_req__debug_fetch),
        .ifetch_req__req_type(            rv_imem_access_req__req_type),
        .ifetch_req__flush_pipeline(            rv_imem_access_req__flush_pipeline)         );
    riscv_i32_pipeline_control_fetch_data pc_fetch_data(
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__jalr(pipeline_response__exec__jalr),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__minimum_mode(pipeline_response__decode__idecode__minimum_mode),
        .pipeline_response__decode__idecode__funct7(pipeline_response__decode__idecode__funct7),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__pc(pipeline_response__decode__pc),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
        .ifetch_resp__tag(rv_imem_access_resp__tag),
        .ifetch_resp__error(rv_imem_access_resp__error),
        .ifetch_resp__mode(rv_imem_access_resp__mode),
        .ifetch_resp__data(rv_imem_access_resp__data),
        .ifetch_resp__debug(rv_imem_access_resp__debug),
        .ifetch_resp__valid(rv_imem_access_resp__valid),
        .ifetch_req__pc_if_mispredicted(rv_imem_access_req__pc_if_mispredicted),
        .ifetch_req__predicted_branch(rv_imem_access_req__predicted_branch),
        .ifetch_req__mode(rv_imem_access_req__mode),
        .ifetch_req__address(rv_imem_access_req__address),
        .ifetch_req__debug_fetch(rv_imem_access_req__debug_fetch),
        .ifetch_req__req_type(rv_imem_access_req__req_type),
        .ifetch_req__flush_pipeline(rv_imem_access_req__flush_pipeline),
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
        .pipeline_fetch_data__dec_pc_if_mispredicted(            pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(            pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(            pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(            pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(            pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(            pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(            pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(            pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(            pipeline_fetch_data__valid)         );
    riscv_i32_pipeline_control_csr_trace pc_csr_trace(
        .coproc_response__cannot_complete(coproc_response__cannot_complete),
        .coproc_response__result_valid(coproc_response__result_valid),
        .coproc_response__result(coproc_response__result),
        .coproc_response__cannot_start(coproc_response__cannot_start),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .pipeline_fetch_data__dec_pc_if_mispredicted(pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(pipeline_fetch_data__valid),
        .pipeline_response__pipeline_empty(pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(pipeline_response__exec__trap__valid),
        .pipeline_response__exec__jalr(pipeline_response__exec__jalr),
        .pipeline_response__exec__branch_taken(pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__minimum_mode(pipeline_response__decode__idecode__minimum_mode),
        .pipeline_response__decode__idecode__funct7(pipeline_response__decode__idecode__funct7),
        .pipeline_response__decode__idecode__subop(pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(pipeline_response__decode__branch_target),
        .pipeline_response__decode__pc(pipeline_response__decode__pc),
        .pipeline_response__decode__blocked(pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(pipeline_response__decode__valid),
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
        .trace__bkpt_reason(            trace__bkpt_reason),
        .trace__bkpt_valid(            trace__bkpt_valid),
        .trace__rfw_data(            trace__rfw_data),
        .trace__rfw_rd(            trace__rfw_rd),
        .trace__rfw_data_valid(            trace__rfw_data_valid),
        .trace__rfw_retire(            trace__rfw_retire),
        .trace__jalr(            trace__jalr),
        .trace__ret(            trace__ret),
        .trace__trap(            trace__trap),
        .trace__branch_target(            trace__branch_target),
        .trace__branch_taken(            trace__branch_taken),
        .trace__instruction(            trace__instruction),
        .trace__instr_pc(            trace__instr_pc),
        .trace__mode(            trace__mode),
        .trace__instr_valid(            trace__instr_valid),
        .csr_controls__trap__ebreak_to_dbg(            csr_controls__trap__ebreak_to_dbg),
        .csr_controls__trap__vector(            csr_controls__trap__vector),
        .csr_controls__trap__ret(            csr_controls__trap__ret),
        .csr_controls__trap__value(            csr_controls__trap__value),
        .csr_controls__trap__pc(            csr_controls__trap__pc),
        .csr_controls__trap__cause(            csr_controls__trap__cause),
        .csr_controls__trap__to_mode(            csr_controls__trap__to_mode),
        .csr_controls__trap__valid(            csr_controls__trap__valid),
        .csr_controls__timer_value(            csr_controls__timer_value),
        .csr_controls__retire(            csr_controls__retire),
        .csr_controls__exec_mode(            csr_controls__exec_mode),
        .coproc_controls__alu_cannot_complete(            coproc_controls__alu_cannot_complete),
        .coproc_controls__alu_cannot_start(            coproc_controls__alu_cannot_start),
        .coproc_controls__alu_flush_pipeline(            coproc_controls__alu_flush_pipeline),
        .coproc_controls__alu_rs2(            coproc_controls__alu_rs2),
        .coproc_controls__alu_rs1(            coproc_controls__alu_rs1),
        .coproc_controls__dec_to_alu_blocked(            coproc_controls__dec_to_alu_blocked),
        .coproc_controls__dec_idecode__ext__dummy(            coproc_controls__dec_idecode__ext__dummy),
        .coproc_controls__dec_idecode__is_compressed(            coproc_controls__dec_idecode__is_compressed),
        .coproc_controls__dec_idecode__illegal_pc(            coproc_controls__dec_idecode__illegal_pc),
        .coproc_controls__dec_idecode__illegal(            coproc_controls__dec_idecode__illegal),
        .coproc_controls__dec_idecode__minimum_mode(            coproc_controls__dec_idecode__minimum_mode),
        .coproc_controls__dec_idecode__funct7(            coproc_controls__dec_idecode__funct7),
        .coproc_controls__dec_idecode__subop(            coproc_controls__dec_idecode__subop),
        .coproc_controls__dec_idecode__op(            coproc_controls__dec_idecode__op),
        .coproc_controls__dec_idecode__immediate_valid(            coproc_controls__dec_idecode__immediate_valid),
        .coproc_controls__dec_idecode__immediate_shift(            coproc_controls__dec_idecode__immediate_shift),
        .coproc_controls__dec_idecode__immediate(            coproc_controls__dec_idecode__immediate),
        .coproc_controls__dec_idecode__csr_access__write_data(            coproc_controls__dec_idecode__csr_access__write_data),
        .coproc_controls__dec_idecode__csr_access__address(            coproc_controls__dec_idecode__csr_access__address),
        .coproc_controls__dec_idecode__csr_access__access(            coproc_controls__dec_idecode__csr_access__access),
        .coproc_controls__dec_idecode__csr_access__access_cancelled(            coproc_controls__dec_idecode__csr_access__access_cancelled),
        .coproc_controls__dec_idecode__rd_written(            coproc_controls__dec_idecode__rd_written),
        .coproc_controls__dec_idecode__rd(            coproc_controls__dec_idecode__rd),
        .coproc_controls__dec_idecode__rs2_valid(            coproc_controls__dec_idecode__rs2_valid),
        .coproc_controls__dec_idecode__rs2(            coproc_controls__dec_idecode__rs2),
        .coproc_controls__dec_idecode__rs1_valid(            coproc_controls__dec_idecode__rs1_valid),
        .coproc_controls__dec_idecode__rs1(            coproc_controls__dec_idecode__rs1),
        .coproc_controls__dec_idecode_valid(            coproc_controls__dec_idecode_valid)         );
    riscv_i32c_pipeline3 dut(
        .clk(clk),
        .clk__enable(riscv_clk__enable),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .csr_read_data(csr_data__read_data),
        .coproc_response__cannot_complete(coproc_response__cannot_complete),
        .coproc_response__result_valid(coproc_response__result_valid),
        .coproc_response__result(coproc_response__result),
        .coproc_response__cannot_start(coproc_response__cannot_start),
        .dmem_access_resp__read_data(dmem_access_resp__read_data),
        .dmem_access_resp__read_data_valid(dmem_access_resp__read_data_valid),
        .dmem_access_resp__abort_req(dmem_access_resp__abort_req),
        .dmem_access_resp__ack(dmem_access_resp__ack),
        .dmem_access_resp__ack_if_seq(dmem_access_resp__ack_if_seq),
        .pipeline_fetch_data__dec_pc_if_mispredicted(pipeline_fetch_data__dec_pc_if_mispredicted),
        .pipeline_fetch_data__dec_predicted_branch(pipeline_fetch_data__dec_predicted_branch),
        .pipeline_fetch_data__dec_flush_pipeline(pipeline_fetch_data__dec_flush_pipeline),
        .pipeline_fetch_data__instruction__debug__data(pipeline_fetch_data__instruction__debug__data),
        .pipeline_fetch_data__instruction__debug__debug_op(pipeline_fetch_data__instruction__debug__debug_op),
        .pipeline_fetch_data__instruction__debug__valid(pipeline_fetch_data__instruction__debug__valid),
        .pipeline_fetch_data__instruction__data(pipeline_fetch_data__instruction__data),
        .pipeline_fetch_data__pc(pipeline_fetch_data__pc),
        .pipeline_fetch_data__valid(pipeline_fetch_data__valid),
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
        .reset_n(reset_n),
        .csr_access__write_data(            csr_access__write_data),
        .csr_access__address(            csr_access__address),
        .csr_access__access(            csr_access__access),
        .csr_access__access_cancelled(            csr_access__access_cancelled),
        .dmem_access_req__write_data(            dmem_access_req__write_data),
        .dmem_access_req__byte_enable(            dmem_access_req__byte_enable),
        .dmem_access_req__sequential(            dmem_access_req__sequential),
        .dmem_access_req__address(            dmem_access_req__address),
        .dmem_access_req__req_type(            dmem_access_req__req_type),
        .dmem_access_req__valid(            dmem_access_req__valid),
        .pipeline_response__pipeline_empty(            pipeline_response__pipeline_empty),
        .pipeline_response__rfw__data(            pipeline_response__rfw__data),
        .pipeline_response__rfw__rd(            pipeline_response__rfw__rd),
        .pipeline_response__rfw__rd_written(            pipeline_response__rfw__rd_written),
        .pipeline_response__rfw__valid(            pipeline_response__rfw__valid),
        .pipeline_response__exec__pc_if_mispredicted(            pipeline_response__exec__pc_if_mispredicted),
        .pipeline_response__exec__predicted_branch(            pipeline_response__exec__predicted_branch),
        .pipeline_response__exec__pc(            pipeline_response__exec__pc),
        .pipeline_response__exec__rs2(            pipeline_response__exec__rs2),
        .pipeline_response__exec__rs1(            pipeline_response__exec__rs1),
        .pipeline_response__exec__instruction__debug__data(            pipeline_response__exec__instruction__debug__data),
        .pipeline_response__exec__instruction__debug__debug_op(            pipeline_response__exec__instruction__debug__debug_op),
        .pipeline_response__exec__instruction__debug__valid(            pipeline_response__exec__instruction__debug__valid),
        .pipeline_response__exec__instruction__data(            pipeline_response__exec__instruction__data),
        .pipeline_response__exec__is_compressed(            pipeline_response__exec__is_compressed),
        .pipeline_response__exec__trap__ebreak_to_dbg(            pipeline_response__exec__trap__ebreak_to_dbg),
        .pipeline_response__exec__trap__vector(            pipeline_response__exec__trap__vector),
        .pipeline_response__exec__trap__ret(            pipeline_response__exec__trap__ret),
        .pipeline_response__exec__trap__value(            pipeline_response__exec__trap__value),
        .pipeline_response__exec__trap__pc(            pipeline_response__exec__trap__pc),
        .pipeline_response__exec__trap__cause(            pipeline_response__exec__trap__cause),
        .pipeline_response__exec__trap__to_mode(            pipeline_response__exec__trap__to_mode),
        .pipeline_response__exec__trap__valid(            pipeline_response__exec__trap__valid),
        .pipeline_response__exec__jalr(            pipeline_response__exec__jalr),
        .pipeline_response__exec__branch_taken(            pipeline_response__exec__branch_taken),
        .pipeline_response__exec__interrupt_ack(            pipeline_response__exec__interrupt_ack),
        .pipeline_response__exec__cannot_complete(            pipeline_response__exec__cannot_complete),
        .pipeline_response__exec__cannot_start(            pipeline_response__exec__cannot_start),
        .pipeline_response__exec__valid(            pipeline_response__exec__valid),
        .pipeline_response__decode__enable_branch_prediction(            pipeline_response__decode__enable_branch_prediction),
        .pipeline_response__decode__idecode__ext__dummy(            pipeline_response__decode__idecode__ext__dummy),
        .pipeline_response__decode__idecode__is_compressed(            pipeline_response__decode__idecode__is_compressed),
        .pipeline_response__decode__idecode__illegal_pc(            pipeline_response__decode__idecode__illegal_pc),
        .pipeline_response__decode__idecode__illegal(            pipeline_response__decode__idecode__illegal),
        .pipeline_response__decode__idecode__minimum_mode(            pipeline_response__decode__idecode__minimum_mode),
        .pipeline_response__decode__idecode__funct7(            pipeline_response__decode__idecode__funct7),
        .pipeline_response__decode__idecode__subop(            pipeline_response__decode__idecode__subop),
        .pipeline_response__decode__idecode__op(            pipeline_response__decode__idecode__op),
        .pipeline_response__decode__idecode__immediate_valid(            pipeline_response__decode__idecode__immediate_valid),
        .pipeline_response__decode__idecode__immediate_shift(            pipeline_response__decode__idecode__immediate_shift),
        .pipeline_response__decode__idecode__immediate(            pipeline_response__decode__idecode__immediate),
        .pipeline_response__decode__idecode__csr_access__write_data(            pipeline_response__decode__idecode__csr_access__write_data),
        .pipeline_response__decode__idecode__csr_access__address(            pipeline_response__decode__idecode__csr_access__address),
        .pipeline_response__decode__idecode__csr_access__access(            pipeline_response__decode__idecode__csr_access__access),
        .pipeline_response__decode__idecode__csr_access__access_cancelled(            pipeline_response__decode__idecode__csr_access__access_cancelled),
        .pipeline_response__decode__idecode__rd_written(            pipeline_response__decode__idecode__rd_written),
        .pipeline_response__decode__idecode__rd(            pipeline_response__decode__idecode__rd),
        .pipeline_response__decode__idecode__rs2_valid(            pipeline_response__decode__idecode__rs2_valid),
        .pipeline_response__decode__idecode__rs2(            pipeline_response__decode__idecode__rs2),
        .pipeline_response__decode__idecode__rs1_valid(            pipeline_response__decode__idecode__rs1_valid),
        .pipeline_response__decode__idecode__rs1(            pipeline_response__decode__idecode__rs1),
        .pipeline_response__decode__branch_target(            pipeline_response__decode__branch_target),
        .pipeline_response__decode__pc(            pipeline_response__decode__pc),
        .pipeline_response__decode__blocked(            pipeline_response__decode__blocked),
        .pipeline_response__decode__valid(            pipeline_response__decode__valid)         );
    riscv_csrs_minimal csrs(
        .clk(clk),
        .clk__enable(1'b1),
        .csr_controls__trap__ebreak_to_dbg(csr_controls__trap__ebreak_to_dbg),
        .csr_controls__trap__vector(csr_controls__trap__vector),
        .csr_controls__trap__ret(csr_controls__trap__ret),
        .csr_controls__trap__value(csr_controls__trap__value),
        .csr_controls__trap__pc(csr_controls__trap__pc),
        .csr_controls__trap__cause(csr_controls__trap__cause),
        .csr_controls__trap__to_mode(csr_controls__trap__to_mode),
        .csr_controls__trap__valid(csr_controls__trap__valid),
        .csr_controls__timer_value(csr_controls__timer_value),
        .csr_controls__retire(csr_controls__retire),
        .csr_controls__exec_mode(csr_controls__exec_mode),
        .csr_access__write_data(csr_access__write_data),
        .csr_access__address(csr_access__address),
        .csr_access__access(csr_access__access),
        .csr_access__access_cancelled(csr_access__access_cancelled),
        .irqs__time(irqs__time),
        .irqs__msip(irqs__msip),
        .irqs__mtip(irqs__mtip),
        .irqs__ueip(irqs__ueip),
        .irqs__seip(irqs__seip),
        .irqs__meip(irqs__meip),
        .irqs__nmi(irqs__nmi),
        .riscv_clk_enable(riscv_clk_enable),
        .reset_n(reset_n),
        .csrs__dscratch1(            csrs__dscratch1),
        .csrs__dscratch0(            csrs__dscratch0),
        .csrs__depc(            csrs__depc),
        .csrs__dcsr__prv(            csrs__dcsr__prv),
        .csrs__dcsr__step(            csrs__dcsr__step),
        .csrs__dcsr__nmip(            csrs__dcsr__nmip),
        .csrs__dcsr__mprven(            csrs__dcsr__mprven),
        .csrs__dcsr__cause(            csrs__dcsr__cause),
        .csrs__dcsr__stoptime(            csrs__dcsr__stoptime),
        .csrs__dcsr__stopcount(            csrs__dcsr__stopcount),
        .csrs__dcsr__stepie(            csrs__dcsr__stepie),
        .csrs__dcsr__ebreaku(            csrs__dcsr__ebreaku),
        .csrs__dcsr__ebreaks(            csrs__dcsr__ebreaks),
        .csrs__dcsr__ebreakm(            csrs__dcsr__ebreakm),
        .csrs__dcsr__xdebug_ver(            csrs__dcsr__xdebug_ver),
        .csrs__mie__usip(            csrs__mie__usip),
        .csrs__mie__ssip(            csrs__mie__ssip),
        .csrs__mie__msip(            csrs__mie__msip),
        .csrs__mie__utip(            csrs__mie__utip),
        .csrs__mie__stip(            csrs__mie__stip),
        .csrs__mie__mtip(            csrs__mie__mtip),
        .csrs__mie__ueip(            csrs__mie__ueip),
        .csrs__mie__seip(            csrs__mie__seip),
        .csrs__mie__meip(            csrs__mie__meip),
        .csrs__mip__usip(            csrs__mip__usip),
        .csrs__mip__ssip(            csrs__mip__ssip),
        .csrs__mip__msip(            csrs__mip__msip),
        .csrs__mip__utip(            csrs__mip__utip),
        .csrs__mip__stip(            csrs__mip__stip),
        .csrs__mip__mtip(            csrs__mip__mtip),
        .csrs__mip__ueip_sw(            csrs__mip__ueip_sw),
        .csrs__mip__seip_sw(            csrs__mip__seip_sw),
        .csrs__mip__ueip(            csrs__mip__ueip),
        .csrs__mip__seip(            csrs__mip__seip),
        .csrs__mip__meip(            csrs__mip__meip),
        .csrs__mstatus__uie(            csrs__mstatus__uie),
        .csrs__mstatus__sie(            csrs__mstatus__sie),
        .csrs__mstatus__mie(            csrs__mstatus__mie),
        .csrs__mstatus__upie(            csrs__mstatus__upie),
        .csrs__mstatus__spie(            csrs__mstatus__spie),
        .csrs__mstatus__mpie(            csrs__mstatus__mpie),
        .csrs__mstatus__spp(            csrs__mstatus__spp),
        .csrs__mstatus__mpp(            csrs__mstatus__mpp),
        .csrs__mstatus__fs(            csrs__mstatus__fs),
        .csrs__mstatus__xs(            csrs__mstatus__xs),
        .csrs__mstatus__mprv(            csrs__mstatus__mprv),
        .csrs__mstatus__sum(            csrs__mstatus__sum),
        .csrs__mstatus__mxr(            csrs__mstatus__mxr),
        .csrs__mstatus__tvm(            csrs__mstatus__tvm),
        .csrs__mstatus__tw(            csrs__mstatus__tw),
        .csrs__mstatus__tsr(            csrs__mstatus__tsr),
        .csrs__mstatus__sd(            csrs__mstatus__sd),
        .csrs__mtvec__vectored(            csrs__mtvec__vectored),
        .csrs__mtvec__base(            csrs__mtvec__base),
        .csrs__mtval(            csrs__mtval),
        .csrs__mcause(            csrs__mcause),
        .csrs__mepc(            csrs__mepc),
        .csrs__mscratch(            csrs__mscratch),
        .csrs__time(            csrs__time),
        .csrs__instret(            csrs__instret),
        .csrs__cycles(            csrs__cycles),
        .csr_data__illegal_access(            csr_data__illegal_access),
        .csr_data__interrupt_cause(            csr_data__interrupt_cause),
        .csr_data__interrupt_mode(            csr_data__interrupt_mode),
        .csr_data__take_interrupt(            csr_data__take_interrupt),
        .csr_data__read_data(            csr_data__read_data)         );
    riscv_i32_muldiv m(
        .clk(clk),
        .clk__enable(riscv_clk__enable),
        .riscv_config__unaligned_mem(riscv_config__unaligned_mem),
        .riscv_config__coproc_disable(riscv_config__coproc_disable),
        .riscv_config__debug_enable(riscv_config__debug_enable),
        .riscv_config__i32m_fuse(riscv_config__i32m_fuse),
        .riscv_config__i32m(riscv_config__i32m),
        .riscv_config__e32(riscv_config__e32),
        .riscv_config__i32c(riscv_config__i32c),
        .coproc_controls__alu_cannot_complete(coproc_controls__alu_cannot_complete),
        .coproc_controls__alu_cannot_start(coproc_controls__alu_cannot_start),
        .coproc_controls__alu_flush_pipeline(coproc_controls__alu_flush_pipeline),
        .coproc_controls__alu_rs2(coproc_controls__alu_rs2),
        .coproc_controls__alu_rs1(coproc_controls__alu_rs1),
        .coproc_controls__dec_to_alu_blocked(coproc_controls__dec_to_alu_blocked),
        .coproc_controls__dec_idecode__ext__dummy(coproc_controls__dec_idecode__ext__dummy),
        .coproc_controls__dec_idecode__is_compressed(coproc_controls__dec_idecode__is_compressed),
        .coproc_controls__dec_idecode__illegal_pc(coproc_controls__dec_idecode__illegal_pc),
        .coproc_controls__dec_idecode__illegal(coproc_controls__dec_idecode__illegal),
        .coproc_controls__dec_idecode__minimum_mode(coproc_controls__dec_idecode__minimum_mode),
        .coproc_controls__dec_idecode__funct7(coproc_controls__dec_idecode__funct7),
        .coproc_controls__dec_idecode__subop(coproc_controls__dec_idecode__subop),
        .coproc_controls__dec_idecode__op(coproc_controls__dec_idecode__op),
        .coproc_controls__dec_idecode__immediate_valid(coproc_controls__dec_idecode__immediate_valid),
        .coproc_controls__dec_idecode__immediate_shift(coproc_controls__dec_idecode__immediate_shift),
        .coproc_controls__dec_idecode__immediate(coproc_controls__dec_idecode__immediate),
        .coproc_controls__dec_idecode__csr_access__write_data(coproc_controls__dec_idecode__csr_access__write_data),
        .coproc_controls__dec_idecode__csr_access__address(coproc_controls__dec_idecode__csr_access__address),
        .coproc_controls__dec_idecode__csr_access__access(coproc_controls__dec_idecode__csr_access__access),
        .coproc_controls__dec_idecode__csr_access__access_cancelled(coproc_controls__dec_idecode__csr_access__access_cancelled),
        .coproc_controls__dec_idecode__rd_written(coproc_controls__dec_idecode__rd_written),
        .coproc_controls__dec_idecode__rd(coproc_controls__dec_idecode__rd),
        .coproc_controls__dec_idecode__rs2_valid(coproc_controls__dec_idecode__rs2_valid),
        .coproc_controls__dec_idecode__rs2(coproc_controls__dec_idecode__rs2),
        .coproc_controls__dec_idecode__rs1_valid(coproc_controls__dec_idecode__rs1_valid),
        .coproc_controls__dec_idecode__rs1(coproc_controls__dec_idecode__rs1),
        .coproc_controls__dec_idecode_valid(coproc_controls__dec_idecode_valid),
        .reset_n(reset_n),
        .coproc_response__cannot_complete(            coproc_response__cannot_complete),
        .coproc_response__result_valid(            coproc_response__result_valid),
        .coproc_response__result(            coproc_response__result),
        .coproc_response__cannot_start(            coproc_response__cannot_start)         );
    riscv_i32_trace trace(
        .clk(clk),
        .clk__enable(1'b1),
        .trace__bkpt_reason(trace__bkpt_reason),
        .trace__bkpt_valid(trace__bkpt_valid),
        .trace__rfw_data(trace__rfw_data),
        .trace__rfw_rd(trace__rfw_rd),
        .trace__rfw_data_valid(trace__rfw_data_valid),
        .trace__rfw_retire(trace__rfw_retire),
        .trace__jalr(trace__jalr),
        .trace__ret(trace__ret),
        .trace__trap(trace__trap),
        .trace__branch_target(trace__branch_target),
        .trace__branch_taken(trace__branch_taken),
        .trace__instruction(trace__instruction),
        .trace__instr_pc(trace__instr_pc),
        .trace__mode(trace__mode),
        .trace__instr_valid(trace__instr_valid),
        .riscv_clk_enable(riscv_clk_enable),
        .reset_n(reset_n)         );
    /*chk_riscv_ifetch checker_ifetch(
        .clk(clk),
        .clk__enable(riscv_clk__enable),
        .fetch_resp__tag(rv_imem_access_resp__tag),
        .fetch_resp__error(rv_imem_access_resp__error),
        .fetch_resp__mode(rv_imem_access_resp__mode),
        .fetch_resp__data(rv_imem_access_resp__data),
        .fetch_resp__debug(rv_imem_access_resp__debug),
        .fetch_resp__valid(rv_imem_access_resp__valid),
        .fetch_req__pc_if_mispredicted(rv_imem_access_req__pc_if_mispredicted),
        .fetch_req__predicted_branch(rv_imem_access_req__predicted_branch),
        .fetch_req__mode(rv_imem_access_req__mode),
        .fetch_req__address(rv_imem_access_req__address),
        .fetch_req__debug_fetch(rv_imem_access_req__debug_fetch),
        .fetch_req__req_type(rv_imem_access_req__req_type),
        .fetch_req__flush_pipeline(rv_imem_access_req__flush_pipeline)         );
    chk_riscv_trace checker_trace(
        .clk(clk),
        .clk__enable(riscv_clk__enable),
        .trace__bkpt_reason(trace__bkpt_reason),
        .trace__bkpt_valid(trace__bkpt_valid),
        .trace__rfw_data(trace__rfw_data),
        .trace__rfw_rd(trace__rfw_rd),
        .trace__rfw_data_valid(trace__rfw_data_valid),
        .trace__rfw_retire(trace__rfw_retire),
        .trace__jalr(trace__jalr),
        .trace__ret(trace__ret),
        .trace__trap(trace__trap),
        .trace__branch_target(trace__branch_target),
        .trace__branch_taken(trace__branch_taken),
        .trace__instruction(trace__instruction),
        .trace__instr_pc(trace__instr_pc),
        .trace__mode(trace__mode),
        .trace__instr_valid(trace__instr_valid)         );*/
    //b clock_divider clock process
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : clock_divider__code
        if (reset_n==1'b0)
        begin
            riscv_clk_cycle_0 <= 1'h1;
            riscv_clk_cycle_1 <= 1'h0;
            riscv_clk_cycle_2 <= 1'h0;
            clk_divider <= 2'h0;
        end
        else if (clk__enable)
        begin
            riscv_clk_cycle_0 <= (clk_divider==2'h2);
            riscv_clk_cycle_1 <= (clk_divider==2'h0);
            riscv_clk_cycle_2 <= (clk_divider==2'h1);
            clk_divider <= (clk_divider+2'h1);
            if ((riscv_clk_cycle_2!=1'h0))
            begin
                clk_divider <= 2'h0;
            end //if
        end //if
    end //always

    //b srams__comb combinatorial process
    always @ ( * )//srams__comb
    begin: srams__comb_code
    reg rv_imem_access_resp__valid__var;
    reg [31:0]rv_imem_access_resp__data__var;
    reg [2:0]rv_imem_access_resp__mode__var;
    reg imem_access_req__flush_pipeline__var;
    reg [2:0]imem_access_req__req_type__var;
    reg imem_access_req__debug_fetch__var;
    reg [31:0]imem_access_req__address__var;
    reg [2:0]imem_access_req__mode__var;
    reg imem_access_req__predicted_branch__var;
    reg [31:0]imem_access_req__pc_if_mispredicted__var;
        rv_imem_access_resp__valid__var = 1'h0;
        rv_imem_access_resp__debug = 1'h0;
        rv_imem_access_resp__data__var = 32'h0;
        rv_imem_access_resp__mode__var = 3'h0;
        rv_imem_access_resp__error = 1'h0;
        rv_imem_access_resp__tag = 2'h0;
        rv_imem_access_resp__valid__var = (rv_imem_access_req__req_type!=3'h0);
        rv_imem_access_resp__data__var = imem_mem_read_data;
        rv_imem_access_resp__mode__var = rv_imem_access_req__mode;
        if (!(rv_imem_access_req__address[1]!=1'h0))
        begin
            imem_access_req__flush_pipeline__var = rv_imem_access_req__flush_pipeline;
            imem_access_req__req_type__var = rv_imem_access_req__req_type;
            imem_access_req__debug_fetch__var = rv_imem_access_req__debug_fetch;
            imem_access_req__address__var = rv_imem_access_req__address;
            imem_access_req__mode__var = rv_imem_access_req__mode;
            imem_access_req__predicted_branch__var = rv_imem_access_req__predicted_branch;
            imem_access_req__pc_if_mispredicted__var = rv_imem_access_req__pc_if_mispredicted;
            rv_imem_access_resp__data__var = imem_mem_read_data;
        end //if
        else
        
        begin
            if ((riscv_clk_cycle_0!=1'h0))
            begin
                imem_access_req__flush_pipeline__var = rv_imem_access_req__flush_pipeline;
                imem_access_req__req_type__var = rv_imem_access_req__req_type;
                imem_access_req__debug_fetch__var = rv_imem_access_req__debug_fetch;
                imem_access_req__address__var = rv_imem_access_req__address;
                imem_access_req__mode__var = rv_imem_access_req__mode;
                imem_access_req__predicted_branch__var = rv_imem_access_req__predicted_branch;
                imem_access_req__pc_if_mispredicted__var = rv_imem_access_req__pc_if_mispredicted;
            end //if
            else
            
            begin
                imem_access_req__flush_pipeline__var = rv_imem_access_req__flush_pipeline;
                imem_access_req__req_type__var = rv_imem_access_req__req_type;
                imem_access_req__debug_fetch__var = rv_imem_access_req__debug_fetch;
                imem_access_req__address__var = rv_imem_access_req__address;
                imem_access_req__mode__var = rv_imem_access_req__mode;
                imem_access_req__predicted_branch__var = rv_imem_access_req__predicted_branch;
                imem_access_req__pc_if_mispredicted__var = rv_imem_access_req__pc_if_mispredicted;
                imem_access_req__address__var = (rv_imem_access_req__address+32'h4);
                rv_imem_access_resp__data__var = {imem_mem_read_data[15:0],last_imem_mem_read_data[31:16]};
            end //else
        end //else
        dmem_access_resp__ack = 1'h1;
        dmem_access_resp__ack_if_seq = 1'h1;
        dmem_access_resp__abort_req = 1'h0;
        dmem_access_resp__read_data_valid = 1'h1;
        dmem_access_resp__read_data = main_mem_read_data;
        rv_imem_access_resp__valid = rv_imem_access_resp__valid__var;
        rv_imem_access_resp__data = rv_imem_access_resp__data__var;
        rv_imem_access_resp__mode = rv_imem_access_resp__mode__var;
        imem_access_req__flush_pipeline = imem_access_req__flush_pipeline__var;
        imem_access_req__req_type = imem_access_req__req_type__var;
        imem_access_req__debug_fetch = imem_access_req__debug_fetch__var;
        imem_access_req__address = imem_access_req__address__var;
        imem_access_req__mode = imem_access_req__mode__var;
        imem_access_req__predicted_branch = imem_access_req__predicted_branch__var;
        imem_access_req__pc_if_mispredicted = imem_access_req__pc_if_mispredicted__var;
    end //always

    //b srams__posedge_clk_active_low_reset_n clock process
    always @( posedge clk or negedge reset_n)
    begin : srams__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            last_imem_mem_read_data <= 32'h0;
            dmem_select <= 1'h0;
            dmem_read_not_write <= 1'h0;
            dmem_address <= 14'h0;
            dmem_write_data <= 32'h0;
        end
        else if (clk__enable)
        begin
            last_imem_mem_read_data <= imem_mem_read_data;
            if ((riscv_clk_cycle_2!=1'h0))
            begin
                dmem_select <= ((dmem_access_req__valid!=1'h0)&&(dmem_access_resp__ack!=1'h0));
                dmem_read_not_write <= (dmem_access_req__req_type!=5'h2);
                dmem_address <= dmem_access_req__address[15:2];
                dmem_write_data <= dmem_access_req__write_data;
            end //if
        end //if
    end //always

    //b riscv_instance combinatorial process
    always @ ( * )//riscv_instance
    begin: riscv_instance__comb_code
    reg riscv_config__i32c__var;
    reg riscv_config__e32__var;
    reg riscv_config__i32m__var;
    reg riscv_config__i32m_fuse__var;
    reg riscv_config__debug_enable__var;
    reg riscv_config__coproc_disable__var;
        tck_enable_fix = tck_enable;
        debug_tgt__valid = debug_tgt0__valid;
        debug_tgt__selected = debug_tgt0__selected;
        debug_tgt__halted = debug_tgt0__halted;
        debug_tgt__resumed = debug_tgt0__resumed;
        debug_tgt__hit_breakpoint = debug_tgt0__hit_breakpoint;
        debug_tgt__op_was_none = debug_tgt0__op_was_none;
        debug_tgt__resp = debug_tgt0__resp;
        debug_tgt__data = debug_tgt0__data;
        debug_tgt__attention = debug_tgt0__attention;
        riscv_config__i32c__var = 1'h0;
        riscv_config__e32__var = 1'h0;
        riscv_config__i32m__var = 1'h0;
        riscv_config__i32m_fuse__var = 1'h0;
        riscv_config__debug_enable__var = 1'h0;
        riscv_config__coproc_disable__var = 1'h0;
        riscv_config__unaligned_mem = 1'h0;
        riscv_config__i32c__var = 1'h1;
        riscv_config__e32__var = 1'h0;
        riscv_config__i32m__var = 1'h1;
        riscv_config__i32m_fuse__var = 1'h1;
        riscv_config__coproc_disable__var = 1'h0;
        riscv_config__debug_enable__var = 1'h1;
        irqs__nmi = 1'h0;
        irqs__meip = 1'h0;
        irqs__seip = 1'h0;
        irqs__ueip = 1'h0;
        irqs__mtip = 1'h0;
        irqs__msip = 1'h0;
        irqs__time = 64'h0;
        riscv_clk_enable = riscv_clk_cycle_2;
        riscv_config__i32c = riscv_config__i32c__var;
        riscv_config__e32 = riscv_config__e32__var;
        riscv_config__i32m = riscv_config__i32m__var;
        riscv_config__i32m_fuse = riscv_config__i32m_fuse__var;
        riscv_config__debug_enable = riscv_config__debug_enable__var;
        riscv_config__coproc_disable = riscv_config__coproc_disable__var;
    end //always

endmodule // tb_riscv_i32mc_pipeline3
