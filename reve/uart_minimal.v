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

//a Module uart_minimal
    //   
    //   This is a bare-minimum UART for one start bit, 8 data bits, one stop bit.
    //   
    //   It has a single byte of holding register in each direction.
    //   
module uart_minimal
(
    clk,
    clk__enable,

    uart_rx__rxd,
    uart_rx__rts,
    uart_control__clear_errors,
    uart_control__rx_ack,
    uart_control__tx_valid,
    uart_control__tx_data,
    uart_control__write_config,
    uart_control__write_brg,
    uart_control__write_data,
    reset_n,

    uart_tx__txd,
    uart_tx__cts,
    uart_output__config_data,
    uart_output__brg_config_data,
    uart_output__status__tx_empty,
    uart_output__status__rx_not_empty,
    uart_output__status__rx_half_full,
    uart_output__status__rx_parity_error,
    uart_output__status__rx_framing_error,
    uart_output__status__rx_overflow,
    uart_output__tx_ack,
    uart_output__rx_valid,
    uart_output__rx_data
);

    //b Clocks
    input clk;
    input clk__enable;

    //b Inputs
    input uart_rx__rxd;
    input uart_rx__rts;
    input uart_control__clear_errors;
    input uart_control__rx_ack;
    input uart_control__tx_valid;
    input [7:0]uart_control__tx_data;
    input uart_control__write_config;
    input uart_control__write_brg;
    input [31:0]uart_control__write_data;
    input reset_n;

    //b Outputs
    output uart_tx__txd;
    output uart_tx__cts;
    output [31:0]uart_output__config_data;
    output [31:0]uart_output__brg_config_data;
    output uart_output__status__tx_empty;
    output uart_output__status__rx_not_empty;
    output uart_output__status__rx_half_full;
    output uart_output__status__rx_parity_error;
    output uart_output__status__rx_framing_error;
    output uart_output__status__rx_overflow;
    output uart_output__tx_ack;
    output uart_output__rx_valid;
    output [7:0]uart_output__rx_data;

