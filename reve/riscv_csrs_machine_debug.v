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

//a Module riscv_csrs_machine_debug
    //   
    //   This module implements a minimal set of RISC-V CSRs, as per v2.1 (May
    //   2016) of the RISC-V instruction set manual user level ISA and v1.9.1
    //   of the privilege architecture (Nov 2016), with the exception that
    //   MTIME has been removed (as this seems to be the correct thing to do).
    //   
    //   The privilege specifcation (v1.10) indicates:
    //   
    //   * meip is read-only and is derived from the external irq in to this module
    //   
    //   * mtip is read-only, cleared by writing to the memory-mapped timer comparator
    //   
    //   * msip is read-write in a memory-mapped register somewhere
    //   
    //   Hence the irqs structure must provide these three signals
    //   
    //   
    //   Minimal CSRs as only machine mode and debug mode are supported.
    //   In debug mode every register access is supported.
    //   In machine mode then every register EXCEPT access to ??? is supported.
    //   
    //   Given machine mode is the only mode supported:
    //   
    //   * there are no SEI and UEI interrupt pins in to this module
    //   
    //   * SEIP and UEIP are not supported
    //   
    //   * STIP and UTIP are not supported
    //   
    //   * SSIP and USIP are not supported
    //   
    //   * mstatus.SIE and mstatus.UIE (and previous versions) are hardwired to 0
    //   
    //   * mstatus.SPP and mstatus.UPP are hardwired to 0
    //   
    //   The mip (machine interrupt pending register) therefore is:
    //   
    //   {20b0, MEIP, 3b0, MTIP, 3b0, MSIP, 3b0}
    //   
    //   The mie (machine interrupt enable register) is:
    //   
    //   {20b0, MEIE, 3b0, MTIE, 3b0, MSIE, 3b0}
    //   
    //   
    //   The instruction to the pipeline to request an interrupt (which is only
    //   taken if an instruction is in uncommitted in the execution stage) must be generated using the
    //   execution mode and the interrupt enable bits and the interrupt pending
    //   bits.
    //   
    //   Hence the 'take interrupt' is (mip & mie) != 0 && mstatus.MIE && (current mode >= machine mode) && (current mode != debug mode).
    //   
    //   The required priority order is:
    //   
    //   external interrupts, software interrupts, timer interrupts
    //   
    //   If an instruction has been committed then it may trap, and the trap
    //   will occur prior to an interrupt which happens after the commit
    //   point. In this case there will be a trap, and the trapped instruction
    //   will be fetched, and then an interrupt can be taken.
    //   
    //   When an interrupt is taken the following occurs:
    //   
    //   * MPP <= current execution mode (must be machine mode, as debug mode is not interruptible)
    //   
    //   * mstatus.MPIE <= mstatus.MIE
    //   
    //   Note that WFI should wait independent of mstatus.MIE for (mip & mie) != 0 (given machine mode only)
    //   In debug mode WFI should be a NOP.
    //   
    //   WFI may always be a NOP.
    //   
    //   
    //   User mode interrupts
    //   --------------------
    //   
    //   For user mode interrupts there has to be support for delegating an interrupt to user mode - hence the medeleg and mideleg need support (read/write)
    //   
    //   User mode interrupts are disabled if mstatus.uie is clear
    //   
    //   When an interrupt/exception is delegated to user mode uepc/ucause/utval/mstatus.upie are set to the address, cause etc and mstatus.uie at the interrupt/exception
    //   mstatus.uie is a bit of mstatus that is CLEARED on a user interrupt/exception, and which is set to mstatus.upie on uret; mstatus.upie is then set
    //   
    //   uscratch is a 32-bit register for use in the trap handler (and outside it too, if necessary)
    //   
    //   utvec is a user vector base for vectored user interrupts
    //   
    //   mstatus.uie and mstatus.upie are visible (and only these 2 bits) in 'ustatus'
    //   
    //   On uret, uepc/ucause/utval can be cleared (i.e. they are guaranteed to be invalid outside of a user trap handler). mstatus.uie become mstatus.upie; mstatus.upie is set; pc becomes mstatus.uepc
    //   
    //   The following CSRs should therefore be supplied for user mode interrupts: ustatus, uie, utvec, uscratch, uepc, ucause, utval, uip.
    //   
