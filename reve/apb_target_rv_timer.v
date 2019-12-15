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

//a Module apb_target_rv_timer
    //   
    //   RISC-V compatible timer with an APB interface.
    //   
    //   This is a monotonically increasing 64-bit timer with a 64-bit comparator.
    //   
    //   
module apb_target_rv_timer
(
    clk,
    clk__enable,

    apb_request__paddr,
    apb_request__penable,
    apb_request__psel,
    apb_request__pwrite,
    apb_request__pwdata,
    timer_control__reset_counter,
    timer_control__enable_counter,
    timer_control__advance,
    timer_control__retard,
    timer_control__lock_to_master,
    timer_control__lock_window_lsb,
    timer_control__synchronize,
    timer_control__synchronize_value,
    timer_control__block_writes,
    timer_control__bonus_subfraction_add,
    timer_control__bonus_subfraction_sub,
    timer_control__fractional_adder,
    timer_control__integer_adder,
    reset_n,

    timer_value__value,
    timer_value__irq,
    timer_value__locked,
    apb_response__prdata,
    apb_response__pready,
    apb_response__perr
);

    //b Clocks
        //   System clock
    input clk;
    input clk__enable;

    //b Inputs
        //   APB request
    input [31:0]apb_request__paddr;
    input apb_request__penable;
    input apb_request__psel;
    input apb_request__pwrite;
    input [31:0]apb_request__pwdata;
        //   Control of the timer
    input timer_control__reset_counter;
    input timer_control__enable_counter;
    input timer_control__advance;
    input timer_control__retard;
    input timer_control__lock_to_master;
    input [1:0]timer_control__lock_window_lsb;
    input [1:0]timer_control__synchronize;
    input [63:0]timer_control__synchronize_value;
    input timer_control__block_writes;
    input [7:0]timer_control__bonus_subfraction_add;
    input [7:0]timer_control__bonus_subfraction_sub;
    input [3:0]timer_control__fractional_adder;
    input [7:0]timer_control__integer_adder;
        //   Active low reset
    input reset_n;

    //b Outputs
    output [63:0]timer_value__value;
    output timer_value__irq;
    output timer_value__locked;
        //   APB response
    output [31:0]apb_response__prdata;
    output apb_response__pready;
    output apb_response__perr;

