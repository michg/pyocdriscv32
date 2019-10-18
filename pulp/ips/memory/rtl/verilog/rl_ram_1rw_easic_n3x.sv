/////////////////////////////////////////////////////////////////////
//   ,------.                    ,--.                ,--.          //
//   |  .--. ' ,---.  ,--,--.    |  |    ,---. ,---. `--' ,---.    //
//   |  '--'.'| .-. |' ,-.  |    |  |   | .-. | .-. |,--.| .--'    //
//   |  |\  \ ' '-' '\ '-'  |    |  '--.' '-' ' '-' ||  |\ `--.    //
//   `--' '--' `---'  `--`--'    `-----' `---' `-   /`--' `---'    //
//                                             `---'               //
//   eASIC Nextreme-3 1R1W RAM Block Wrapper                       //
//                                                                 //
/////////////////////////////////////////////////////////////////////
//                                                                 //
//             Copyright (C) 2016-2018 Roa Logic BV                //
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
// FILE NAME      : rl_ram_1rw_easic_n3x.sv
// DEPARTMENT     :
// AUTHOR         : rherveille
// AUTHOR'S EMAIL :
// ------------------------------------------------------------------
// RELEASE HISTORY
// VERSION DATE        AUTHOR      DESCRIPTION
// 1.0     2018-07-27  rherveille  initial release with new logo
// ------------------------------------------------------------------
// KEYWORDS : eASIC Nextreme3 MEMORY RAM 1RW
// ------------------------------------------------------------------
// PURPOSE  : Wrapper for eASIC Nextreme-3 1RW RAM Blocks
// ------------------------------------------------------------------
// PARAMETERS
//  PARAM NAME        RANGE  DESCRIPTION              DEFAULT UNITS
//  ABITS             1+     Number of address bits   10      bits
//  DBITS             1+     Number of data bits      32      bits
// ------------------------------------------------------------------
// REUSE ISSUES 
//   Reset Strategy      : rstn_i; asynchronous, active low
//   Clock Domains       : clk_i; rising edge
//   Critical Timing     : 
//   Test Features       : 
//   Asynchronous I/F    : none                     
//   Scan Methodology    : na
//   Instantiations      : Yes; eip_n3x_bram_sp_array
//   Synthesizable (y/n) : Yes
//   Other               : 
// -FHDR-------------------------------------------------------------


module rl_ram_1rw_easic_n3x #(
  parameter ABITS      = 10,
  parameter DBITS      = 32
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

  eip_n3x_bram_sp_array #(
    .WIDTH         ( DBITS    ),
    .DEPTH         ( 2**ABITS ),
    .REG_OUT       ( "NO"     ),
    .INIT_ON       ( "NO"     ),
    .NINE_BIT_MODE ( "AUTO"   ),
    .TARGET        ( "POWER"  ) )
  ram_inst (
    .CLK    ( clk_i         ),
    .A      ( addr_i        ),
    .D      ( din_i         ),
    .Q      ( dout_o        ),
    .ME     ( 1'b1          ),
    .WE     ( we_i          ),
    .BE     ( {DBITS{1'b1}} ),
    .RST_N  ( 1'b1          ),

    .SD     ( 1'b0          ),
    .DS     ( 1'b0          ),
    .LS     ( 1'b0          ) );
endmodule