// output components here

    //b Output combinatorials
    reg uart_tx__txd;
    reg uart_tx__cts;
    reg [31:0]uart_output__config_data;
    reg [31:0]uart_output__brg_config_data;
    reg uart_output__status__tx_empty;
    reg uart_output__status__rx_not_empty;
    reg uart_output__status__rx_half_full;
    reg uart_output__status__rx_parity_error;
    reg uart_output__status__rx_framing_error;
    reg uart_output__status__rx_overflow;
    reg uart_output__tx_ack;
    reg uart_output__rx_valid;
    reg [7:0]uart_output__rx_data;

    //b Output nets

    //b Internal and output registers
        //   Receive state
    reg [2:0]receive_state__fsm_state;
    reg [3:0]receive_state__sub_bit;
    reg [7:0]receive_state__shift_register;
    reg [3:0]receive_state__bit_number;
    reg [2:0]receive_state__rxd_sync_reg;
    reg receive_state__active;
    reg receive_state__overflow;
    reg receive_state__framing_error;
    reg receive_state__holding_register__valid;
    reg [7:0]receive_state__holding_register__data;
        //   Transmit state
    reg [3:0]transmit_state__divider;
    reg [9:0]transmit_state__shift_register;
    reg [3:0]transmit_state__bits_remaining;
    reg transmit_state__active;
    reg transmit_state__holding_register__valid;
    reg [7:0]transmit_state__holding_register__data;

    //b Internal combinatorials
        //   Combinatorial decode of receive state
    reg receive_combs__brg_enable;
    reg receive_combs__sync_rxd;
    reg [2:0]receive_combs__action;
    reg receive_combs__produce_holding_register;
    reg receive_combs__framing_error;
        //   Combinatorial decode of transmit state
    reg transmit_combs__consume_holding_register;
    reg transmit_combs__brg_enable;
    reg transmit_combs__finish_byte;
    reg brg_control__write_config;
    reg [31:0]brg_control__write_data;
    reg brg_control__start;
    reg brg_control__stop;
    reg brg_control__disable_fractional;

    //b Internal nets
    wire [31:0]brg_output__config_data;
    wire brg_output__running;
    wire brg_output__clock_enable;

    //b Clock gating module instances
    //b Module instances
    clock_divider brg(
        .clk(clk),
        .clk__enable(1'b1),
        .divider_control__disable_fractional(brg_control__disable_fractional),
        .divider_control__stop(brg_control__stop),
        .divider_control__start(brg_control__start),
        .divider_control__write_data(brg_control__write_data),
        .divider_control__write_config(brg_control__write_config),
        .reset_n(reset_n),
        .divider_output__clock_enable(            brg_output__clock_enable),
        .divider_output__running(            brg_output__running),
        .divider_output__config_data(            brg_output__config_data)         );
    //b drive_outputs combinatorial process
    always @ ( * )//drive_outputs
    begin: drive_outputs__comb_code
    reg [31:0]uart_output__config_data__var;
    reg [31:0]uart_output__brg_config_data__var;
    reg uart_output__status__tx_empty__var;
    reg uart_output__status__rx_not_empty__var;
    reg uart_output__status__rx_framing_error__var;
    reg uart_output__status__rx_overflow__var;
    reg uart_output__tx_ack__var;
    reg uart_output__rx_valid__var;
    reg [7:0]uart_output__rx_data__var;
    reg uart_tx__txd__var;
        uart_output__config_data__var = 32'h0;
        uart_output__brg_config_data__var = 32'h0;
        uart_output__status__tx_empty__var = 1'h0;
        uart_output__status__rx_not_empty__var = 1'h0;
        uart_output__status__rx_half_full = 1'h0;
        uart_output__status__rx_parity_error = 1'h0;
        uart_output__status__rx_framing_error__var = 1'h0;
        uart_output__status__rx_overflow__var = 1'h0;
        uart_output__tx_ack__var = 1'h0;
        uart_output__rx_valid__var = 1'h0;
        uart_output__rx_data__var = 8'h0;
        uart_output__status__tx_empty__var = !(transmit_state__holding_register__valid!=1'h0);
        uart_output__status__rx_not_empty__var = receive_state__holding_register__valid;
        uart_output__status__rx_framing_error__var = receive_state__framing_error;
        uart_output__status__rx_overflow__var = receive_state__overflow;
        uart_output__tx_ack__var = !(transmit_state__holding_register__valid!=1'h0);
        uart_output__rx_valid__var = receive_state__holding_register__valid;
        uart_output__rx_data__var = receive_state__holding_register__data;
        uart_output__config_data__var = 32'h0;
        uart_output__brg_config_data__var = brg_output__config_data;
        uart_tx__txd__var = 1'h0;
        uart_tx__cts = 1'h0;
        uart_tx__txd__var = 1'h1;
        if ((transmit_state__active!=1'h0))
        begin
            uart_tx__txd__var = transmit_state__shift_register[0];
        end //if
        uart_output__config_data = uart_output__config_data__var;
        uart_output__brg_config_data = uart_output__brg_config_data__var;
        uart_output__status__tx_empty = uart_output__status__tx_empty__var;
        uart_output__status__rx_not_empty = uart_output__status__rx_not_empty__var;
        uart_output__status__rx_framing_error = uart_output__status__rx_framing_error__var;
        uart_output__status__rx_overflow = uart_output__status__rx_overflow__var;
        uart_output__tx_ack = uart_output__tx_ack__var;
        uart_output__rx_valid = uart_output__rx_valid__var;
        uart_output__rx_data = uart_output__rx_data__var;
        uart_tx__txd = uart_tx__txd__var;
    end //always

    //b uart_control_interface clock process
    always @( posedge clk or negedge reset_n)
    begin : uart_control_interface__code
        if (reset_n==1'b0)
        begin
            receive_state__overflow <= 1'h0;
            receive_state__framing_error <= 1'h0;
            receive_state__holding_register__valid <= 1'h0;
            transmit_state__holding_register__valid <= 1'h0;
            transmit_state__holding_register__data <= 8'h0;
            receive_state__holding_register__data <= 8'h0;
        end
        else if (clk__enable)
        begin
            if ((uart_control__clear_errors!=1'h0))
            begin
                receive_state__overflow <= 1'h0;
                receive_state__framing_error <= 1'h0;
            end //if
            if ((uart_control__rx_ack!=1'h0))
            begin
                receive_state__holding_register__valid <= 1'h0;
            end //if
            if (((uart_control__tx_valid!=1'h0)&&!(transmit_state__holding_register__valid!=1'h0)))
            begin
                transmit_state__holding_register__valid <= 1'h1;
                transmit_state__holding_register__data <= uart_control__tx_data;
            end //if
            if ((transmit_combs__consume_holding_register!=1'h0))
            begin
                transmit_state__holding_register__valid <= 1'h0;
            end //if
            if ((receive_combs__produce_holding_register!=1'h0))
            begin
                if ((receive_state__holding_register__valid!=1'h0))
                begin
                    receive_state__overflow <= 1'h1;
                end //if
                receive_state__holding_register__data <= receive_state__shift_register;
                receive_state__holding_register__valid <= 1'h1;
            end //if
            if ((receive_combs__framing_error!=1'h0))
            begin
                receive_state__framing_error <= 1'h1;
            end //if
        end //if
    end //always

    //b baud_rate combinatorial process
        //   
        //       Use a standard clock divider for the baud rate generator
        //       This can be fractional or integer
        //       For 115200 baud the clock enable should be every 542.5ns (1.8432MHz)
        //       For a 50MHz base clock this is divide by 27.13
        //       For a 300MHz base clock this is divide by 162.75
        //       These can be achieved to 1% accuracy with an integer divide, but fractional
        //       should be supported for higher accuracy (or lower clock speed)
        //       
    always @ ( * )//baud_rate
    begin: baud_rate__comb_code
    reg brg_control__start__var;
    reg brg_control__stop__var;
        brg_control__disable_fractional = 1'h0;
        brg_control__start__var = 1'h0;
        brg_control__stop__var = 1'h0;
        if (((transmit_combs__brg_enable!=1'h0)||(receive_combs__brg_enable!=1'h0)))
        begin
            brg_control__start__var = !(brg_output__running!=1'h0);
        end //if
        else
        
        begin
            if ((brg_output__running!=1'h0))
            begin
                brg_control__stop__var = 1'h1;
            end //if
        end //else
        brg_control__write_config = uart_control__write_brg;
        brg_control__write_data = uart_control__write_data;
        brg_control__start = brg_control__start__var;
        brg_control__stop = brg_control__stop__var;
    end //always

    //b transmitter__comb combinatorial process
        //   
        //       The transmitter has a 10-bit shift register initialized with
        //       STOP, DATA[8;0], START
        //       i.e. 1b1, data[8;0], 1b0
        //       and this is shifted out at the BRG clock enable rate divided by 16
        //   
        //       The transmitter is activated on a BRG tick when the holding register is valid;
        //       this pops the holding register.
        //       
    always @ ( * )//transmitter__comb
    begin: transmitter__comb_code
    reg transmit_combs__finish_byte__var;
    reg transmit_combs__consume_holding_register__var;
        transmit_combs__finish_byte__var = 1'h0;
        if (((transmit_state__active!=1'h0)&&(brg_output__clock_enable!=1'h0)))
        begin
            if ((transmit_state__divider==4'h0))
            begin
                transmit_combs__finish_byte__var = (transmit_state__bits_remaining==4'h0);
            end //if
            else
            
            begin
            end //else
        end //if
        transmit_combs__consume_holding_register__var = 1'h0;
        if ((brg_output__clock_enable!=1'h0))
        begin
            if (((transmit_state__holding_register__valid!=1'h0)&&((transmit_combs__finish_byte__var!=1'h0)||!(transmit_state__active!=1'h0))))
            begin
                transmit_combs__consume_holding_register__var = 1'h1;
            end //if
        end //if
        transmit_combs__brg_enable = ((transmit_state__active!=1'h0)||(transmit_state__holding_register__valid!=1'h0));
        transmit_combs__finish_byte = transmit_combs__finish_byte__var;
        transmit_combs__consume_holding_register = transmit_combs__consume_holding_register__var;
    end //always

    //b transmitter__posedge_clk_active_low_reset_n clock process
        //   
        //       The transmitter has a 10-bit shift register initialized with
        //       STOP, DATA[8;0], START
        //       i.e. 1b1, data[8;0], 1b0
        //       and this is shifted out at the BRG clock enable rate divided by 16
        //   
        //       The transmitter is activated on a BRG tick when the holding register is valid;
        //       this pops the holding register.
        //       
    always @( posedge clk or negedge reset_n)
    begin : transmitter__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            transmit_state__divider <= 4'h0;
            transmit_state__shift_register <= 10'h0;
            transmit_state__bits_remaining <= 4'h0;
            transmit_state__active <= 1'h0;
        end
        else if (clk__enable)
        begin
            if (((transmit_state__active!=1'h0)&&(brg_output__clock_enable!=1'h0)))
            begin
                if ((transmit_state__divider==4'h0))
                begin
                    transmit_state__divider <= 4'hf;
                    transmit_state__shift_register <= {1'h1,transmit_state__shift_register[9:1]};
                    transmit_state__bits_remaining <= (transmit_state__bits_remaining-4'h1);
                end //if
                else
                
                begin
                    transmit_state__divider <= (transmit_state__divider-4'h1);
                end //else
            end //if
            if ((brg_output__clock_enable!=1'h0))
            begin
                if ((transmit_combs__finish_byte!=1'h0))
                begin
                    transmit_state__active <= 1'h0;
                end //if
                if (((transmit_state__holding_register__valid!=1'h0)&&((transmit_combs__finish_byte!=1'h0)||!(transmit_state__active!=1'h0))))
                begin
                    transmit_state__shift_register <= {{1'h1,transmit_state__holding_register__data},1'h0};
                    transmit_state__bits_remaining <= 4'h9;
                    transmit_state__active <= 1'h1;
                    transmit_state__divider <= 4'hf;
                end //if
            end //if
        end //if
    end //always

    //b receiver__comb combinatorial process
        //   
        //       The receiver has a simple state machine:
        //       Idle: waiting for start bit (low on rxd)
        //       StartBegin : beginning of start bit
        //       CaptureBit(n) : ideally the middle of the bit
        //       StopBit : ideally the middle of the stop bit
        //       Complete : Done
        //       Error : 
        //   
        //       Bits are shifted in to a shift register from the top
        //   
        //       A framing
        //       
    always @ ( * )//receiver__comb
    begin: receiver__comb_code
    reg [2:0]receive_combs__action__var;
    reg receive_combs__produce_holding_register__var;
    reg receive_combs__framing_error__var;
        receive_combs__sync_rxd = receive_state__rxd_sync_reg[0];
        receive_combs__action__var = 3'h0;
        case (receive_state__fsm_state) //synopsys parallel_case
        3'h0: // req 1
            begin
            if (!(receive_combs__sync_rxd!=1'h0))
            begin
                receive_combs__action__var = 3'h1;
            end //if
            end
        3'h1: // req 1
            begin
            if ((receive_state__sub_bit==4'h0))
            begin
                receive_combs__action__var = 3'h2;
            end //if
            if ((receive_combs__sync_rxd!=1'h0))
            begin
                receive_combs__action__var = 3'h3;
            end //if
            end
        3'h2: // req 1
            begin
            if ((receive_state__sub_bit==4'h0))
            begin
                receive_combs__action__var = 3'h2;
                if ((receive_state__bit_number==4'h8))
                begin
                    receive_combs__action__var = 3'h4;
                end //if
            end //if
            end
        3'h3: // req 1
            begin
            if ((receive_state__sub_bit==4'h0))
            begin
                receive_combs__action__var = 3'h5;
                if (!(receive_combs__sync_rxd!=1'h0))
                begin
                    receive_combs__action__var = 3'h3;
                end //if
            end //if
            end
        3'h4: // req 1
            begin
            if ((receive_combs__sync_rxd!=1'h0))
            begin
                receive_combs__action__var = 3'h6;
            end //if
            end
    //synopsys  translate_off
    //pragma coverage off
        default:
            begin
                if (1)
                begin
                    $display("%t *********CDL ASSERTION FAILURE:uart_minimal:receiver: Full switch statement did not cover all values", $time);
                end
            end
    //pragma coverage on
    //synopsys  translate_on
        endcase
        if (!(brg_output__clock_enable!=1'h0))
        begin
            receive_combs__action__var = 3'h0;
        end //if
        receive_combs__brg_enable = ((receive_state__active!=1'h0)||!(receive_combs__sync_rxd!=1'h0));
        receive_combs__produce_holding_register__var = 1'h0;
        receive_combs__framing_error__var = 1'h0;
        case (receive_combs__action__var) //synopsys parallel_case
        3'h1: // req 1
            begin
            end
        3'h2: // req 1
            begin
            end
        3'h4: // req 1
            begin
            end
        3'h5: // req 1
            begin
            receive_combs__produce_holding_register__var = 1'h1;
            end
        3'h3: // req 1
            begin
            receive_combs__framing_error__var = 1'h1;
            end
        3'h6: // req 1
            begin
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
        receive_combs__action = receive_combs__action__var;
        receive_combs__produce_holding_register = receive_combs__produce_holding_register__var;
        receive_combs__framing_error = receive_combs__framing_error__var;
    end //always

    //b receiver__posedge_clk_active_low_reset_n clock process
        //   
        //       The receiver has a simple state machine:
        //       Idle: waiting for start bit (low on rxd)
        //       StartBegin : beginning of start bit
        //       CaptureBit(n) : ideally the middle of the bit
        //       StopBit : ideally the middle of the stop bit
        //       Complete : Done
        //       Error : 
        //   
        //       Bits are shifted in to a shift register from the top
        //   
        //       A framing
        //       
    always @( posedge clk or negedge reset_n)
    begin : receiver__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            receive_state__rxd_sync_reg <= 3'h0;
            receive_state__rxd_sync_reg <= 3'h7;
            receive_state__sub_bit <= 4'h0;
            receive_state__active <= 1'h0;
            receive_state__fsm_state <= 3'h0;
            receive_state__bit_number <= 4'h0;
            receive_state__shift_register <= 8'h0;
        end
        else if (clk__enable)
        begin
            receive_state__rxd_sync_reg <= (receive_state__rxd_sync_reg>>64'h1);
            receive_state__rxd_sync_reg[2] <= uart_rx__rxd;
            if (((brg_output__clock_enable!=1'h0)&&(receive_state__active!=1'h0)))
            begin
                receive_state__sub_bit <= (receive_state__sub_bit-4'h1);
            end //if
            case (receive_combs__action) //synopsys parallel_case
            3'h1: // req 1
                begin
                receive_state__active <= 1'h1;
                receive_state__fsm_state <= 3'h1;
                receive_state__sub_bit <= 4'h7;
                receive_state__bit_number <= 4'h0;
                end
            3'h2: // req 1
                begin
                receive_state__fsm_state <= 3'h2;
                receive_state__sub_bit <= 4'hf;
                receive_state__bit_number <= (receive_state__bit_number+4'h1);
                receive_state__shift_register <= {receive_combs__sync_rxd,receive_state__shift_register[7:1]};
                end
            3'h4: // req 1
                begin
                receive_state__shift_register <= {receive_combs__sync_rxd,receive_state__shift_register[7:1]};
                receive_state__fsm_state <= 3'h3;
                receive_state__sub_bit <= 4'hf;
                end
            3'h5: // req 1
                begin
                receive_state__fsm_state <= 3'h0;
                receive_state__active <= 1'h0;
                end
            3'h3: // req 1
                begin
                receive_state__fsm_state <= 3'h4;
                end
            3'h6: // req 1
                begin
                receive_state__fsm_state <= 3'h0;
                receive_state__active <= 1'h0;
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
        end //if
    end //always

endmodule // uart_minimal
