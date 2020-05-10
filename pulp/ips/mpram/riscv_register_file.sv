// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

////////////////////////////////////////////////////////////////////////////////
// Engineer:       Francesco Conti - f.conti@unibo.it                         //
//                                                                            //
// Additional contributions by:                                               //
//                 Michael Gautschi - gautschi@iis.ee.ethz.ch                 //
//                 Davide Schiavone - pschiavo@iis.ee.ethz.ch                 //
//                                                                            //
// Design Name:    RISC-V register file                                       //
// Project Name:   RI5CY                                                      //
// Language:       SystemVerilog                                              //
//                                                                            //
// Description:    Register file with 31x 32 bit wide registers. Register 0   //
//                 is fixed to 0. This register file is based on flip-flops.  //
//                 Also supports the fp-register file now if FPU=1            //
//                 If Zfinx is 1, floating point operations take values from  //
//                 the X register file                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

module riscv_register_file
#(
    parameter ADDR_WIDTH    = 5,
    parameter DATA_WIDTH    = 32,
    parameter FPU           = 0,
    parameter Zfinx         = 0
)
(
    // Clock and Reset
    input  logic         clk,
    input  logic         rst_n,

    input  logic         test_en_i,

    //Read port R1
    input  logic [ADDR_WIDTH-1:0]  raddr_a_i,
    output logic [DATA_WIDTH-1:0]  rdata_a_o,

    //Read port R2
    input  logic [ADDR_WIDTH-1:0]  raddr_b_i,
    output logic [DATA_WIDTH-1:0]  rdata_b_o,

    //Read port R3
    input  logic [ADDR_WIDTH-1:0]  raddr_c_i,
    output logic [DATA_WIDTH-1:0]  rdata_c_o,

    // Write port W1
    input logic [ADDR_WIDTH-1:0]   waddr_a_i,
    input logic [DATA_WIDTH-1:0]   wdata_a_i,
    input logic                    we_a_i,

    // Write port W2
    input logic [ADDR_WIDTH-1:0]   waddr_b_i,
    input logic [DATA_WIDTH-1:0]   wdata_b_i,
    input logic                    we_b_i
);

  // number of integer registers
  localparam    NUM_WORDS     = 2**(ADDR_WIDTH-1);
  // number of floating point registers
  localparam    NUM_FP_WORDS  = 2**(ADDR_WIDTH-1);
  localparam    NUM_TOT_WORDS = FPU ? ( Zfinx ? NUM_WORDS : NUM_WORDS + NUM_FP_WORDS ) : NUM_WORDS;
  localparam nRP = 3;
  localparam nWP = 2;
 

  

  
  logic [nRP-1:0][DATA_WIDTH-1:0 ] ireaddata;
  logic [nRP-1:0][DATA_WIDTH-1:0 ] freaddata;

  //-----------------------------------------------------------------------------
  //-- READ : Read address decoder RAD
  //-----------------------------------------------------------------------------
  generate
  if (FPU == 1 && Zfinx == 0) begin
     assign rdata_a_o = (raddr_a_i==0) ? 0 :  raddr_a_i[5] ? freaddata[2] : ireaddata[2];
     assign rdata_b_o = (raddr_b_i==0) ? 0 :  raddr_b_i[5] ? freaddata[1] : ireaddata[1];
     assign rdata_c_o = (raddr_c_i==0) ? 0 : raddr_c_i[5] ? freaddata[0] : ireaddata[0];
  end else begin
     assign rdata_a_o = (raddr_a_i==0) ? 0 : ireaddata[2];
     assign rdata_b_o = (raddr_b_i==0) ? 0 : ireaddata[1];
     assign rdata_c_o = (raddr_c_i==0) ? 0 : ireaddata[0];
  end
  endgenerate
 
  //-----------------------------------------------------------------------------
  //-- WRITE : Write Address Decoder (WAD), combinatorial process
  //-----------------------------------------------------------------------------

 
 
 mpram #(.MEMD(NUM_WORDS),
 .DATAW(DATA_WIDTH),
 .nRPORTS(3),
 .nWPORTS(2),
 .TYPE("REG"),
 .BYP("RDW"),
 .IFILE("")
 )
 regi(
 .clk(clk),
 .WEnb({we_a_i&~waddr_a_i[5],we_b_i&~waddr_b_i[5]}),
 .WAddr({waddr_a_i[4:0],waddr_b_i[4:0]}),
 .WData({wdata_a_i,wdata_b_i}),
 .RAddr({raddr_a_i[4:0],raddr_b_i[4:0],raddr_c_i[4:0]}),
 .RData(ireaddata)
 );
 
 mpram #(.MEMD(NUM_WORDS),
 .DATAW(DATA_WIDTH),
 .nRPORTS(3),
 .nWPORTS(2),
 .TYPE("REG"),
 .BYP("RDW"),
 .IFILE("")
 )
 regf(
 .clk(clk),
 .WEnb({we_a_i&waddr_a_i[5],we_b_i&waddr_b_i[5]}),
 .WAddr({waddr_a_i[4:0],waddr_b_i[4:0]}),
 .WData({wdata_a_i,wdata_b_i}),
 .RAddr({raddr_a_i[4:0],raddr_b_i[4:0],raddr_c_i[4:0]}),
 .RData(freaddata)
 );
 

endmodule
