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

//a Module riscv_i32_pipeline_control_fetch_data
module riscv_i32_pipeline_control_fetch_data
(

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
    ifetch_resp__valid,
    ifetch_resp__debug,
    ifetch_resp__data,
    ifetch_resp__mode,
    ifetch_resp__error,
    ifetch_resp__tag,
    ifetch_req__flush_pipeline,
    ifetch_req__req_type,
    ifetch_req__debug_fetch,
    ifetch_req__address,
    ifetch_req__mode,
    ifetch_req__predicted_branch,
    ifetch_req__pc_if_mispredicted,
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

    pipeline_fetch_data__valid,
    pipeline_fetch_data__pc,
    pipeline_fetch_data__instruction__data,
    pipeline_fetch_data__instruction__debug__valid,
    pipeline_fetch_data__instruction__debug__debug_op,
    pipeline_fetch_data__instruction__debug__data,
    pipeline_fetch_data__dec_flush_pipeline,
    pipeline_fetch_data__dec_predicted_branch,
    pipeline_fetch_data__dec_pc_if_mispredicted
);

    //b Clocks

    //b Inputs
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
    input ifetch_resp__valid;
    input ifetch_resp__debug;
    input [31:0]ifetch_resp__data;
    input [2:0]ifetch_resp__mode;
    input ifetch_resp__error;
    input [1:0]ifetch_resp__tag;
    input ifetch_req__flush_pipeline;
    input [2:0]ifetch_req__req_type;
    input ifetch_req__debug_fetch;
    input [31:0]ifetch_req__address;
    input [2:0]ifetch_req__mode;
    input ifetch_req__predicted_branch;
    input [31:0]ifetch_req__pc_if_mispredicted;
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
    output pipeline_fetch_data__valid;
    output [31:0]pipeline_fetch_data__pc;
    output [31:0]pipeline_fetch_data__instruction__data;
    output pipeline_fetch_data__instruction__debug__valid;
    output [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    output [15:0]pipeline_fetch_data__instruction__debug__data;
    output pipeline_fetch_data__dec_flush_pipeline;
    output pipeline_fetch_data__dec_predicted_branch;
    output [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;

// output components here

    //b Output combinatorials
    reg pipeline_fetch_data__valid;
    reg [31:0]pipeline_fetch_data__pc;
    reg [31:0]pipeline_fetch_data__instruction__data;
    reg pipeline_fetch_data__instruction__debug__valid;
    reg [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    reg [15:0]pipeline_fetch_data__instruction__debug__data;
    reg pipeline_fetch_data__dec_flush_pipeline;
    reg pipeline_fetch_data__dec_predicted_branch;
    reg [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b pipeline_control_logic combinatorial process
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
    always @ ( * )//pipeline_control_logic
    begin: pipeline_control_logic__comb_code
    reg pipeline_fetch_data__valid__var;
    reg [31:0]pipeline_fetch_data__instruction__data__var;
    reg pipeline_fetch_data__instruction__debug__valid__var;
    reg [1:0]pipeline_fetch_data__instruction__debug__debug_op__var;
    reg [15:0]pipeline_fetch_data__instruction__debug__data__var;
    reg pipeline_fetch_data__dec_flush_pipeline__var;
        pipeline_fetch_data__valid__var = (((pipeline_control__valid!=1'h0)&&(ifetch_resp__valid!=1'h0))&&(ifetch_req__req_type!=3'h0));
        pipeline_fetch_data__pc = ifetch_req__address;
        pipeline_fetch_data__instruction__data__var = ifetch_resp__data;
        pipeline_fetch_data__instruction__debug__valid__var = 1'h0;
        pipeline_fetch_data__instruction__debug__debug_op__var = 2'h0;
        pipeline_fetch_data__instruction__debug__data__var = 16'h0;
        if ((ifetch_req__debug_fetch!=1'h0))
        begin
            if ((ifetch_req__address[7:0]==8'h0))
            begin
                pipeline_fetch_data__valid__var = pipeline_control__valid;
                pipeline_fetch_data__instruction__data__var = pipeline_control__instruction_data;
            end //if
            else
            
            begin
                pipeline_fetch_data__valid__var = pipeline_control__valid;
                pipeline_fetch_data__instruction__data__var = 32'h100073;
            end //else
        end //if
        pipeline_fetch_data__dec_pc_if_mispredicted = ifetch_req__pc_if_mispredicted;
        pipeline_fetch_data__dec_predicted_branch = ifetch_req__predicted_branch;
        pipeline_fetch_data__dec_flush_pipeline__var = ifetch_req__flush_pipeline;
        if (((pipeline_response__exec__valid!=1'h0)&&(pipeline_response__exec__branch_taken!=pipeline_response__exec__predicted_branch)))
        begin
            pipeline_fetch_data__dec_flush_pipeline__var = 1'h1;
            pipeline_fetch_data__valid__var = 1'h0;
        end //if
        if ((pipeline_response__exec__trap__valid!=1'h0))
        begin
            pipeline_fetch_data__dec_flush_pipeline__var = 1'h1;
            pipeline_fetch_data__valid__var = 1'h0;
        end //if
        if ((pipeline_response__exec__trap__ret!=1'h0))
        begin
            pipeline_fetch_data__dec_flush_pipeline__var = 1'h1;
            pipeline_fetch_data__valid__var = 1'h0;
        end //if
        if ((pipeline_control__instruction_debug__valid!=1'h0))
        begin
            pipeline_fetch_data__valid__var = 1'h1;
            pipeline_fetch_data__instruction__debug__valid__var = pipeline_control__instruction_debug__valid;
            pipeline_fetch_data__instruction__debug__debug_op__var = pipeline_control__instruction_debug__debug_op;
            pipeline_fetch_data__instruction__debug__data__var = pipeline_control__instruction_debug__data;
            pipeline_fetch_data__instruction__data__var = pipeline_control__instruction_data;
        end //if
        pipeline_fetch_data__valid = pipeline_fetch_data__valid__var;
        pipeline_fetch_data__instruction__data = pipeline_fetch_data__instruction__data__var;
        pipeline_fetch_data__instruction__debug__valid = pipeline_fetch_data__instruction__debug__valid__var;
        pipeline_fetch_data__instruction__debug__debug_op = pipeline_fetch_data__instruction__debug__debug_op__var;
        pipeline_fetch_data__instruction__debug__data = pipeline_fetch_data__instruction__debug__data__var;
        pipeline_fetch_data__dec_flush_pipeline = pipeline_fetch_data__dec_flush_pipeline__var;
    end //always

endmodule // riscv_i32_pipeline_control_fetch_data
