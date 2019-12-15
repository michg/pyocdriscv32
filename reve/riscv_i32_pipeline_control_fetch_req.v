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

//a Module riscv_i32_pipeline_control_fetch_req
module riscv_i32_pipeline_control_fetch_req
(

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

    ifetch_req__flush_pipeline,
    ifetch_req__req_type,
    ifetch_req__address,
    ifetch_req__mode,
    pipeline_fetch_req__debug_fetch,
    pipeline_fetch_req__predicted_branch,
    pipeline_fetch_req__pc_if_mispredicted
);

    //b Clocks

    //b Inputs
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
    output ifetch_req__flush_pipeline;
    output [2:0]ifetch_req__req_type;
    output [31:0]ifetch_req__address;
    output [2:0]ifetch_req__mode;
    output pipeline_fetch_req__debug_fetch;
    output pipeline_fetch_req__predicted_branch;
    output [31:0]pipeline_fetch_req__pc_if_mispredicted;

// output components here

    //b Output combinatorials
    reg ifetch_req__flush_pipeline;
    reg [2:0]ifetch_req__req_type;
    reg [31:0]ifetch_req__address;
    reg [2:0]ifetch_req__mode;
    reg pipeline_fetch_req__debug_fetch;
    reg pipeline_fetch_req__predicted_branch;
    reg [31:0]pipeline_fetch_req__pc_if_mispredicted;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials
    reg [31:0]ifetch_combs__pc_plus_4;
    reg [31:0]ifetch_combs__pc_plus_2;
    reg [31:0]ifetch_combs__pc_plus_inst;
    reg [31:0]ifetch_combs__pc_if_mispredicted;
    reg ifetch_combs__predict_branch;
    reg [31:0]ifetch_combs__fetch_next_pc;
    reg ifetch_combs__fetch_sequential;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b pipeline_state_logic combinatorial process
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
    always @ ( * )//pipeline_state_logic
    begin: pipeline_state_logic__comb_code
    reg [31:0]ifetch_combs__pc_plus_inst__var;
    reg ifetch_combs__predict_branch__var;
    reg [31:0]ifetch_combs__fetch_next_pc__var;
    reg ifetch_combs__fetch_sequential__var;
    reg [31:0]ifetch_combs__pc_if_mispredicted__var;
    reg ifetch_req__flush_pipeline__var;
    reg [2:0]ifetch_req__req_type__var;
    reg [31:0]ifetch_req__address__var;
    reg [2:0]ifetch_req__mode__var;
    reg pipeline_fetch_req__debug_fetch__var;
    reg pipeline_fetch_req__predicted_branch__var;
    reg [31:0]pipeline_fetch_req__pc_if_mispredicted__var;
        ifetch_combs__pc_plus_4 = (pipeline_response__decode__pc+32'h4);
        ifetch_combs__pc_plus_2 = (pipeline_response__decode__pc+32'h2);
        ifetch_combs__pc_plus_inst__var = ifetch_combs__pc_plus_4;
        if ((pipeline_response__decode__idecode__is_compressed!=1'h0))
        begin
            ifetch_combs__pc_plus_inst__var = ifetch_combs__pc_plus_2;
        end //if
        ifetch_combs__predict_branch__var = 1'h0;
        case (pipeline_response__decode__idecode__op) //synopsys parallel_case
        4'h0: // req 1
            begin
            ifetch_combs__predict_branch__var = pipeline_response__decode__idecode__immediate[31];
            end
        4'h1: // req 1
            begin
            ifetch_combs__predict_branch__var = 1'h1;
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
        if ((1'h0!=64'h0))
        begin
            if ((pipeline_response__decode__branch_target[1]!=1'h0))
            begin
                ifetch_combs__predict_branch__var = 1'h0;
            end //if
        end //if
        if ((1'h0||!(pipeline_response__decode__enable_branch_prediction!=1'h0)))
        begin
            ifetch_combs__predict_branch__var = 1'h0;
        end //if
        ifetch_combs__fetch_next_pc__var = ifetch_combs__pc_plus_inst__var;
        ifetch_combs__fetch_sequential__var = 1'h1;
        ifetch_combs__pc_if_mispredicted__var = pipeline_response__decode__branch_target;
        if ((ifetch_combs__predict_branch__var!=1'h0))
        begin
            ifetch_combs__fetch_next_pc__var = pipeline_response__decode__branch_target;
            ifetch_combs__fetch_sequential__var = 1'h0;
            ifetch_combs__pc_if_mispredicted__var = ifetch_combs__pc_plus_inst__var;
        end //if
        ifetch_req__flush_pipeline__var = 1'h0;
        ifetch_req__req_type__var = 3'h0;
        ifetch_req__address__var = 32'h0;
        ifetch_req__mode__var = 3'h0;
        pipeline_fetch_req__debug_fetch__var = 1'h0;
        pipeline_fetch_req__predicted_branch__var = 1'h0;
        pipeline_fetch_req__pc_if_mispredicted__var = 32'h0;
        pipeline_fetch_req__predicted_branch__var = ifetch_combs__predict_branch__var;
        pipeline_fetch_req__pc_if_mispredicted__var = ifetch_combs__pc_if_mispredicted__var;
        ifetch_req__flush_pipeline__var = 1'h1;
        ifetch_req__req_type__var = 3'h0;
        ifetch_req__address__var = pipeline_state__fetch_pc;
        ifetch_req__mode__var = pipeline_state__mode;
        case (pipeline_state__fetch_action) //synopsys parallel_case
        3'h2: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h1;
            ifetch_req__req_type__var = 3'h1;
            ifetch_req__address__var = pipeline_state__fetch_pc;
            end
        3'h3: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h0;
            ifetch_req__req_type__var = 3'h3;
            ifetch_req__address__var = pipeline_state__fetch_pc;
            end
        3'h4: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h0;
            ifetch_req__req_type__var = 3'h1;
            if ((ifetch_combs__fetch_sequential__var!=1'h0))
            begin
                ifetch_req__req_type__var = ((pipeline_response__decode__idecode__is_compressed!=1'h0)?3'h6:3'h2);
            end //if
            ifetch_req__address__var = ifetch_combs__fetch_next_pc__var;
            end
        3'h1: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h0;
            end
        default: // req 1
            begin
            ifetch_req__flush_pipeline__var = 1'h1;
            end
        endcase
        pipeline_fetch_req__debug_fetch__var = 1'h0;
        if ((pipeline_state__mode==3'h7))
        begin
            if ((((pipeline_state__fetch_action!=3'h0)&&(pipeline_state__fetch_action!=3'h1))&&(ifetch_req__address__var[31:8]==24'hffffff)))
            begin
                ifetch_req__req_type__var = 3'h0;
                ifetch_req__mode__var = 3'h7;
                pipeline_fetch_req__debug_fetch__var = 1'h1;
            end //if
        end //if
        ifetch_combs__pc_plus_inst = ifetch_combs__pc_plus_inst__var;
        ifetch_combs__predict_branch = ifetch_combs__predict_branch__var;
        ifetch_combs__fetch_next_pc = ifetch_combs__fetch_next_pc__var;
        ifetch_combs__fetch_sequential = ifetch_combs__fetch_sequential__var;
        ifetch_combs__pc_if_mispredicted = ifetch_combs__pc_if_mispredicted__var;
        ifetch_req__flush_pipeline = ifetch_req__flush_pipeline__var;
        ifetch_req__req_type = ifetch_req__req_type__var;
        ifetch_req__address = ifetch_req__address__var;
        ifetch_req__mode = ifetch_req__mode__var;
        pipeline_fetch_req__debug_fetch = pipeline_fetch_req__debug_fetch__var;
        pipeline_fetch_req__predicted_branch = pipeline_fetch_req__predicted_branch__var;
        pipeline_fetch_req__pc_if_mispredicted = pipeline_fetch_req__pc_if_mispredicted__var;
    end //always

endmodule // riscv_i32_pipeline_control_fetch_req
