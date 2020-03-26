// Copyright 2019 ETH Zurich and University of Bologna.
//
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the "License"); you may not use this file except in
// compliance with the License. You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

// Author: Stefan Mach <smach@iis.ee.ethz.ch>

function int get_Width(input  fpnew_pkg::fpu_features_t f);    
  get_Width = f.Width;
endfunction

function logic get_EnableVectors(input  fpnew_pkg::fpu_features_t f);    
  get_EnableVectors = f.EnableVectors;
endfunction

function logic get_EnableNanBox(input  fpnew_pkg::fpu_features_t f);    
  get_EnableNanBox = f.EnableNanBox;
endfunction


function logic[4:0] get_FpFmtMask(input  fpnew_pkg::fpu_features_t f);    
   get_FpFmtMask= f.FpFmtMask;
endfunction

function logic[3:0] get_IntFmtMask(input  fpnew_pkg::fpu_features_t f);    
   get_IntFmtMask= f.IntFmtMask;
endfunction

function logic [0:fpnew_pkg::NUM_OPGROUPS-1][0:fpnew_pkg::NUM_FP_FORMATS-1][31:0] get_PipeRegs(input  fpnew_pkg::fpu_implementation_t f);    
   get_PipeRegs= f.PipeRegs;
endfunction

function logic [0:fpnew_pkg::NUM_OPGROUPS-1][0:fpnew_pkg::NUM_FP_FORMATS-1][1:0] get_UnitTypes(input  fpnew_pkg::fpu_implementation_t f);
   get_UnitTypes = f.UnitTypes;
endfunction

function logic [1:0] get_PipeConfig(input  fpnew_pkg::fpu_implementation_t f);
   get_PipeConfig = f.PipeConfig;
endfunction