module riscv_csrs_machine_debug
(
    riscv_clk,
    riscv_clk__enable,
    clk,
    clk__enable,

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
    irqs__nmi,
    irqs__meip,
    irqs__seip,
    irqs__ueip,
    irqs__mtip,
    irqs__msip,
    irqs__time,
    riscv_clk_enable,
    reset_n,

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
    csrs__uscratch,
    csrs__uepc,
    csrs__ucause,
    csrs__utval,
    csrs__utvec__base,
    csrs__utvec__vectored,
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
    csr_data__read_data,
    csr_data__take_interrupt,
    csr_data__interrupt_mode,
    csr_data__interrupt_cause
);

    //b Clocks
        //   Clk gated by riscv_clk_enable - provide for single clock gate outside the module
    input riscv_clk;
    input riscv_clk__enable;
        //   Free-running clock
    input clk;
    input clk__enable;

    //b Inputs
        //   Control signals to update the CSRs
    input [2:0]csr_controls__exec_mode;
    input csr_controls__retire;
    input [63:0]csr_controls__timer_value;
    input csr_controls__trap__valid;
    input [2:0]csr_controls__trap__to_mode;
    input [4:0]csr_controls__trap__cause;
    input [31:0]csr_controls__trap__pc;
    input [31:0]csr_controls__trap__value;
    input csr_controls__trap__ret;
    input csr_controls__trap__ebreak_to_dbg;
        //   RISC-V CSR access, combinatorially decoded
    input [2:0]csr_access__mode;
    input csr_access__access_cancelled;
    input [2:0]csr_access__access;
    input [31:0]csr_access__custom__mhartid;
    input [31:0]csr_access__custom__misa;
    input [31:0]csr_access__custom__mvendorid;
    input [31:0]csr_access__custom__marchid;
    input [31:0]csr_access__custom__mimpid;
    input [11:0]csr_access__address;
    input [11:0]csr_access__select;
    input [31:0]csr_access__write_data;
        //   Interrupts in to the CPU
    input irqs__nmi;
    input irqs__meip;
    input irqs__seip;
    input irqs__ueip;
    input irqs__mtip;
    input irqs__msip;
    input [63:0]irqs__time;
        //   RISC-V clock enable
    input riscv_clk_enable;
        //   Active low reset
    input reset_n;

    //b Outputs
        //   CSR values
    output [63:0]csrs__cycles;
    output [63:0]csrs__instret;
    output [63:0]csrs__time;
    output [31:0]csrs__mscratch;
    output [31:0]csrs__mepc;
    output [31:0]csrs__mcause;
    output [31:0]csrs__mtval;
    output [29:0]csrs__mtvec__base;
    output csrs__mtvec__vectored;
    output csrs__mstatus__sd;
    output csrs__mstatus__tsr;
    output csrs__mstatus__tw;
    output csrs__mstatus__tvm;
    output csrs__mstatus__mxr;
    output csrs__mstatus__sum;
    output csrs__mstatus__mprv;
    output [1:0]csrs__mstatus__xs;
    output [1:0]csrs__mstatus__fs;
    output [1:0]csrs__mstatus__mpp;
    output csrs__mstatus__spp;
    output csrs__mstatus__mpie;
    output csrs__mstatus__spie;
    output csrs__mstatus__upie;
    output csrs__mstatus__mie;
    output csrs__mstatus__sie;
    output csrs__mstatus__uie;
    output csrs__mip__meip;
    output csrs__mip__seip;
    output csrs__mip__ueip;
    output csrs__mip__seip_sw;
    output csrs__mip__ueip_sw;
    output csrs__mip__mtip;
    output csrs__mip__stip;
    output csrs__mip__utip;
    output csrs__mip__msip;
    output csrs__mip__ssip;
    output csrs__mip__usip;
    output csrs__mie__meip;
    output csrs__mie__seip;
    output csrs__mie__ueip;
    output csrs__mie__mtip;
    output csrs__mie__stip;
    output csrs__mie__utip;
    output csrs__mie__msip;
    output csrs__mie__ssip;
    output csrs__mie__usip;
    output [31:0]csrs__uscratch;
    output [31:0]csrs__uepc;
    output [31:0]csrs__ucause;
    output [31:0]csrs__utval;
    output [29:0]csrs__utvec__base;
    output csrs__utvec__vectored;
    output [3:0]csrs__dcsr__xdebug_ver;
    output csrs__dcsr__ebreakm;
    output csrs__dcsr__ebreaks;
    output csrs__dcsr__ebreaku;
    output csrs__dcsr__stepie;
    output csrs__dcsr__stopcount;
    output csrs__dcsr__stoptime;
    output [2:0]csrs__dcsr__cause;
    output csrs__dcsr__mprven;
    output csrs__dcsr__nmip;
    output csrs__dcsr__step;
    output [1:0]csrs__dcsr__prv;
    output [31:0]csrs__depc;
    output [31:0]csrs__dscratch0;
    output [31:0]csrs__dscratch1;
        //   CSR respone (including read data), from the current @a csr_access
    output [31:0]csr_data__read_data;
    output csr_data__take_interrupt;
    output [2:0]csr_data__interrupt_mode;
    output [3:0]csr_data__interrupt_cause;

