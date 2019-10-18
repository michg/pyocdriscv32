/////////////////////////////////////////////////////////////////////
//   ,------.                    ,--.                ,--.          //
//   |  .--. ' ,---.  ,--,--.    |  |    ,---. ,---. `--' ,---.    //
//   |  '--'.'| .-. |' ,-.  |    |  |   | .-. | .-. |,--.| .--'    //
//   |  |\  \ ' '-' '\ '-'  |    |  '--.' '-' ' '-' ||  |\ `--.    //
//   `--' '--' `---'  `--`--'    `-----' `---' `-   /`--' `---'    //
//                                             `---'               //
//   1RW (SP) Memory Block                                         //
//                                                                 //
/////////////////////////////////////////////////////////////////////
//                                                                 //
//             Copyright (C) 2014-2018 Roa Logic BV                //
//             www.roalogic.com                                    //
//                                                                 //
//   This source file may be used and distributed without          //
//   restriction provided that this copyright statement is not     //
//   removed from the file and that any derivative work contains   //
//   the original copyright notice and the associated disclaimer.  //
//                                                                 //
//      THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY        //
//   EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED     //
//   TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS     //
//   FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL THE AUTHOR OR     //
//   CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,  //
//   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT  //
//   NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;  //
//   LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)      //
//   HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN     //
//   CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR  //
//   OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS          //
//   SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.  //
//                                                                 //
/////////////////////////////////////////////////////////////////////

// +FHDR -  Semiconductor Reuse Standard File Header Section  -------
// FILE NAME      : rl_ram_1rw.sv
// DEPARTMENT     :
// AUTHOR         : rherveille
// AUTHOR'S EMAIL :
// ------------------------------------------------------------------
// RELEASE HISTORY
// VERSION DATE        AUTHOR      DESCRIPTION
// 1.0     2018-07-27  rherveille  initial release with new logo
// ------------------------------------------------------------------
// KEYWORDS : MEMORY RAM 1RW Single Port
// ------------------------------------------------------------------
// PURPOSE  : Wrapper for technology specific 1RW RAM Blocks
// ------------------------------------------------------------------
// PARAMETERS
//  PARAM NAME        RANGE  DESCRIPTION              DEFAULT UNITS
//  ABITS             1+     Number of address bits   10      bits
//  DBITS             1+     Number of data bits      32      bits
//  TECHNOLOGY               Technology Name          GENERIC
// ------------------------------------------------------------------
// REUSE ISSUES 
//   Reset Strategy      : rstn_i; asynchronous, active low
//   Clock Domains       : clk_i; rising edge
//   Critical Timing     : 
//   Test Features       : 
//   Asynchronous I/F    : none                     
//   Scan Methodology    : na
//   Instantiations      : Yes; eip_n3xs_rfile_array
//                              eip_n3xs_bram_array
//   Synthesizable (y/n) : Yes
//   Other               : 
// -FHDR-------------------------------------------------------------


module rl_ram_1rw #(
  parameter ABITS      = 10,
  parameter DBITS      = 32,
  parameter TECHNOLOGY = "GENERIC"
)
(
  input                    rst_ni,
  input                    clk_i,

  input  [ ABITS     -1:0] addr_i,
  input                    we_i,
  input  [(DBITS+7)/8-1:0] be_i,
  input  [ DBITS     -1:0] din_i,
  output [ DBITS     -1:0] dout_o
);
  //////////////////////////////////////////////////////////////////
  //
  // Module Body
  //
generate

  if (TECHNOLOGY == "N3X" ||
      TECHNOLOGY == "n3x" )
  begin
      /*
       * eASIC N3X
       */
      rl_ram_1rw_easic_n3x #(
        .ABITS ( ABITS ),
        .DBITS ( DBITS ) )
      ram_inst (
        .rst_ni ( rst_ni ),
        .clk_i  ( clk_i  ),

        .addr_i ( addr_i ),
        .we_i   ( we_i   ),
        .be_i   ( be_i   ),
        .din_i  ( din_i  ),
        .dout_o ( dout_o )
      );
  end
  else // (TECHNOLOGY == "GENERIC")
  begin
      /*
       * GENERIC  -- inferrable memory
       */
      initial $display ("INFO   : No memory technology specified. Using generic inferred memory (%m)");

      rl_ram_1rw_generic #(
        .ABITS ( ABITS ),
        .DBITS ( DBITS ) )
      ram_inst (
        .rst_ni ( rst_ni ),
        .clk_i  ( clk_i  ),

        .addr_i ( addr_i ),
        .we_i   ( we_i   ),
        .be_i   ( be_i   ),
        .din_i  ( din_i  ),
        .dout_o ( dout_o )
      );
  end

endgenerate

endmodule


