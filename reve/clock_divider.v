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

//a Module clock_divider
    //   
    //    * CDL implementation of a module that generates a fractional clock divider
    //    * 
    //    * It uses a simple accumulator with add/subtract values, or just a down counter if not in fractional mode
    //   
module clock_divider
(
    clk,
    clk__enable,

    divider_control__write_config,
    divider_control__write_data,
    divider_control__start,
    divider_control__stop,
    divider_control__disable_fractional,
    reset_n,

    divider_output__config_data,
    divider_output__running,
    divider_output__clock_enable
);

    //b Clocks
        //   Clock for the module
    input clk;
    input clk__enable;

    //b Inputs
        //   Controls for any clock divider
    input divider_control__write_config;
    input [31:0]divider_control__write_data;
    input divider_control__start;
    input divider_control__stop;
    input divider_control__disable_fractional;
        //   Active low reset
    input reset_n;

    //b Outputs
        //   Clock divider output state, all clocked
    output [31:0]divider_output__config_data;
    output divider_output__running;
    output divider_output__clock_enable;

// output components here

    //b Output combinatorials
        //   Clock divider output state, all clocked
    reg [31:0]divider_output__config_data;
    reg divider_output__running;
    reg divider_output__clock_enable;

    //b Output nets

    //b Internal and output registers
    reg [15:0]divider_state__adder;
    reg [14:0]divider_state__subtractor;
    reg [30:0]divider_state__accumulator;
    reg divider_state__fractional_mode;
    reg divider_state__running;
    reg divider_state__clock_enable;

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b drive_outputs combinatorial process
        //    
        //       
    always @ ( * )//drive_outputs
    begin: drive_outputs__comb_code
    reg [31:0]divider_output__config_data__var;
        divider_output__config_data__var = 32'h0;
        divider_output__config_data__var[15:0] = divider_state__adder;
        divider_output__config_data__var[30:16] = divider_state__subtractor;
        divider_output__config_data__var[31] = divider_state__fractional_mode;
        divider_output__running = divider_state__running;
        divider_output__clock_enable = divider_state__clock_enable;
        divider_output__config_data = divider_output__config_data__var;
    end //always

    //b configure clock process
        //    
        //       
    always @( posedge clk or negedge reset_n)
    begin : configure__code
        if (reset_n==1'b0)
        begin
            divider_state__adder <= 16'h0;
            divider_state__subtractor <= 15'h0;
            divider_state__fractional_mode <= 1'h0;
        end
        else if (clk__enable)
        begin
            if ((divider_control__write_config!=1'h0))
            begin
                divider_state__adder <= divider_control__write_data[15:0];
                divider_state__subtractor <= divider_control__write_data[30:16];
                divider_state__fractional_mode <= divider_control__write_data[31];
            end //if
            if ((divider_control__disable_fractional!=1'h0))
            begin
                divider_state__fractional_mode <= 1'h0;
            end //if
        end //if
    end //always

    //b fractional_divider clock process
        //   
        //       
    always @( posedge clk or negedge reset_n)
    begin : fractional_divider__code
        if (reset_n==1'b0)
        begin
            divider_state__clock_enable <= 1'h0;
            divider_state__running <= 1'h0;
            divider_state__accumulator <= 31'h0;
        end
        else if (clk__enable)
        begin
            if ((divider_state__running!=1'h0))
            begin
                divider_state__clock_enable <= 1'h0;
                if ((divider_control__stop!=1'h0))
                begin
                    divider_state__running <= 1'h0;
                end //if
                else
                
                begin
                    if ((divider_state__fractional_mode!=1'h0))
                    begin
                        if ((divider_state__accumulator[15]!=1'h0))
                        begin
                            divider_state__accumulator[15:0] <= (divider_state__accumulator[15:0]+divider_state__adder);
                            divider_state__clock_enable <= 1'h1;
                        end //if
                        else
                        
                        begin
                            divider_state__accumulator[15:0] <= (divider_state__accumulator[15:0]-{1'h0,divider_state__subtractor});
                        end //else
                    end //if
                    else
                    
                    begin
                        if ((divider_state__accumulator==31'h0))
                        begin
                            divider_state__accumulator <= {divider_state__subtractor,divider_state__adder};
                            divider_state__clock_enable <= 1'h1;
                        end //if
                        else
                        
                        begin
                            divider_state__accumulator <= (divider_state__accumulator-31'h1);
                        end //else
                    end //else
                end //else
            end //if
            if ((divider_control__start!=1'h0))
            begin
                divider_state__running <= 1'h1;
                if ((divider_state__fractional_mode!=1'h0))
                begin
                    divider_state__accumulator[15:0] <= (divider_state__adder>>64'h1);
                end //if
                else
                
                begin
                    divider_state__accumulator <= {divider_state__subtractor,divider_state__adder};
                end //else
            end //if
        end //if
    end //always

endmodule // clock_divider
