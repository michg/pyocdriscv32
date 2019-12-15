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

//a Module apb_target_sram_interface
    //   
    //   APB target peripheral that generates SRAM read/write requests
    //   
    //   The module maintains a 32-bit SRAM address that is used in the
    //   requests, which is a read/write register. There is also a 32-bit
    //   control register, that can be used for any purpose by the client.
    //   
    //   SRAM requests occur when the data register is accessed; it can be
    //   accessed in one of three different ways. Firstly, it may be accessed
    //   simply read/write, with either generating the appropriate SRAM request
    //   to the address given by the SRAM address register. Secondly, it may be
    //   accessed with a post-increment, where the SRAM address register value
    //   is used as-is in the request, but it is incremented ready for a
    //   subsequent transaction. Thirdly, it may be accessed 'windowed'; in
    //   this manner the bottom 7 bits of the APB address are used in
    //   conjunction with the top 25 bits of the SRAM address register to
    //   generate the address for the SRAM request.
    //   
    //   
module apb_target_sram_interface
(
    clk,
    clk__enable,

    sram_access_resp__ack,
    sram_access_resp__valid,
    sram_access_resp__id,
    sram_access_resp__data,
    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    reset_n,

    sram_access_req__valid,
    sram_access_req__id,
    sram_access_req__read_not_write,
    sram_access_req__byte_enable,
    sram_access_req__address,
    sram_access_req__write_data,
    sram_ctrl,
    apb_response__prdata,
    apb_response__pready,
    apb_response__perr
);

    //b Clocks
        //   System clock
    input clk;
    input clk__enable;

    //b Inputs
        //   SRAM access response
    input sram_access_resp__ack;
    input sram_access_resp__valid;
    input [7:0]sram_access_resp__id;
    input [63:0]sram_access_resp__data;
        //   APB request
    input [31:0]apb_request__paddr;
    input apb_request__penable;
    input apb_request__psel;
    input apb_request__pwrite;
    input [31:0]apb_request__pwdata;
        //   Active low reset
    input reset_n;

    //b Outputs
        //   SRAM access request
    output sram_access_req__valid;
    output [7:0]sram_access_req__id;
    output sram_access_req__read_not_write;
    output [7:0]sram_access_req__byte_enable;
    output [31:0]sram_access_req__address;
    output [63:0]sram_access_req__write_data;
        //   SRAM control data, for whatever purpose
    output [31:0]sram_ctrl;
        //   APB response
    output [31:0]apb_response__prdata;
    output apb_response__pready;
    output apb_response__perr;

