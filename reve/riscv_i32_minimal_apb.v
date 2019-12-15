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

//a Module riscv_i32_minimal_apb
    //   
    //   
module riscv_i32_minimal_apb
(
    clk,
    clk__enable,

    apb_response__prdata,
    apb_response__pready,
    apb_response__perr,
    data_access_req__valid,
    data_access_req__mode,
    data_access_req__req_type,
    data_access_req__address,
    data_access_req__sequential,
    data_access_req__byte_enable,
    data_access_req__write_data,
    reset_n,

    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    data_access_resp__ack_if_seq,
    data_access_resp__ack,
    data_access_resp__abort_req,
    data_access_resp__may_still_abort,
    data_access_resp__access_complete,
    data_access_resp__read_data
);

    //b Clocks
    input clk;
    input clk__enable;

    //b Inputs
    input [31:0]apb_response__prdata;
    input apb_response__pready;
    input apb_response__perr;
    input data_access_req__valid;
    input [2:0]data_access_req__mode;
    input [4:0]data_access_req__req_type;
    input [31:0]data_access_req__address;
    input data_access_req__sequential;
    input [3:0]data_access_req__byte_enable;
    input [31:0]data_access_req__write_data;
    input reset_n;

    //b Outputs
    output [31:0]apb_request__paddr;
    output apb_request__penable;
    output apb_request__psel;
    output apb_request__pwrite;
    output [31:0]apb_request__pwdata;
    output data_access_resp__ack_if_seq;
    output data_access_resp__ack;
    output data_access_resp__abort_req;
    output data_access_resp__may_still_abort;
    output data_access_resp__access_complete;
    output [31:0]data_access_resp__read_data;

// output components here

    //b Output combinatorials
    reg data_access_resp__ack_if_seq;
    reg data_access_resp__ack;
    reg data_access_resp__abort_req;
    reg data_access_resp__may_still_abort;
    reg data_access_resp__access_complete;
    reg [31:0]data_access_resp__read_data;

    //b Output nets

    //b Internal and output registers
    reg [31:0]apb_request__paddr;
    reg apb_request__penable;
    reg apb_request__psel;
    reg apb_request__pwrite;
    reg [31:0]apb_request__pwdata;

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b apb_logic__comb combinatorial process
        //   
    always @ ( * )//apb_logic__comb
    begin: apb_logic__comb_code
    reg data_access_resp__ack_if_seq__var;
    reg data_access_resp__ack__var;
    reg data_access_resp__abort_req__var;
    reg data_access_resp__access_complete__var;
    reg [31:0]data_access_resp__read_data__var;
        data_access_resp__ack_if_seq__var = 1'h0;
        data_access_resp__ack__var = 1'h0;
        data_access_resp__abort_req__var = 1'h0;
        data_access_resp__may_still_abort = 1'h0;
        data_access_resp__access_complete__var = 1'h0;
        data_access_resp__read_data__var = 32'h0;
        data_access_resp__ack__var = 1'h1;
        data_access_resp__ack_if_seq__var = 1'h1;
        data_access_resp__abort_req__var = 1'h0;
        data_access_resp__access_complete__var = 1'h1;
        if ((apb_request__penable!=1'h0))
        begin
            data_access_resp__read_data__var = apb_response__prdata;
        end //if
        if ((apb_request__psel!=1'h0))
        begin
            data_access_resp__ack__var = 1'h0;
            data_access_resp__ack_if_seq__var = 1'h0;
            data_access_resp__access_complete__var = 1'h0;
            if (((apb_request__penable!=1'h0)&&(apb_response__pready!=1'h0)))
            begin
                data_access_resp__access_complete__var = 1'h1;
            end //if
        end //if
        else
        
        begin
        end //else
        data_access_resp__ack_if_seq = data_access_resp__ack_if_seq__var;
        data_access_resp__ack = data_access_resp__ack__var;
        data_access_resp__abort_req = data_access_resp__abort_req__var;
        data_access_resp__access_complete = data_access_resp__access_complete__var;
        data_access_resp__read_data = data_access_resp__read_data__var;
    end //always

    //b apb_logic__posedge_clk_active_low_reset_n clock process
        //   
    always @( posedge clk or negedge reset_n)
    begin : apb_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            apb_request__penable <= 1'h0;
            apb_request__psel <= 1'h0;
            apb_request__paddr <= 32'h0;
            apb_request__pwrite <= 1'h0;
            apb_request__pwdata <= 32'h0;
        end
        else if (clk__enable)
        begin
            if ((apb_request__psel!=1'h0))
            begin
                apb_request__penable <= 1'h1;
                if (((apb_request__penable!=1'h0)&&(apb_response__pready!=1'h0)))
                begin
                    apb_request__psel <= 1'h0;
                    apb_request__penable <= 1'h0;
                end //if
            end //if
            else
            
            begin
                if ((data_access_req__valid!=1'h0))
                begin
                    apb_request__psel <= 1'h1;
                    apb_request__penable <= 1'h0;
                    apb_request__paddr <= data_access_req__address;
                    apb_request__pwrite <= (data_access_req__req_type==5'h2);
                    apb_request__pwdata <= data_access_req__write_data;
                end //if
            end //else
        end //if
    end //always

endmodule // riscv_i32_minimal_apb