// output components here

    //b Output combinatorials
        //   CSR respone (including read data), from the current @a csr_access
    reg [31:0]csr_data__read_data;
    reg csr_data__take_interrupt;
    reg [2:0]csr_data__interrupt_mode;
    reg [3:0]csr_data__interrupt_cause;

    //b Output nets

    //b Internal and output registers
        //   State bit to ensure that 'clk' is kept - can be used be other versions for state updates etc
    reg keep_clk;
    reg [63:0]csrs__cycles;
    reg [63:0]csrs__instret;
    reg [63:0]csrs__time;
    reg [31:0]csrs__mscratch;
    reg [31:0]csrs__mepc;
    reg [31:0]csrs__mcause;
    reg [31:0]csrs__mtval;
    reg [29:0]csrs__mtvec__base;
    reg csrs__mtvec__vectored;
    reg csrs__mstatus__sd;
    reg csrs__mstatus__tsr;
    reg csrs__mstatus__tw;
    reg csrs__mstatus__tvm;
    reg csrs__mstatus__mxr;
    reg csrs__mstatus__sum;
    reg csrs__mstatus__mprv;
    reg [1:0]csrs__mstatus__xs;
    reg [1:0]csrs__mstatus__fs;
    reg [1:0]csrs__mstatus__mpp;
    reg csrs__mstatus__spp;
    reg csrs__mstatus__mpie;
    reg csrs__mstatus__spie;
    reg csrs__mstatus__upie;
    reg csrs__mstatus__mie;
    reg csrs__mstatus__sie;
    reg csrs__mstatus__uie;
    reg csrs__mip__meip;
    reg csrs__mip__seip;
    reg csrs__mip__ueip;
    reg csrs__mip__seip_sw;
    reg csrs__mip__ueip_sw;
    reg csrs__mip__mtip;
    reg csrs__mip__stip;
    reg csrs__mip__utip;
    reg csrs__mip__msip;
    reg csrs__mip__ssip;
    reg csrs__mip__usip;
    reg csrs__mie__meip;
    reg csrs__mie__seip;
    reg csrs__mie__ueip;
    reg csrs__mie__mtip;
    reg csrs__mie__stip;
    reg csrs__mie__utip;
    reg csrs__mie__msip;
    reg csrs__mie__ssip;
    reg csrs__mie__usip;
    reg [31:0]csrs__uscratch;
    reg [31:0]csrs__uepc;
    reg [31:0]csrs__ucause;
    reg [31:0]csrs__utval;
    reg [29:0]csrs__utvec__base;
    reg csrs__utvec__vectored;
    reg [3:0]csrs__dcsr__xdebug_ver;
    reg csrs__dcsr__ebreakm;
    reg csrs__dcsr__ebreaks;
    reg csrs__dcsr__ebreaku;
    reg csrs__dcsr__stepie;
    reg csrs__dcsr__stopcount;
    reg csrs__dcsr__stoptime;
    reg [2:0]csrs__dcsr__cause;
    reg csrs__dcsr__mprven;
    reg csrs__dcsr__nmip;
    reg csrs__dcsr__step;
    reg [1:0]csrs__dcsr__prv;
    reg [31:0]csrs__depc;
    reg [31:0]csrs__dscratch0;
    reg [31:0]csrs__dscratch1;

    //b Internal combinatorials
        //   Breakout for valid trap to mode
    reg trap_combs__d;
    reg trap_combs__m;
    reg trap_combs__s;
    reg trap_combs__u;
        //   Breakout for xRET
    reg ret_combs__d;
    reg ret_combs__m;
    reg ret_combs__s;
    reg ret_combs__u;
    reg csr_write__enable;
    reg [31:0]csr_write__data_mask;
    reg [31:0]csr_write__data_set;
    reg [31:0]csr_combs__ustatus;
    reg [31:0]csr_combs__utvec;
    reg [31:0]csr_combs__uip;
    reg [31:0]csr_combs__uie;
    reg [31:0]csr_combs__mstatus;
    reg [31:0]csr_combs__mtvec;
    reg [31:0]csr_combs__mip;
    reg [31:0]csr_combs__mie;
    reg [31:0]csr_combs__dcsr;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b clk_state clock process
    always @( posedge clk or negedge reset_n)
    begin : clk_state__code
        if (reset_n==1'b0)
        begin
            keep_clk <= 1'h0;
        end
        else if (clk__enable)
        begin
            keep_clk <= 1'h0;
        end //if
    end //always

    //b csr_bundling combinatorial process
        //   
        //       
    always @ ( * )//csr_bundling
    begin: csr_bundling__comb_code
        csr_combs__mstatus = {{{{{{{{{{{{{{{{{{{{csrs__mstatus__sd,8'h0},csrs__mstatus__tsr},csrs__mstatus__tw},csrs__mstatus__tvm},csrs__mstatus__mxr},csrs__mstatus__sum},csrs__mstatus__mprv},csrs__mstatus__xs},csrs__mstatus__fs},csrs__mstatus__mpp},2'h0},csrs__mstatus__spp},csrs__mstatus__mpie},1'h0},csrs__mstatus__spie},csrs__mstatus__upie},csrs__mstatus__mie},1'h0},csrs__mstatus__sie},csrs__mstatus__uie};
        csr_combs__mie = {{{{{{{{{{{{20'h0,csrs__mie__meip},1'h0},csrs__mie__seip},csrs__mie__ueip},csrs__mie__mtip},1'h0},csrs__mie__stip},csrs__mie__utip},csrs__mie__msip},1'h0},csrs__mie__ssip},csrs__mie__usip};
        csr_combs__mip = {{{{{{{{{{{{20'h0,csrs__mip__meip},1'h0},csrs__mip__seip},csrs__mip__ueip},csrs__mip__mtip},1'h0},csrs__mip__stip},csrs__mip__utip},csrs__mip__msip},1'h0},csrs__mip__ssip},csrs__mip__usip};
        csr_combs__mtvec = {{csrs__mtvec__base,1'h0},csrs__mtvec__vectored};
        csr_combs__ustatus = {{{27'h0,csrs__mstatus__upie},3'h0},csrs__mstatus__uie};
        csr_combs__uie = {{{{{23'h0,csrs__mie__ueip},3'h0},csrs__mie__utip},3'h0},csrs__mie__usip};
        csr_combs__uip = {{{{{23'h0,csrs__mip__ueip},3'h0},csrs__mip__utip},3'h0},csrs__mip__usip};
        csr_combs__utvec = {{csrs__utvec__base,1'h0},csrs__utvec__vectored};
        csr_combs__dcsr = {{{{{{{{{{{{{{csrs__dcsr__xdebug_ver,12'h0},csrs__dcsr__ebreakm},1'h0},csrs__dcsr__ebreaks},csrs__dcsr__ebreaku},csrs__dcsr__stepie},csrs__dcsr__stopcount},csrs__dcsr__stoptime},csrs__dcsr__cause},1'h0},csrs__dcsr__mprven},csrs__dcsr__nmip},csrs__dcsr__step},csrs__dcsr__prv};
    end //always

    //b csr_read_data combinatorial process
        //   
        //       
    always @ ( * )//csr_read_data
    begin: csr_read_data__comb_code
    reg [31:0]csr_data__read_data__var;
        csr_data__read_data__var = 32'h0;
        csr_data__take_interrupt = 1'h0;
        csr_data__interrupt_mode = 3'h0;
        csr_data__interrupt_cause = 4'h0;
        case (csr_access__select) //synopsys parallel_case
        12'h10: // req 1
            begin
            csr_data__read_data__var = csrs__time[31:0];
            end
        12'h11: // req 1
            begin
            csr_data__read_data__var = csrs__time[63:32];
            end
        12'h12: // req 1
            begin
            csr_data__read_data__var = csrs__cycles[31:0];
            end
        12'h13: // req 1
            begin
            csr_data__read_data__var = csrs__cycles[63:32];
            end
        12'h14: // req 1
            begin
            csr_data__read_data__var = csrs__instret[31:0];
            end
        12'h15: // req 1
            begin
            csr_data__read_data__var = csrs__instret[63:32];
            end
        12'h20: // req 1
            begin
            csr_data__read_data__var = (32'h0 | csr_access__custom__misa);
            end
        12'h21: // req 1
            begin
            csr_data__read_data__var = (32'h0 | csr_access__custom__mvendorid);
            end
        12'h22: // req 1
            begin
            csr_data__read_data__var = (32'h0 | csr_access__custom__marchid);
            end
        12'h23: // req 1
            begin
            csr_data__read_data__var = (32'h0 | csr_access__custom__mimpid);
            end
        12'h24: // req 1
            begin
            csr_data__read_data__var = (32'h0 | csr_access__custom__mhartid);
            end
        12'h40: // req 1
            begin
            csr_data__read_data__var = csr_combs__ustatus;
            end
        12'h41: // req 1
            begin
            csr_data__read_data__var = csrs__uscratch;
            end
        12'h42: // req 1
            begin
            csr_data__read_data__var = csr_combs__uie;
            end
        12'h43: // req 1
            begin
            csr_data__read_data__var = csr_combs__uip;
            end
        12'h44: // req 1
            begin
            csr_data__read_data__var = csr_combs__utvec;
            end
        12'h45: // req 1
            begin
            csr_data__read_data__var = csrs__utval;
            end
        12'h46: // req 1
            begin
            csr_data__read_data__var = csrs__uepc;
            end
        12'h47: // req 1
            begin
            csr_data__read_data__var = csrs__ucause;
            end
        12'h80: // req 1
            begin
            csr_data__read_data__var = csr_combs__mstatus;
            end
        12'h81: // req 1
            begin
            csr_data__read_data__var = csrs__mscratch;
            end
        12'h82: // req 1
            begin
            csr_data__read_data__var = csr_combs__mie;
            end
        12'h83: // req 1
            begin
            csr_data__read_data__var = csr_combs__mip;
            end
        12'h84: // req 1
            begin
            csr_data__read_data__var = csr_combs__mtvec;
            end
        12'h85: // req 1
            begin
            csr_data__read_data__var = csrs__mtval;
            end
        12'h86: // req 1
            begin
            csr_data__read_data__var = csrs__mepc;
            end
        12'h87: // req 1
            begin
            csr_data__read_data__var = csrs__mcause;
            end
        12'h100: // req 1
            begin
            csr_data__read_data__var = 32'h0;
            end
        12'h101: // req 1
            begin
            csr_data__read_data__var = 32'h0;
            end
        12'h800: // req 1
            begin
            csr_data__read_data__var = csrs__depc;
            end
        12'h801: // req 1
            begin
            csr_data__read_data__var = csr_combs__dcsr;
            end
        12'h802: // req 1
            begin
            csr_data__read_data__var = csrs__dscratch0;
            end
        12'h803: // req 1
            begin
            csr_data__read_data__var = csrs__dscratch1;
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
        csr_data__read_data = csr_data__read_data__var;
    end //always

    //b csr_write_controls combinatorial process
        //   
        //       
    always @ ( * )//csr_write_controls
    begin: csr_write_controls__comb_code
    reg csr_write__enable__var;
    reg [31:0]csr_write__data_mask__var;
    reg [31:0]csr_write__data_set__var;
        csr_write__enable__var = 1'h0;
        csr_write__data_mask__var = 32'h0;
        csr_write__data_set__var = csr_access__write_data;
        case (csr_access__access) //synopsys parallel_case
        3'h1: // req 1
            begin
            csr_write__enable__var = 1'h1;
            end
        3'h3: // req 1
            begin
            csr_write__enable__var = 1'h1;
            end
        3'h6: // req 1
            begin
            csr_write__enable__var = 1'h1;
            csr_write__data_mask__var = 32'hffffffff;
            end
        3'h7: // req 1
            begin
            csr_write__enable__var = 1'h1;
            csr_write__data_set__var = 32'h0;
            csr_write__data_mask__var = ~csr_access__write_data;
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
        if ((csr_access__access_cancelled!=1'h0))
        begin
            csr_write__enable__var = 1'h0;
        end //if
        csr_write__enable = csr_write__enable__var;
        csr_write__data_mask = csr_write__data_mask__var;
        csr_write__data_set = csr_write__data_set__var;
    end //always

    //b ret_trap_breakout combinatorial process
    always @ ( * )//ret_trap_breakout
    begin: ret_trap_breakout__comb_code
    reg trap_combs__d__var;
    reg trap_combs__m__var;
    reg trap_combs__s__var;
    reg trap_combs__u__var;
    reg ret_combs__d__var;
    reg ret_combs__m__var;
    reg ret_combs__s__var;
    reg ret_combs__u__var;
        trap_combs__d__var = 1'h0;
        trap_combs__m__var = 1'h0;
        trap_combs__s__var = 1'h0;
        trap_combs__u__var = 1'h0;
        ret_combs__d__var = 1'h0;
        ret_combs__m__var = 1'h0;
        ret_combs__s__var = 1'h0;
        ret_combs__u__var = 1'h0;
        if ((csr_controls__trap__valid!=1'h0))
        begin
            if ((csr_controls__trap__ebreak_to_dbg!=1'h0))
            begin
                trap_combs__d__var = 1'h1;
            end //if
            else
            
            begin
                if ((csr_controls__trap__ret!=1'h0))
                begin
                    case (csr_controls__trap__cause) //synopsys parallel_case
                    5'h3: // req 1
                        begin
                        ret_combs__d__var = 1'h1;
                        end
                    5'h0: // req 1
                        begin
                        ret_combs__m__var = 1'h1;
                        end
                    5'h1: // req 1
                        begin
                        ret_combs__s__var = 1'h1;
                        end
                    5'h2: // req 1
                        begin
                        ret_combs__u__var = 1'h1;
                        end
    //synopsys  translate_off
    //pragma coverage off
                    default:
                        begin
                            if (1)
                            begin
                                $display("%t *********CDL ASSERTION FAILURE:riscv_csrs_machine_debug:ret_trap_breakout: Full switch statement did not cover all values", $time);
                            end
                        end
    //pragma coverage on
    //synopsys  translate_on
                    endcase
                end //if
                else
                
                begin
                    case (csr_controls__trap__to_mode) //synopsys parallel_case
                    3'h7: // req 1
                        begin
                        trap_combs__d__var = 1'h1;
                        end
                    3'h3: // req 1
                        begin
                        trap_combs__m__var = 1'h1;
                        end
                    3'h1: // req 1
                        begin
                        trap_combs__s__var = 1'h1;
                        end
                    3'h0: // req 1
                        begin
                        trap_combs__u__var = 1'h1;
                        end
    //synopsys  translate_off
    //pragma coverage off
                    default:
                        begin
                            if (1)
                            begin
                                $display("%t *********CDL ASSERTION FAILURE:riscv_csrs_machine_debug:ret_trap_breakout: Full switch statement did not cover all values", $time);
                            end
                        end
    //pragma coverage on
    //synopsys  translate_on
                    endcase
                end //else
            end //else
        end //if
        trap_combs__d = trap_combs__d__var;
        trap_combs__m = trap_combs__m__var;
        trap_combs__s = trap_combs__s__var;
        trap_combs__u = trap_combs__u__var;
        ret_combs__d = ret_combs__d__var;
        ret_combs__m = ret_combs__m__var;
        ret_combs__s = ret_combs__s__var;
        ret_combs__u = ret_combs__u__var;
    end //always

    //b csr_state_update clock process
        //   
        //       
    always @( posedge riscv_clk or negedge reset_n)
    begin : csr_state_update__code
        if (reset_n==1'b0)
        begin
            csrs__time <= 64'h0;
            csrs__cycles <= 64'h0;
            csrs__instret <= 64'h0;
            csrs__mip__meip <= 1'h0;
            csrs__mip__mtip <= 1'h0;
            csrs__mip__msip <= 1'h0;
            csrs__mie__meip <= 1'h0;
            csrs__mie__mtip <= 1'h0;
            csrs__mie__msip <= 1'h0;
            csrs__mstatus__upie <= 1'h0;
            csrs__mstatus__uie <= 1'h0;
            csrs__mstatus__mpp <= 2'h0;
            csrs__mstatus__mpie <= 1'h0;
            csrs__mstatus__mie <= 1'h0;
            csrs__uepc <= 32'h0;
            csrs__mepc <= 32'h0;
            csrs__depc <= 32'h0;
            csrs__utvec__base <= 30'h0;
            csrs__utvec__vectored <= 1'h0;
            csrs__mtvec__base <= 30'h0;
            csrs__mtvec__vectored <= 1'h0;
            csrs__utval <= 32'h0;
            csrs__mtval <= 32'h0;
            csrs__ucause <= 32'h0;
            csrs__mcause <= 32'h0;
            csrs__uscratch <= 32'h0;
            csrs__mscratch <= 32'h0;
            csrs__dscratch0 <= 32'h0;
            csrs__dscratch1 <= 32'h0;
            csrs__dcsr__ebreakm <= 1'h0;
            csrs__dcsr__ebreaks <= 1'h0;
            csrs__dcsr__ebreaku <= 1'h0;
            csrs__dcsr__stepie <= 1'h0;
            csrs__dcsr__stopcount <= 1'h0;
            csrs__dcsr__stoptime <= 1'h0;
            csrs__dcsr__mprven <= 1'h0;
            csrs__dcsr__step <= 1'h0;
            csrs__dcsr__prv <= 2'h0;
            csrs__dcsr__cause <= 3'h0;
            csrs__dcsr__xdebug_ver <= 4'h0;
            csrs__dcsr__nmip <= 1'h0;
            csrs__mstatus__sd <= 1'h0;
            csrs__mstatus__tsr <= 1'h0;
            csrs__mstatus__tw <= 1'h0;
            csrs__mstatus__tvm <= 1'h0;
            csrs__mstatus__mxr <= 1'h0;
            csrs__mstatus__sum <= 1'h0;
            csrs__mstatus__mprv <= 1'h0;
            csrs__mstatus__xs <= 2'h0;
            csrs__mstatus__fs <= 2'h0;
            csrs__mstatus__spp <= 1'h0;
            csrs__mstatus__spie <= 1'h0;
            csrs__mstatus__sie <= 1'h0;
            csrs__mip__seip <= 1'h0;
            csrs__mip__seip_sw <= 1'h0;
            csrs__mip__stip <= 1'h0;
            csrs__mip__ssip <= 1'h0;
            csrs__mie__seip <= 1'h0;
            csrs__mie__stip <= 1'h0;
            csrs__mie__ssip <= 1'h0;
            csrs__mip__ueip <= 1'h0;
            csrs__mip__ueip_sw <= 1'h0;
            csrs__mip__utip <= 1'h0;
            csrs__mip__usip <= 1'h0;
            csrs__mie__ueip <= 1'h0;
            csrs__mie__utip <= 1'h0;
            csrs__mie__usip <= 1'h0;
        end
        else if (riscv_clk__enable)
        begin
            csrs__time <= irqs__time;
            csrs__cycles[31:0] <= (csrs__cycles[31:0]+32'h1);
            if ((csrs__cycles[31:0]==32'hffffffff))
            begin
                csrs__cycles[63:32] <= (csrs__cycles[63:32]+32'h1);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h12)))
            begin
                csrs__cycles[31:0] <= ((csrs__cycles[31:0] & csr_write__data_mask) | csr_write__data_set);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h13)))
            begin
                csrs__cycles[63:32] <= ((csrs__cycles[63:32] & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((csr_controls__retire!=1'h0))
            begin
                csrs__instret[31:0] <= (csrs__instret[31:0]+32'h1);
                if ((csrs__instret[31:0]==32'hffffffff))
                begin
                    csrs__instret[63:32] <= (csrs__instret[63:32]+32'h1);
                end //if
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h14)))
            begin
                csrs__instret[31:0] <= ((csrs__instret[31:0] & csr_write__data_mask) | csr_write__data_set);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h15)))
            begin
                csrs__instret[63:32] <= ((csrs__instret[63:32] & csr_write__data_mask) | csr_write__data_set);
            end //if
            csrs__mip__meip <= irqs__meip;
            csrs__mip__mtip <= irqs__mtip;
            csrs__mip__msip <= irqs__msip;
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h82)))
            begin
                csrs__mie__meip <= ((csrs__mie__meip & csr_write__data_mask[11]) | csr_write__data_set[11]);
                csrs__mie__mtip <= ((csrs__mie__meip & csr_write__data_mask[7]) | csr_write__data_set[7]);
                csrs__mie__msip <= ((csrs__mie__meip & csr_write__data_mask[3]) | csr_write__data_set[3]);
            end //if
            if ((trap_combs__u!=1'h0))
            begin
                csrs__mstatus__upie <= csrs__mstatus__uie;
                csrs__mstatus__uie <= 1'h0;
            end //if
            else
            
            begin
                if ((ret_combs__u!=1'h0))
                begin
                    csrs__mstatus__upie <= 1'h1;
                    csrs__mstatus__uie <= csrs__mstatus__upie;
                end //if
                if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h80)))
                begin
                    csrs__mstatus__upie <= ((csrs__mstatus__upie & csr_write__data_mask[4]) | csr_write__data_set[4]);
                    csrs__mstatus__uie <= ((csrs__mstatus__uie & csr_write__data_mask[0]) | csr_write__data_set[0]);
                end //if
                if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h40)))
                begin
                    csrs__mstatus__upie <= ((csrs__mstatus__upie & csr_write__data_mask[4]) | csr_write__data_set[4]);
                    csrs__mstatus__uie <= ((csrs__mstatus__uie & csr_write__data_mask[0]) | csr_write__data_set[0]);
                end //if
            end //else
            if ((trap_combs__m!=1'h0))
            begin
                csrs__mstatus__mpp <= csr_controls__exec_mode[1:0];
                csrs__mstatus__mpie <= csrs__mstatus__mie;
                csrs__mstatus__mie <= 1'h0;
            end //if
            else
            
            begin
                if ((ret_combs__m!=1'h0))
                begin
                    csrs__mstatus__mpp <= 2'h0;
                    csrs__mstatus__mpie <= 1'h1;
                    csrs__mstatus__mie <= csrs__mstatus__mpie;
                end //if
                if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h80)))
                begin
                    csrs__mstatus__mpp <= ((csrs__mstatus__mpp & csr_write__data_mask[12:11]) | csr_write__data_set[12:11]);
                    csrs__mstatus__mpie <= ((csrs__mstatus__mpie & csr_write__data_mask[7]) | csr_write__data_set[7]);
                    csrs__mstatus__mie <= ((csrs__mstatus__mie & csr_write__data_mask[3]) | csr_write__data_set[3]);
                end //if
            end //else
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h46)))
            begin
                csrs__uepc <= ((csrs__uepc & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__u!=1'h0))
            begin
                csrs__uepc <= csr_controls__trap__pc;
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h86)))
            begin
                csrs__mepc <= ((csrs__mepc & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__m!=1'h0))
            begin
                csrs__mepc <= csr_controls__trap__pc;
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h800)))
            begin
                csrs__depc <= ((csrs__depc & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__d!=1'h0))
            begin
                csrs__depc <= csr_controls__trap__pc;
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h44)))
            begin
                csrs__utvec__base <= ((csrs__utvec__base & csr_write__data_mask[31:2]) | csr_write__data_set[31:2]);
                csrs__utvec__vectored <= ((csrs__utvec__vectored & csr_write__data_mask[0]) | csr_write__data_set[0]);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h84)))
            begin
                csrs__mtvec__base <= ((csrs__mtvec__base & csr_write__data_mask[31:2]) | csr_write__data_set[31:2]);
                csrs__mtvec__vectored <= ((csrs__mtvec__vectored & csr_write__data_mask[0]) | csr_write__data_set[0]);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h45)))
            begin
                csrs__utval <= ((csrs__utval & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__u!=1'h0))
            begin
                csrs__utval <= csr_controls__trap__value;
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h85)))
            begin
                csrs__mtval <= ((csrs__mtval & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__m!=1'h0))
            begin
                csrs__mtval <= csr_controls__trap__value;
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h47)))
            begin
                csrs__ucause <= ((csrs__ucause & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__u!=1'h0))
            begin
                case (csr_controls__trap__cause) //synopsys parallel_case
                5'h0: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h0};
                    end
                5'h1: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h1};
                    end
                5'h2: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h2};
                    end
                5'h3: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h3};
                    end
                5'h4: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h4};
                    end
                5'h5: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h5};
                    end
                5'h6: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h6};
                    end
                5'h7: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h7};
                    end
                5'h8: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h8};
                    end
                5'h9: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'h9};
                    end
                5'hb: // req 1
                    begin
                    csrs__ucause <= {24'h0,8'hb};
                    end
                default: // req 1
                    begin
                    csrs__ucause <= {{{1'h1,23'h0},4'h0},csr_controls__trap__cause[3:0]};
                    end
                endcase
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h87)))
            begin
                csrs__mcause <= ((csrs__mcause & csr_write__data_mask) | csr_write__data_set);
            end //if
            if ((trap_combs__m!=1'h0))
            begin
                case (csr_controls__trap__cause) //synopsys parallel_case
                5'h0: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h0};
                    end
                5'h1: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h1};
                    end
                5'h2: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h2};
                    end
                5'h3: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h3};
                    end
                5'h4: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h4};
                    end
                5'h5: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h5};
                    end
                5'h6: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h6};
                    end
                5'h7: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h7};
                    end
                5'h8: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h8};
                    end
                5'h9: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'h9};
                    end
                5'hb: // req 1
                    begin
                    csrs__mcause <= {24'h0,8'hb};
                    end
                default: // req 1
                    begin
                    csrs__mcause <= {{{1'h1,23'h0},4'h0},csr_controls__trap__cause[3:0]};
                    end
                endcase
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h41)))
            begin
                csrs__uscratch <= ((csrs__uscratch & csr_write__data_mask) | csr_write__data_set);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h81)))
            begin
                csrs__mscratch <= ((csrs__mscratch & csr_write__data_mask) | csr_write__data_set);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h802)))
            begin
                csrs__dscratch0 <= ((csrs__dscratch0 & csr_write__data_mask) | csr_write__data_set);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h803)))
            begin
                csrs__dscratch1 <= ((csrs__dscratch1 & csr_write__data_mask) | csr_write__data_set);
            end //if
            if (((csr_write__enable!=1'h0)&&(csr_access__select==12'h801)))
            begin
                csrs__dcsr__ebreakm <= ((csrs__dcsr__ebreakm & csr_write__data_mask[15]) | csr_write__data_set[15]);
                csrs__dcsr__ebreaks <= ((csrs__dcsr__ebreaks & csr_write__data_mask[13]) | csr_write__data_set[13]);
                csrs__dcsr__ebreaku <= ((csrs__dcsr__ebreaku & csr_write__data_mask[12]) | csr_write__data_set[12]);
                csrs__dcsr__stepie <= ((csrs__dcsr__stepie & csr_write__data_mask[11]) | csr_write__data_set[11]);
                csrs__dcsr__stopcount <= ((csrs__dcsr__stopcount & csr_write__data_mask[10]) | csr_write__data_set[10]);
                csrs__dcsr__stoptime <= ((csrs__dcsr__stoptime & csr_write__data_mask[9]) | csr_write__data_set[9]);
                csrs__dcsr__mprven <= ((csrs__dcsr__mprven & csr_write__data_mask[4]) | csr_write__data_set[4]);
                csrs__dcsr__step <= ((csrs__dcsr__step & csr_write__data_mask[2]) | csr_write__data_set[2]);
                csrs__dcsr__prv <= ((csrs__dcsr__prv & csr_write__data_mask[1:0]) | csr_write__data_set[1:0]);
            end //if
            if ((trap_combs__d!=1'h0))
            begin
                csrs__dcsr__cause <= ((csr_controls__trap__ebreak_to_dbg!=1'h0)?64'h1:64'h0);
                csrs__dcsr__prv <= csr_controls__exec_mode[1:0];
            end //if
            csrs__dcsr__xdebug_ver <= 4'h4;
            if ((1'h0!=64'h0))
            begin
                csrs__depc <= 32'h0;
                csrs__dscratch0 <= 32'h0;
                csrs__dscratch1 <= 32'h0;
                csrs__dcsr__xdebug_ver <= 4'h0;
                csrs__dcsr__ebreakm <= 1'h0;
                csrs__dcsr__ebreaks <= 1'h0;
                csrs__dcsr__ebreaku <= 1'h0;
                csrs__dcsr__stepie <= 1'h0;
                csrs__dcsr__stopcount <= 1'h0;
                csrs__dcsr__stoptime <= 1'h0;
                csrs__dcsr__cause <= 3'h0;
                csrs__dcsr__mprven <= 1'h0;
                csrs__dcsr__nmip <= 1'h0;
                csrs__dcsr__step <= 1'h0;
                csrs__dcsr__prv <= 2'h0;
            end //if
            if (1'h1)
            begin
                csrs__mstatus__mpp <= 2'h3;
                csrs__mstatus__sd <= 1'h0;
                csrs__mstatus__tsr <= 1'h0;
                csrs__mstatus__tw <= 1'h0;
                csrs__mstatus__tvm <= 1'h0;
                csrs__mstatus__mxr <= 1'h0;
                csrs__mstatus__sum <= 1'h0;
                csrs__mstatus__mprv <= 1'h0;
                csrs__mstatus__xs <= 2'h0;
                csrs__mstatus__fs <= 2'h0;
                csrs__mstatus__spp <= 1'h0;
                csrs__mstatus__spie <= 1'h0;
                csrs__mstatus__sie <= 1'h0;
                csrs__mstatus__upie <= 1'h0;
                csrs__mstatus__uie <= 1'h0;
                csrs__mip__seip <= 1'h0;
                csrs__mip__seip_sw <= 1'h0;
                csrs__mip__stip <= 1'h0;
                csrs__mip__ssip <= 1'h0;
                csrs__mie__seip <= 1'h0;
                csrs__mie__stip <= 1'h0;
                csrs__mie__ssip <= 1'h0;
                csrs__mip__ueip <= 1'h0;
                csrs__mip__ueip_sw <= 1'h0;
                csrs__mip__utip <= 1'h0;
                csrs__mip__usip <= 1'h0;
                csrs__mie__ueip <= 1'h0;
                csrs__mie__utip <= 1'h0;
                csrs__mie__usip <= 1'h0;
                csrs__uscratch <= 32'h0;
                csrs__uepc <= 32'h0;
                csrs__ucause <= 32'h0;
                csrs__utval <= 32'h0;
                csrs__utvec__base <= 30'h0;
                csrs__utvec__vectored <= 1'h0;
            end //if
            if (1'h1)
            begin
                csrs__uscratch <= 32'h0;
                csrs__uepc <= 32'h0;
                csrs__ucause <= 32'h0;
                csrs__utval <= 32'h0;
                csrs__utvec__base <= 30'h0;
                csrs__utvec__vectored <= 1'h0;
            end //if
            if (1'h1)
            begin
                csrs__mstatus__spp <= 1'h0;
                csrs__mstatus__spie <= 1'h0;
                csrs__mstatus__sie <= 1'h0;
                csrs__mip__seip <= 1'h0;
                csrs__mip__seip_sw <= 1'h0;
                csrs__mip__stip <= 1'h0;
                csrs__mip__ssip <= 1'h0;
                csrs__mie__seip <= 1'h0;
                csrs__mie__stip <= 1'h0;
                csrs__mie__ssip <= 1'h0;
            end //if
        end //if
    end //always

endmodule // riscv_csrs_machine_debug
