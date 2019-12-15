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

//a Module clock_timer
    //   
    //   This is a monotonically increasing 64-bit timer with a standard control interface.
    //   
    //   The purpose of the timer is to support a 64-bit global nanosecond
    //   clock that can be used as a 'nanoseconds since' an epoch - for PTP
    //   this would be 1 January 1970 00:00:00 TAI, which is 31 December 1969
    //   23:59:51.999918 UTC. A 64-bit nanosecond timestamp with this epoch
    //   wraps roughly in the year 2106.
    //   
    //   The timer has a fractional component to permit, for example, a
    //   'nanosecond' timer that is clocked at, say, 600MHz; in this case the
    //   timer is ticked every 1.666ns, and so an addition in each cycle of
    //   0xa to a 4-bit fractional component and a 1 integer component. The
    //   timer_control has, therfore, a fixed-point adder value with a 4-digit
    //   fractional component.
    //   
    //   However, this would actually lead to a timer that would be only 99.61% accurate.
    //   
    //   Hence a further subfraction capability is supported; this permits a
    //   further 1/16th of a nanosecond (or whatever the timer unit is) to be
    //   added for (A+1) cycles out of every (A+S+2).
    //   
    //   In the case of 600MHz a bonus 1/16th should be added for 2 out of
    //   every 3 cycles. This is set using a @a bonus_subfraction_add of 1 and a
    //   @a bonus_subfraction_sub of 0 (meaning for 2 out of every 3 cycles add
    //   a further 1/16th).
    //   
    //   This operates using a digital differential accumulator; this is a
    //   9-bit value whose top bit being low indicates that the bonus should be added.
    //   If the accumulator has the top bit set then the @a bonus_subfraction_add
    //   value +1 is added to it; if it does not then it has ~@a bonus_subfraction_sub
    //   added to it.
    //   
    //   In the 600MHz case the accumulator will cycle through 0, -1, 1, 0, -1,
    //   and so on.
    //   
    //   Hence every three cycles the timer will have 0x1.b, 0x1.b, 0x1.a
    //   added to it - hence the timer will have gone up by an integer value of
    //   5ns, which is correct for 3 600MHz clock cycles.
    //   
    //   If the @a bonus_subfraction values are tied off to zero then the extra fractional
    //   logic will be optimized out.
    //   
    //   Some example values for 1ns timer values:
    //   
    //   Clock    | Period    | Adder (Int/fraction) | Bonus rate | Add / sub
    //   ---------|-----------|----------------------|------------|-----------
    //   1GHz     |    1ns    |      1 / 0x0         |    0       |   0 / 0
    //   800MHz   |  1.25ns   |      1 / 0x4         |    0       |   0 / 0
    //   600MHz   |  1.66ns   |      1 / 0xa         |    1 / 3   |   1 / 0
    //   156.25Hz |   6.4ns   |      6 / 0x6         |    4 / 10  |   3 / 5
    //   
    //   With a 3/5 bonus the accumulator will cycle through 0, -6, -2, 2, -4, 0, ...
    //   
    //   Hence the clock period should be:
    //   
    //     * bonus add,sub=0,0: (Int + fraction/16)
    //   
    //     * bonus add,sub=a,s: (Int + (fraction+(a+1)/(a+s+2))/16) 
    //   
    //   In addition a synchronous advance/retard option is provided for.  Each
    //   time advance is seen going high (i.e. positive edge of advance) then
    //   on an addition the timer will increment by a bonus half tick value.
    //   Each time retard is seen going high the timer will reduces its
    //   increment by a half tick value.
    //   
    //   Furthermore, there is a synchronize control. When this is asserted, on the next
    //   clock edge where the clock is loaded with the 64-bit synchronization value.
    //   
    //   
module clock_timer
(
    clk,
    clk__enable,

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
    timer_value__locked
);

    //b Clocks
        //   Timer clock
    input clk;
    input clk__enable;

    //b Inputs
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

