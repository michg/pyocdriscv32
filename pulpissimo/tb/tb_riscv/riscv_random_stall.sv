// Copyright 2018 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                              //
// Author:                      Andreas Traber - atraber@student.ethz.ch                                        //
//                                                                                                              //
// Additional contributions by: Francesco Minervini - minervif@student.ethz.ch                                  //
//                              Davide Schiavone    - pschiavo@iis.ee.ethz.ch                                   //
// Design Name:                 Perturbation Unit                                                               //
// Project Name:                RI5CY, Zeroriscy                                                                //
// Language:                    SystemVerilog                                                                   //
//                                                                                                              //
// Description:                 Introduce stalls on core standard execution for both data and instructions      //
//                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

import riscv_defines::*;
import perturbation_defines::*;
`include "riscv_config.sv"

module riscv_random_stall

#(
    parameter MAX_STALL_N       = 1,
    parameter INSTR_RDATA_WIDTH = 32
)

(
    input logic                             clk_i,
    input logic                             rst_ni,
    input logic                             grant_per_i,
    input logic                             rvalid_per_i,
    input logic [INSTR_RDATA_WIDTH-1:0]     rdata_per_i,

    output logic                            grant_per_o,
    output logic                            rvalid_per_o,
    output logic [INSTR_RDATA_WIDTH-1:0]    rdata_per_o,

    input logic                             req_per_i,
    output logic                            req_mem_o,

    input logic [31:0]                      addr_per_i,
    output logic [31:0]                     addr_mem_o,

    input logic [31:0]                      wdata_per_i,
    output logic [31:0]                     wdata_mem_o,

    input logic                             we_per_i,
    output logic                            we_mem_o,

    input logic [3:0]                       be_per_i,
    output logic [3:0]                      be_mem_o,

    input logic                             dbg_req_i,
    input logic                             dbg_we_i,
    input logic [31:0]                      dbg_mode_i,
    input logic [31:0]                      dbg_max_stall_i,
    input logic [31:0]                      dbg_gnt_stall_i,
    input logic [31:0]                      dbg_valid_stall_i
);

logic req_per_q, grant_per_q, rvalid_per_q;

typedef struct {
     logic [31:0] addr;
     logic        we;
     logic [ 3:0] be;
     logic [31:0] wdata;
     logic [31:0] rdata;
   } stall_mem_t;

class rand_gnt_cycles;
     rand int n;
endclass : rand_gnt_cycles

class rand_data_cycles;
     rand int n;
endclass : rand_data_cycles

mailbox #(stall_mem_t) core_reqs          = new (4);
mailbox #(stall_mem_t) core_resps         = new (4);
mailbox core_resps_granted = new (4);
mailbox #(stall_mem_t) memory_transfers   = new (4);

 always_latch
 begin
   if (req_per_i)
       req_per_q    <= 1'b1;
   else
       req_per_q    <= 1'b0;
 end

 always_latch
 begin
   if (rvalid_per_i)
       rvalid_per_q    <= 1'b1;
   else
       rvalid_per_q    <= 1'b0;
 end


always_latch
 begin
   if (grant_per_i)
       grant_per_q    <= 1'b1;
   else
       grant_per_q    <= 1'b0;
 end



 //Grant Process
 initial
 begin
     stall_mem_t mem_acc;
     automatic rand_gnt_cycles wait_cycles = new ();

     int temp;

     int stalls, max_val;
     #10;//wait at the very beginning
     while(1) begin
         @(posedge clk_i);
         #1;
         grant_per_o = 1'b0;
         if (!req_per_q) begin
            wait(req_per_q == 1'b1);
         end

         if(dbg_mode_i == STANDARD) begin  //FIXED NUMBER OF STALLS MODE
             stalls = dbg_gnt_stall_i;
         end else if(dbg_mode_i == RANDOM) begin
             max_val = dbg_max_stall_i;
             temp = wait_cycles.randomize() with{
                 n >= 0;
                 n<= max_val;
             };
             stalls = wait_cycles.n;

         end else begin
             stalls = 0;
         end


         while(stalls != 0) begin
            @(negedge clk_i);
            stalls--;
         end

         @(negedge clk_i);
         if(req_per_q == 1'b1) begin
             grant_per_o   = 1'b1;
             mem_acc.addr  = addr_per_i;
             mem_acc.be    = be_per_i;
             mem_acc.we    = we_per_i;
             mem_acc.wdata = wdata_per_i;
             core_reqs.put(mem_acc);
             core_resps_granted.put(1'b1);
         end

     end
 end

 initial
 begin
     stall_mem_t mem_acc;
     automatic rand_data_cycles wait_cycles = new ();
     logic granted;
     int temp, stalls, max_val;

     while(1) begin
         @(posedge clk_i);
         #1;
         rvalid_per_o = 1'b0;
         rdata_per_o  = 'x;

         core_resps_granted.get(granted);

         core_resps.get(mem_acc);

         if(dbg_mode_i == STANDARD) begin  //FIXED NUMBER OF STALLS MODE
             stalls = dbg_valid_stall_i;
         end else if(dbg_mode_i == RANDOM) begin
             max_val = dbg_max_stall_i;
             temp = wait_cycles.randomize() with {
                 n>= 0;
                 n<= max_val;
             };
             stalls = wait_cycles.n;

         end else begin

             stalls = 0;
         end


         while(stalls != 0) begin
             @(negedge clk_i);
             stalls--;
         end

         rdata_per_o  = mem_acc.rdata;
         rvalid_per_o = 1'b1;
     end
 end

 initial
 begin
     stall_mem_t mem_acc;
     we_mem_o    = 1'b0;
     req_mem_o   = 1'b0;
     addr_mem_o  = '0;
     be_mem_o    = 4'b0;
     wdata_mem_o = 'x;

     while(1) begin
         @(posedge clk_i);
         #1;
         req_mem_o   = 1'b0;
         addr_mem_o  = '0;
         wdata_mem_o = 'x;
         core_reqs.get(mem_acc);
         req_mem_o   = 1'b1;
         addr_mem_o  = mem_acc.addr;
         we_mem_o    = mem_acc.we;
         be_mem_o    = mem_acc.be;
         wdata_mem_o = mem_acc.wdata;

         wait(grant_per_q);
         memory_transfers.put(mem_acc);

     end
 end

 initial
 begin
     stall_mem_t mem_acc;
     while(1) begin
         memory_transfers.get(mem_acc);

         wait(rvalid_per_q == 1'b1);
         @(negedge clk_i);
         mem_acc.rdata = rdata_per_i;

         core_resps.put(mem_acc);

     end
 end
 endmodule