// output components here

    //b Output combinatorials
        //   SRAM control data, for whatever purpose
    reg [31:0]sram_ctrl;
        //   APB response
    reg [31:0]apb_response__prdata;
    reg apb_response__pready;
    reg apb_response__perr;

    //b Output nets

    //b Internal and output registers
    reg [3:0]req_resp_state__access;
    reg [31:0]req_resp_state__address;
    reg [31:0]req_resp_state__control;
    reg [31:0]req_resp_state__data;
    reg req_resp_state__in_progress;
    reg req_resp_state__data_valid;
    reg sram_access_req__valid;
    reg [7:0]sram_access_req__id;
    reg sram_access_req__read_not_write;
    reg [7:0]sram_access_req__byte_enable;
    reg [31:0]sram_access_req__address;
    reg [63:0]sram_access_req__write_data;

    //b Internal combinatorials
        //   Access being performed by APB, combinatorial decode - only not none in first cycle
    reg [3:0]access;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b apb_interface_logic combinatorial process
        //   
        //       The APB interface is decoded to @a access when @p psel is asserted
        //       and @p penable is deasserted - this is the first cycle of an APB
        //       access. This permits the access type to be registered, so that the
        //       APB @p prdata can be driven from registers, and so that writes
        //       will occur correctly when @p penable is asserted.
        //   
        //       The APB read data @p prdata can then be generated based on @a
        //       access.
        //       
    always @ ( * )//apb_interface_logic
    begin: apb_interface_logic__comb_code
    reg [3:0]access__var;
    reg [31:0]apb_response__prdata__var;
    reg apb_response__pready__var;
        access__var = 4'h0;
        if (((apb_request__paddr[7:0] & 8'h80)!=8'h0))
        begin
            access__var = ((apb_request__pwrite!=1'h0)?4'ha:4'h7);
        end //if
        else
        
        begin
            case (apb_request__paddr[6:0]) //synopsys parallel_case
            7'h0: // req 1
                begin
                access__var = ((apb_request__pwrite!=1'h0)?4'h1:4'h2);
                end
            7'h1: // req 1
                begin
                access__var = ((apb_request__pwrite!=1'h0)?4'h8:4'h5);
                end
            7'h2: // req 1
                begin
                access__var = ((apb_request__pwrite!=1'h0)?4'h3:4'h4);
                end
            default: // req 1
                begin
                access__var = ((apb_request__pwrite!=1'h0)?4'h9:4'h6);
                end
            endcase
        end //else
        if ((!(apb_request__psel!=1'h0)||(apb_request__penable!=1'h0)))
        begin
            access__var = 4'h0;
        end //if
        sram_ctrl = req_resp_state__control;
        apb_response__prdata__var = 32'h0;
        apb_response__pready__var = 1'h0;
        apb_response__perr = 1'h0;
        apb_response__pready__var = 1'h1;
        case (req_resp_state__access) //synopsys parallel_case
        4'h2: // req 1
            begin
            apb_response__prdata__var = req_resp_state__address;
            end
        4'h4: // req 1
            begin
            apb_response__prdata__var = req_resp_state__control;
            end
        4'h5: // req 1
            begin
            apb_response__prdata__var = req_resp_state__data;
            apb_response__pready__var = req_resp_state__data_valid;
            end
        4'h6: // req 1
            begin
            apb_response__prdata__var = req_resp_state__data;
            apb_response__pready__var = req_resp_state__data_valid;
            end
        4'h7: // req 1
            begin
            apb_response__prdata__var = req_resp_state__data;
            apb_response__pready__var = req_resp_state__data_valid;
            end
        4'h8: // req 1
            begin
            apb_response__pready__var = !(req_resp_state__in_progress!=1'h0);
            end
        4'h9: // req 1
            begin
            apb_response__pready__var = !(req_resp_state__in_progress!=1'h0);
            end
        4'ha: // req 1
            begin
            apb_response__pready__var = !(req_resp_state__in_progress!=1'h0);
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
        access = access__var;
        apb_response__prdata = apb_response__prdata__var;
        apb_response__pready = apb_response__pready__var;
    end //always

    //b sram_request_logic clock process
        //   
        //       While an SRAM request is in progress the APB side is ignored; it
        //       should be held as busy. Hence an acknowledged valid request can be
        //       removed, and a valid SRAM response completes the SRAM request in
        //       progress.
        //   
        //       If an SRAM request is not in progress then one may be started,
        //       depending on the APB access being presented.
        //       
    always @( posedge clk or negedge reset_n)
    begin : sram_request_logic__code
        if (reset_n==1'b0)
        begin
            sram_access_req__id <= 8'h0;
            sram_access_req__byte_enable <= 8'h0;
            sram_access_req__byte_enable <= 8'hf;
            sram_access_req__valid <= 1'h0;
            req_resp_state__in_progress <= 1'h0;
            req_resp_state__data <= 32'h0;
            req_resp_state__data_valid <= 1'h0;
            req_resp_state__access <= 4'h0;
            req_resp_state__address <= 32'h0;
            req_resp_state__control <= 32'h0;
            sram_access_req__read_not_write <= 1'h0;
            sram_access_req__address <= 32'h0;
            sram_access_req__write_data <= 64'h0;
        end
        else if (clk__enable)
        begin
            sram_access_req__id <= 8'h0;
            sram_access_req__byte_enable <= 8'hf;
            if ((req_resp_state__in_progress!=1'h0))
            begin
                if (((sram_access_req__valid!=1'h0)&&(sram_access_resp__ack!=1'h0)))
                begin
                    sram_access_req__valid <= 1'h0;
                end //if
                if ((sram_access_resp__valid!=1'h0))
                begin
                    req_resp_state__in_progress <= 1'h0;
                    req_resp_state__data <= sram_access_resp__data[31:0];
                    req_resp_state__data_valid <= 1'h1;
                end //if
            end //if
            else
            
            begin
                if ((access!=4'h0))
                begin
                    req_resp_state__access <= access;
                end //if
                case (access) //synopsys parallel_case
                4'h1: // req 1
                    begin
                    req_resp_state__address <= apb_request__pwdata;
                    end
                4'h3: // req 1
                    begin
                    req_resp_state__control <= apb_request__pwdata;
                    end
                4'h5: // req 1
                    begin
                    sram_access_req__valid <= 1'h1;
                    sram_access_req__read_not_write <= 1'h1;
                    sram_access_req__address <= req_resp_state__address;
                    req_resp_state__in_progress <= 1'h1;
                    req_resp_state__data_valid <= 1'h0;
                    end
                4'h6: // req 1
                    begin
                    sram_access_req__valid <= 1'h1;
                    sram_access_req__read_not_write <= 1'h1;
                    sram_access_req__address <= req_resp_state__address;
                    req_resp_state__in_progress <= 1'h1;
                    req_resp_state__data_valid <= 1'h0;
                    end
                4'h7: // req 1
                    begin
                    sram_access_req__valid <= 1'h1;
                    sram_access_req__read_not_write <= 1'h1;
                    sram_access_req__address <= req_resp_state__address;
                    req_resp_state__in_progress <= 1'h1;
                    req_resp_state__data_valid <= 1'h0;
                    end
                4'h8: // req 1
                    begin
                    sram_access_req__valid <= 1'h1;
                    sram_access_req__read_not_write <= 1'h0;
                    sram_access_req__address <= req_resp_state__address;
                    sram_access_req__write_data <= {32'h0,apb_request__pwdata};
                    req_resp_state__in_progress <= 1'h1;
                    req_resp_state__data_valid <= 1'h0;
                    end
                4'h9: // req 1
                    begin
                    sram_access_req__valid <= 1'h1;
                    sram_access_req__read_not_write <= 1'h0;
                    sram_access_req__address <= req_resp_state__address;
                    sram_access_req__write_data <= {32'h0,apb_request__pwdata};
                    req_resp_state__in_progress <= 1'h1;
                    req_resp_state__data_valid <= 1'h0;
                    end
                4'ha: // req 1
                    begin
                    sram_access_req__valid <= 1'h1;
                    sram_access_req__read_not_write <= 1'h0;
                    sram_access_req__address <= req_resp_state__address;
                    sram_access_req__write_data <= {32'h0,apb_request__pwdata};
                    req_resp_state__in_progress <= 1'h1;
                    req_resp_state__data_valid <= 1'h0;
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
                if (((access==4'ha)||(access==4'h7)))
                begin
                    sram_access_req__address[6:0] <= apb_request__paddr[6:0];
                end //if
                if (((access==4'h9)||(access==4'h6)))
                begin
                    req_resp_state__address <= (req_resp_state__address+32'h1);
                end //if
            end //else
        end //if
    end //always

endmodule // apb_target_sram_interface
