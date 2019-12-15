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

//a Module apb_target_uart_minimal
    //   
    //   This is an APB target that uses a minimal UART
    //   
module apb_target_uart_minimal
(
    clk,
    clk__enable,

    uart_rx__rxd,
    uart_rx__rts,
    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    reset_n,

    status__tx_empty,
    status__rx_not_empty,
    status__rx_half_full,
    status__rx_parity_error,
    status__rx_framing_error,
    status__rx_overflow,
    uart_tx__txd,
    uart_tx__cts,
    apb_response__prdata,
    apb_response__pready,
    apb_response__perr
);

    //b Clocks
    input clk;
    input clk__enable;

    //b Inputs
    input uart_rx__rxd;
    input uart_rx__rts;
        //   APB request
    input [31:0]apb_request__paddr;
    input apb_request__penable;
    input apb_request__psel;
    input apb_request__pwrite;
    input [31:0]apb_request__pwdata;
    input reset_n;

    //b Outputs
    output status__tx_empty;
    output status__rx_not_empty;
    output status__rx_half_full;
    output status__rx_parity_error;
    output status__rx_framing_error;
    output status__rx_overflow;
    output uart_tx__txd;
    output uart_tx__cts;
        //   APB response
    output [31:0]apb_response__prdata;
    output apb_response__pready;
    output apb_response__perr;

