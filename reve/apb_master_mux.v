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

//a Module apb_master_mux
    //   
    //   APB multiplexer - or rather, arbiter and multiplexer
    //   
    //   The module takes two APB requests in, and provides a single APB request out.
    //   
    //   An APB request from each master is registered, and APB transactions
    //   are performed using simple round-robin arbitration.
    //   
    //   
module apb_master_mux
(
    clk,
    clk__enable,

    apb_response__prdata,
    apb_response__pready,
    apb_response__perr,
    apb_request_1__paddr,
    apb_request_1__penable,
    apb_request_1__psel,
    apb_request_1__pwrite,
    apb_request_1__pwdata,
    apb_request_0__paddr,
    apb_request_0__penable,
    apb_request_0__psel,
    apb_request_0__pwrite,
    apb_request_0__pwdata,
    reset_n,

    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    apb_response_1__prdata,
    apb_response_1__pready,
    apb_response_1__perr,
    apb_response_0__prdata,
    apb_response_0__pready,
    apb_response_0__perr
);

    //b Clocks
        //   System clock
    input clk;
    input clk__enable;

    //b Inputs
        //   APB response from targets
    input [31:0]apb_response__prdata;
    input apb_response__pready;
    input apb_response__perr;
        //   APB request to master 1
    input [31:0]apb_request_1__paddr;
    input apb_request_1__penable;
    input apb_request_1__psel;
    input apb_request_1__pwrite;
    input [31:0]apb_request_1__pwdata;
        //   APB request to master 0
    input [31:0]apb_request_0__paddr;
    input apb_request_0__penable;
    input apb_request_0__psel;
    input apb_request_0__pwrite;
    input [31:0]apb_request_0__pwdata;
        //   Active low reset
    input reset_n;

    //b Outputs
        //   APB request to targets
    output [31:0]apb_request__paddr;
    output apb_request__penable;
    output apb_request__psel;
    output apb_request__pwrite;
    output [31:0]apb_request__pwdata;
        //   APB response to master 1
    output [31:0]apb_response_1__prdata;
    output apb_response_1__pready;
    output apb_response_1__perr;
        //   APB response to master 0
    output [31:0]apb_response_0__prdata;
    output apb_response_0__pready;
    output apb_response_0__perr;