module fpnew_top #(
  // FPU configuration
  parameter fpnew_pkg::fpu_features_t       Features       = fpnew_pkg::RV32F,
  parameter fpnew_pkg::fpu_implementation_t Implementation = fpnew_pkg::DEFAULT_NOREGS
  //parameter type                            TagType        = logic,
  // Do not change
) (
  input logic                               clk_i,
  input logic                               rst_ni,
  // Input signals
  input logic [NUM_OPERANDS-1:0][get_Width(Features)-1:0] operands_i,
  //input logic [NUM_OPERANDS-1:0][32-1:0] operands_i,
  input fpnew_pkg::roundmode_e              rnd_mode_i,
  input fpnew_pkg::operation_e              op_i,
  input logic                               op_mod_i,
  input fpnew_pkg::fp_format_e              src_fmt_i,
  input fpnew_pkg::fp_format_e              dst_fmt_i,
  input fpnew_pkg::int_format_e             int_fmt_i,
  input logic                               vectorial_op_i,
  input logic                             tag_i,
  // Input Handshake
  input  logic                              in_valid_i,
  output logic                              in_ready_o,
  input  logic                              flush_i,
  // Output signals
  output logic [get_Width(Features)-1:0]                  result_o,
  //output logic [32-1:0]                  result_o,
  output fpnew_pkg::status_t                status_o,
  output logic                            tag_o,
  // Output handshake
  output logic                              out_valid_o,
  input  logic                              out_ready_i,
  // Indication of valid data in flight
  output logic                              busy_o
);
  //localparam fpnew_pkg::fpu_features_t       LFeatures       = fpnew_pkg::RV64D_Xsflt;
    /*localparam fpnew_pkg::fpu_features_t LFeatures = '{
            Width:         C_FLEN,
            EnableVectors: C_XFVEC,
            EnableNanBox:  1'b0,
            FpFmtMask:     {C_RVF, C_RVD, C_XF16, C_XF8, C_XF16ALT},
            IntFmtMask:    {C_XFVEC && C_XF8, C_XFVEC && (C_XF16 || C_XF16ALT), 1'b1, 1'b0}
          }; */
  
  //localparam fpnew_pkg::fpu_features_t       LFeatures=con(Features);
  localparam int unsigned WIDTH        = get_Width(Features);
  localparam logic ENABLEVECTORS = get_EnableVectors(Features);
  localparam logic ENABLENANBOX = get_EnableNanBox(Features);
  localparam logic [4:0] FPFMTMASK = get_FpFmtMask(Features);
  localparam logic [3:0] INTFMTMASK = get_IntFmtMask(Features);
  localparam logic [0:fpnew_pkg::NUM_OPGROUPS-1][0:fpnew_pkg::NUM_FP_FORMATS-1][31:0] PIPEREGS = get_PipeRegs(Implementation);
  localparam logic [0:fpnew_pkg::NUM_OPGROUPS-1][0:fpnew_pkg::NUM_FP_FORMATS-1][1:0] UNITTYPES = get_UnitTypes(Implementation);
  localparam logic [1:0] PIPECONFIG = get_PipeConfig(Implementation);
  
  //localparam int unsigned WIDTH        = LFeatures.Width;
  
  localparam int unsigned NUM_OPERANDS = 3;
  localparam int unsigned NUM_OPGROUPS = fpnew_pkg::NUM_OPGROUPS;
  localparam int unsigned NUM_FORMATS  = fpnew_pkg::NUM_FP_FORMATS;

  // ----------------
  // Type Definition
  // ----------------
  typedef struct packed {
    logic [WIDTH-1:0]   result;
    fpnew_pkg::status_t status;
    logic             tag;
  } output_t;

  // Handshake signals for the blocks
  logic [NUM_OPGROUPS-1:0] opgrp_in_ready, opgrp_out_valid, opgrp_out_ready, opgrp_ext, opgrp_busy;
  output_t [NUM_OPGROUPS-1:0] opgrp_outputs;

  logic [NUM_FORMATS-1:0][NUM_OPERANDS-1:0] is_boxed;

  // -----------
  // Input Side
  // -----------
  assign in_ready_o = in_valid_i & opgrp_in_ready[fpnew_pkg::get_opgroup(op_i)];

  // NaN-boxing check
  generate
  genvar fmt, op;
  for (fmt = 0; fmt < int'(NUM_FORMATS); fmt++) begin : gen_nanbox_check
    localparam int unsigned FP_WIDTH = fpnew_pkg::fp_width(fpnew_pkg::fp_format_e'(fmt));
    // NaN boxing is only generated if it's enabled and needed
    if (ENABLENANBOX && (FP_WIDTH < WIDTH)) begin : check
      for (op = 0; op < int'(NUM_OPERANDS); op++) begin : operands
        assign is_boxed[fmt][op] = (!vectorial_op_i)
                                   ? operands_i[op][WIDTH-1:FP_WIDTH] == '1
                                   : 1'b1;
      end
    end else begin : no_check
      assign is_boxed[fmt] = '1;
    end
  end
  
  // -------------------------
  // Generate Operation Blocks
  // -------------------------
  genvar opgrp;
  for (opgrp = 0; opgrp < int'(NUM_OPGROUPS); opgrp++) begin : gen_operation_groups
    localparam int unsigned NUM_OPS = fpnew_pkg::num_operands(fpnew_pkg::opgroup_e'(opgrp));

    logic in_valid;
    logic [NUM_FORMATS-1:0][NUM_OPS-1:0] input_boxed;

    assign in_valid = in_valid_i & (fpnew_pkg::get_opgroup(op_i) == fpnew_pkg::opgroup_e'(opgrp));

    // slice out input boxing
    always_comb begin : slice_inputs
      for (int unsigned fmt = 0; fmt < NUM_FORMATS; fmt++)
        input_boxed[fmt] = is_boxed[fmt][NUM_OPS-1:0];
    end

    fpnew_opgroup_block #(
      .OpGroup       ( fpnew_pkg::opgroup_e'(opgrp)    ),
      .Width         ( WIDTH                           ),
      .EnableVectors ( ENABLEVECTORS                   ),
      .FpFmtMask     ( FPFMTMASK              ),
      .IntFmtMask    ( INTFMTMASK            ),
      .FmtPipeRegs   ( PIPEREGS[opgrp]  ),
      .FmtUnitTypes  ( UNITTYPES[opgrp] ),
      .PipeConfig    ( PIPECONFIG       )
      //.TagType       ( TagType                         )
    ) i_opgroup_block (
      .clk_i,
      .rst_ni,
      .operands_i      ( operands_i[NUM_OPS-1:0] ),
      .is_boxed_i      ( input_boxed             ),
      .rnd_mode_i,
      .op_i,
      .op_mod_i,
      .src_fmt_i,
      .dst_fmt_i,
      .int_fmt_i,
      .vectorial_op_i,
      .tag_i,
      .in_valid_i      ( in_valid              ),
      .in_ready_o      ( opgrp_in_ready[opgrp] ),
      .flush_i,
      .result_o        ( opgrp_outputs[opgrp].result ),
      .status_o        ( opgrp_outputs[opgrp].status ),
      .extension_bit_o ( opgrp_ext[opgrp]            ),
      .tag_o           ( opgrp_outputs[opgrp].tag    ),
      .out_valid_o     ( opgrp_out_valid[opgrp]      ),
      .out_ready_i     ( opgrp_out_ready[opgrp]      ),
      .busy_o          ( opgrp_busy[opgrp]           )
    );
  end
  endgenerate
  // ------------------
  // Arbitrate Outputs
  // ------------------
  output_t arbiter_output;

  // Round-Robin arbiter to decide which result to use
  rr_arb_tree_fpu #(
    .DataWidth ($bits(output_t)),
    .NumIn     ( NUM_OPGROUPS ),
    //.DataType  ( output_t     ),
    .AxiVldRdy ( 1'b1         )
  ) i_arbiter (
    .clk_i,
    .rst_ni,
    .flush_i,
    .rr_i   ( '0             ),
    .req_i  ( opgrp_out_valid ),
    .gnt_o  ( opgrp_out_ready ),
    .data_i ( opgrp_outputs   ),
    .gnt_i  ( out_ready_i     ),
    .req_o  ( out_valid_o     ),
    .data_o ( arbiter_output  ),
    .idx_o  ( /* unused */    )
  );

  // Unpack output
  assign result_o        = arbiter_output.result;
  assign status_o        = arbiter_output.status;
  assign tag_o           = arbiter_output.tag;

  assign busy_o = (| opgrp_busy);

endmodule