// output components here

    //b Output combinatorials
    reg status__tx_empty;
    reg status__rx_not_empty;
    reg status__rx_half_full;
    reg status__rx_parity_error;
    reg status__rx_framing_error;
    reg status__rx_overflow;
        //   APB response
    reg [31:0]apb_response__prdata;
    reg apb_response__pready;
    reg apb_response__perr;

    //b Output nets
    wire uart_tx__txd;
    wire uart_tx__cts;

    //b Internal and output registers
        //   Decode of APB
    reg [3:0]apb_state__access;

    //b Internal combinatorials
    reg uart_control__clear_errors;
    reg uart_control__rx_ack;
    reg uart_control__tx_valid;
    reg [7:0]uart_control__tx_data;
    reg uart_control__write_config;
    reg uart_control__write_brg;
    reg [31:0]uart_control__write_data;

    //b Internal nets
    wire [31:0]uart_output__config_data;
    wire [31:0]uart_output__brg_config_data;
    wire uart_output__status__tx_empty;
    wire uart_output__status__rx_not_empty;
    wire uart_output__status__rx_half_full;
    wire uart_output__status__rx_parity_error;
    wire uart_output__status__rx_framing_error;
    wire uart_output__status__rx_overflow;
    wire uart_output__tx_ack;
    wire uart_output__rx_valid;
    wire [7:0]uart_output__rx_data;

    //b Clock gating module instances
    //b Module instances
    uart_minimal uart(
        .clk(clk),
        .clk__enable(1'b1),
        .uart_rx__rts(uart_rx__rts),
        .uart_rx__rxd(uart_rx__rxd),
        .uart_control__write_data(uart_control__write_data),
        .uart_control__write_brg(uart_control__write_brg),
        .uart_control__write_config(uart_control__write_config),
        .uart_control__tx_data(uart_control__tx_data),
        .uart_control__tx_valid(uart_control__tx_valid),
        .uart_control__rx_ack(uart_control__rx_ack),
        .uart_control__clear_errors(uart_control__clear_errors),
        .reset_n(reset_n),
        .uart_tx__cts(            uart_tx__cts),
        .uart_tx__txd(            uart_tx__txd),
        .uart_output__rx_data(            uart_output__rx_data),
        .uart_output__rx_valid(            uart_output__rx_valid),
        .uart_output__tx_ack(            uart_output__tx_ack),
        .uart_output__status__rx_overflow(            uart_output__status__rx_overflow),
        .uart_output__status__rx_framing_error(            uart_output__status__rx_framing_error),
        .uart_output__status__rx_parity_error(            uart_output__status__rx_parity_error),
        .uart_output__status__rx_half_full(            uart_output__status__rx_half_full),
        .uart_output__status__rx_not_empty(            uart_output__status__rx_not_empty),
        .uart_output__status__tx_empty(            uart_output__status__tx_empty),
        .uart_output__brg_config_data(            uart_output__brg_config_data),
        .uart_output__config_data(            uart_output__config_data)         );
    //b drive_outputs combinatorial process
    always @ ( * )//drive_outputs
    begin: drive_outputs__comb_code
        status__tx_empty = uart_output__status__tx_empty;
        status__rx_not_empty = uart_output__status__rx_not_empty;
        status__rx_half_full = uart_output__status__rx_half_full;
        status__rx_parity_error = uart_output__status__rx_parity_error;
        status__rx_framing_error = uart_output__status__rx_framing_error;
        status__rx_overflow = uart_output__status__rx_overflow;
    end //always

    //b apb_interface__comb combinatorial process
    always @ ( * )//apb_interface__comb
    begin: apb_interface__comb_code
    reg [31:0]apb_response__prdata__var;
    reg apb_response__pready__var;
        apb_response__prdata__var = 32'h0;
        apb_response__pready__var = 1'h0;
        apb_response__perr = 1'h0;
        apb_response__pready__var = 1'h1;
        case (apb_state__access) //synopsys parallel_case
        4'h7: // req 1
            begin
            apb_response__prdata__var[8] = !(uart_output__tx_ack!=1'h0);
            apb_response__prdata__var[16] = uart_output__rx_valid;
            apb_response__prdata__var[17] = uart_output__status__rx_half_full;
            apb_response__prdata__var[18] = uart_output__status__rx_overflow;
            apb_response__prdata__var[19] = uart_output__status__rx_framing_error;
            apb_response__prdata__var[20] = uart_output__status__rx_parity_error;
            end
        4'h2: // req 1
            begin
            apb_response__prdata__var = uart_output__config_data;
            end
        4'h4: // req 1
            begin
            apb_response__prdata__var = uart_output__brg_config_data;
            end
        4'h6: // req 1
            begin
            apb_response__prdata__var[7:0] = uart_output__rx_data;
            apb_response__prdata__var[28] = uart_output__status__rx_overflow;
            apb_response__prdata__var[29] = uart_output__status__rx_framing_error;
            apb_response__prdata__var[30] = uart_output__status__rx_parity_error;
            apb_response__prdata__var[31] = !(uart_output__rx_valid!=1'h0);
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
        apb_response__prdata = apb_response__prdata__var;
        apb_response__pready = apb_response__pready__var;
    end //always

    //b apb_interface__posedge_clk_active_low_reset_n clock process
    always @( posedge clk or negedge reset_n)
    begin : apb_interface__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            apb_state__access <= 4'h0;
        end
        else if (clk__enable)
        begin
            case (apb_request__paddr[2:0]) //synopsys parallel_case
            3'h0: // req 1
                begin
                apb_state__access <= ((apb_request__pwrite!=1'h0)?4'h0:4'h7);
                end
            3'h2: // req 1
                begin
                apb_state__access <= ((apb_request__pwrite!=1'h0)?4'h1:4'h2);
                end
            3'h1: // req 1
                begin
                apb_state__access <= ((apb_request__pwrite!=1'h0)?4'h3:4'h4);
                end
            3'h3: // req 1
                begin
                apb_state__access <= ((apb_request__pwrite!=1'h0)?4'h5:4'h6);
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
            if ((!(apb_request__psel!=1'h0)||(apb_request__penable!=1'h0)))
            begin
                apb_state__access <= 4'h0;
            end //if
        end //if
    end //always

    //b uart_instance combinatorial process
        //   
        //       
    always @ ( * )//uart_instance
    begin: uart_instance__comb_code
        uart_control__clear_errors = (apb_state__access==4'h7);
        uart_control__rx_ack = (apb_state__access==4'h6);
        uart_control__tx_valid = (apb_state__access==4'h5);
        uart_control__tx_data = apb_request__pwdata[7:0];
        uart_control__write_config = (apb_state__access==4'h1);
        uart_control__write_brg = (apb_state__access==4'h3);
        uart_control__write_data = apb_request__pwdata;
    end //always

endmodule // apb_target_uart_minimal
