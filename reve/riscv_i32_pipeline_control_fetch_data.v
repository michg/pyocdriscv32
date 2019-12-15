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

    pipeline_fetch_req__debug_fetch,
    pipeline_fetch_req__predicted_branch,
    pipeline_fetch_req__pc_if_mispredicted,
    ifetch_resp__valid,
    ifetch_resp__data,
    ifetch_resp__error,
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

    pipeline_fetch_data__valid,
    pipeline_fetch_data__mode,
    pipeline_fetch_data__pc,
    pipeline_fetch_data__instruction__mode,
    pipeline_fetch_data__instruction__data,
    pipeline_fetch_data__instruction__debug__valid,
    pipeline_fetch_data__instruction__debug__debug_op,
    pipeline_fetch_data__instruction__debug__data,
    pipeline_fetch_data__dec_predicted_branch,
    pipeline_fetch_data__dec_pc_if_mispredicted
);

    //b Clocks

    //b Inputs
    input pipeline_fetch_req__debug_fetch;
    input pipeline_fetch_req__predicted_branch;
    input [31:0]pipeline_fetch_req__pc_if_mispredicted;
    input ifetch_resp__valid;
    input [31:0]ifetch_resp__data;
    input [1:0]ifetch_resp__error;
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
    output pipeline_fetch_data__valid;
    output [2:0]pipeline_fetch_data__mode;
    output [31:0]pipeline_fetch_data__pc;
    output [2:0]pipeline_fetch_data__instruction__mode;
    output [31:0]pipeline_fetch_data__instruction__data;
    output pipeline_fetch_data__instruction__debug__valid;
    output [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    output [15:0]pipeline_fetch_data__instruction__debug__data;
    output pipeline_fetch_data__dec_predicted_branch;
    output [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;

// output components here

    //b Output combinatorials
    reg pipeline_fetch_data__valid;
    reg [2:0]pipeline_fetch_data__mode;
    reg [31:0]pipeline_fetch_data__pc;
    reg [2:0]pipeline_fetch_data__instruction__mode;
    reg [31:0]pipeline_fetch_data__instruction__data;
    reg pipeline_fetch_data__instruction__debug__valid;
    reg [1:0]pipeline_fetch_data__instruction__debug__debug_op;
    reg [15:0]pipeline_fetch_data__instruction__debug__data;
    reg pipeline_fetch_data__dec_predicted_branch;
    reg [31:0]pipeline_fetch_data__dec_pc_if_mispredicted;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials

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
    reg pipeline_fetch_data__valid__var;
    reg [31:0]pipeline_fetch_data__instruction__data__var;
    reg pipeline_fetch_data__instruction__debug__valid__var;
    reg [1:0]pipeline_fetch_data__instruction__debug__debug_op__var;
    reg [15:0]pipeline_fetch_data__instruction__debug__data__var;
        pipeline_fetch_data__valid__var = ((ifetch_resp__valid!=1'h0)&&(ifetch_req__req_type!=3'h0));
        pipeline_fetch_data__pc = ifetch_req__address;
        pipeline_fetch_data__mode = ifetch_req__mode;
        pipeline_fetch_data__instruction__data__var = ifetch_resp__data;
        pipeline_fetch_data__instruction__mode = ifetch_req__mode;
        pipeline_fetch_data__instruction__debug__valid__var = 1'h0;
        pipeline_fetch_data__instruction__debug__debug_op__var = 2'h0;
        pipeline_fetch_data__instruction__debug__data__var = 16'h0;
        if ((pipeline_fetch_req__debug_fetch!=1'h0))
        begin
            if ((ifetch_req__address[7:0]==8'h0))
            begin
                pipeline_fetch_data__valid__var = 1'h1;
                pipeline_fetch_data__instruction__data__var = pipeline_state__instruction_data;
            end //if
            else
            
            begin
                pipeline_fetch_data__valid__var = 1'h1;
                pipeline_fetch_data__instruction__data__var = 32'h100073;
            end //else
        end //if
        pipeline_fetch_data__dec_pc_if_mispredicted = pipeline_fetch_req__pc_if_mispredicted;
        pipeline_fetch_data__dec_predicted_branch = pipeline_fetch_req__predicted_branch;
        if ((pipeline_state__instruction_debug__valid!=1'h0))
        begin
            pipeline_fetch_data__valid__var = 1'h1;
            pipeline_fetch_data__instruction__debug__valid__var = pipeline_state__instruction_debug__valid;
            pipeline_fetch_data__instruction__debug__debug_op__var = pipeline_state__instruction_debug__debug_op;
            pipeline_fetch_data__instruction__debug__data__var = pipeline_state__instruction_debug__data;
            pipeline_fetch_data__instruction__data__var = pipeline_state__instruction_data;
        end //if
        pipeline_fetch_data__valid = pipeline_fetch_data__valid__var;
        pipeline_fetch_data__instruction__data = pipeline_fetch_data__instruction__data__var;
        pipeline_fetch_data__instruction__debug__valid = pipeline_fetch_data__instruction__debug__valid__var;
        pipeline_fetch_data__instruction__debug__debug_op = pipeline_fetch_data__instruction__debug__debug_op__var;
        pipeline_fetch_data__instruction__debug__data = pipeline_fetch_data__instruction__debug__data__var;
    end //always

endmodule // riscv_i32_pipeline_control_fetch_data