// output components here

    //b Output combinatorials
    reg [63:0]timer_value__value;
    reg timer_value__irq;
    reg timer_value__locked;
        //   APB response
    reg [31:0]apb_response__prdata;
    reg apb_response__pready;
    reg apb_response__perr;

    //b Output nets

    //b Internal and output registers
        //   State of the timer and comparator
    reg [31:0]timer_state__comparator_lower;
    reg [31:0]timer_state__comparator_upper;
    reg timer_state__upper_eq;
    reg timer_state__upper_ge;
    reg timer_state__lower_eq;
    reg timer_state__lower_ge;
    reg timer_state__comparator_exceeded;
        //   Access being performed by APB
    reg [3:0]access;

    //b Internal combinatorials
        //   Combinatorial decode of timer state and controls
    reg [32:0]timer_combs__lower_t_minus_c;
    reg [32:0]timer_combs__upper_t_minus_c;
    reg timer_combs__timer_control__reset_counter;
    reg timer_combs__timer_control__enable_counter;
    reg timer_combs__timer_control__advance;
    reg timer_combs__timer_control__retard;
    reg timer_combs__timer_control__lock_to_master;
    reg [1:0]timer_combs__timer_control__lock_window_lsb;
    reg [1:0]timer_combs__timer_control__synchronize;
    reg [63:0]timer_combs__timer_control__synchronize_value;
    reg timer_combs__timer_control__block_writes;
    reg [7:0]timer_combs__timer_control__bonus_subfraction_add;
    reg [7:0]timer_combs__timer_control__bonus_subfraction_sub;
    reg [3:0]timer_combs__timer_control__fractional_adder;
    reg [7:0]timer_combs__timer_control__integer_adder;

    //b Internal nets
    wire [63:0]timer_value_without_irq__value;
    wire timer_value_without_irq__irq;
    wire timer_value_without_irq__locked;

    //b Clock gating module instances
    //b Module instances
    clock_timer timer(
        .clk(clk),
        .clk__enable(1'b1),
        .timer_control__integer_adder(timer_combs__timer_control__integer_adder),
        .timer_control__fractional_adder(timer_combs__timer_control__fractional_adder),
        .timer_control__bonus_subfraction_sub(timer_combs__timer_control__bonus_subfraction_sub),
        .timer_control__bonus_subfraction_add(timer_combs__timer_control__bonus_subfraction_add),
        .timer_control__block_writes(timer_combs__timer_control__block_writes),
        .timer_control__synchronize_value(timer_combs__timer_control__synchronize_value),
        .timer_control__synchronize(timer_combs__timer_control__synchronize),
        .timer_control__lock_window_lsb(timer_combs__timer_control__lock_window_lsb),
        .timer_control__lock_to_master(timer_combs__timer_control__lock_to_master),
        .timer_control__retard(timer_combs__timer_control__retard),
        .timer_control__advance(timer_combs__timer_control__advance),
        .timer_control__enable_counter(timer_combs__timer_control__enable_counter),
        .timer_control__reset_counter(timer_combs__timer_control__reset_counter),
        .reset_n(reset_n),
        .timer_value__locked(            timer_value_without_irq__locked),
        .timer_value__irq(            timer_value_without_irq__irq),
        .timer_value__value(            timer_value_without_irq__value)         );
    //b apb_interface_logic__comb combinatorial process
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
    always @ ( * )//apb_interface_logic__comb
    begin: apb_interface_logic__comb_code
    reg [31:0]apb_response__prdata__var;
    reg apb_response__pready__var;
        apb_response__prdata__var = 32'h0;
        apb_response__pready__var = 1'h0;
        apb_response__perr = 1'h0;
        apb_response__pready__var = 1'h1;
        case (access) //synopsys parallel_case
        4'h3: // req 1
            begin
            apb_response__prdata__var = timer_value_without_irq__value[31:0];
            end
        4'h4: // req 1
            begin
            apb_response__prdata__var = timer_value_without_irq__value[63:32];
            end
        4'h7: // req 1
            begin
            apb_response__prdata__var = timer_state__comparator_lower;
            end
        4'h8: // req 1
            begin
            apb_response__prdata__var = timer_state__comparator_upper;
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

    //b apb_interface_logic__posedge_clk_active_low_reset_n clock process
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
    always @( posedge clk or negedge reset_n)
    begin : apb_interface_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            access <= 4'h0;
        end
        else if (clk__enable)
        begin
            access <= 4'h0;
            case (apb_request__paddr[3:0]) //synopsys parallel_case
            4'h0: // req 1
                begin
                access <= (((apb_request__pwrite!=1'h0)&&!(timer_control__block_writes!=1'h0))?4'h1:4'h3);
                end
            4'h1: // req 1
                begin
                access <= (((apb_request__pwrite!=1'h0)&&!(timer_control__block_writes!=1'h0))?4'h2:4'h4);
                end
            4'h2: // req 1
                begin
                access <= ((apb_request__pwrite!=1'h0)?4'h5:4'h7);
                end
            4'h3: // req 1
                begin
                access <= ((apb_request__pwrite!=1'h0)?4'h6:4'h8);
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
                access <= 4'h0;
            end //if
        end //if
    end //always

    //b timer_logic__comb combinatorial process
        //   
        //       The @a timer value can be reset or it may count on a tick, or it
        //       may just hold its value. Furthermore, it may be writable (the
        //       RISC-V spec seems to require this, but it defeats the purpose of a
        //       global clock if there are many of these in a system that are not
        //       at the same global value).
        //   
        //       The comparison logic operates over two clock ticks. In the first
        //       clock tick the upper and lower halves are subtracted to provide
        //       'greater-or-equal' comparisons and 'equality' comparison; these
        //       bits are recorded, and in a second clock tick they are combined
        //       and a result is generated and registered.
        //       
    always @ ( * )//timer_logic__comb
    begin: timer_logic__comb_code
    reg [1:0]timer_combs__timer_control__synchronize__var;
    reg [63:0]timer_combs__timer_control__synchronize_value__var;
    reg timer_value__irq__var;
        timer_combs__lower_t_minus_c = ({1'h0,timer_value_without_irq__value[31:0]}-{1'h0,timer_state__comparator_lower});
        timer_combs__upper_t_minus_c = ({1'h0,timer_value_without_irq__value[63:32]}-{1'h0,timer_state__comparator_upper});
        timer_combs__timer_control__reset_counter = timer_control__reset_counter;
        timer_combs__timer_control__enable_counter = timer_control__enable_counter;
        timer_combs__timer_control__advance = timer_control__advance;
        timer_combs__timer_control__retard = timer_control__retard;
        timer_combs__timer_control__lock_to_master = timer_control__lock_to_master;
        timer_combs__timer_control__lock_window_lsb = timer_control__lock_window_lsb;
        timer_combs__timer_control__synchronize__var = timer_control__synchronize;
        timer_combs__timer_control__synchronize_value__var = timer_control__synchronize_value;
        timer_combs__timer_control__block_writes = timer_control__block_writes;
        timer_combs__timer_control__bonus_subfraction_add = timer_control__bonus_subfraction_add;
        timer_combs__timer_control__bonus_subfraction_sub = timer_control__bonus_subfraction_sub;
        timer_combs__timer_control__fractional_adder = timer_control__fractional_adder;
        timer_combs__timer_control__integer_adder = timer_control__integer_adder;
        if ((access==4'h1))
        begin
            timer_combs__timer_control__synchronize__var[0] = 1'h1;
            timer_combs__timer_control__synchronize_value__var[31:0] = apb_request__pwdata;
        end //if
        if ((access==4'h2))
        begin
            timer_combs__timer_control__synchronize__var[1] = 1'h1;
            timer_combs__timer_control__synchronize_value__var[63:32] = apb_request__pwdata;
        end //if
        timer_value__value = timer_value_without_irq__value;
        timer_value__irq__var = timer_value_without_irq__irq;
        timer_value__locked = timer_value_without_irq__locked;
        timer_value__irq__var = timer_state__comparator_exceeded;
        timer_combs__timer_control__synchronize = timer_combs__timer_control__synchronize__var;
        timer_combs__timer_control__synchronize_value = timer_combs__timer_control__synchronize_value__var;
        timer_value__irq = timer_value__irq__var;
    end //always

    //b timer_logic__posedge_clk_active_low_reset_n clock process
        //   
        //       The @a timer value can be reset or it may count on a tick, or it
        //       may just hold its value. Furthermore, it may be writable (the
        //       RISC-V spec seems to require this, but it defeats the purpose of a
        //       global clock if there are many of these in a system that are not
        //       at the same global value).
        //   
        //       The comparison logic operates over two clock ticks. In the first
        //       clock tick the upper and lower halves are subtracted to provide
        //       'greater-or-equal' comparisons and 'equality' comparison; these
        //       bits are recorded, and in a second clock tick they are combined
        //       and a result is generated and registered.
        //       
    always @( posedge clk or negedge reset_n)
    begin : timer_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            timer_state__upper_ge <= 1'h0;
            timer_state__upper_eq <= 1'h0;
            timer_state__lower_ge <= 1'h0;
            timer_state__lower_eq <= 1'h0;
            timer_state__comparator_exceeded <= 1'h0;
            timer_state__comparator_lower <= 32'h0;
            timer_state__comparator_upper <= 32'h0;
        end
        else if (clk__enable)
        begin
            timer_state__upper_ge <= !(timer_combs__upper_t_minus_c[32]!=1'h0);
            timer_state__upper_eq <= (timer_combs__upper_t_minus_c==33'h0);
            timer_state__lower_ge <= !(timer_combs__lower_t_minus_c[32]!=1'h0);
            timer_state__lower_eq <= (timer_combs__lower_t_minus_c==33'h0);
            timer_state__comparator_exceeded <= 1'h0;
            if ((timer_state__upper_eq!=1'h0))
            begin
                timer_state__comparator_exceeded <= ((timer_state__lower_ge!=1'h0)&&!(timer_state__lower_eq!=1'h0));
            end //if
            else
            
            begin
                if ((timer_state__upper_ge!=1'h0))
                begin
                    timer_state__comparator_exceeded <= 1'h1;
                end //if
            end //else
            if ((access==4'h5))
            begin
                timer_state__comparator_lower <= apb_request__pwdata;
            end //if
            if ((access==4'h6))
            begin
                timer_state__comparator_upper <= apb_request__pwdata;
            end //if
        end //if
    end //always

endmodule // apb_target_rv_timer
