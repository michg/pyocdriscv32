//a Root modules
//m se_sram_srw
module se_sram_srw(sram_clock, sram_clock__enable, write_data, address, read_not_write, select, data_out );
   parameter address_width=16;
   parameter data_width=8;
   parameter initfile="";
  
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [address_width-1:0] address;
   input  [data_width-1:0]  write_data;
   output [data_width-1:0] data_out;
   (* ram_init_file = initfile *)   reg [data_width-1:0] ram[(1<<address_width)-1:0];
   reg [data_width-1:0] data_out;
   initial
     begin
        data_out <= 0;
     end
   always @(posedge sram_clock)
     if (sram_clock__enable)
     begin
        if (!read_not_write && select)
          begin
             ram[address] <= write_data;
          end
        if (read_not_write && select)
          begin
             data_out <= ram[address];
          end
     end
endmodule

//m se_sram_srw_we8_unused
module se_sram_srw_we8_unused(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter address_width=16;
   parameter data_width=32;
   parameter initfile="";
  
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [3:0] write_enable;
   input [address_width-1:0] address;
   input  [data_width-1:0]  write_data;
   output [data_width-1:0] data_out;
   (* ram_init_file = initfile *)   reg [data_width-1:0] ram[(1<<address_width)-1:0];
   reg [data_width-1:0] data_out;
   initial
     begin
        data_out <= 0;
     end
   always @(posedge sram_clock)
     if (sram_clock__enable)
     begin
        if (!read_not_write && select)
          begin
             if (write_enable[0])  ram[address][ 7: 0] <= write_data[ 7: 0];
             if (write_enable[1])  ram[address][15: 8] <= write_data[15: 8];
             if (write_enable[2])  ram[address][23:16] <= write_data[23:16];
             if (write_enable[3])  ram[address][31:24] <= write_data[31:24];
          end
        if (read_not_write && select)
          begin
             data_out <= ram[address];
          end
     end
endmodule
// See http://www.pldworld.com/_altera/html/_sw/q2help/source/mega/mega_file_altsynch_ram.htm
module se_sram_srw_we8(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter address_width=16;
   parameter data_width=32;
   parameter initfile="";

   input sram_clock, sram_clock__enable, select, read_not_write;
   input [3:0] write_enable;
   input [address_width-1:0] address;
   input  [data_width-1:0]  write_data;
   output [data_width-1:0] data_out;

	altsyncram	altsyncram_component (
				.address_a (address),
				.byteena_a (write_enable),
				.clock0 (sram_clock),
				.data_a (write_data),
				.rden_a (select & read_not_write),
				.wren_a (select & !read_not_write),
				.q_a (data_out),
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_b (1'b1),
				.clock1 (1'b1),
				.clocken0 (sram_clock__enable),
				.clocken1 (1'b1),
				.clocken2 (1'b1),
				.clocken3 (1'b1),
				.data_b (1'b1),
				.eccstatus (),
				.q_b (),
				.rden_b (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.byte_size = 8,
		altsyncram_component.clock_enable_input_a = "NORMAL",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.init_file = initfile,
		altsyncram_component.intended_device_family = "Cyclone V",
		altsyncram_component.lpm_hint = "ENABLE_RUNTIME_MOD=NO",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 16384,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "UNREGISTERED",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.read_during_write_mode_port_a = "DONT_CARE",
		altsyncram_component.widthad_a = 14,
		altsyncram_component.width_a = 32,
		altsyncram_component.width_byteena_a = 4;


endmodule

//m se_sram_srw_we
module se_sram_srw_we(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter address_width=16;
   parameter data_width=8;
   parameter initfile="";
  
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input  [data_width-1:0]  write_data;
   output [data_width-1:0] data_out;
   (* ram_init_file = initfile *)   reg [data_width-1:0] ram[(1<<address_width)-1:0];
   reg [data_width-1:0] data_out;
   initial
     begin
        data_out <= 0;
     end
   always @(posedge sram_clock)
     if (sram_clock__enable)
     begin
        if (write_enable && !read_not_write && select)
          begin
             ram[address] <= write_data;
          end
        if (read_not_write && select)
          begin
             data_out <= ram[address];
          end
     end
endmodule

//m se_sram_mrw_2
module se_sram_mrw_2( sram_clock_0, sram_clock_0__enable, write_data_0, address_0, read_not_write_0, select_0, data_out_0,
                      sram_clock_1, sram_clock_1__enable, write_data_1, address_1, read_not_write_1, select_1, data_out_1
 );
   parameter address_width=16;
   parameter data_width=8;
   parameter initfile="";
  
   input sram_clock_0, sram_clock_0__enable, select_0, read_not_write_0;
   input [address_width-1:0] address_0;
   input  [data_width-1:0]  write_data_0;
   output [data_width-1:0] data_out_0;
   input sram_clock_1, sram_clock_1__enable, select_1, read_not_write_1;
   input [address_width-1:0] address_1;
   input  [data_width-1:0]  write_data_1;
   output [data_width-1:0] data_out_1;
   (* ram_init_file = initfile *)   reg [data_width-1:0] ram[(1<<address_width)-1:0];
   reg [data_width-1:0] data_out_0;
   reg [data_width-1:0] data_out_1;
   initial
     begin
        data_out_0 <= 0;
        data_out_1 <= 0;
     end
   always @(posedge sram_clock_0)
     if (sram_clock_0__enable)
     begin
        if (!read_not_write_0 && select_0)
          begin
             ram[address_0] <= write_data_0;
          end
        if (read_not_write_0 && select_0)
          begin
             data_out_0 <= ram[address_0];
          end
     end
   always @(posedge sram_clock_1)
     if (sram_clock_1__enable)
     begin
        if (!read_not_write_1 && select_1)
          begin
             ram[address_1] <= write_data_1;
          end
        if (read_not_write_1 && select_1)
          begin
             data_out_1 <= ram[address_1];
          end
     end
endmodule

//a Single port SRAMs
//m se_sram_srw_65536x32
module se_sram_srw_65536x32(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=16,data_width=32;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_65536x8
module se_sram_srw_65536x8(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=16,data_width=8;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_32768x64
module se_sram_srw_32768x64(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=15,data_width=64;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_32768x32
module se_sram_srw_32768x32(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=15,data_width=32;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_16384x8
module se_sram_srw_16384x8(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=14,data_width=8;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_16384x32_we8
module se_sram_srw_16384x32_we8(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=14,data_width=32;
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [3:0] write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
    `ifdef VERILATOR 
       se_sram_srw_we8_unused #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
    `else
       se_sram_srw_we8 #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
    `endif
endmodule

//m se_sram_srw_16384x32
module se_sram_srw_16384x32(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=14,data_width=32;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;   
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_16384x40
module se_sram_srw_16384x40(sram_clock, sram_clock__enable, write_data, address, read_not_write, select, data_out );
   parameter initfile="",address_width=14,data_width=40;
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,read_not_write,select,data_out);
endmodule

//m se_sram_srw_256x40 - no we
module se_sram_srw_256x40(sram_clock, sram_clock__enable, write_data, address, read_not_write, select, data_out );
   parameter initfile="",address_width=8,data_width=40;
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,read_not_write,select,data_out);
endmodule

//m se_sram_srw_256x7 - no we
module se_sram_srw_256x7(sram_clock, sram_clock__enable, write_data, address, read_not_write, select, data_out );
   parameter initfile="",address_width=8,data_width=7;
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,read_not_write,select,data_out);
endmodule

//m se_sram_srw_128x8
module se_sram_srw_128x8_we(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=7,data_width=8;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_128x64
module se_sram_srw_128x64(sram_clock, sram_clock__enable, write_data, address, write_enable, read_not_write, select, data_out );
   parameter initfile="",address_width=7,data_width=64;
   input sram_clock, sram_clock__enable, select, read_not_write, write_enable;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw_we #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,write_enable,read_not_write,select,data_out);
endmodule

//m se_sram_srw_128x45 - no we
module se_sram_srw_128x45(sram_clock, sram_clock__enable, write_data, address, read_not_write, select, data_out );
   parameter initfile="",address_width=7,data_width=45;
   input sram_clock, sram_clock__enable, select, read_not_write;
   input [address_width-1:0] address;
   input [data_width-1:0]    write_data;
   output [data_width-1:0]   data_out;
   se_sram_srw #(address_width,data_width,initfile) ram(sram_clock,sram_clock__enable,write_data,address,read_not_write,select,data_out);
endmodule

//a Dual-port SRAMs
//m se_sram_mrw_2_16384x48
module se_sram_mrw_2_16384x48(sram_clock_0, sram_clock_0__enable, write_data_0, address_0, read_not_write_0, select_0, data_out_0,
                              sram_clock_1, sram_clock_1__enable, write_data_1, address_1, read_not_write_1, select_1, data_out_1 );
   parameter initfile="",address_width=14,data_width=48;
   input sram_clock_0, sram_clock_0__enable, select_0, read_not_write_0;
   input sram_clock_1, sram_clock_1__enable, select_1, read_not_write_1;
   input [address_width-1:0] address_0, address_1;
   input [data_width-1:0]    write_data_0, write_data_1;
   output [data_width-1:0]   data_out_0, data_out_1;
   se_sram_mrw_2 #(address_width,data_width,initfile) ram(sram_clock_0,sram_clock_0__enable,write_data_0,address_0,read_not_write_0,select_0,data_out_0,
                                                          sram_clock_1,sram_clock_1__enable,write_data_1,address_1,read_not_write_1,select_1,data_out_1 );
endmodule

//m se_sram_mrw_2_16384x8
module se_sram_mrw_2_16384x8(sram_clock_0, sram_clock_0__enable, write_data_0, address_0, read_not_write_0, select_0, data_out_0,
                              sram_clock_1, sram_clock_1__enable, write_data_1, address_1, read_not_write_1, select_1, data_out_1 );
   parameter initfile="",address_width=14,data_width=8;
   input sram_clock_0, sram_clock_0__enable, select_0, read_not_write_0;
   input sram_clock_1, sram_clock_1__enable, select_1, read_not_write_1;
   input [address_width-1:0] address_0, address_1;
   input [data_width-1:0]    write_data_0, write_data_1;
   output [data_width-1:0]   data_out_0, data_out_1;
   se_sram_mrw_2 #(address_width,data_width,initfile) ram(sram_clock_0,sram_clock_0__enable,write_data_0,address_0,read_not_write_0,select_0,data_out_0,
                                                          sram_clock_1,sram_clock_1__enable,write_data_1,address_1,read_not_write_1,select_1,data_out_1 );
endmodule