// output components here

    //b Output combinatorials
    reg [63:0]timer_value__value;
    reg timer_value__irq;
    reg timer_value__locked;

    //b Output nets

    //b Internal and output registers
        //   State of the timer
    reg [8:0]timer_state__bonus_subfraction_acc;
    reg [3:0]timer_state__fraction;
    reg [31:0]timer_state__timer_lower;
    reg [31:0]timer_state__timer_upper;
    reg timer_state__advance;
    reg timer_state__retard;
    reg timer_state__hold_adder;
    reg [3:0]timer_state__fractional_adder;
    reg [7:0]timer_state__integer_adder;

    //b Internal combinatorials
        //   Combinatorial decode of timer state and controls
    reg timer_combs__fractional_bonus;
    reg [4:0]timer_combs__fractional_sum;
    reg [32:0]timer_combs__lower_sum;
    reg [31:0]timer_combs__upper_sum;
    reg [3:0]timer_combs__fractional_half_adder;
    reg [7:0]timer_combs__integer_half_adder;
    reg [4:0]timer_combs__fractional_one_and_half_adder;
    reg [7:0]timer_combs__integer_one_and_half_adder;

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b bonus_fraction_logic__comb combinatorial process
        //   
        //       This logic manages the DDA for the bonus fraction.
        //   
        //       The accumulator adds the @a bonus_subfraction_add value +1 if it is negative, and is subtracts
        //       @a bonus_subfraction_sub -1 if the accumulator is positive.
        //   
        //       The fractional bonus of 1/16 nanosecond is added when the accumulator is negative.
        //   
        //       If the bonus fraction configuration is 0, rather than a 1-out-of-2 cycle bonus (which can be
        //       achieved using an @a bonus_subfraction_add value of 1 and a @a bonus_subfraction_sub value of 1)
        //       the fractional bonus is 0, and the logic will be optimized out if the configuration is tied off.
        //       
    always @ ( * )//bonus_fraction_logic__comb
    begin: bonus_fraction_logic__comb_code
    reg timer_combs__fractional_bonus__var;
        timer_combs__fractional_bonus__var = !(timer_state__bonus_subfraction_acc[8]!=1'h0);
        if (((timer_control__bonus_subfraction_add==8'h0)&&(timer_control__bonus_subfraction_sub==8'h0)))
        begin
            timer_combs__fractional_bonus__var = 1'h0;
        end //if
        timer_combs__fractional_bonus = timer_combs__fractional_bonus__var;
    end //always

    //b bonus_fraction_logic__posedge_clk_active_low_reset_n clock process
        //   
        //       This logic manages the DDA for the bonus fraction.
        //   
        //       The accumulator adds the @a bonus_subfraction_add value +1 if it is negative, and is subtracts
        //       @a bonus_subfraction_sub -1 if the accumulator is positive.
        //   
        //       The fractional bonus of 1/16 nanosecond is added when the accumulator is negative.
        //   
        //       If the bonus fraction configuration is 0, rather than a 1-out-of-2 cycle bonus (which can be
        //       achieved using an @a bonus_subfraction_add value of 1 and a @a bonus_subfraction_sub value of 1)
        //       the fractional bonus is 0, and the logic will be optimized out if the configuration is tied off.
        //       
    always @( posedge clk or negedge reset_n)
    begin : bonus_fraction_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            timer_state__bonus_subfraction_acc <= 9'h0;
        end
        else if (clk__enable)
        begin
            if ((timer_control__enable_counter!=1'h0))
            begin
                if ((timer_state__bonus_subfraction_acc[8]!=1'h0))
                begin
                    timer_state__bonus_subfraction_acc <= ((timer_state__bonus_subfraction_acc+{1'h0,timer_control__bonus_subfraction_add})+9'h1);
                end //if
                else
                
                begin
                    timer_state__bonus_subfraction_acc <= (timer_state__bonus_subfraction_acc+{1'h1,~timer_control__bonus_subfraction_sub});
                end //else
            end //if
            if ((timer_control__reset_counter!=1'h0))
            begin
                timer_state__bonus_subfraction_acc <= 9'h0;
            end //if
            if (((timer_control__bonus_subfraction_add==8'h0)&&(timer_control__bonus_subfraction_sub==8'h0)))
            begin
                timer_state__bonus_subfraction_acc <= 9'h0;
            end //if
        end //if
    end //always

    //b timer_logic__comb combinatorial process
        //   
        //       The @a timer value can be reset or it may count on a tick, or it
        //       may just hold its value.
        //   
        //       The timer update logic adds the integer and fractional increments
        //       to the timer value, with an optional carry (@a fractional_bonus)
        //       in that is generated and registered on the previous cycle. This
        //       bonus is one for @a bonus_subfraction_numer out of @a
        //       bonus_subfraction_denom.
        //   
        //       
    always @ ( * )//timer_logic__comb
    begin: timer_logic__comb_code
    reg [3:0]timer_combs__fractional_half_adder__var;
    reg [7:0]timer_combs__integer_one_and_half_adder__var;
    reg [31:0]timer_combs__upper_sum__var;
        timer_combs__fractional_half_adder__var = (timer_control__fractional_adder>>64'h1);
        timer_combs__fractional_half_adder__var[3] = timer_control__integer_adder[0];
        timer_combs__fractional_one_and_half_adder = ({1'h0,timer_combs__fractional_half_adder__var}+{1'h0,timer_control__fractional_adder});
        timer_combs__integer_half_adder = (timer_control__integer_adder>>64'h1);
        timer_combs__integer_one_and_half_adder__var = (timer_combs__integer_half_adder+timer_control__integer_adder);
        if ((timer_combs__fractional_one_and_half_adder[4]!=1'h0))
        begin
            timer_combs__integer_one_and_half_adder__var = ((timer_combs__integer_half_adder+timer_control__integer_adder)+8'h1);
        end //if
        timer_combs__fractional_sum = (({1'h0,timer_state__fraction}+{1'h0,timer_state__fractional_adder})+((timer_combs__fractional_bonus!=1'h0)?64'h1:64'h0));
        timer_combs__lower_sum = (({1'h0,timer_state__timer_lower}+{25'h0,timer_state__integer_adder})+((timer_combs__fractional_sum[4]!=1'h0)?64'h1:64'h0));
        timer_combs__upper_sum__var = timer_state__timer_upper;
        if ((timer_combs__lower_sum[32]!=1'h0))
        begin
            timer_combs__upper_sum__var = (timer_state__timer_upper+32'h1);
        end //if
        timer_value__value = {timer_state__timer_upper,timer_state__timer_lower};
        timer_value__irq = 1'h0;
        timer_value__locked = 1'h0;
        timer_combs__fractional_half_adder = timer_combs__fractional_half_adder__var;
        timer_combs__integer_one_and_half_adder = timer_combs__integer_one_and_half_adder__var;
        timer_combs__upper_sum = timer_combs__upper_sum__var;
    end //always

    //b timer_logic__posedge_clk_active_low_reset_n clock process
        //   
        //       The @a timer value can be reset or it may count on a tick, or it
        //       may just hold its value.
        //   
        //       The timer update logic adds the integer and fractional increments
        //       to the timer value, with an optional carry (@a fractional_bonus)
        //       in that is generated and registered on the previous cycle. This
        //       bonus is one for @a bonus_subfraction_numer out of @a
        //       bonus_subfraction_denom.
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : timer_logic__posedge_clk_active_low_reset_n__code
        if (reset_n==1'b0)
        begin
            timer_state__fractional_adder <= 4'h0;
            timer_state__integer_adder <= 8'h0;
            timer_state__hold_adder <= 1'h0;
            timer_state__advance <= 1'h0;
            timer_state__retard <= 1'h0;
            timer_state__fraction <= 4'h0;
            timer_state__timer_lower <= 32'h0;
            timer_state__timer_upper <= 32'h0;
        end
        else if (clk__enable)
        begin
            if (((!(timer_state__hold_adder!=1'h0)||(timer_control__reset_counter!=1'h0))||(timer_control__enable_counter!=1'h0)))
            begin
                timer_state__fractional_adder <= timer_control__fractional_adder;
                timer_state__integer_adder <= timer_control__integer_adder;
                timer_state__hold_adder <= 1'h1;
            end //if
            if (((timer_control__advance!=1'h0)&&!(timer_state__advance!=1'h0)))
            begin
                timer_state__fractional_adder <= timer_combs__fractional_one_and_half_adder[3:0];
                timer_state__integer_adder <= timer_combs__integer_one_and_half_adder;
                timer_state__hold_adder <= 1'h0;
            end //if
            else
            
            begin
                if (((timer_control__retard!=1'h0)&&!(timer_state__retard!=1'h0)))
                begin
                    timer_state__fractional_adder <= timer_combs__fractional_half_adder;
                    timer_state__integer_adder <= timer_combs__integer_half_adder;
                    timer_state__hold_adder <= 1'h0;
                end //if
            end //else
            if (((timer_control__advance!=1'h0)||(timer_state__advance!=1'h0)))
            begin
                timer_state__advance <= timer_control__advance;
            end //if
            if (((timer_control__retard!=1'h0)||(timer_state__retard!=1'h0)))
            begin
                timer_state__retard <= timer_control__retard;
            end //if
            if ((timer_control__enable_counter!=1'h0))
            begin
                timer_state__fraction <= timer_combs__fractional_sum[3:0];
                timer_state__timer_lower <= timer_combs__lower_sum[31:0];
                timer_state__timer_upper <= timer_combs__upper_sum;
            end //if
            if ((timer_control__reset_counter!=1'h0))
            begin
                timer_state__fraction <= 4'h0;
                timer_state__timer_lower <= 32'h0;
                timer_state__timer_upper <= 32'h0;
            end //if
            if ((timer_control__synchronize[0]!=1'h0))
            begin
                timer_state__timer_lower <= timer_control__synchronize_value[31:0];
                timer_state__fraction <= 4'h0;
            end //if
            if ((timer_control__synchronize[1]!=1'h0))
            begin
                timer_state__timer_upper <= timer_control__synchronize_value[63:32];
                timer_state__fraction <= 4'h0;
            end //if
        end //if
    end //always

endmodule // clock_timer