// output components here

    //b Output combinatorials

    //b Output nets

    //b Internal and output registers
    reg arbiter_state__busy;
    reg arbiter_state__handling;
    reg [31:0]apb_request_1_r__paddr;
    reg apb_request_1_r__penable;
    reg apb_request_1_r__psel;
    reg apb_request_1_r__pwrite;
    reg [31:0]apb_request_1_r__pwdata;
    reg [31:0]apb_request_0_r__paddr;
    reg apb_request_0_r__penable;
    reg apb_request_0_r__psel;
    reg apb_request_0_r__pwrite;
    reg [31:0]apb_request_0_r__pwdata;
    reg [31:0]apb_request__paddr;
    reg apb_request__penable;
    reg apb_request__psel;
    reg apb_request__pwrite;
    reg [31:0]apb_request__pwdata;
    reg [31:0]apb_response_1__prdata;
    reg apb_response_1__pready;
    reg apb_response_1__perr;
    reg [31:0]apb_response_0__prdata;
    reg apb_response_0__pready;
    reg apb_response_0__perr;

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b apb_master_interfaces clock process
        //   
        //       The APB master interfaces are registered (if psel is asserted)
        //   
        //       A not-ready response is presented unless the request is completing.
        //       
    always @( posedge clk or negedge reset_n)
    begin : apb_master_interfaces__code
        if (reset_n==1'b0)
        begin
            apb_request_0_r__paddr <= 32'h0;
            apb_request_0_r__penable <= 1'h0;
            apb_request_0_r__psel <= 1'h0;
            apb_request_0_r__pwrite <= 1'h0;
            apb_request_0_r__pwdata <= 32'h0;
            apb_request_1_r__paddr <= 32'h0;
            apb_request_1_r__penable <= 1'h0;
            apb_request_1_r__psel <= 1'h0;
            apb_request_1_r__pwrite <= 1'h0;
            apb_request_1_r__pwdata <= 32'h0;
            apb_response_0__pready <= 1'h0;
            apb_response_1__pready <= 1'h0;
            apb_response_1__prdata <= 32'h0;
            apb_response_1__perr <= 1'h0;
            apb_response_0__prdata <= 32'h0;
            apb_response_0__perr <= 1'h0;
            arbiter_state__busy <= 1'h0;
            apb_request__psel <= 1'h0;
            apb_request__penable <= 1'h0;
            arbiter_state__handling <= 1'h0;
            apb_request__paddr <= 32'h0;
            apb_request__pwrite <= 1'h0;
            apb_request__pwdata <= 32'h0;
        end
        else if (clk__enable)
        begin
            if (((apb_request_0__psel!=1'h0)||(apb_request_0_r__psel!=1'h0)))
            begin
                apb_request_0_r__paddr <= apb_request_0__paddr;
                apb_request_0_r__penable <= apb_request_0__penable;
                apb_request_0_r__psel <= apb_request_0__psel;
                apb_request_0_r__pwrite <= apb_request_0__pwrite;
                apb_request_0_r__pwdata <= apb_request_0__pwdata;
                if ((apb_response_0__pready!=1'h0))
                begin
                    apb_request_0_r__psel <= 1'h0;
                end //if
            end //if
            if (((apb_request_1__psel!=1'h0)||(apb_request_1_r__psel!=1'h0)))
            begin
                apb_request_1_r__paddr <= apb_request_1__paddr;
                apb_request_1_r__penable <= apb_request_1__penable;
                apb_request_1_r__psel <= apb_request_1__psel;
                apb_request_1_r__pwrite <= apb_request_1__pwrite;
                apb_request_1_r__pwdata <= apb_request_1__pwdata;
                if ((apb_response_1__pready!=1'h0))
                begin
                    apb_request_1_r__psel <= 1'h0;
                end //if
            end //if
            apb_response_0__pready <= 1'h0;
            apb_response_1__pready <= 1'h0;
            if ((((arbiter_state__busy!=1'h0)&&(apb_request__penable!=1'h0))&&(apb_response__pready!=1'h0)))
            begin
                if ((arbiter_state__handling!=1'h0))
                begin
                    apb_response_1__prdata <= apb_response__prdata;
                    apb_response_1__pready <= apb_response__pready;
                    apb_response_1__perr <= apb_response__perr;
                end //if
                else
                
                begin
                    apb_response_0__prdata <= apb_response__prdata;
                    apb_response_0__pready <= apb_response__pready;
                    apb_response_0__perr <= apb_response__perr;
                end //else
            end //if
            if ((arbiter_state__busy!=1'h0))
            begin
                if ((apb_request__penable!=1'h0))
                begin
                    if ((apb_response__pready!=1'h0))
                    begin
                        arbiter_state__busy <= 1'h0;
                        apb_request__psel <= 1'h0;
                        apb_request__penable <= 1'h0;
                    end //if
                end //if
                else
                
                begin
                    apb_request__penable <= 1'h1;
                end //else
            end //if
            else
            
            begin
                if ((((apb_request_0_r__psel!=1'h0)&&!(apb_response_0__pready!=1'h0))&&(!(apb_request_1_r__psel!=1'h0)||(arbiter_state__handling!=1'h0))))
                begin
                    arbiter_state__busy <= 1'h1;
                    arbiter_state__handling <= 1'h0;
                    apb_request__paddr <= apb_request_0_r__paddr;
                    apb_request__penable <= apb_request_0_r__penable;
                    apb_request__psel <= apb_request_0_r__psel;
                    apb_request__pwrite <= apb_request_0_r__pwrite;
                    apb_request__pwdata <= apb_request_0_r__pwdata;
                    apb_request__penable <= 1'h0;
                end //if
                else
                
                begin
                    if (((apb_request_1_r__psel!=1'h0)&&!(apb_response_1__pready!=1'h0)))
                    begin
                        arbiter_state__busy <= 1'h1;
                        arbiter_state__handling <= 1'h1;
                        apb_request__paddr <= apb_request_1_r__paddr;
                        apb_request__penable <= apb_request_1_r__penable;
                        apb_request__psel <= apb_request_1_r__psel;
                        apb_request__pwrite <= apb_request_1_r__pwrite;
                        apb_request__pwdata <= apb_request_1_r__pwdata;
                        apb_request__penable <= 1'h0;
                    end //if
                end //else
            end //else
        end //if
    end //always

endmodule // apb_master_mux
