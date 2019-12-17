// Generator : SpinalHDL v1.3.6    git head : 9bf01e7f360e003fac1dd5ca8b8f4bffec0e52b8
// Date      : 16/12/2019, 11:07:22
// Component : Murax


`define EnvCtrlEnum_defaultEncoding_type [1:0]
`define EnvCtrlEnum_defaultEncoding_NONE 2'b00
`define EnvCtrlEnum_defaultEncoding_XRET 2'b01
`define EnvCtrlEnum_defaultEncoding_WFI 2'b10
`define EnvCtrlEnum_defaultEncoding_ECALL 2'b11

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10

`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define Src2CtrlEnum_defaultEncoding_type [1:0]
`define Src2CtrlEnum_defaultEncoding_RS 2'b00
`define Src2CtrlEnum_defaultEncoding_IMI 2'b01
`define Src2CtrlEnum_defaultEncoding_IMS 2'b10
`define Src2CtrlEnum_defaultEncoding_PC 2'b11

`define Src1CtrlEnum_defaultEncoding_type [1:0]
`define Src1CtrlEnum_defaultEncoding_RS 2'b00
`define Src1CtrlEnum_defaultEncoding_IMU 2'b01
`define Src1CtrlEnum_defaultEncoding_PC_INCREMENT 2'b10
`define Src1CtrlEnum_defaultEncoding_URS1 2'b11

`define JtagState_defaultEncoding_type [3:0]
`define JtagState_defaultEncoding_RESET 4'b0000
`define JtagState_defaultEncoding_IDLE 4'b0001
`define JtagState_defaultEncoding_IR_SELECT 4'b0010
`define JtagState_defaultEncoding_IR_CAPTURE 4'b0011
`define JtagState_defaultEncoding_IR_SHIFT 4'b0100
`define JtagState_defaultEncoding_IR_EXIT1 4'b0101
`define JtagState_defaultEncoding_IR_PAUSE 4'b0110
`define JtagState_defaultEncoding_IR_EXIT2 4'b0111
`define JtagState_defaultEncoding_IR_UPDATE 4'b1000
`define JtagState_defaultEncoding_DR_SELECT 4'b1001
`define JtagState_defaultEncoding_DR_CAPTURE 4'b1010
`define JtagState_defaultEncoding_DR_SHIFT 4'b1011
`define JtagState_defaultEncoding_DR_EXIT1 4'b1100
`define JtagState_defaultEncoding_DR_PAUSE 4'b1101
`define JtagState_defaultEncoding_DR_EXIT2 4'b1110
`define JtagState_defaultEncoding_DR_UPDATE 4'b1111

`define UartStopType_defaultEncoding_type [0:0]
`define UartStopType_defaultEncoding_ONE 1'b0
`define UartStopType_defaultEncoding_TWO 1'b1

`define UartParityType_defaultEncoding_type [1:0]
`define UartParityType_defaultEncoding_NONE 2'b00
`define UartParityType_defaultEncoding_EVEN 2'b01
`define UartParityType_defaultEncoding_ODD 2'b10

`define UartCtrlTxState_defaultEncoding_type [2:0]
`define UartCtrlTxState_defaultEncoding_IDLE 3'b000
`define UartCtrlTxState_defaultEncoding_START 3'b001
`define UartCtrlTxState_defaultEncoding_DATA 3'b010
`define UartCtrlTxState_defaultEncoding_PARITY 3'b011
`define UartCtrlTxState_defaultEncoding_STOP 3'b100

`define UartCtrlRxState_defaultEncoding_type [2:0]
`define UartCtrlRxState_defaultEncoding_IDLE 3'b000
`define UartCtrlRxState_defaultEncoding_START 3'b001
`define UartCtrlRxState_defaultEncoding_DATA 3'b010
`define UartCtrlRxState_defaultEncoding_PARITY 3'b011
`define UartCtrlRxState_defaultEncoding_STOP 3'b100

`define SpiMasterCtrlCmdMode_defaultEncoding_type [0:0]
`define SpiMasterCtrlCmdMode_defaultEncoding_DATA 1'b0
`define SpiMasterCtrlCmdMode_defaultEncoding_SS 1'b1

module BufferCC (
      input   io_initial,
      input   io_dataIn,
      output  io_dataOut,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      buffers_0 <= io_initial;
      buffers_1 <= io_initial;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end

endmodule

module BufferCC_1_ (
      input   io_dataIn,
      output  io_dataOut,
      input   io_mainClk,
      input   resetCtrl_mainClkReset);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module UartCtrlTx (
      input  [2:0] io_configFrame_dataLength,
      input  `UartStopType_defaultEncoding_type io_configFrame_stop,
      input  `UartParityType_defaultEncoding_type io_configFrame_parity,
      input   io_samplingTick,
      input   io_write_valid,
      output reg  io_write_ready,
      input  [7:0] io_write_payload,
      output  io_txd,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_1_;
  wire [0:0] _zz_2_;
  wire [2:0] _zz_3_;
  wire [0:0] _zz_4_;
  wire [2:0] _zz_5_;
  reg  clockDivider_counter_willIncrement;
  wire  clockDivider_counter_willClear;
  reg [2:0] clockDivider_counter_valueNext;
  reg [2:0] clockDivider_counter_value;
  wire  clockDivider_counter_willOverflowIfInc;
  wire  clockDivider_willOverflow;
  reg [2:0] tickCounter_value;
  reg `UartCtrlTxState_defaultEncoding_type stateMachine_state;
  reg  stateMachine_parity;
  reg  stateMachine_txd;
  reg  stateMachine_txd_regNext;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif

  assign _zz_1_ = (tickCounter_value == io_configFrame_dataLength);
  assign _zz_2_ = clockDivider_counter_willIncrement;
  assign _zz_3_ = {2'd0, _zz_2_};
  assign _zz_4_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
  assign _zz_5_ = {2'd0, _zz_4_};
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlTxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlTxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlTxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlTxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  always @ (*) begin
    clockDivider_counter_willIncrement = 1'b0;
    if(io_samplingTick)begin
      clockDivider_counter_willIncrement = 1'b1;
    end
  end

  assign clockDivider_counter_willClear = 1'b0;
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == (3'b100));
  assign clockDivider_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @ (*) begin
    if(clockDivider_willOverflow)begin
      clockDivider_counter_valueNext = (3'b000);
    end else begin
      clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_3_);
    end
    if(clockDivider_counter_willClear)begin
      clockDivider_counter_valueNext = (3'b000);
    end
  end

  always @ (*) begin
    stateMachine_txd = 1'b1;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        stateMachine_txd = 1'b0;
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        stateMachine_txd = io_write_payload[tickCounter_value];
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        stateMachine_txd = stateMachine_parity;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    io_write_ready = 1'b0;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_willOverflow)begin
          if(_zz_1_)begin
            io_write_ready = 1'b1;
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
      end
      default : begin
      end
    endcase
  end

  assign io_txd = stateMachine_txd_regNext;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      clockDivider_counter_value <= (3'b000);
      stateMachine_state <= `UartCtrlTxState_defaultEncoding_IDLE;
      stateMachine_txd_regNext <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        `UartCtrlTxState_defaultEncoding_IDLE : begin
          if((io_write_valid && clockDivider_willOverflow))begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_START;
          end
        end
        `UartCtrlTxState_defaultEncoding_START : begin
          if(clockDivider_willOverflow)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_DATA;
          end
        end
        `UartCtrlTxState_defaultEncoding_DATA : begin
          if(clockDivider_willOverflow)begin
            if(_zz_1_)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
              end else begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlTxState_defaultEncoding_PARITY : begin
          if(clockDivider_willOverflow)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
          end
        end
        default : begin
          if(clockDivider_willOverflow)begin
            if((tickCounter_value == _zz_5_))begin
              stateMachine_state <= (io_write_valid ? `UartCtrlTxState_defaultEncoding_START : `UartCtrlTxState_defaultEncoding_IDLE);
            end
          end
        end
      endcase
      stateMachine_txd_regNext <= stateMachine_txd;
    end
  end

  always @ (posedge io_mainClk) begin
    if(clockDivider_willOverflow)begin
      tickCounter_value <= (tickCounter_value + (3'b001));
    end
    if(clockDivider_willOverflow)begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_willOverflow)begin
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
          tickCounter_value <= (3'b000);
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_willOverflow)begin
          if(_zz_1_)begin
            tickCounter_value <= (3'b000);
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_willOverflow)begin
          tickCounter_value <= (3'b000);
        end
      end
      default : begin
      end
    endcase
  end

endmodule

module UartCtrlRx (
      input  [2:0] io_configFrame_dataLength,
      input  `UartStopType_defaultEncoding_type io_configFrame_stop,
      input  `UartParityType_defaultEncoding_type io_configFrame_parity,
      input   io_samplingTick,
      output  io_read_valid,
      output [7:0] io_read_payload,
      input   io_rxd,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_1_;
  wire  bufferCC_4__io_dataOut;
  wire  _zz_2_;
  wire  _zz_3_;
  wire  _zz_4_;
  wire [0:0] _zz_5_;
  wire [2:0] _zz_6_;
  wire  sampler_synchroniser;
  wire  sampler_samples_0;
  reg  sampler_samples_1;
  reg  sampler_samples_2;
  reg  sampler_value;
  reg  sampler_tick;
  reg [2:0] bitTimer_counter;
  reg  bitTimer_tick;
  reg [2:0] bitCounter_value;
  reg `UartCtrlRxState_defaultEncoding_type stateMachine_state;
  reg  stateMachine_parity;
  reg [7:0] stateMachine_shifter;
  reg  stateMachine_validReg;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif

  assign _zz_2_ = (bitTimer_counter == (3'b000));
  assign _zz_3_ = (sampler_tick && (! sampler_value));
  assign _zz_4_ = (bitCounter_value == io_configFrame_dataLength);
  assign _zz_5_ = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? (1'b0) : (1'b1));
  assign _zz_6_ = {2'd0, _zz_5_};
  BufferCC bufferCC_4_ ( 
    .io_initial(_zz_1_),
    .io_dataIn(io_rxd),
    .io_dataOut(bufferCC_4__io_dataOut),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_configFrame_stop)
      `UartStopType_defaultEncoding_ONE : io_configFrame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_configFrame_stop_string = "TWO";
      default : io_configFrame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_configFrame_parity)
      `UartParityType_defaultEncoding_NONE : io_configFrame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_configFrame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_configFrame_parity_string = "ODD ";
      default : io_configFrame_parity_string = "????";
    endcase
  end
  always @(*) begin
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : stateMachine_state_string = "IDLE  ";
      `UartCtrlRxState_defaultEncoding_START : stateMachine_state_string = "START ";
      `UartCtrlRxState_defaultEncoding_DATA : stateMachine_state_string = "DATA  ";
      `UartCtrlRxState_defaultEncoding_PARITY : stateMachine_state_string = "PARITY";
      `UartCtrlRxState_defaultEncoding_STOP : stateMachine_state_string = "STOP  ";
      default : stateMachine_state_string = "??????";
    endcase
  end
  `endif

  assign _zz_1_ = 1'b0;
  assign sampler_synchroniser = bufferCC_4__io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @ (*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick)begin
      if(_zz_2_)begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign io_read_valid = stateMachine_validReg;
  assign io_read_payload = stateMachine_shifter;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      if(io_samplingTick)begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick)begin
        sampler_samples_2 <= sampler_samples_1;
      end
      sampler_value <= (((1'b0 || ((1'b1 && sampler_samples_0) && sampler_samples_1)) || ((1'b1 && sampler_samples_0) && sampler_samples_2)) || ((1'b1 && sampler_samples_1) && sampler_samples_2));
      sampler_tick <= io_samplingTick;
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        `UartCtrlRxState_defaultEncoding_IDLE : begin
          if(_zz_3_)begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_START;
          end
        end
        `UartCtrlRxState_defaultEncoding_START : begin
          if(bitTimer_tick)begin
            stateMachine_state <= `UartCtrlRxState_defaultEncoding_DATA;
            if((sampler_value == 1'b1))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        `UartCtrlRxState_defaultEncoding_DATA : begin
          if(bitTimer_tick)begin
            if(_zz_4_)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
                stateMachine_validReg <= 1'b1;
              end else begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlRxState_defaultEncoding_PARITY : begin
          if(bitTimer_tick)begin
            if((stateMachine_parity == sampler_value))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick)begin
            if((! sampler_value))begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end else begin
              if((bitCounter_value == _zz_6_))begin
                stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
              end
            end
          end
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    if(sampler_tick)begin
      bitTimer_counter <= (bitTimer_counter - (3'b001));
      if(_zz_2_)begin
        bitTimer_counter <= (3'b100);
      end
    end
    if(bitTimer_tick)begin
      bitCounter_value <= (bitCounter_value + (3'b001));
    end
    if(bitTimer_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
        if(_zz_3_)begin
          bitTimer_counter <= (3'b001);
        end
      end
      `UartCtrlRxState_defaultEncoding_START : begin
        if(bitTimer_tick)begin
          bitCounter_value <= (3'b000);
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
        end
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
        if(bitTimer_tick)begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(_zz_4_)begin
            bitCounter_value <= (3'b000);
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          bitCounter_value <= (3'b000);
        end
      end
      default : begin
      end
    endcase
  end

endmodule

module StreamFifoLowLatency (
      input   io_push_valid,
      output  io_push_ready,
      input   io_push_payload_error,
      input  [31:0] io_push_payload_inst,
      output reg  io_pop_valid,
      input   io_pop_ready,
      output reg  io_pop_payload_error,
      output reg [31:0] io_pop_payload_inst,
      input   io_flush,
      output [0:0] io_occupancy,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_5_;
  wire [0:0] _zz_6_;
  reg  _zz_1_;
  reg  pushPtr_willIncrement;
  reg  pushPtr_willClear;
  wire  pushPtr_willOverflowIfInc;
  wire  pushPtr_willOverflow;
  reg  popPtr_willIncrement;
  reg  popPtr_willClear;
  wire  popPtr_willOverflowIfInc;
  wire  popPtr_willOverflow;
  wire  ptrMatch;
  reg  risingOccupancy;
  wire  empty;
  wire  full;
  wire  pushing;
  wire  popping;
  wire [32:0] _zz_2_;
  wire [32:0] _zz_3_;
  reg [32:0] _zz_4_;
  assign _zz_5_ = (! empty);
  assign _zz_6_ = _zz_2_[0 : 0];
  always @ (*) begin
    _zz_1_ = 1'b0;
    if(pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willIncrement = 1'b0;
    if(pushing)begin
      pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    pushPtr_willClear = 1'b0;
    if(io_flush)begin
      pushPtr_willClear = 1'b1;
    end
  end

  assign pushPtr_willOverflowIfInc = 1'b1;
  assign pushPtr_willOverflow = (pushPtr_willOverflowIfInc && pushPtr_willIncrement);
  always @ (*) begin
    popPtr_willIncrement = 1'b0;
    if(popping)begin
      popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    popPtr_willClear = 1'b0;
    if(io_flush)begin
      popPtr_willClear = 1'b1;
    end
  end

  assign popPtr_willOverflowIfInc = 1'b1;
  assign popPtr_willOverflow = (popPtr_willOverflowIfInc && popPtr_willIncrement);
  assign ptrMatch = 1'b1;
  assign empty = (ptrMatch && (! risingOccupancy));
  assign full = (ptrMatch && risingOccupancy);
  assign pushing = (io_push_valid && io_push_ready);
  assign popping = (io_pop_valid && io_pop_ready);
  assign io_push_ready = (! full);
  always @ (*) begin
    if(_zz_5_)begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  assign _zz_2_ = _zz_3_;
  always @ (*) begin
    if(_zz_5_)begin
      io_pop_payload_error = _zz_6_[0];
    end else begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @ (*) begin
    if(_zz_5_)begin
      io_pop_payload_inst = _zz_2_[32 : 1];
    end else begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign io_occupancy = (risingOccupancy && ptrMatch);
  assign _zz_3_ = _zz_4_;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      risingOccupancy <= 1'b0;
    end else begin
      if((pushing != popping))begin
        risingOccupancy <= pushing;
      end
      if(io_flush)begin
        risingOccupancy <= 1'b0;
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_1_)begin
      _zz_4_ <= {io_push_payload_inst,io_push_payload_error};
    end
  end

endmodule

module FlowCCByToggle (
      input   io_input_valid,
      input   io_input_payload_last,
      input  [0:0] io_input_payload_fragment,
      output  io_output_valid,
      output  io_output_payload_last,
      output [0:0] io_output_payload_fragment,
      input   io_jtag_tck,
      input   io_mainClk,
      input   resetCtrl_mainClkReset);
  wire  bufferCC_4__io_dataOut;
  wire  outHitSignal;
  reg  inputArea_target = 0;
  reg  inputArea_data_last;
  reg [0:0] inputArea_data_fragment;
  wire  outputArea_target;
  reg  outputArea_hit;
  wire  outputArea_flow_valid;
  wire  outputArea_flow_payload_last;
  wire [0:0] outputArea_flow_payload_fragment;
  reg  outputArea_flow_m2sPipe_valid;
  reg  outputArea_flow_m2sPipe_payload_last;
  reg [0:0] outputArea_flow_m2sPipe_payload_fragment;
  BufferCC_1_ bufferCC_4_ ( 
    .io_dataIn(inputArea_target),
    .io_dataOut(bufferCC_4__io_dataOut),
    .io_mainClk(io_mainClk),
    .resetCtrl_mainClkReset(resetCtrl_mainClkReset) 
  );
  assign outputArea_target = bufferCC_4__io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_m2sPipe_valid;
  assign io_output_payload_last = outputArea_flow_m2sPipe_payload_last;
  assign io_output_payload_fragment = outputArea_flow_m2sPipe_payload_fragment;
  always @ (posedge io_jtag_tck) begin
    if(io_input_valid)begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @ (posedge io_mainClk) begin
    outputArea_hit <= outputArea_target;
    if(outputArea_flow_valid)begin
      outputArea_flow_m2sPipe_payload_last <= outputArea_flow_payload_last;
      outputArea_flow_m2sPipe_payload_fragment <= outputArea_flow_payload_fragment;
    end
  end

  always @ (posedge io_mainClk or posedge resetCtrl_mainClkReset) begin
    if (resetCtrl_mainClkReset) begin
      outputArea_flow_m2sPipe_valid <= 1'b0;
    end else begin
      outputArea_flow_m2sPipe_valid <= outputArea_flow_valid;
    end
  end

endmodule

module BufferCC_2_ (
      input  [31:0] io_dataIn,
      output [31:0] io_dataOut,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [31:0] buffers_0;
  reg [31:0] buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module UartCtrl (
      input  [2:0] io_config_frame_dataLength,
      input  `UartStopType_defaultEncoding_type io_config_frame_stop,
      input  `UartParityType_defaultEncoding_type io_config_frame_parity,
      input  [19:0] io_config_clockDivider,
      input   io_write_valid,
      output  io_write_ready,
      input  [7:0] io_write_payload,
      output  io_read_valid,
      output [7:0] io_read_payload,
      output  io_uart_txd,
      input   io_uart_rxd,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  tx_io_write_ready;
  wire  tx_io_txd;
  wire  rx_io_read_valid;
  wire [7:0] rx_io_read_payload;
  reg [19:0] clockDivider_counter;
  wire  clockDivider_tick;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif

  UartCtrlTx tx ( 
    .io_configFrame_dataLength(io_config_frame_dataLength),
    .io_configFrame_stop(io_config_frame_stop),
    .io_configFrame_parity(io_config_frame_parity),
    .io_samplingTick(clockDivider_tick),
    .io_write_valid(io_write_valid),
    .io_write_ready(tx_io_write_ready),
    .io_write_payload(io_write_payload),
    .io_txd(tx_io_txd),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  UartCtrlRx rx ( 
    .io_configFrame_dataLength(io_config_frame_dataLength),
    .io_configFrame_stop(io_config_frame_stop),
    .io_configFrame_parity(io_config_frame_parity),
    .io_samplingTick(clockDivider_tick),
    .io_read_valid(rx_io_read_valid),
    .io_read_payload(rx_io_read_payload),
    .io_rxd(io_uart_rxd),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_config_frame_stop)
      `UartStopType_defaultEncoding_ONE : io_config_frame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : io_config_frame_stop_string = "TWO";
      default : io_config_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(io_config_frame_parity)
      `UartParityType_defaultEncoding_NONE : io_config_frame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : io_config_frame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : io_config_frame_parity_string = "ODD ";
      default : io_config_frame_parity_string = "????";
    endcase
  end
  `endif

  assign clockDivider_tick = (clockDivider_counter == (20'b00000000000000000000));
  assign io_write_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      clockDivider_counter <= (20'b00000000000000000000);
    end else begin
      clockDivider_counter <= (clockDivider_counter - (20'b00000000000000000001));
      if(clockDivider_tick)begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end

endmodule

module StreamFifo (
      input   io_push_valid,
      output  io_push_ready,
      input  [7:0] io_push_payload,
      output  io_pop_valid,
      input   io_pop_ready,
      output [7:0] io_pop_payload,
      input   io_flush,
      output [4:0] io_occupancy,
      output [4:0] io_availability,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [7:0] _zz_3_;
  wire [0:0] _zz_4_;
  wire [3:0] _zz_5_;
  wire [0:0] _zz_6_;
  wire [3:0] _zz_7_;
  wire [3:0] _zz_8_;
  wire  _zz_9_;
  reg  _zz_1_;
  reg  logic_pushPtr_willIncrement;
  reg  logic_pushPtr_willClear;
  reg [3:0] logic_pushPtr_valueNext;
  reg [3:0] logic_pushPtr_value;
  wire  logic_pushPtr_willOverflowIfInc;
  wire  logic_pushPtr_willOverflow;
  reg  logic_popPtr_willIncrement;
  reg  logic_popPtr_willClear;
  reg [3:0] logic_popPtr_valueNext;
  reg [3:0] logic_popPtr_value;
  wire  logic_popPtr_willOverflowIfInc;
  wire  logic_popPtr_willOverflow;
  wire  logic_ptrMatch;
  reg  logic_risingOccupancy;
  wire  logic_pushing;
  wire  logic_popping;
  wire  logic_empty;
  wire  logic_full;
  reg  _zz_2_;
  wire [3:0] logic_ptrDif;
  reg [7:0] logic_ram [0:15];
  assign _zz_4_ = logic_pushPtr_willIncrement;
  assign _zz_5_ = {3'd0, _zz_4_};
  assign _zz_6_ = logic_popPtr_willIncrement;
  assign _zz_7_ = {3'd0, _zz_6_};
  assign _zz_8_ = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_9_ = 1'b1;
  always @ (posedge io_mainClk) begin
    if(_zz_1_) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload;
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_9_) begin
      _zz_3_ <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(logic_pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == (4'b1111));
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_5_);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = (4'b0000);
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == (4'b1111));
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_7_);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = (4'b0000);
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2_ && (! logic_full))));
  assign io_pop_payload = _zz_3_;
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_8_};
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      logic_pushPtr_value <= (4'b0000);
      logic_popPtr_value <= (4'b0000);
      logic_risingOccupancy <= 1'b0;
      _zz_2_ <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2_ <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end

endmodule


//StreamFifo_1_ remplaced by StreamFifo

module Prescaler (
      input   io_clear,
      input  [15:0] io_limit,
      output  io_overflow,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [15:0] counter;
  assign io_overflow = (counter == io_limit);
  always @ (posedge io_mainClk) begin
    counter <= (counter + (16'b0000000000000001));
    if((io_clear || io_overflow))begin
      counter <= (16'b0000000000000000);
    end
  end

endmodule

module Timer (
      input   io_tick,
      input   io_clear,
      input  [15:0] io_limit,
      output  io_full,
      output [15:0] io_value,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire [0:0] _zz_1_;
  wire [15:0] _zz_2_;
  reg [15:0] counter;
  wire  limitHit;
  reg  inhibitFull;
  assign _zz_1_ = (! limitHit);
  assign _zz_2_ = {15'd0, _zz_1_};
  assign limitHit = (counter == io_limit);
  assign io_full = ((limitHit && io_tick) && (! inhibitFull));
  assign io_value = counter;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      inhibitFull <= 1'b0;
    end else begin
      if(io_tick)begin
        inhibitFull <= limitHit;
      end
      if(io_clear)begin
        inhibitFull <= 1'b0;
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(io_tick)begin
      counter <= (counter + _zz_2_);
    end
    if(io_clear)begin
      counter <= (16'b0000000000000000);
    end
  end

endmodule


//Timer_1_ remplaced by Timer

module InterruptCtrl (
      input  [1:0] io_inputs,
      input  [1:0] io_clears,
      input  [1:0] io_masks,
      output [1:0] io_pendings,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [1:0] pendings;
  assign io_pendings = (pendings & io_masks);
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      pendings <= (2'b00);
    end else begin
      pendings <= ((pendings & (~ io_clears)) | io_inputs);
    end
  end

endmodule

module SpiMasterCtrl (
      input   io_config_kind_cpol,
      input   io_config_kind_cpha,
      input  [15:0] io_config_sclkToogle,
      input  [0:0] io_config_ss_activeHigh,
      input  [15:0] io_config_ss_setup,
      input  [15:0] io_config_ss_hold,
      input  [15:0] io_config_ss_disable,
      input   io_cmd_valid,
      output reg  io_cmd_ready,
      input  `SpiMasterCtrlCmdMode_defaultEncoding_type io_cmd_payload_mode,
      input  [8:0] io_cmd_payload_args,
      output  io_rsp_valid,
      output [7:0] io_rsp_payload,
      output [0:0] io_spi_ss,
      output  io_spi_sclk,
      output  io_spi_mosi,
      input   io_spi_miso,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_4_;
  wire  _zz_5_;
  wire  _zz_6_;
  wire  _zz_7_;
  wire [0:0] _zz_8_;
  wire [3:0] _zz_9_;
  wire [8:0] _zz_10_;
  wire [0:0] _zz_11_;
  wire [0:0] _zz_12_;
  wire [7:0] _zz_13_;
  wire [2:0] _zz_14_;
  wire [2:0] _zz_15_;
  reg [15:0] timer_counter;
  reg  timer_reset;
  wire  timer_ss_setupHit;
  wire  timer_ss_holdHit;
  wire  timer_ss_disableHit;
  wire  timer_sclkToogleHit;
  reg  fsm_counter_willIncrement;
  wire  fsm_counter_willClear;
  reg [3:0] fsm_counter_valueNext;
  reg [3:0] fsm_counter_value;
  wire  fsm_counter_willOverflowIfInc;
  wire  fsm_counter_willOverflow;
  reg [7:0] fsm_buffer;
  reg [0:0] fsm_ss;
  reg  _zz_1_;
  reg  _zz_2_;
  reg  _zz_3_;
  `ifndef SYNTHESIS
  reg [31:0] io_cmd_payload_mode_string;
  `endif

  assign _zz_4_ = (io_cmd_payload_mode == `SpiMasterCtrlCmdMode_defaultEncoding_DATA);
  assign _zz_5_ = _zz_11_[0];
  assign _zz_6_ = (! fsm_counter_value[0]);
  assign _zz_7_ = ((! io_cmd_valid) || io_cmd_ready);
  assign _zz_8_ = fsm_counter_willIncrement;
  assign _zz_9_ = {3'd0, _zz_8_};
  assign _zz_10_ = {fsm_buffer,io_spi_miso};
  assign _zz_11_ = io_cmd_payload_args[0 : 0];
  assign _zz_12_ = io_cmd_payload_args[8 : 8];
  assign _zz_13_ = io_cmd_payload_args[7 : 0];
  assign _zz_14_ = ((3'b111) - _zz_15_);
  assign _zz_15_ = (fsm_counter_value >>> 1);
  `ifndef SYNTHESIS
  always @(*) begin
    case(io_cmd_payload_mode)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : io_cmd_payload_mode_string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : io_cmd_payload_mode_string = "SS  ";
      default : io_cmd_payload_mode_string = "????";
    endcase
  end
  `endif

  always @ (*) begin
    timer_reset = 1'b0;
    if(io_cmd_valid)begin
      if(_zz_4_)begin
        if(timer_sclkToogleHit)begin
          timer_reset = 1'b1;
        end
      end else begin
        if(! _zz_5_) begin
          if(_zz_6_)begin
            if(timer_ss_holdHit)begin
              timer_reset = 1'b1;
            end
          end
        end
      end
    end
    if(_zz_7_)begin
      timer_reset = 1'b1;
    end
  end

  assign timer_ss_setupHit = (timer_counter == io_config_ss_setup);
  assign timer_ss_holdHit = (timer_counter == io_config_ss_hold);
  assign timer_ss_disableHit = (timer_counter == io_config_ss_disable);
  assign timer_sclkToogleHit = (timer_counter == io_config_sclkToogle);
  always @ (*) begin
    fsm_counter_willIncrement = 1'b0;
    if(io_cmd_valid)begin
      if(_zz_4_)begin
        if(timer_sclkToogleHit)begin
          fsm_counter_willIncrement = 1'b1;
        end
      end else begin
        if(! _zz_5_) begin
          if(_zz_6_)begin
            if(timer_ss_holdHit)begin
              fsm_counter_willIncrement = 1'b1;
            end
          end
        end
      end
    end
  end

  assign fsm_counter_willClear = 1'b0;
  assign fsm_counter_willOverflowIfInc = (fsm_counter_value == (4'b1111));
  assign fsm_counter_willOverflow = (fsm_counter_willOverflowIfInc && fsm_counter_willIncrement);
  always @ (*) begin
    fsm_counter_valueNext = (fsm_counter_value + _zz_9_);
    if(fsm_counter_willClear)begin
      fsm_counter_valueNext = (4'b0000);
    end
  end

  always @ (*) begin
    io_cmd_ready = 1'b0;
    if(io_cmd_valid)begin
      if(_zz_4_)begin
        if(timer_sclkToogleHit)begin
          io_cmd_ready = fsm_counter_willOverflowIfInc;
        end
      end else begin
        if(_zz_5_)begin
          if(timer_ss_setupHit)begin
            io_cmd_ready = 1'b1;
          end
        end else begin
          if(! _zz_6_) begin
            if(timer_ss_disableHit)begin
              io_cmd_ready = 1'b1;
            end
          end
        end
      end
    end
  end

  assign io_rsp_valid = _zz_1_;
  assign io_rsp_payload = fsm_buffer;
  assign io_spi_ss = (fsm_ss ^ io_config_ss_activeHigh);
  assign io_spi_sclk = _zz_2_;
  assign io_spi_mosi = _zz_3_;
  always @ (posedge io_mainClk) begin
    timer_counter <= (timer_counter + (16'b0000000000000001));
    if(timer_reset)begin
      timer_counter <= (16'b0000000000000000);
    end
    if(io_cmd_valid)begin
      if(_zz_4_)begin
        if(timer_sclkToogleHit)begin
          if(fsm_counter_value[0])begin
            fsm_buffer <= _zz_10_[7:0];
          end
        end
      end
    end
    _zz_2_ <= (((io_cmd_valid && (io_cmd_payload_mode == `SpiMasterCtrlCmdMode_defaultEncoding_DATA)) && (fsm_counter_value[0] ^ io_config_kind_cpha)) ^ io_config_kind_cpol);
    _zz_3_ <= _zz_13_[_zz_14_];
  end

  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      fsm_counter_value <= (4'b0000);
      fsm_ss <= (1'b1);
      _zz_1_ <= 1'b0;
    end else begin
      fsm_counter_value <= fsm_counter_valueNext;
      if(io_cmd_valid)begin
        if(! _zz_4_) begin
          if(_zz_5_)begin
            fsm_ss[0] <= 1'b0;
          end else begin
            if(! _zz_6_) begin
              fsm_ss[0] <= 1'b1;
            end
          end
        end
      end
      _zz_1_ <= (((io_cmd_valid && io_cmd_ready) && (io_cmd_payload_mode == `SpiMasterCtrlCmdMode_defaultEncoding_DATA)) && _zz_12_[0]);
      if(_zz_7_)begin
        fsm_counter_value <= (4'b0000);
      end
    end
  end

endmodule

module StreamFifo_2_ (
      input   io_push_valid,
      output  io_push_ready,
      input  `SpiMasterCtrlCmdMode_defaultEncoding_type io_push_payload_mode,
      input  [8:0] io_push_payload_args,
      output  io_pop_valid,
      input   io_pop_ready,
      output `SpiMasterCtrlCmdMode_defaultEncoding_type io_pop_payload_mode,
      output [8:0] io_pop_payload_args,
      input   io_flush,
      output [5:0] io_occupancy,
      output [5:0] io_availability,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [9:0] _zz_6_;
  wire [0:0] _zz_7_;
  wire [4:0] _zz_8_;
  wire [0:0] _zz_9_;
  wire [4:0] _zz_10_;
  wire [4:0] _zz_11_;
  wire  _zz_12_;
  wire [9:0] _zz_13_;
  reg  _zz_1_;
  reg  logic_pushPtr_willIncrement;
  reg  logic_pushPtr_willClear;
  reg [4:0] logic_pushPtr_valueNext;
  reg [4:0] logic_pushPtr_value;
  wire  logic_pushPtr_willOverflowIfInc;
  wire  logic_pushPtr_willOverflow;
  reg  logic_popPtr_willIncrement;
  reg  logic_popPtr_willClear;
  reg [4:0] logic_popPtr_valueNext;
  reg [4:0] logic_popPtr_value;
  wire  logic_popPtr_willOverflowIfInc;
  wire  logic_popPtr_willOverflow;
  wire  logic_ptrMatch;
  reg  logic_risingOccupancy;
  wire  logic_pushing;
  wire  logic_popping;
  wire  logic_empty;
  wire  logic_full;
  reg  _zz_2_;
  wire `SpiMasterCtrlCmdMode_defaultEncoding_type _zz_3_;
  wire [9:0] _zz_4_;
  wire `SpiMasterCtrlCmdMode_defaultEncoding_type _zz_5_;
  wire [4:0] logic_ptrDif;
  `ifndef SYNTHESIS
  reg [31:0] io_push_payload_mode_string;
  reg [31:0] io_pop_payload_mode_string;
  reg [31:0] _zz_3__string;
  reg [31:0] _zz_5__string;
  `endif

  reg [9:0] logic_ram [0:31];
  assign _zz_7_ = logic_pushPtr_willIncrement;
  assign _zz_8_ = {4'd0, _zz_7_};
  assign _zz_9_ = logic_popPtr_willIncrement;
  assign _zz_10_ = {4'd0, _zz_9_};
  assign _zz_11_ = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_12_ = 1'b1;
  assign _zz_13_ = {io_push_payload_args,io_push_payload_mode};
  always @ (posedge io_mainClk) begin
    if(_zz_1_) begin
      logic_ram[logic_pushPtr_value] <= _zz_13_;
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_12_) begin
      _zz_6_ <= logic_ram[logic_popPtr_valueNext];
    end
  end

  `ifndef SYNTHESIS
  always @(*) begin
    case(io_push_payload_mode)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : io_push_payload_mode_string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : io_push_payload_mode_string = "SS  ";
      default : io_push_payload_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(io_pop_payload_mode)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : io_pop_payload_mode_string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : io_pop_payload_mode_string = "SS  ";
      default : io_pop_payload_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_3_)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : _zz_3__string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : _zz_3__string = "SS  ";
      default : _zz_3__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_5_)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : _zz_5__string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : _zz_5__string = "SS  ";
      default : _zz_5__string = "????";
    endcase
  end
  `endif

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(logic_pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == (5'b11111));
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_8_);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = (5'b00000);
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == (5'b11111));
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_10_);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = (5'b00000);
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2_ && (! logic_full))));
  assign _zz_4_ = _zz_6_;
  assign _zz_5_ = _zz_4_[0 : 0];
  assign _zz_3_ = _zz_5_;
  assign io_pop_payload_mode = _zz_3_;
  assign io_pop_payload_args = _zz_4_[9 : 1];
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_11_};
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      logic_pushPtr_value <= (5'b00000);
      logic_popPtr_value <= (5'b00000);
      logic_risingOccupancy <= 1'b0;
      _zz_2_ <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2_ <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end

endmodule

module StreamFifo_3_ (
      input   io_push_valid,
      output  io_push_ready,
      input  [7:0] io_push_payload,
      output  io_pop_valid,
      input   io_pop_ready,
      output [7:0] io_pop_payload,
      input   io_flush,
      output [5:0] io_occupancy,
      output [5:0] io_availability,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [7:0] _zz_3_;
  wire [0:0] _zz_4_;
  wire [4:0] _zz_5_;
  wire [0:0] _zz_6_;
  wire [4:0] _zz_7_;
  wire [4:0] _zz_8_;
  wire  _zz_9_;
  reg  _zz_1_;
  reg  logic_pushPtr_willIncrement;
  reg  logic_pushPtr_willClear;
  reg [4:0] logic_pushPtr_valueNext;
  reg [4:0] logic_pushPtr_value;
  wire  logic_pushPtr_willOverflowIfInc;
  wire  logic_pushPtr_willOverflow;
  reg  logic_popPtr_willIncrement;
  reg  logic_popPtr_willClear;
  reg [4:0] logic_popPtr_valueNext;
  reg [4:0] logic_popPtr_value;
  wire  logic_popPtr_willOverflowIfInc;
  wire  logic_popPtr_willOverflow;
  wire  logic_ptrMatch;
  reg  logic_risingOccupancy;
  wire  logic_pushing;
  wire  logic_popping;
  wire  logic_empty;
  wire  logic_full;
  reg  _zz_2_;
  wire [4:0] logic_ptrDif;
  reg [7:0] logic_ram [0:31];
  assign _zz_4_ = logic_pushPtr_willIncrement;
  assign _zz_5_ = {4'd0, _zz_4_};
  assign _zz_6_ = logic_popPtr_willIncrement;
  assign _zz_7_ = {4'd0, _zz_6_};
  assign _zz_8_ = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_9_ = 1'b1;
  always @ (posedge io_mainClk) begin
    if(_zz_1_) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload;
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_9_) begin
      _zz_3_ <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (*) begin
    _zz_1_ = 1'b0;
    if(logic_pushing)begin
      _zz_1_ = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willIncrement = 1'b0;
    if(logic_pushing)begin
      logic_pushPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_pushPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_pushPtr_willClear = 1'b1;
    end
  end

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == (5'b11111));
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_5_);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = (5'b00000);
    end
  end

  always @ (*) begin
    logic_popPtr_willIncrement = 1'b0;
    if(logic_popping)begin
      logic_popPtr_willIncrement = 1'b1;
    end
  end

  always @ (*) begin
    logic_popPtr_willClear = 1'b0;
    if(io_flush)begin
      logic_popPtr_willClear = 1'b1;
    end
  end

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == (5'b11111));
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_7_);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = (5'b00000);
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2_ && (! logic_full))));
  assign io_pop_payload = _zz_3_;
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_8_};
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      logic_pushPtr_value <= (5'b00000);
      logic_popPtr_value <= (5'b00000);
      logic_risingOccupancy <= 1'b0;
      _zz_2_ <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2_ <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end

endmodule

module BufferCC_3_ (
      input   io_dataIn,
      output  io_dataOut,
      input   io_mainClk);
  reg  buffers_0;
  reg  buffers_1;
  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end

endmodule

module MuraxMasterArbiter (
      input   io_iBus_cmd_valid,
      output reg  io_iBus_cmd_ready,
      input  [31:0] io_iBus_cmd_payload_pc,
      output  io_iBus_rsp_valid,
      output  io_iBus_rsp_payload_error,
      output [31:0] io_iBus_rsp_payload_inst,
      input   io_dBus_cmd_valid,
      output reg  io_dBus_cmd_ready,
      input   io_dBus_cmd_payload_wr,
      input  [31:0] io_dBus_cmd_payload_address,
      input  [31:0] io_dBus_cmd_payload_data,
      input  [1:0] io_dBus_cmd_payload_size,
      output  io_dBus_rsp_ready,
      output  io_dBus_rsp_error,
      output [31:0] io_dBus_rsp_data,
      output reg  io_masterBus_cmd_valid,
      input   io_masterBus_cmd_ready,
      output  io_masterBus_cmd_payload_write,
      output [31:0] io_masterBus_cmd_payload_address,
      output [31:0] io_masterBus_cmd_payload_data,
      output [3:0] io_masterBus_cmd_payload_mask,
      input   io_masterBus_rsp_valid,
      input  [31:0] io_masterBus_rsp_payload_data,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_2_;
  reg [3:0] _zz_1_;
  reg  rspPending;
  reg  rspTarget;
  assign _zz_2_ = (rspPending && (! io_masterBus_rsp_valid));
  always @ (*) begin
    io_masterBus_cmd_valid = (io_iBus_cmd_valid || io_dBus_cmd_valid);
    if(_zz_2_)begin
      io_masterBus_cmd_valid = 1'b0;
    end
  end

  assign io_masterBus_cmd_payload_write = (io_dBus_cmd_valid && io_dBus_cmd_payload_wr);
  assign io_masterBus_cmd_payload_address = (io_dBus_cmd_valid ? io_dBus_cmd_payload_address : io_iBus_cmd_payload_pc);
  assign io_masterBus_cmd_payload_data = io_dBus_cmd_payload_data;
  always @ (*) begin
    case(io_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_1_ = (4'b0001);
      end
      2'b01 : begin
        _zz_1_ = (4'b0011);
      end
      default : begin
        _zz_1_ = (4'b1111);
      end
    endcase
  end

  assign io_masterBus_cmd_payload_mask = (_zz_1_ <<< io_dBus_cmd_payload_address[1 : 0]);
  always @ (*) begin
    io_iBus_cmd_ready = (io_masterBus_cmd_ready && (! io_dBus_cmd_valid));
    if(_zz_2_)begin
      io_iBus_cmd_ready = 1'b0;
    end
  end

  always @ (*) begin
    io_dBus_cmd_ready = io_masterBus_cmd_ready;
    if(_zz_2_)begin
      io_dBus_cmd_ready = 1'b0;
    end
  end

  assign io_iBus_rsp_valid = (io_masterBus_rsp_valid && (! rspTarget));
  assign io_iBus_rsp_payload_inst = io_masterBus_rsp_payload_data;
  assign io_iBus_rsp_payload_error = 1'b0;
  assign io_dBus_rsp_ready = (io_masterBus_rsp_valid && rspTarget);
  assign io_dBus_rsp_data = io_masterBus_rsp_payload_data;
  assign io_dBus_rsp_error = 1'b0;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      rspPending <= 1'b0;
      rspTarget <= 1'b0;
    end else begin
      if(io_masterBus_rsp_valid)begin
        rspPending <= 1'b0;
      end
      if(((io_masterBus_cmd_valid && io_masterBus_cmd_ready) && (! io_masterBus_cmd_payload_write)))begin
        rspTarget <= io_dBus_cmd_valid;
        rspPending <= 1'b1;
      end
    end
  end

endmodule

module VexRiscv (
      output  iBus_cmd_valid,
      input   iBus_cmd_ready,
      output [31:0] iBus_cmd_payload_pc,
      input   iBus_rsp_valid,
      input   iBus_rsp_payload_error,
      input  [31:0] iBus_rsp_payload_inst,
      input   timerInterrupt,
      input   externalInterrupt,
      input   softwareInterrupt,
      input   debug_bus_cmd_valid,
      output reg  debug_bus_cmd_ready,
      input   debug_bus_cmd_payload_wr,
      input  [7:0] debug_bus_cmd_payload_address,
      input  [31:0] debug_bus_cmd_payload_data,
      output reg [31:0] debug_bus_rsp_data,
      output  debug_resetOut,
      output  dBus_cmd_valid,
      input   dBus_cmd_ready,
      output  dBus_cmd_payload_wr,
      output [31:0] dBus_cmd_payload_address,
      output [31:0] dBus_cmd_payload_data,
      output [1:0] dBus_cmd_payload_size,
      input   dBus_rsp_ready,
      input   dBus_rsp_error,
      input  [31:0] dBus_rsp_data,
      input   io_mainClk,
      input   resetCtrl_systemReset,
      input   resetCtrl_mainClkReset);
  reg [31:0] _zz_189_;
  reg [31:0] _zz_190_;
  wire  IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire  IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire  IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire [31:0] IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire [0:0] IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire  _zz_191_;
  wire  _zz_192_;
  wire  _zz_193_;
  wire  _zz_194_;
  wire  _zz_195_;
  wire  _zz_196_;
  wire  _zz_197_;
  wire  _zz_198_;
  wire  _zz_199_;
  wire  _zz_200_;
  wire [1:0] _zz_201_;
  wire  _zz_202_;
  wire  _zz_203_;
  wire  _zz_204_;
  wire  _zz_205_;
  wire [1:0] _zz_206_;
  wire  _zz_207_;
  wire  _zz_208_;
  wire  _zz_209_;
  wire  _zz_210_;
  wire  _zz_211_;
  wire  _zz_212_;
  wire  _zz_213_;
  wire  _zz_214_;
  wire [5:0] _zz_215_;
  wire  _zz_216_;
  wire  _zz_217_;
  wire  _zz_218_;
  wire  _zz_219_;
  wire [4:0] _zz_220_;
  wire [1:0] _zz_221_;
  wire [1:0] _zz_222_;
  wire [1:0] _zz_223_;
  wire  _zz_224_;
  wire [1:0] _zz_225_;
  wire [1:0] _zz_226_;
  wire [1:0] _zz_227_;
  wire [2:0] _zz_228_;
  wire [31:0] _zz_229_;
  wire [2:0] _zz_230_;
  wire [31:0] _zz_231_;
  wire [31:0] _zz_232_;
  wire [11:0] _zz_233_;
  wire [11:0] _zz_234_;
  wire [2:0] _zz_235_;
  wire [31:0] _zz_236_;
  wire [2:0] _zz_237_;
  wire [0:0] _zz_238_;
  wire [2:0] _zz_239_;
  wire [0:0] _zz_240_;
  wire [2:0] _zz_241_;
  wire [0:0] _zz_242_;
  wire [2:0] _zz_243_;
  wire [0:0] _zz_244_;
  wire [0:0] _zz_245_;
  wire [0:0] _zz_246_;
  wire [0:0] _zz_247_;
  wire [0:0] _zz_248_;
  wire [0:0] _zz_249_;
  wire [0:0] _zz_250_;
  wire [0:0] _zz_251_;
  wire [0:0] _zz_252_;
  wire [0:0] _zz_253_;
  wire [0:0] _zz_254_;
  wire [0:0] _zz_255_;
  wire [0:0] _zz_256_;
  wire [0:0] _zz_257_;
  wire [0:0] _zz_258_;
  wire [0:0] _zz_259_;
  wire [0:0] _zz_260_;
  wire [2:0] _zz_261_;
  wire [4:0] _zz_262_;
  wire [11:0] _zz_263_;
  wire [11:0] _zz_264_;
  wire [31:0] _zz_265_;
  wire [31:0] _zz_266_;
  wire [31:0] _zz_267_;
  wire [31:0] _zz_268_;
  wire [31:0] _zz_269_;
  wire [31:0] _zz_270_;
  wire [31:0] _zz_271_;
  wire [51:0] _zz_272_;
  wire [51:0] _zz_273_;
  wire [51:0] _zz_274_;
  wire [32:0] _zz_275_;
  wire [51:0] _zz_276_;
  wire [49:0] _zz_277_;
  wire [51:0] _zz_278_;
  wire [49:0] _zz_279_;
  wire [51:0] _zz_280_;
  wire [65:0] _zz_281_;
  wire [65:0] _zz_282_;
  wire [31:0] _zz_283_;
  wire [31:0] _zz_284_;
  wire [0:0] _zz_285_;
  wire [5:0] _zz_286_;
  wire [32:0] _zz_287_;
  wire [32:0] _zz_288_;
  wire [31:0] _zz_289_;
  wire [31:0] _zz_290_;
  wire [32:0] _zz_291_;
  wire [32:0] _zz_292_;
  wire [32:0] _zz_293_;
  wire [0:0] _zz_294_;
  wire [32:0] _zz_295_;
  wire [0:0] _zz_296_;
  wire [32:0] _zz_297_;
  wire [0:0] _zz_298_;
  wire [31:0] _zz_299_;
  wire [31:0] _zz_300_;
  wire [32:0] _zz_301_;
  wire [19:0] _zz_302_;
  wire [11:0] _zz_303_;
  wire [11:0] _zz_304_;
  wire [0:0] _zz_305_;
  wire [0:0] _zz_306_;
  wire [0:0] _zz_307_;
  wire [0:0] _zz_308_;
  wire [0:0] _zz_309_;
  wire [0:0] _zz_310_;
  wire [0:0] _zz_311_;
  wire  _zz_312_;
  wire  _zz_313_;
  wire  _zz_314_;
  wire  _zz_315_;
  wire [6:0] _zz_316_;
  wire [4:0] _zz_317_;
  wire  _zz_318_;
  wire [4:0] _zz_319_;
  wire [31:0] _zz_320_;
  wire  _zz_321_;
  wire [0:0] _zz_322_;
  wire [0:0] _zz_323_;
  wire [1:0] _zz_324_;
  wire [1:0] _zz_325_;
  wire  _zz_326_;
  wire [0:0] _zz_327_;
  wire [24:0] _zz_328_;
  wire [31:0] _zz_329_;
  wire [31:0] _zz_330_;
  wire [31:0] _zz_331_;
  wire [31:0] _zz_332_;
  wire [31:0] _zz_333_;
  wire [31:0] _zz_334_;
  wire [0:0] _zz_335_;
  wire [0:0] _zz_336_;
  wire [1:0] _zz_337_;
  wire [1:0] _zz_338_;
  wire  _zz_339_;
  wire [0:0] _zz_340_;
  wire [21:0] _zz_341_;
  wire [31:0] _zz_342_;
  wire [31:0] _zz_343_;
  wire [31:0] _zz_344_;
  wire [31:0] _zz_345_;
  wire [31:0] _zz_346_;
  wire [31:0] _zz_347_;
  wire  _zz_348_;
  wire [0:0] _zz_349_;
  wire [0:0] _zz_350_;
  wire  _zz_351_;
  wire [0:0] _zz_352_;
  wire [0:0] _zz_353_;
  wire  _zz_354_;
  wire [0:0] _zz_355_;
  wire [18:0] _zz_356_;
  wire [31:0] _zz_357_;
  wire [31:0] _zz_358_;
  wire [31:0] _zz_359_;
  wire [0:0] _zz_360_;
  wire [3:0] _zz_361_;
  wire [1:0] _zz_362_;
  wire [1:0] _zz_363_;
  wire  _zz_364_;
  wire [0:0] _zz_365_;
  wire [15:0] _zz_366_;
  wire [31:0] _zz_367_;
  wire [31:0] _zz_368_;
  wire [31:0] _zz_369_;
  wire  _zz_370_;
  wire [0:0] _zz_371_;
  wire [0:0] _zz_372_;
  wire [31:0] _zz_373_;
  wire [31:0] _zz_374_;
  wire  _zz_375_;
  wire [0:0] _zz_376_;
  wire [0:0] _zz_377_;
  wire [0:0] _zz_378_;
  wire [0:0] _zz_379_;
  wire  _zz_380_;
  wire [0:0] _zz_381_;
  wire [12:0] _zz_382_;
  wire [31:0] _zz_383_;
  wire [31:0] _zz_384_;
  wire [31:0] _zz_385_;
  wire [31:0] _zz_386_;
  wire [31:0] _zz_387_;
  wire [31:0] _zz_388_;
  wire [31:0] _zz_389_;
  wire [31:0] _zz_390_;
  wire [31:0] _zz_391_;
  wire [31:0] _zz_392_;
  wire [0:0] _zz_393_;
  wire [3:0] _zz_394_;
  wire [2:0] _zz_395_;
  wire [2:0] _zz_396_;
  wire  _zz_397_;
  wire [0:0] _zz_398_;
  wire [10:0] _zz_399_;
  wire [31:0] _zz_400_;
  wire  _zz_401_;
  wire [0:0] _zz_402_;
  wire [0:0] _zz_403_;
  wire [31:0] _zz_404_;
  wire [31:0] _zz_405_;
  wire  _zz_406_;
  wire  _zz_407_;
  wire  _zz_408_;
  wire  _zz_409_;
  wire  _zz_410_;
  wire [0:0] _zz_411_;
  wire [0:0] _zz_412_;
  wire  _zz_413_;
  wire [0:0] _zz_414_;
  wire [7:0] _zz_415_;
  wire [31:0] _zz_416_;
  wire [31:0] _zz_417_;
  wire [31:0] _zz_418_;
  wire [31:0] _zz_419_;
  wire [31:0] _zz_420_;
  wire [31:0] _zz_421_;
  wire [31:0] _zz_422_;
  wire [31:0] _zz_423_;
  wire [31:0] _zz_424_;
  wire [31:0] _zz_425_;
  wire  _zz_426_;
  wire [0:0] _zz_427_;
  wire [0:0] _zz_428_;
  wire  _zz_429_;
  wire [0:0] _zz_430_;
  wire [5:0] _zz_431_;
  wire [31:0] _zz_432_;
  wire [31:0] _zz_433_;
  wire [31:0] _zz_434_;
  wire [31:0] _zz_435_;
  wire  _zz_436_;
  wire [0:0] _zz_437_;
  wire [1:0] _zz_438_;
  wire [0:0] _zz_439_;
  wire [0:0] _zz_440_;
  wire [0:0] _zz_441_;
  wire [0:0] _zz_442_;
  wire  _zz_443_;
  wire [0:0] _zz_444_;
  wire [1:0] _zz_445_;
  wire [31:0] _zz_446_;
  wire [31:0] _zz_447_;
  wire [31:0] _zz_448_;
  wire  _zz_449_;
  wire [31:0] _zz_450_;
  wire [31:0] _zz_451_;
  wire [31:0] _zz_452_;
  wire [31:0] _zz_453_;
  wire [31:0] _zz_454_;
  wire [31:0] _zz_455_;
  wire [0:0] _zz_456_;
  wire [2:0] _zz_457_;
  wire [2:0] _zz_458_;
  wire [2:0] _zz_459_;
  wire  _zz_460_;
  wire  _zz_461_;
  wire [31:0] _zz_462_;
  wire [31:0] _zz_463_;
  wire [31:0] _zz_464_;
  wire  _zz_465_;
  wire  _zz_466_;
  wire  _zz_467_;
  wire  _zz_468_;
  wire  _zz_469_;
  wire [1:0] memory_MEMORY_ADDRESS_LOW;
  wire [1:0] execute_MEMORY_ADDRESS_LOW;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_1_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_2_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_3_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_4_;
  wire `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_5_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_6_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_7_;
  wire  decode_SRC_LESS_UNSIGNED;
  wire [31:0] decode_SRC2;
  wire  decode_MEMORY_STORE;
  wire [31:0] execute_MUL_LL;
  wire [33:0] memory_MUL_HH;
  wire [33:0] execute_MUL_HH;
  wire  execute_BYPASSABLE_MEMORY_STAGE;
  wire  decode_BYPASSABLE_MEMORY_STAGE;
  wire `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_8_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_9_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_10_;
  wire  decode_IS_RS2_SIGNED;
  wire [33:0] execute_MUL_LH;
  wire  execute_BRANCH_DO;
  wire [31:0] execute_BRANCH_CALC;
  wire [31:0] decode_RS1;
  wire  decode_DO_EBREAK;
  wire  decode_MEMORY_ENABLE;
  wire [33:0] execute_MUL_HL;
  wire  decode_SRC2_FORCE_ZERO;
  wire [31:0] writeBack_REGFILE_WRITE_DATA;
  wire [31:0] execute_REGFILE_WRITE_DATA;
  wire  memory_IS_MUL;
  wire  execute_IS_MUL;
  wire  decode_IS_MUL;
  wire  decode_BYPASSABLE_EXECUTE_STAGE;
  wire `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_11_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_12_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_13_;
  wire [31:0] memory_PC;
  wire [31:0] decode_SRC1;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_14_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_15_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_16_;
  wire [31:0] decode_RS2;
  wire [51:0] memory_MUL_LOW;
  wire `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_17_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_18_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_19_;
  wire  decode_IS_CSR;
  wire  decode_IS_DIV;
  wire  decode_CSR_READ_OPCODE;
  wire [31:0] writeBack_FORMAL_PC_NEXT;
  wire [31:0] memory_FORMAL_PC_NEXT;
  wire [31:0] execute_FORMAL_PC_NEXT;
  wire [31:0] decode_FORMAL_PC_NEXT;
  wire  decode_CSR_WRITE_OPCODE;
  wire  decode_IS_RS1_SIGNED;
  wire [31:0] memory_MEMORY_READ_DATA;
  wire  execute_DO_EBREAK;
  wire  decode_IS_EBREAK;
  wire  _zz_20_;
  wire [31:0] memory_BRANCH_CALC;
  wire  memory_BRANCH_DO;
  wire [31:0] _zz_21_;
  wire [31:0] execute_PC;
  wire `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_22_;
  wire  _zz_23_;
  wire  decode_RS2_USE;
  wire  decode_RS1_USE;
  wire  execute_REGFILE_WRITE_VALID;
  wire  execute_BYPASSABLE_EXECUTE_STAGE;
  wire  memory_REGFILE_WRITE_VALID;
  wire  memory_BYPASSABLE_MEMORY_STAGE;
  wire  writeBack_REGFILE_WRITE_VALID;
  wire [31:0] memory_REGFILE_WRITE_DATA;
  wire `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_24_;
  wire  execute_IS_RS1_SIGNED;
  wire [31:0] execute_RS1;
  wire  execute_IS_DIV;
  wire  execute_IS_RS2_SIGNED;
  reg [31:0] _zz_25_;
  wire [31:0] memory_INSTRUCTION;
  wire  memory_IS_DIV;
  wire  writeBack_IS_MUL;
  wire [33:0] writeBack_MUL_HH;
  wire [51:0] writeBack_MUL_LOW;
  wire [33:0] memory_MUL_HL;
  wire [33:0] memory_MUL_LH;
  wire [31:0] memory_MUL_LL;
  wire [51:0] _zz_26_;
  wire [33:0] _zz_27_;
  wire [33:0] _zz_28_;
  wire [33:0] _zz_29_;
  wire [31:0] _zz_30_;
  wire  _zz_31_;
  wire [31:0] _zz_32_;
  wire [31:0] _zz_33_;
  wire  execute_SRC_LESS_UNSIGNED;
  wire  execute_SRC2_FORCE_ZERO;
  wire  execute_SRC_USE_SUB_LESS;
  wire [31:0] _zz_34_;
  wire [31:0] _zz_35_;
  wire `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_36_;
  wire [31:0] _zz_37_;
  wire [31:0] _zz_38_;
  wire `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_39_;
  wire [31:0] _zz_40_;
  wire  decode_SRC_USE_SUB_LESS;
  wire  decode_SRC_ADD_ZERO;
  wire  _zz_41_;
  wire [31:0] execute_SRC_ADD_SUB;
  wire  execute_SRC_LESS;
  wire `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire `AluCtrlEnum_defaultEncoding_type _zz_42_;
  wire [31:0] _zz_43_;
  wire [31:0] execute_SRC2;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_44_;
  wire [31:0] _zz_45_;
  wire  _zz_46_;
  reg  _zz_47_;
  wire [31:0] _zz_48_;
  wire [31:0] _zz_49_;
  wire [31:0] decode_INSTRUCTION_ANTICIPATED;
  reg  decode_REGFILE_WRITE_VALID;
  wire  _zz_50_;
  wire  _zz_51_;
  wire  _zz_52_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_53_;
  wire  _zz_54_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_55_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_56_;
  wire  _zz_57_;
  wire  _zz_58_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_59_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_60_;
  wire  _zz_61_;
  wire  _zz_62_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_63_;
  wire  _zz_64_;
  wire  _zz_65_;
  wire  _zz_66_;
  wire  _zz_67_;
  wire  _zz_68_;
  wire  _zz_69_;
  wire  _zz_70_;
  wire  _zz_71_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_72_;
  reg [31:0] _zz_73_;
  wire [31:0] execute_SRC1;
  wire  execute_CSR_READ_OPCODE;
  wire  execute_CSR_WRITE_OPCODE;
  wire  execute_IS_CSR;
  wire `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_74_;
  wire `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_75_;
  wire  _zz_76_;
  wire  _zz_77_;
  wire `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_78_;
  wire  writeBack_MEMORY_STORE;
  reg [31:0] _zz_79_;
  wire  writeBack_MEMORY_ENABLE;
  wire [1:0] writeBack_MEMORY_ADDRESS_LOW;
  wire [31:0] writeBack_MEMORY_READ_DATA;
  wire  memory_MEMORY_STORE;
  wire  memory_MEMORY_ENABLE;
  wire [31:0] _zz_80_;
  wire [31:0] execute_SRC_ADD;
  wire [1:0] _zz_81_;
  wire [31:0] execute_RS2;
  wire [31:0] execute_INSTRUCTION;
  wire  execute_MEMORY_STORE;
  wire  execute_MEMORY_ENABLE;
  wire  execute_ALIGNEMENT_FAULT;
  reg [31:0] _zz_82_;
  wire [31:0] decode_PC;
  wire [31:0] _zz_83_;
  wire  _zz_84_;
  wire [31:0] _zz_85_;
  wire [31:0] _zz_86_;
  wire [31:0] decode_INSTRUCTION;
  wire [31:0] _zz_87_;
  wire  decode_IS_RVC;
  wire [31:0] writeBack_PC;
  wire [31:0] writeBack_INSTRUCTION;
  reg  decode_arbitration_haltItself;
  reg  decode_arbitration_haltByOther;
  reg  decode_arbitration_removeIt;
  wire  decode_arbitration_flushIt;
  wire  decode_arbitration_flushNext;
  reg  decode_arbitration_isValid;
  wire  decode_arbitration_isStuck;
  wire  decode_arbitration_isStuckByOthers;
  wire  decode_arbitration_isFlushed;
  wire  decode_arbitration_isMoving;
  wire  decode_arbitration_isFiring;
  reg  execute_arbitration_haltItself;
  reg  execute_arbitration_haltByOther;
  reg  execute_arbitration_removeIt;
  reg  execute_arbitration_flushIt;
  reg  execute_arbitration_flushNext;
  reg  execute_arbitration_isValid;
  wire  execute_arbitration_isStuck;
  wire  execute_arbitration_isStuckByOthers;
  wire  execute_arbitration_isFlushed;
  wire  execute_arbitration_isMoving;
  wire  execute_arbitration_isFiring;
  reg  memory_arbitration_haltItself;
  wire  memory_arbitration_haltByOther;
  reg  memory_arbitration_removeIt;
  wire  memory_arbitration_flushIt;
  reg  memory_arbitration_flushNext;
  reg  memory_arbitration_isValid;
  wire  memory_arbitration_isStuck;
  wire  memory_arbitration_isStuckByOthers;
  wire  memory_arbitration_isFlushed;
  wire  memory_arbitration_isMoving;
  wire  memory_arbitration_isFiring;
  wire  writeBack_arbitration_haltItself;
  wire  writeBack_arbitration_haltByOther;
  reg  writeBack_arbitration_removeIt;
  wire  writeBack_arbitration_flushIt;
  reg  writeBack_arbitration_flushNext;
  reg  writeBack_arbitration_isValid;
  wire  writeBack_arbitration_isStuck;
  wire  writeBack_arbitration_isStuckByOthers;
  wire  writeBack_arbitration_isFlushed;
  wire  writeBack_arbitration_isMoving;
  wire  writeBack_arbitration_isFiring;
  wire [31:0] lastStageInstruction /* verilator public */ ;
  wire [31:0] lastStagePc /* verilator public */ ;
  wire  lastStageIsValid /* verilator public */ ;
  wire  lastStageIsFiring /* verilator public */ ;
  reg  IBusSimplePlugin_fetcherHalt;
  reg  IBusSimplePlugin_fetcherflushIt;
  reg  IBusSimplePlugin_incomingInstruction;
  wire  IBusSimplePlugin_pcValids_0;
  wire  IBusSimplePlugin_pcValids_1;
  wire  IBusSimplePlugin_pcValids_2;
  wire  IBusSimplePlugin_pcValids_3;
  reg  CsrPlugin_jumpInterface_valid;
  reg [31:0] CsrPlugin_jumpInterface_payload;
  wire  CsrPlugin_exceptionPendings_0;
  wire  CsrPlugin_exceptionPendings_1;
  wire  CsrPlugin_exceptionPendings_2;
  wire  CsrPlugin_exceptionPendings_3;
  wire  contextSwitching;
  reg [1:0] CsrPlugin_privilege;
  reg  CsrPlugin_forceMachineWire;
  reg  CsrPlugin_selfException_valid;
  reg [3:0] CsrPlugin_selfException_payload_code;
  wire [31:0] CsrPlugin_selfException_payload_badAddr;
  reg  CsrPlugin_allowInterrupts;
  reg  CsrPlugin_allowException;
  wire  BranchPlugin_jumpInterface_valid;
  wire [31:0] BranchPlugin_jumpInterface_payload;
  reg  IBusSimplePlugin_injectionPort_valid;
  reg  IBusSimplePlugin_injectionPort_ready;
  wire [31:0] IBusSimplePlugin_injectionPort_payload;
  wire  IBusSimplePlugin_jump_pcLoad_valid;
  wire [31:0] IBusSimplePlugin_jump_pcLoad_payload;
  wire [1:0] _zz_88_;
  wire  IBusSimplePlugin_fetchPc_output_valid;
  wire  IBusSimplePlugin_fetchPc_output_ready;
  wire [31:0] IBusSimplePlugin_fetchPc_output_payload;
  reg [31:0] IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg  IBusSimplePlugin_fetchPc_corrected;
  reg  IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg  IBusSimplePlugin_fetchPc_booted;
  reg  IBusSimplePlugin_fetchPc_inc;
  reg [31:0] IBusSimplePlugin_fetchPc_pc;
  reg [31:0] IBusSimplePlugin_decodePc_pcReg /* verilator public */ ;
  wire [31:0] IBusSimplePlugin_decodePc_pcPlus;
  reg  IBusSimplePlugin_decodePc_injectedDecode;
  wire  IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire  IBusSimplePlugin_iBusRsp_stages_0_inputSample;
  wire  IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  reg  IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire  IBusSimplePlugin_iBusRsp_stages_1_inputSample;
  wire  IBusSimplePlugin_iBusRsp_stages_2_input_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_2_input_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_2_input_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_2_output_valid;
  wire  IBusSimplePlugin_iBusRsp_stages_2_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_stages_2_output_payload;
  wire  IBusSimplePlugin_iBusRsp_stages_2_halt;
  wire  IBusSimplePlugin_iBusRsp_stages_2_inputSample;
  wire  _zz_89_;
  wire  _zz_90_;
  wire  _zz_91_;
  wire  _zz_92_;
  wire  _zz_93_;
  reg  _zz_94_;
  wire  _zz_95_;
  reg  _zz_96_;
  reg [31:0] _zz_97_;
  reg  IBusSimplePlugin_iBusRsp_readyForError;
  wire  IBusSimplePlugin_iBusRsp_output_valid;
  wire  IBusSimplePlugin_iBusRsp_output_ready;
  wire [31:0] IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire  IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire  IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire  IBusSimplePlugin_decompressor_inputBeforeStage_valid;
  wire  IBusSimplePlugin_decompressor_inputBeforeStage_ready;
  wire [31:0] IBusSimplePlugin_decompressor_inputBeforeStage_payload_pc;
  wire  IBusSimplePlugin_decompressor_inputBeforeStage_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_decompressor_inputBeforeStage_payload_rsp_inst;
  wire  IBusSimplePlugin_decompressor_inputBeforeStage_payload_isRvc;
  reg  IBusSimplePlugin_decompressor_bufferValid;
  reg [15:0] IBusSimplePlugin_decompressor_bufferData;
  wire [31:0] IBusSimplePlugin_decompressor_raw;
  wire  IBusSimplePlugin_decompressor_isRvc;
  wire [15:0] _zz_98_;
  reg [31:0] IBusSimplePlugin_decompressor_decompressed;
  wire [4:0] _zz_99_;
  wire [4:0] _zz_100_;
  wire [11:0] _zz_101_;
  wire  _zz_102_;
  reg [11:0] _zz_103_;
  wire  _zz_104_;
  reg [9:0] _zz_105_;
  wire [20:0] _zz_106_;
  wire  _zz_107_;
  reg [14:0] _zz_108_;
  wire  _zz_109_;
  reg [2:0] _zz_110_;
  wire  _zz_111_;
  reg [9:0] _zz_112_;
  wire [20:0] _zz_113_;
  wire  _zz_114_;
  reg [4:0] _zz_115_;
  wire [12:0] _zz_116_;
  wire [4:0] _zz_117_;
  wire [4:0] _zz_118_;
  wire [4:0] _zz_119_;
  wire  _zz_120_;
  reg [2:0] _zz_121_;
  reg [2:0] _zz_122_;
  wire  _zz_123_;
  reg [6:0] _zz_124_;
  reg  IBusSimplePlugin_decompressor_bufferFill;
  wire  IBusSimplePlugin_injector_decodeInput_valid;
  wire  IBusSimplePlugin_injector_decodeInput_ready;
  wire [31:0] IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire  IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire  IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg  _zz_125_;
  reg [31:0] _zz_126_;
  reg  _zz_127_;
  reg [31:0] _zz_128_;
  reg  _zz_129_;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_0;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_1;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_2;
  reg  IBusSimplePlugin_injector_nextPcCalc_valids_3;
  reg  IBusSimplePlugin_injector_decodeRemoved;
  reg [31:0] IBusSimplePlugin_injector_formal_rawInDecode;
  wire  IBusSimplePlugin_cmd_valid;
  wire  IBusSimplePlugin_cmd_ready;
  wire [31:0] IBusSimplePlugin_cmd_payload_pc;
  reg [2:0] IBusSimplePlugin_pendingCmd;
  wire [2:0] IBusSimplePlugin_pendingCmdNext;
  reg [2:0] IBusSimplePlugin_rspJoin_discardCounter;
  wire  IBusSimplePlugin_rspJoin_rspBufferOutput_valid;
  wire  IBusSimplePlugin_rspJoin_rspBufferOutput_ready;
  wire  IBusSimplePlugin_rspJoin_rspBufferOutput_payload_error;
  wire [31:0] IBusSimplePlugin_rspJoin_rspBufferOutput_payload_inst;
  wire  iBus_rsp_takeWhen_valid;
  wire  iBus_rsp_takeWhen_payload_error;
  wire [31:0] iBus_rsp_takeWhen_payload_inst;
  wire [31:0] IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg  IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire [31:0] IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire  IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire  IBusSimplePlugin_rspJoin_join_valid;
  wire  IBusSimplePlugin_rspJoin_join_ready;
  wire [31:0] IBusSimplePlugin_rspJoin_join_payload_pc;
  wire  IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire [31:0] IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire  IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire  IBusSimplePlugin_rspJoin_exceptionDetected;
  wire  IBusSimplePlugin_rspJoin_redoRequired;
  wire  _zz_130_;
  wire  _zz_131_;
  reg  execute_DBusSimplePlugin_skipCmd;
  reg [31:0] _zz_132_;
  reg [3:0] _zz_133_;
  wire [3:0] execute_DBusSimplePlugin_formalMask;
  reg [31:0] writeBack_DBusSimplePlugin_rspShifted;
  wire  _zz_134_;
  reg [31:0] _zz_135_;
  wire  _zz_136_;
  reg [31:0] _zz_137_;
  reg [31:0] writeBack_DBusSimplePlugin_rspFormated;
  reg [1:0] CsrPlugin_misa_base;
  reg [25:0] CsrPlugin_misa_extensions;
  reg [1:0] CsrPlugin_mtvec_mode;
  reg [29:0] CsrPlugin_mtvec_base;
  reg [31:0] CsrPlugin_mepc;
  reg  CsrPlugin_mstatus_MIE;
  reg  CsrPlugin_mstatus_MPIE;
  reg [1:0] CsrPlugin_mstatus_MPP;
  reg  CsrPlugin_mip_MEIP;
  reg  CsrPlugin_mip_MTIP;
  reg  CsrPlugin_mip_MSIP;
  reg  CsrPlugin_mie_MEIE;
  reg  CsrPlugin_mie_MTIE;
  reg  CsrPlugin_mie_MSIE;
  reg [31:0] CsrPlugin_mscratch;
  reg  CsrPlugin_mcause_interrupt;
  reg [3:0] CsrPlugin_mcause_exceptionCode;
  reg [31:0] CsrPlugin_mtval;
  reg [63:0] CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg [63:0] CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire  _zz_138_;
  wire  _zz_139_;
  wire  _zz_140_;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  wire  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg  CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg [3:0] CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg [31:0] CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire [1:0] CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  reg  CsrPlugin_interrupt_valid;
  reg [3:0] CsrPlugin_interrupt_code /* verilator public */ ;
  reg [1:0] CsrPlugin_interrupt_targetPrivilege;
  wire  CsrPlugin_exception;
  reg  CsrPlugin_lastStageWasWfi;
  reg  CsrPlugin_pipelineLiberator_done;
  wire  CsrPlugin_interruptJump /* verilator public */ ;
  reg  CsrPlugin_hadException;
  reg [1:0] CsrPlugin_targetPrivilege;
  reg [3:0] CsrPlugin_trapCause;
  reg [1:0] CsrPlugin_xtvec_mode;
  reg [29:0] CsrPlugin_xtvec_base;
  reg  execute_CsrPlugin_inWfi /* verilator public */ ;
  reg  execute_CsrPlugin_wfiWake;
  wire  execute_CsrPlugin_blockedBySideEffects;
  reg  execute_CsrPlugin_illegalAccess;
  reg  execute_CsrPlugin_illegalInstruction;
  reg [31:0] execute_CsrPlugin_readData;
  wire  execute_CsrPlugin_writeInstruction;
  wire  execute_CsrPlugin_readInstruction;
  wire  execute_CsrPlugin_writeEnable;
  wire  execute_CsrPlugin_readEnable;
  wire [31:0] execute_CsrPlugin_readToWriteData;
  reg [31:0] execute_CsrPlugin_writeData;
  wire [11:0] execute_CsrPlugin_csrAddress;
  wire [30:0] _zz_141_;
  wire  _zz_142_;
  wire  _zz_143_;
  wire  _zz_144_;
  wire  _zz_145_;
  wire  _zz_146_;
  wire  _zz_147_;
  wire `Src2CtrlEnum_defaultEncoding_type _zz_148_;
  wire `EnvCtrlEnum_defaultEncoding_type _zz_149_;
  wire `BranchCtrlEnum_defaultEncoding_type _zz_150_;
  wire `Src1CtrlEnum_defaultEncoding_type _zz_151_;
  wire `AluBitwiseCtrlEnum_defaultEncoding_type _zz_152_;
  wire `ShiftCtrlEnum_defaultEncoding_type _zz_153_;
  wire `AluCtrlEnum_defaultEncoding_type _zz_154_;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress1;
  wire [4:0] decode_RegFilePlugin_regFileReadAddress2;
  wire [31:0] decode_RegFilePlugin_rs1Data;
  wire [31:0] decode_RegFilePlugin_rs2Data;
  reg  lastStageRegFileWrite_valid /* verilator public */ ;
  wire [4:0] lastStageRegFileWrite_payload_address /* verilator public */ ;
  wire [31:0] lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg  _zz_155_;
  reg [31:0] execute_IntAluPlugin_bitwise;
  reg [31:0] _zz_156_;
  reg [31:0] _zz_157_;
  wire  _zz_158_;
  reg [19:0] _zz_159_;
  wire  _zz_160_;
  reg [19:0] _zz_161_;
  reg [31:0] _zz_162_;
  reg [31:0] execute_SrcPlugin_addSub;
  wire  execute_SrcPlugin_less;
  reg  execute_MulPlugin_aSigned;
  reg  execute_MulPlugin_bSigned;
  wire [31:0] execute_MulPlugin_a;
  wire [31:0] execute_MulPlugin_b;
  wire [15:0] execute_MulPlugin_aULow;
  wire [15:0] execute_MulPlugin_bULow;
  wire [16:0] execute_MulPlugin_aSLow;
  wire [16:0] execute_MulPlugin_bSLow;
  wire [16:0] execute_MulPlugin_aHigh;
  wire [16:0] execute_MulPlugin_bHigh;
  wire [65:0] writeBack_MulPlugin_result;
  reg [32:0] memory_DivPlugin_rs1;
  reg [31:0] memory_DivPlugin_rs2;
  reg [64:0] memory_DivPlugin_accumulator;
  wire  memory_DivPlugin_frontendOk;
  reg  memory_DivPlugin_div_needRevert;
  reg  memory_DivPlugin_div_counter_willIncrement;
  reg  memory_DivPlugin_div_counter_willClear;
  reg [5:0] memory_DivPlugin_div_counter_valueNext;
  reg [5:0] memory_DivPlugin_div_counter_value;
  wire  memory_DivPlugin_div_counter_willOverflowIfInc;
  wire  memory_DivPlugin_div_counter_willOverflow;
  reg  memory_DivPlugin_div_done;
  reg [31:0] memory_DivPlugin_div_result;
  wire [31:0] _zz_163_;
  wire [32:0] _zz_164_;
  wire [32:0] _zz_165_;
  wire [31:0] _zz_166_;
  wire  _zz_167_;
  wire  _zz_168_;
  reg [32:0] _zz_169_;
  reg  execute_LightShifterPlugin_isActive;
  wire  execute_LightShifterPlugin_isShift;
  reg [4:0] execute_LightShifterPlugin_amplitudeReg;
  wire [4:0] execute_LightShifterPlugin_amplitude;
  wire [31:0] execute_LightShifterPlugin_shiftInput;
  wire  execute_LightShifterPlugin_done;
  reg [31:0] _zz_170_;
  reg  _zz_171_;
  reg  _zz_172_;
  wire  _zz_173_;
  reg  _zz_174_;
  reg [4:0] _zz_175_;
  wire  execute_BranchPlugin_eq;
  wire [2:0] _zz_176_;
  reg  _zz_177_;
  reg  _zz_178_;
  wire [31:0] execute_BranchPlugin_branch_src1;
  wire  _zz_179_;
  reg [10:0] _zz_180_;
  wire  _zz_181_;
  reg [19:0] _zz_182_;
  wire  _zz_183_;
  reg [18:0] _zz_184_;
  reg [31:0] _zz_185_;
  wire [31:0] execute_BranchPlugin_branch_src2;
  wire [31:0] execute_BranchPlugin_branchAdder;
  reg  DebugPlugin_firstCycle;
  reg  DebugPlugin_secondCycle;
  reg  DebugPlugin_resetIt;
  reg  DebugPlugin_haltIt;
  reg  DebugPlugin_stepIt;
  reg  DebugPlugin_isPipBusy;
  reg  DebugPlugin_godmode;
  reg  DebugPlugin_haltedByBreak;
  reg [31:0] DebugPlugin_busReadDataReg;
  reg  _zz_186_;
  reg  _zz_187_;
  reg  DebugPlugin_resetIt_regNext;
  reg [31:0] memory_to_writeBack_MEMORY_READ_DATA;
  reg  decode_to_execute_IS_RS1_SIGNED;
  reg  decode_to_execute_CSR_WRITE_OPCODE;
  reg [31:0] decode_to_execute_FORMAL_PC_NEXT;
  reg [31:0] execute_to_memory_FORMAL_PC_NEXT;
  reg [31:0] memory_to_writeBack_FORMAL_PC_NEXT;
  reg  decode_to_execute_CSR_READ_OPCODE;
  reg  decode_to_execute_IS_DIV;
  reg  execute_to_memory_IS_DIV;
  reg  decode_to_execute_IS_CSR;
  reg `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg [51:0] memory_to_writeBack_MUL_LOW;
  reg [31:0] decode_to_execute_RS2;
  reg `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg [31:0] decode_to_execute_SRC1;
  reg [31:0] decode_to_execute_PC;
  reg [31:0] execute_to_memory_PC;
  reg [31:0] memory_to_writeBack_PC;
  reg `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg  decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg  decode_to_execute_IS_MUL;
  reg  execute_to_memory_IS_MUL;
  reg  memory_to_writeBack_IS_MUL;
  reg [31:0] execute_to_memory_REGFILE_WRITE_DATA;
  reg [31:0] memory_to_writeBack_REGFILE_WRITE_DATA;
  reg  decode_to_execute_SRC2_FORCE_ZERO;
  reg [33:0] execute_to_memory_MUL_HL;
  reg  decode_to_execute_MEMORY_ENABLE;
  reg  execute_to_memory_MEMORY_ENABLE;
  reg  memory_to_writeBack_MEMORY_ENABLE;
  reg  decode_to_execute_DO_EBREAK;
  reg [31:0] decode_to_execute_INSTRUCTION;
  reg [31:0] execute_to_memory_INSTRUCTION;
  reg [31:0] memory_to_writeBack_INSTRUCTION;
  reg [31:0] decode_to_execute_RS1;
  reg [31:0] execute_to_memory_BRANCH_CALC;
  reg  execute_to_memory_BRANCH_DO;
  reg [33:0] execute_to_memory_MUL_LH;
  reg  decode_to_execute_IS_RS2_SIGNED;
  reg `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg  decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg  execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg [33:0] execute_to_memory_MUL_HH;
  reg [33:0] memory_to_writeBack_MUL_HH;
  reg [31:0] execute_to_memory_MUL_LL;
  reg  decode_to_execute_REGFILE_WRITE_VALID;
  reg  execute_to_memory_REGFILE_WRITE_VALID;
  reg  memory_to_writeBack_REGFILE_WRITE_VALID;
  reg  decode_to_execute_MEMORY_STORE;
  reg  execute_to_memory_MEMORY_STORE;
  reg  memory_to_writeBack_MEMORY_STORE;
  reg [31:0] decode_to_execute_SRC2;
  reg  decode_to_execute_SRC_LESS_UNSIGNED;
  reg  decode_to_execute_SRC_USE_SUB_LESS;
  reg `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  reg `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  reg [1:0] execute_to_memory_MEMORY_ADDRESS_LOW;
  reg [1:0] memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg [2:0] _zz_188_;
  `ifndef SYNTHESIS
  reg [39:0] _zz_1__string;
  reg [39:0] _zz_2__string;
  reg [39:0] _zz_3__string;
  reg [39:0] _zz_4__string;
  reg [39:0] decode_ENV_CTRL_string;
  reg [39:0] _zz_5__string;
  reg [39:0] _zz_6__string;
  reg [39:0] _zz_7__string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_8__string;
  reg [63:0] _zz_9__string;
  reg [63:0] _zz_10__string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_11__string;
  reg [71:0] _zz_12__string;
  reg [71:0] _zz_13__string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_14__string;
  reg [39:0] _zz_15__string;
  reg [39:0] _zz_16__string;
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_17__string;
  reg [31:0] _zz_18__string;
  reg [31:0] _zz_19__string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_22__string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_24__string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_36__string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_39__string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_42__string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_44__string;
  reg [63:0] _zz_53__string;
  reg [71:0] _zz_55__string;
  reg [39:0] _zz_56__string;
  reg [95:0] _zz_59__string;
  reg [31:0] _zz_60__string;
  reg [39:0] _zz_63__string;
  reg [23:0] _zz_72__string;
  reg [39:0] memory_ENV_CTRL_string;
  reg [39:0] _zz_74__string;
  reg [39:0] execute_ENV_CTRL_string;
  reg [39:0] _zz_75__string;
  reg [39:0] writeBack_ENV_CTRL_string;
  reg [39:0] _zz_78__string;
  reg [23:0] _zz_148__string;
  reg [39:0] _zz_149__string;
  reg [31:0] _zz_150__string;
  reg [95:0] _zz_151__string;
  reg [39:0] _zz_152__string;
  reg [71:0] _zz_153__string;
  reg [63:0] _zz_154__string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [39:0] decode_to_execute_ENV_CTRL_string;
  reg [39:0] execute_to_memory_ENV_CTRL_string;
  reg [39:0] memory_to_writeBack_ENV_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;
  assign _zz_191_ = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_192_ = (execute_arbitration_isValid && execute_IS_CSR);
  assign _zz_193_ = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != (5'b00000)));
  assign _zz_194_ = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
  assign _zz_195_ = (! execute_arbitration_isStuckByOthers);
  assign _zz_196_ = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign _zz_197_ = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != (2'b00)) == 1'b0);
  assign _zz_198_ = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign _zz_199_ = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign _zz_200_ = (DebugPlugin_stepIt && IBusSimplePlugin_incomingInstruction);
  assign _zz_201_ = writeBack_INSTRUCTION[29 : 28];
  assign _zz_202_ = (IBusSimplePlugin_iBusRsp_output_valid && IBusSimplePlugin_iBusRsp_output_ready);
  assign _zz_203_ = ((! (((! IBusSimplePlugin_decompressor_isRvc) && (! IBusSimplePlugin_iBusRsp_output_payload_pc[1])) && (! IBusSimplePlugin_decompressor_bufferValid))) && (! ((IBusSimplePlugin_decompressor_isRvc && IBusSimplePlugin_iBusRsp_output_payload_pc[1]) && IBusSimplePlugin_decompressor_inputBeforeStage_ready)));
  assign _zz_204_ = (execute_CsrPlugin_illegalAccess || execute_CsrPlugin_illegalInstruction);
  assign _zz_205_ = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_ECALL));
  assign _zz_206_ = execute_INSTRUCTION[13 : 12];
  assign _zz_207_ = (memory_DivPlugin_frontendOk && (! memory_DivPlugin_div_done));
  assign _zz_208_ = (! memory_arbitration_isStuck);
  assign _zz_209_ = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign _zz_210_ = (1'b1 || (! 1'b1));
  assign _zz_211_ = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign _zz_212_ = (1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign _zz_213_ = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign _zz_214_ = (1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign _zz_215_ = debug_bus_cmd_payload_address[7 : 2];
  assign _zz_216_ = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < (2'b11)));
  assign _zz_217_ = ((_zz_138_ && 1'b1) && (! 1'b0));
  assign _zz_218_ = ((_zz_139_ && 1'b1) && (! 1'b0));
  assign _zz_219_ = ((_zz_140_ && 1'b1) && (! 1'b0));
  assign _zz_220_ = {_zz_98_[1 : 0],_zz_98_[15 : 13]};
  assign _zz_221_ = _zz_98_[6 : 5];
  assign _zz_222_ = _zz_98_[11 : 10];
  assign _zz_223_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_224_ = execute_INSTRUCTION[13];
  assign _zz_225_ = writeBack_INSTRUCTION[13 : 12];
  assign _zz_226_ = (_zz_88_ & (~ _zz_227_));
  assign _zz_227_ = (_zz_88_ - (2'b01));
  assign _zz_228_ = {IBusSimplePlugin_fetchPc_inc,(2'b00)};
  assign _zz_229_ = {29'd0, _zz_228_};
  assign _zz_230_ = (decode_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_231_ = {29'd0, _zz_230_};
  assign _zz_232_ = {{_zz_108_,_zz_98_[6 : 2]},(12'b000000000000)};
  assign _zz_233_ = {{{(4'b0000),_zz_98_[8 : 7]},_zz_98_[12 : 9]},(2'b00)};
  assign _zz_234_ = {{{(4'b0000),_zz_98_[8 : 7]},_zz_98_[12 : 9]},(2'b00)};
  assign _zz_235_ = (decode_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_236_ = {29'd0, _zz_235_};
  assign _zz_237_ = (IBusSimplePlugin_pendingCmd + _zz_239_);
  assign _zz_238_ = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign _zz_239_ = {2'd0, _zz_238_};
  assign _zz_240_ = iBus_rsp_valid;
  assign _zz_241_ = {2'd0, _zz_240_};
  assign _zz_242_ = (iBus_rsp_valid && (IBusSimplePlugin_rspJoin_discardCounter != (3'b000)));
  assign _zz_243_ = {2'd0, _zz_242_};
  assign _zz_244_ = _zz_141_[2 : 2];
  assign _zz_245_ = _zz_141_[4 : 4];
  assign _zz_246_ = _zz_141_[5 : 5];
  assign _zz_247_ = _zz_141_[6 : 6];
  assign _zz_248_ = _zz_141_[7 : 7];
  assign _zz_249_ = _zz_141_[8 : 8];
  assign _zz_250_ = _zz_141_[9 : 9];
  assign _zz_251_ = _zz_141_[10 : 10];
  assign _zz_252_ = _zz_141_[13 : 13];
  assign _zz_253_ = _zz_141_[14 : 14];
  assign _zz_254_ = _zz_141_[19 : 19];
  assign _zz_255_ = _zz_141_[20 : 20];
  assign _zz_256_ = _zz_141_[25 : 25];
  assign _zz_257_ = _zz_141_[28 : 28];
  assign _zz_258_ = _zz_141_[29 : 29];
  assign _zz_259_ = _zz_141_[30 : 30];
  assign _zz_260_ = execute_SRC_LESS;
  assign _zz_261_ = (decode_IS_RVC ? (3'b010) : (3'b100));
  assign _zz_262_ = decode_INSTRUCTION[19 : 15];
  assign _zz_263_ = decode_INSTRUCTION[31 : 20];
  assign _zz_264_ = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_265_ = ($signed(_zz_266_) + $signed(_zz_269_));
  assign _zz_266_ = ($signed(_zz_267_) + $signed(_zz_268_));
  assign _zz_267_ = execute_SRC1;
  assign _zz_268_ = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_269_ = (execute_SRC_USE_SUB_LESS ? _zz_270_ : _zz_271_);
  assign _zz_270_ = (32'b00000000000000000000000000000001);
  assign _zz_271_ = (32'b00000000000000000000000000000000);
  assign _zz_272_ = ($signed(_zz_273_) + $signed(_zz_278_));
  assign _zz_273_ = ($signed(_zz_274_) + $signed(_zz_276_));
  assign _zz_274_ = (52'b0000000000000000000000000000000000000000000000000000);
  assign _zz_275_ = {1'b0,memory_MUL_LL};
  assign _zz_276_ = {{19{_zz_275_[32]}}, _zz_275_};
  assign _zz_277_ = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_278_ = {{2{_zz_277_[49]}}, _zz_277_};
  assign _zz_279_ = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_280_ = {{2{_zz_279_[49]}}, _zz_279_};
  assign _zz_281_ = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_282_ = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_283_ = writeBack_MUL_LOW[31 : 0];
  assign _zz_284_ = writeBack_MulPlugin_result[63 : 32];
  assign _zz_285_ = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_286_ = {5'd0, _zz_285_};
  assign _zz_287_ = {1'd0, memory_DivPlugin_rs2};
  assign _zz_288_ = {_zz_163_,(! _zz_165_[32])};
  assign _zz_289_ = _zz_165_[31:0];
  assign _zz_290_ = _zz_164_[31:0];
  assign _zz_291_ = _zz_292_;
  assign _zz_292_ = _zz_293_;
  assign _zz_293_ = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_166_) : _zz_166_)} + _zz_295_);
  assign _zz_294_ = memory_DivPlugin_div_needRevert;
  assign _zz_295_ = {32'd0, _zz_294_};
  assign _zz_296_ = _zz_168_;
  assign _zz_297_ = {32'd0, _zz_296_};
  assign _zz_298_ = _zz_167_;
  assign _zz_299_ = {31'd0, _zz_298_};
  assign _zz_300_ = (_zz_301_ >>> 1);
  assign _zz_301_ = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_302_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_303_ = execute_INSTRUCTION[31 : 20];
  assign _zz_304_ = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_305_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_306_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_307_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_308_ = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_309_ = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_310_ = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_311_ = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_312_ = 1'b1;
  assign _zz_313_ = 1'b1;
  assign _zz_314_ = (_zz_98_[11 : 10] == (2'b01));
  assign _zz_315_ = ((_zz_98_[11 : 10] == (2'b11)) && (_zz_98_[6 : 5] == (2'b00)));
  assign _zz_316_ = (7'b0000000);
  assign _zz_317_ = _zz_98_[6 : 2];
  assign _zz_318_ = _zz_98_[12];
  assign _zz_319_ = _zz_98_[11 : 7];
  assign _zz_320_ = (32'b00000010000000000100000001110100);
  assign _zz_321_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001000100)) == (32'b00000000000000000000000001000000));
  assign _zz_322_ = ((decode_INSTRUCTION & _zz_329_) == (32'b00000000000000000010000000010000));
  assign _zz_323_ = ((decode_INSTRUCTION & _zz_330_) == (32'b01000000000000000000000000110000));
  assign _zz_324_ = {(_zz_331_ == _zz_332_),(_zz_333_ == _zz_334_)};
  assign _zz_325_ = (2'b00);
  assign _zz_326_ = (_zz_144_ != (1'b0));
  assign _zz_327_ = ({_zz_335_,_zz_336_} != (2'b00));
  assign _zz_328_ = {(_zz_337_ != _zz_338_),{_zz_339_,{_zz_340_,_zz_341_}}};
  assign _zz_329_ = (32'b00000000000000000010000000010100);
  assign _zz_330_ = (32'b01000000000000000100000000110100);
  assign _zz_331_ = (decode_INSTRUCTION & (32'b00000000000000000110000000000100));
  assign _zz_332_ = (32'b00000000000000000110000000000000);
  assign _zz_333_ = (decode_INSTRUCTION & (32'b00000000000000000101000000000100));
  assign _zz_334_ = (32'b00000000000000000100000000000000);
  assign _zz_335_ = ((decode_INSTRUCTION & _zz_342_) == (32'b00000000000000000010000000000000));
  assign _zz_336_ = ((decode_INSTRUCTION & _zz_343_) == (32'b00000000000000000001000000000000));
  assign _zz_337_ = {(_zz_344_ == _zz_345_),(_zz_346_ == _zz_347_)};
  assign _zz_338_ = (2'b00);
  assign _zz_339_ = ({_zz_348_,{_zz_349_,_zz_350_}} != (3'b000));
  assign _zz_340_ = (_zz_351_ != (1'b0));
  assign _zz_341_ = {(_zz_352_ != _zz_353_),{_zz_354_,{_zz_355_,_zz_356_}}};
  assign _zz_342_ = (32'b00000000000000000010000000010000);
  assign _zz_343_ = (32'b00000000000000000101000000000000);
  assign _zz_344_ = (decode_INSTRUCTION & (32'b00000000000000000111000000110100));
  assign _zz_345_ = (32'b00000000000000000101000000010000);
  assign _zz_346_ = (decode_INSTRUCTION & (32'b00000010000000000111000001100100));
  assign _zz_347_ = (32'b00000000000000000101000000100000);
  assign _zz_348_ = ((decode_INSTRUCTION & (32'b01000000000000000011000001010100)) == (32'b01000000000000000001000000010000));
  assign _zz_349_ = ((decode_INSTRUCTION & _zz_357_) == (32'b00000000000000000001000000010000));
  assign _zz_350_ = ((decode_INSTRUCTION & _zz_358_) == (32'b00000000000000000001000000010000));
  assign _zz_351_ = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000001000000000000));
  assign _zz_352_ = ((decode_INSTRUCTION & _zz_359_) == (32'b00000000000000000010000000000000));
  assign _zz_353_ = (1'b0);
  assign _zz_354_ = ({_zz_145_,{_zz_360_,_zz_361_}} != (6'b000000));
  assign _zz_355_ = (_zz_147_ != (1'b0));
  assign _zz_356_ = {(_zz_362_ != _zz_363_),{_zz_364_,{_zz_365_,_zz_366_}}};
  assign _zz_357_ = (32'b00000000000000000111000000110100);
  assign _zz_358_ = (32'b00000010000000000111000001010100);
  assign _zz_359_ = (32'b00000000000000000011000000000000);
  assign _zz_360_ = ((decode_INSTRUCTION & _zz_367_) == (32'b00000000000000000001000000010000));
  assign _zz_361_ = {(_zz_368_ == _zz_369_),{_zz_370_,{_zz_371_,_zz_372_}}};
  assign _zz_362_ = {(_zz_373_ == _zz_374_),_zz_146_};
  assign _zz_363_ = (2'b00);
  assign _zz_364_ = ({_zz_375_,_zz_146_} != (2'b00));
  assign _zz_365_ = ({_zz_376_,_zz_377_} != (2'b00));
  assign _zz_366_ = {(_zz_378_ != _zz_379_),{_zz_380_,{_zz_381_,_zz_382_}}};
  assign _zz_367_ = (32'b00000000000000000001000000010000);
  assign _zz_368_ = (decode_INSTRUCTION & (32'b00000000000000000010000000010000));
  assign _zz_369_ = (32'b00000000000000000010000000010000);
  assign _zz_370_ = ((decode_INSTRUCTION & _zz_383_) == (32'b00000000000000000000000000010000));
  assign _zz_371_ = (_zz_384_ == _zz_385_);
  assign _zz_372_ = (_zz_386_ == _zz_387_);
  assign _zz_373_ = (decode_INSTRUCTION & (32'b00000000000000000000000000010100));
  assign _zz_374_ = (32'b00000000000000000000000000000100);
  assign _zz_375_ = ((decode_INSTRUCTION & _zz_388_) == (32'b00000000000000000000000000000100));
  assign _zz_376_ = _zz_145_;
  assign _zz_377_ = (_zz_389_ == _zz_390_);
  assign _zz_378_ = (_zz_391_ == _zz_392_);
  assign _zz_379_ = (1'b0);
  assign _zz_380_ = ({_zz_393_,_zz_394_} != (5'b00000));
  assign _zz_381_ = (_zz_395_ != _zz_396_);
  assign _zz_382_ = {_zz_397_,{_zz_398_,_zz_399_}};
  assign _zz_383_ = (32'b00000000000000000000000001010000);
  assign _zz_384_ = (decode_INSTRUCTION & (32'b00000000000000000000000000001100));
  assign _zz_385_ = (32'b00000000000000000000000000000100);
  assign _zz_386_ = (decode_INSTRUCTION & (32'b00000000000000000000000000101000));
  assign _zz_387_ = (32'b00000000000000000000000000000000);
  assign _zz_388_ = (32'b00000000000000000000000001000100);
  assign _zz_389_ = (decode_INSTRUCTION & (32'b00000000000000000000000000011100));
  assign _zz_390_ = (32'b00000000000000000000000000000100);
  assign _zz_391_ = (decode_INSTRUCTION & (32'b00000000000000000000000001011000));
  assign _zz_392_ = (32'b00000000000000000000000001000000);
  assign _zz_393_ = ((decode_INSTRUCTION & _zz_400_) == (32'b00000000000000000000000001000000));
  assign _zz_394_ = {_zz_142_,{_zz_401_,{_zz_402_,_zz_403_}}};
  assign _zz_395_ = {(_zz_404_ == _zz_405_),{_zz_406_,_zz_407_}};
  assign _zz_396_ = (3'b000);
  assign _zz_397_ = ({_zz_408_,_zz_409_} != (2'b00));
  assign _zz_398_ = (_zz_410_ != (1'b0));
  assign _zz_399_ = {(_zz_411_ != _zz_412_),{_zz_413_,{_zz_414_,_zz_415_}}};
  assign _zz_400_ = (32'b00000000000000000000000001000000);
  assign _zz_401_ = ((decode_INSTRUCTION & _zz_416_) == (32'b00000000000000000100000000100000));
  assign _zz_402_ = _zz_143_;
  assign _zz_403_ = (_zz_417_ == _zz_418_);
  assign _zz_404_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_405_ = (32'b00000000000000000000000000100100);
  assign _zz_406_ = ((decode_INSTRUCTION & _zz_419_) == (32'b00000000000000000001000000010000));
  assign _zz_407_ = ((decode_INSTRUCTION & _zz_420_) == (32'b00000000000000000001000000010000));
  assign _zz_408_ = ((decode_INSTRUCTION & _zz_421_) == (32'b00010000000000000000000001010000));
  assign _zz_409_ = ((decode_INSTRUCTION & _zz_422_) == (32'b00000000000000000000000001010000));
  assign _zz_410_ = ((decode_INSTRUCTION & _zz_423_) == (32'b00000000000000000000000001010000));
  assign _zz_411_ = (_zz_424_ == _zz_425_);
  assign _zz_412_ = (1'b0);
  assign _zz_413_ = (_zz_426_ != (1'b0));
  assign _zz_414_ = (_zz_427_ != _zz_428_);
  assign _zz_415_ = {_zz_429_,{_zz_430_,_zz_431_}};
  assign _zz_416_ = (32'b00000000000000000100000000100000);
  assign _zz_417_ = (decode_INSTRUCTION & (32'b00000010000000000000000000100000));
  assign _zz_418_ = (32'b00000000000000000000000000100000);
  assign _zz_419_ = (32'b00000000000000000011000000110100);
  assign _zz_420_ = (32'b00000010000000000011000001010100);
  assign _zz_421_ = (32'b00010000001000000011000001010000);
  assign _zz_422_ = (32'b00010000000100000011000001010000);
  assign _zz_423_ = (32'b00000000000100000011000001010000);
  assign _zz_424_ = (decode_INSTRUCTION & (32'b00010000000100000011000001010000));
  assign _zz_425_ = (32'b00000000000100000000000001010000);
  assign _zz_426_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000100000));
  assign _zz_427_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001011000)) == (32'b00000000000000000000000000000000));
  assign _zz_428_ = (1'b0);
  assign _zz_429_ = ({(_zz_432_ == _zz_433_),(_zz_434_ == _zz_435_)} != (2'b00));
  assign _zz_430_ = ({_zz_436_,{_zz_437_,_zz_438_}} != (4'b0000));
  assign _zz_431_ = {({_zz_439_,_zz_440_} != (2'b00)),{(_zz_441_ != _zz_442_),{_zz_443_,{_zz_444_,_zz_445_}}}};
  assign _zz_432_ = (decode_INSTRUCTION & (32'b00000000000000000001000001010000));
  assign _zz_433_ = (32'b00000000000000000001000001010000);
  assign _zz_434_ = (decode_INSTRUCTION & (32'b00000000000000000010000001010000));
  assign _zz_435_ = (32'b00000000000000000010000001010000);
  assign _zz_436_ = ((decode_INSTRUCTION & _zz_446_) == (32'b00000000000000000000000000000000));
  assign _zz_437_ = (_zz_447_ == _zz_448_);
  assign _zz_438_ = {_zz_144_,_zz_449_};
  assign _zz_439_ = (_zz_450_ == _zz_451_);
  assign _zz_440_ = (_zz_452_ == _zz_453_);
  assign _zz_441_ = (_zz_454_ == _zz_455_);
  assign _zz_442_ = (1'b0);
  assign _zz_443_ = ({_zz_456_,_zz_457_} != (4'b0000));
  assign _zz_444_ = (_zz_458_ != _zz_459_);
  assign _zz_445_ = {_zz_460_,_zz_461_};
  assign _zz_446_ = (32'b00000000000000000000000001000100);
  assign _zz_447_ = (decode_INSTRUCTION & (32'b00000000000000000000000000011000));
  assign _zz_448_ = (32'b00000000000000000000000000000000);
  assign _zz_449_ = ((decode_INSTRUCTION & (32'b00000000000000000101000000000100)) == (32'b00000000000000000001000000000000));
  assign _zz_450_ = (decode_INSTRUCTION & (32'b00000000000000000000000000110100));
  assign _zz_451_ = (32'b00000000000000000000000000100000);
  assign _zz_452_ = (decode_INSTRUCTION & (32'b00000000000000000000000001100100));
  assign _zz_453_ = (32'b00000000000000000000000000100000);
  assign _zz_454_ = (decode_INSTRUCTION & (32'b00000010000000000100000001100100));
  assign _zz_455_ = (32'b00000010000000000100000000100000);
  assign _zz_456_ = ((decode_INSTRUCTION & _zz_462_) == (32'b00000000000000000010000001000000));
  assign _zz_457_ = {(_zz_463_ == _zz_464_),{_zz_465_,_zz_466_}};
  assign _zz_458_ = {_zz_142_,{_zz_143_,_zz_467_}};
  assign _zz_459_ = (3'b000);
  assign _zz_460_ = ({_zz_142_,_zz_468_} != (2'b00));
  assign _zz_461_ = ({_zz_142_,_zz_469_} != (2'b00));
  assign _zz_462_ = (32'b00000000000000000010000001000000);
  assign _zz_463_ = (decode_INSTRUCTION & (32'b00000000000000000001000001000000));
  assign _zz_464_ = (32'b00000000000000000001000001000000);
  assign _zz_465_ = ((decode_INSTRUCTION & (32'b00000000000100000000000001000000)) == (32'b00000000000000000000000001000000));
  assign _zz_466_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001010000)) == (32'b00000000000000000000000001000000));
  assign _zz_467_ = ((decode_INSTRUCTION & (32'b00000010000000000000000001100000)) == (32'b00000000000000000000000000100000));
  assign _zz_468_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001110000)) == (32'b00000000000000000000000000100000));
  assign _zz_469_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000100000)) == (32'b00000000000000000000000000000000));
  always @ (posedge io_mainClk) begin
    if(_zz_47_) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_312_) begin
      _zz_189_ <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_313_) begin
      _zz_190_ <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rspJoin_rspBuffer_c ( 
    .io_push_valid(iBus_rsp_takeWhen_valid),
    .io_push_ready(IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready),
    .io_push_payload_error(iBus_rsp_takeWhen_payload_error),
    .io_push_payload_inst(iBus_rsp_takeWhen_payload_inst),
    .io_pop_valid(IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid),
    .io_pop_ready(IBusSimplePlugin_rspJoin_rspBufferOutput_ready),
    .io_pop_payload_error(IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error),
    .io_pop_payload_inst(IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst),
    .io_flush(IBusSimplePlugin_fetcherflushIt),
    .io_occupancy(IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(_zz_1_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_1__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_1__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_1__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_1__string = "ECALL";
      default : _zz_1__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_2_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_2__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_2__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_2__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_2__string = "ECALL";
      default : _zz_2__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_3_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_3__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_3__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_3__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_3__string = "ECALL";
      default : _zz_3__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_4_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_4__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_4__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_4__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_4__string = "ECALL";
      default : _zz_4__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : decode_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : decode_ENV_CTRL_string = "ECALL";
      default : decode_ENV_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_5_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_5__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_5__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_5__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_5__string = "ECALL";
      default : _zz_5__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_6_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_6__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_6__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_6__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_6__string = "ECALL";
      default : _zz_6__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_7_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_7__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_7__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_7__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_7__string = "ECALL";
      default : _zz_7__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_ALU_CTRL_string = "BITWISE ";
      default : decode_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_8_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_8__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_8__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_8__string = "BITWISE ";
      default : _zz_8__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_9_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_9__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_9__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_9__string = "BITWISE ";
      default : _zz_9__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_10_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_10__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_10__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_10__string = "BITWISE ";
      default : _zz_10__string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_11_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_11__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_11__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_11__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_11__string = "SRA_1    ";
      default : _zz_11__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_12_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_12__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_12__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_12__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_12__string = "SRA_1    ";
      default : _zz_12__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_13_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_13__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_13__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_13__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_13__string = "SRA_1    ";
      default : _zz_13__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_14_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_14__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_14__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_14__string = "AND_1";
      default : _zz_14__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_15_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_15__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_15__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_15__string = "AND_1";
      default : _zz_15__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_16_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_16__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_16__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_16__string = "AND_1";
      default : _zz_16__string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_BRANCH_CTRL_string = "JALR";
      default : decode_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_17_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_17__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_17__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_17__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_17__string = "JALR";
      default : _zz_17__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_18_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_18__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_18__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_18__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_18__string = "JALR";
      default : _zz_18__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_19_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_19__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_19__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_19__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_19__string = "JALR";
      default : _zz_19__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : execute_BRANCH_CTRL_string = "JALR";
      default : execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_22_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_22__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_22__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_22__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_22__string = "JALR";
      default : _zz_22__string = "????";
    endcase
  end
  always @(*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : execute_SHIFT_CTRL_string = "SRA_1    ";
      default : execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_24_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_24__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_24__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_24__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_24__string = "SRA_1    ";
      default : _zz_24__string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : decode_SRC2_CTRL_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : decode_SRC2_CTRL_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : decode_SRC2_CTRL_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : decode_SRC2_CTRL_string = "PC ";
      default : decode_SRC2_CTRL_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_36_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_36__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_36__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_36__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_36__string = "PC ";
      default : _zz_36__string = "???";
    endcase
  end
  always @(*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : decode_SRC1_CTRL_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : decode_SRC1_CTRL_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : decode_SRC1_CTRL_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : decode_SRC1_CTRL_string = "URS1        ";
      default : decode_SRC1_CTRL_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_39_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_39__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_39__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_39__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_39__string = "URS1        ";
      default : _zz_39__string = "????????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : execute_ALU_CTRL_string = "BITWISE ";
      default : execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_42_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_42__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_42__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_42__string = "BITWISE ";
      default : _zz_42__string = "????????";
    endcase
  end
  always @(*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_44_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_44__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_44__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_44__string = "AND_1";
      default : _zz_44__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_53_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_53__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_53__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_53__string = "BITWISE ";
      default : _zz_53__string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_55_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_55__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_55__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_55__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_55__string = "SRA_1    ";
      default : _zz_55__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_56_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_56__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_56__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_56__string = "AND_1";
      default : _zz_56__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_59_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_59__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_59__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_59__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_59__string = "URS1        ";
      default : _zz_59__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_60_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_60__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_60__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_60__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_60__string = "JALR";
      default : _zz_60__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_63_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_63__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_63__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_63__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_63__string = "ECALL";
      default : _zz_63__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_72_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_72__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_72__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_72__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_72__string = "PC ";
      default : _zz_72__string = "???";
    endcase
  end
  always @(*) begin
    case(memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : memory_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : memory_ENV_CTRL_string = "ECALL";
      default : memory_ENV_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_74_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_74__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_74__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_74__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_74__string = "ECALL";
      default : _zz_74__string = "?????";
    endcase
  end
  always @(*) begin
    case(execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : execute_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : execute_ENV_CTRL_string = "ECALL";
      default : execute_ENV_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_75_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_75__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_75__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_75__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_75__string = "ECALL";
      default : _zz_75__string = "?????";
    endcase
  end
  always @(*) begin
    case(writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : writeBack_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : writeBack_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : writeBack_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : writeBack_ENV_CTRL_string = "ECALL";
      default : writeBack_ENV_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_78_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_78__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_78__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_78__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_78__string = "ECALL";
      default : _zz_78__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_148_)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_148__string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_148__string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_148__string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_148__string = "PC ";
      default : _zz_148__string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_149_)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_149__string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_149__string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_149__string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_149__string = "ECALL";
      default : _zz_149__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_150_)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_150__string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_150__string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_150__string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_150__string = "JALR";
      default : _zz_150__string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_151_)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_151__string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_151__string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_151__string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_151__string = "URS1        ";
      default : _zz_151__string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_152_)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_152__string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_152__string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_152__string = "AND_1";
      default : _zz_152__string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_153_)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_153__string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_153__string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_153__string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_153__string = "SRA_1    ";
      default : _zz_153__string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_154_)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_154__string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_154__string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_154__string = "BITWISE ";
      default : _zz_154__string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : decode_to_execute_ALU_BITWISE_CTRL_string = "AND_1";
      default : decode_to_execute_ALU_BITWISE_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : decode_to_execute_SHIFT_CTRL_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : decode_to_execute_SHIFT_CTRL_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : decode_to_execute_SHIFT_CTRL_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : decode_to_execute_SHIFT_CTRL_string = "SRA_1    ";
      default : decode_to_execute_SHIFT_CTRL_string = "?????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
    endcase
  end
  always @(*) begin
    case(decode_to_execute_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : decode_to_execute_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : decode_to_execute_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : decode_to_execute_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : decode_to_execute_ENV_CTRL_string = "ECALL";
      default : decode_to_execute_ENV_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(execute_to_memory_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : execute_to_memory_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : execute_to_memory_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : execute_to_memory_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : execute_to_memory_ENV_CTRL_string = "ECALL";
      default : execute_to_memory_ENV_CTRL_string = "?????";
    endcase
  end
  always @(*) begin
    case(memory_to_writeBack_ENV_CTRL)
      `EnvCtrlEnum_defaultEncoding_NONE : memory_to_writeBack_ENV_CTRL_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : memory_to_writeBack_ENV_CTRL_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : memory_to_writeBack_ENV_CTRL_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : memory_to_writeBack_ENV_CTRL_string = "ECALL";
      default : memory_to_writeBack_ENV_CTRL_string = "?????";
    endcase
  end
  `endif

  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = _zz_81_;
  assign _zz_1_ = _zz_2_;
  assign _zz_3_ = _zz_4_;
  assign decode_ENV_CTRL = _zz_5_;
  assign _zz_6_ = _zz_7_;
  assign decode_SRC_LESS_UNSIGNED = _zz_54_;
  assign decode_SRC2 = _zz_37_;
  assign decode_MEMORY_STORE = _zz_65_;
  assign execute_MUL_LL = _zz_30_;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = _zz_27_;
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_61_;
  assign decode_ALU_CTRL = _zz_8_;
  assign _zz_9_ = _zz_10_;
  assign decode_IS_RS2_SIGNED = _zz_58_;
  assign execute_MUL_LH = _zz_29_;
  assign execute_BRANCH_DO = _zz_23_;
  assign execute_BRANCH_CALC = _zz_21_;
  assign decode_RS1 = _zz_49_;
  assign decode_DO_EBREAK = _zz_20_;
  assign decode_MEMORY_ENABLE = _zz_66_;
  assign execute_MUL_HL = _zz_28_;
  assign decode_SRC2_FORCE_ZERO = _zz_41_;
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_43_;
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_50_;
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_71_;
  assign decode_SHIFT_CTRL = _zz_11_;
  assign _zz_12_ = _zz_13_;
  assign memory_PC = execute_to_memory_PC;
  assign decode_SRC1 = _zz_40_;
  assign decode_ALU_BITWISE_CTRL = _zz_14_;
  assign _zz_15_ = _zz_16_;
  assign decode_RS2 = _zz_48_;
  assign memory_MUL_LOW = _zz_26_;
  assign decode_BRANCH_CTRL = _zz_17_;
  assign _zz_18_ = _zz_19_;
  assign decode_IS_CSR = _zz_67_;
  assign decode_IS_DIV = _zz_70_;
  assign decode_CSR_READ_OPCODE = _zz_76_;
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = _zz_83_;
  assign decode_CSR_WRITE_OPCODE = _zz_77_;
  assign decode_IS_RS1_SIGNED = _zz_52_;
  assign memory_MEMORY_READ_DATA = _zz_80_;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_64_;
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_BRANCH_CTRL = _zz_22_;
  assign decode_RS2_USE = _zz_69_;
  assign decode_RS1_USE = _zz_68_;
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_SHIFT_CTRL = _zz_24_;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  always @ (*) begin
    _zz_25_ = memory_REGFILE_WRITE_DATA;
    if(_zz_191_)begin
      _zz_25_ = memory_DivPlugin_div_result;
    end
  end

  assign memory_INSTRUCTION = execute_to_memory_INSTRUCTION;
  assign memory_IS_DIV = execute_to_memory_IS_DIV;
  assign writeBack_IS_MUL = memory_to_writeBack_IS_MUL;
  assign writeBack_MUL_HH = memory_to_writeBack_MUL_HH;
  assign writeBack_MUL_LOW = memory_to_writeBack_MUL_LOW;
  assign memory_MUL_HL = execute_to_memory_MUL_HL;
  assign memory_MUL_LH = execute_to_memory_MUL_LH;
  assign memory_MUL_LL = execute_to_memory_MUL_LL;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_34_ = decode_PC;
  assign _zz_35_ = decode_RS2;
  assign decode_SRC2_CTRL = _zz_36_;
  assign _zz_38_ = decode_RS1;
  assign decode_SRC1_CTRL = _zz_39_;
  assign decode_SRC_USE_SUB_LESS = _zz_51_;
  assign decode_SRC_ADD_ZERO = _zz_62_;
  assign execute_SRC_ADD_SUB = _zz_33_;
  assign execute_SRC_LESS = _zz_31_;
  assign execute_ALU_CTRL = _zz_42_;
  assign execute_SRC2 = decode_to_execute_SRC2;
  assign execute_ALU_BITWISE_CTRL = _zz_44_;
  assign _zz_45_ = writeBack_INSTRUCTION;
  assign _zz_46_ = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_47_ = 1'b0;
    if(lastStageRegFileWrite_valid)begin
      _zz_47_ = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = _zz_87_;
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_57_;
    if((decode_INSTRUCTION[11 : 7] == (5'b00000)))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @ (*) begin
    _zz_73_ = execute_REGFILE_WRITE_DATA;
    if(_zz_192_)begin
      _zz_73_ = execute_CsrPlugin_readData;
    end
    if(_zz_193_)begin
      _zz_73_ = _zz_170_;
    end
  end

  assign execute_SRC1 = decode_to_execute_SRC1;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_74_;
  assign execute_ENV_CTRL = _zz_75_;
  assign writeBack_ENV_CTRL = _zz_78_;
  assign writeBack_MEMORY_STORE = memory_to_writeBack_MEMORY_STORE;
  always @ (*) begin
    _zz_79_ = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_79_ = writeBack_DBusSimplePlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_225_)
        2'b00 : begin
          _zz_79_ = _zz_283_;
        end
        default : begin
          _zz_79_ = _zz_284_;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_MEMORY_STORE = execute_to_memory_MEMORY_STORE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_SRC_ADD = _zz_32_;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = 1'b0;
  always @ (*) begin
    _zz_82_ = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid)begin
      _zz_82_ = BranchPlugin_jumpInterface_payload;
    end
  end

  assign decode_PC = _zz_86_;
  assign decode_INSTRUCTION = _zz_85_;
  assign decode_IS_RVC = _zz_84_;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    case(_zz_188_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      3'b011 : begin
      end
      3'b100 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts))begin
      decode_arbitration_haltByOther = decode_arbitration_isValid;
    end
    if(({(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))}} != (3'b000)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if((decode_arbitration_isValid && (_zz_171_ || _zz_172_)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(_zz_187_)begin
      decode_arbitration_removeIt = 1'b1;
    end
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  assign decode_arbitration_flushNext = 1'b0;
  always @ (*) begin
    execute_arbitration_haltItself = 1'b0;
    if(((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_131_)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_194_)begin
      if((! execute_CsrPlugin_wfiWake))begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_192_)begin
      if(execute_CsrPlugin_blockedBySideEffects)begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_193_)begin
      if(_zz_195_)begin
        if(! execute_LightShifterPlugin_done) begin
          execute_arbitration_haltItself = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(_zz_196_)begin
      execute_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_removeIt = 1'b0;
    if(CsrPlugin_selfException_valid)begin
      execute_arbitration_removeIt = 1'b1;
    end
    if(execute_arbitration_isFlushed)begin
      execute_arbitration_removeIt = 1'b1;
    end
  end

  always @ (*) begin
    execute_arbitration_flushIt = 1'b0;
    if(_zz_196_)begin
      if(_zz_197_)begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @ (*) begin
    execute_arbitration_flushNext = 1'b0;
    if(CsrPlugin_selfException_valid)begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(_zz_196_)begin
      if(_zz_197_)begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
  end

  always @ (*) begin
    memory_arbitration_haltItself = 1'b0;
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_MEMORY_STORE)) && ((! dBus_rsp_ready) || 1'b0)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(_zz_191_)begin
      if(((! memory_DivPlugin_frontendOk) || (! memory_DivPlugin_div_done)))begin
        memory_arbitration_haltItself = 1'b1;
      end
    end
  end

  assign memory_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    memory_arbitration_removeIt = 1'b0;
    if(memory_arbitration_isFlushed)begin
      memory_arbitration_removeIt = 1'b1;
    end
  end

  assign memory_arbitration_flushIt = 1'b0;
  always @ (*) begin
    memory_arbitration_flushNext = 1'b0;
    if(BranchPlugin_jumpInterface_valid)begin
      memory_arbitration_flushNext = 1'b1;
    end
  end

  assign writeBack_arbitration_haltItself = 1'b0;
  assign writeBack_arbitration_haltByOther = 1'b0;
  always @ (*) begin
    writeBack_arbitration_removeIt = 1'b0;
    if(writeBack_arbitration_isFlushed)begin
      writeBack_arbitration_removeIt = 1'b1;
    end
  end

  assign writeBack_arbitration_flushIt = 1'b0;
  always @ (*) begin
    writeBack_arbitration_flushNext = 1'b0;
    if(_zz_198_)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(_zz_199_)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @ (*) begin
    IBusSimplePlugin_fetcherHalt = 1'b0;
    if(({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != (4'b0000)))begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_198_)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_199_)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_196_)begin
      if(_zz_197_)begin
        IBusSimplePlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_200_)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetcherflushIt = 1'b0;
    if(({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != (4'b0000)))begin
      IBusSimplePlugin_fetcherflushIt = 1'b1;
    end
    if(_zz_196_)begin
      if(_zz_197_)begin
        IBusSimplePlugin_fetcherflushIt = 1'b1;
      end
    end
  end

  always @ (*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if((IBusSimplePlugin_iBusRsp_stages_1_input_valid || IBusSimplePlugin_iBusRsp_stages_2_input_valid))begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if((IBusSimplePlugin_decompressor_bufferValid && (IBusSimplePlugin_decompressor_bufferData[1 : 0] != (2'b11))))begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(_zz_198_)begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(_zz_199_)begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_jumpInterface_payload = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    if(_zz_198_)begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,(2'b00)};
    end
    if(_zz_199_)begin
      case(_zz_201_)
        2'b11 : begin
          CsrPlugin_jumpInterface_payload = CsrPlugin_mepc;
        end
        default : begin
        end
      endcase
    end
  end

  always @ (*) begin
    CsrPlugin_forceMachineWire = 1'b0;
    if(DebugPlugin_godmode)begin
      CsrPlugin_forceMachineWire = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_allowInterrupts = 1'b1;
    if((DebugPlugin_haltIt || DebugPlugin_stepIt))begin
      CsrPlugin_allowInterrupts = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_allowException = 1'b1;
    if(DebugPlugin_godmode)begin
      CsrPlugin_allowException = 1'b0;
    end
  end

  assign IBusSimplePlugin_jump_pcLoad_valid = ({BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid} != (2'b00));
  assign _zz_88_ = {BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid};
  assign IBusSimplePlugin_jump_pcLoad_payload = (_zz_226_[0] ? CsrPlugin_jumpInterface_payload : BranchPlugin_jumpInterface_payload);
  always @ (*) begin
    IBusSimplePlugin_fetchPc_corrected = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_corrected = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready)begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_229_);
    if(IBusSimplePlugin_fetchPc_inc)begin
      IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
    end
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
  end

  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  assign IBusSimplePlugin_decodePc_pcPlus = (IBusSimplePlugin_decodePc_pcReg + _zz_231_);
  always @ (*) begin
    IBusSimplePlugin_decodePc_injectedDecode = 1'b0;
    if((_zz_188_ != (3'b000)))begin
      IBusSimplePlugin_decodePc_injectedDecode = 1'b1;
    end
  end

  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  assign IBusSimplePlugin_iBusRsp_stages_0_inputSample = 1'b1;
  assign IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
  assign _zz_89_ = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && _zz_89_);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_89_);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
    if((IBusSimplePlugin_iBusRsp_stages_1_input_valid && ((! IBusSimplePlugin_cmd_valid) || (! IBusSimplePlugin_cmd_ready))))begin
      IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_90_ = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && _zz_90_);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_90_);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_2_halt = 1'b0;
  assign _zz_91_ = (! IBusSimplePlugin_iBusRsp_stages_2_halt);
  assign IBusSimplePlugin_iBusRsp_stages_2_input_ready = (IBusSimplePlugin_iBusRsp_stages_2_output_ready && _zz_91_);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_valid = (IBusSimplePlugin_iBusRsp_stages_2_input_valid && _zz_91_);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_payload = IBusSimplePlugin_iBusRsp_stages_2_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = _zz_92_;
  assign _zz_92_ = ((1'b0 && (! _zz_93_)) || IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign _zz_93_ = _zz_94_;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_93_;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! _zz_95_)) || IBusSimplePlugin_iBusRsp_stages_2_input_ready);
  assign _zz_95_ = _zz_96_;
  assign IBusSimplePlugin_iBusRsp_stages_2_input_valid = _zz_95_;
  assign IBusSimplePlugin_iBusRsp_stages_2_input_payload = _zz_97_;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if((IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isRvc))begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_decompressor_raw = (IBusSimplePlugin_decompressor_bufferValid ? {IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[15 : 0],IBusSimplePlugin_decompressor_bufferData} : {IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[31 : 16],(IBusSimplePlugin_iBusRsp_output_payload_pc[1] ? IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[31 : 16] : IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[15 : 0])});
  assign IBusSimplePlugin_decompressor_isRvc = (IBusSimplePlugin_decompressor_raw[1 : 0] != (2'b11));
  assign _zz_98_ = IBusSimplePlugin_decompressor_raw[15 : 0];
  always @ (*) begin
    IBusSimplePlugin_decompressor_decompressed = (32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    case(_zz_220_)
      5'b00000 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{{(2'b00),_zz_98_[10 : 7]},_zz_98_[12 : 11]},_zz_98_[5]},_zz_98_[6]},(2'b00)},(5'b00010)},(3'b000)},_zz_100_},(7'b0010011)};
      end
      5'b00010 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_101_,_zz_99_},(3'b010)},_zz_100_},(7'b0000011)};
      end
      5'b00110 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_101_[11 : 5],_zz_100_},_zz_99_},(3'b010)},_zz_101_[4 : 0]},(7'b0100011)};
      end
      5'b01000 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_103_,_zz_98_[11 : 7]},(3'b000)},_zz_98_[11 : 7]},(7'b0010011)};
      end
      5'b01001 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_106_[20],_zz_106_[10 : 1]},_zz_106_[11]},_zz_106_[19 : 12]},_zz_118_},(7'b1101111)};
      end
      5'b01010 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_103_,(5'b00000)},(3'b000)},_zz_98_[11 : 7]},(7'b0010011)};
      end
      5'b01011 : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_98_[11 : 7] == (5'b00010)) ? {{{{{{{{{_zz_110_,_zz_98_[4 : 3]},_zz_98_[5]},_zz_98_[2]},_zz_98_[6]},(4'b0000)},_zz_98_[11 : 7]},(3'b000)},_zz_98_[11 : 7]},(7'b0010011)} : {{_zz_232_[31 : 12],_zz_98_[11 : 7]},(7'b0110111)});
      end
      5'b01100 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{((_zz_98_[11 : 10] == (2'b10)) ? _zz_124_ : {{(1'b0),(_zz_314_ || _zz_315_)},(5'b00000)}),(((! _zz_98_[11]) || _zz_120_) ? _zz_98_[6 : 2] : _zz_100_)},_zz_99_},_zz_122_},_zz_99_},(_zz_120_ ? (7'b0010011) : (7'b0110011))};
      end
      5'b01101 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_113_[20],_zz_113_[10 : 1]},_zz_113_[11]},_zz_113_[19 : 12]},_zz_117_},(7'b1101111)};
      end
      5'b01110 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_116_[12],_zz_116_[10 : 5]},_zz_117_},_zz_99_},(3'b000)},_zz_116_[4 : 1]},_zz_116_[11]},(7'b1100011)};
      end
      5'b01111 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_116_[12],_zz_116_[10 : 5]},_zz_117_},_zz_99_},(3'b001)},_zz_116_[4 : 1]},_zz_116_[11]},(7'b1100011)};
      end
      5'b10000 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{(7'b0000000),_zz_98_[6 : 2]},_zz_98_[11 : 7]},(3'b001)},_zz_98_[11 : 7]},(7'b0010011)};
      end
      5'b10010 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{(4'b0000),_zz_98_[3 : 2]},_zz_98_[12]},_zz_98_[6 : 4]},(2'b00)},_zz_119_},(3'b010)},_zz_98_[11 : 7]},(7'b0000011)};
      end
      5'b10100 : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_98_[12 : 2] == (11'b10000000000)) ? (32'b00000000000100000000000001110011) : ((_zz_98_[6 : 2] == (5'b00000)) ? {{{{(12'b000000000000),_zz_98_[11 : 7]},(3'b000)},(_zz_98_[12] ? _zz_118_ : _zz_117_)},(7'b1100111)} : {{{{{_zz_316_,_zz_317_},(_zz_318_ ? _zz_319_ : _zz_117_)},(3'b000)},_zz_98_[11 : 7]},(7'b0110011)}));
      end
      5'b10110 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_233_[11 : 5],_zz_98_[6 : 2]},_zz_119_},(3'b010)},_zz_234_[4 : 0]},(7'b0100011)};
      end
      default : begin
      end
    endcase
  end

  assign _zz_99_ = {(2'b01),_zz_98_[9 : 7]};
  assign _zz_100_ = {(2'b01),_zz_98_[4 : 2]};
  assign _zz_101_ = {{{{(5'b00000),_zz_98_[5]},_zz_98_[12 : 10]},_zz_98_[6]},(2'b00)};
  assign _zz_102_ = _zz_98_[12];
  always @ (*) begin
    _zz_103_[11] = _zz_102_;
    _zz_103_[10] = _zz_102_;
    _zz_103_[9] = _zz_102_;
    _zz_103_[8] = _zz_102_;
    _zz_103_[7] = _zz_102_;
    _zz_103_[6] = _zz_102_;
    _zz_103_[5] = _zz_102_;
    _zz_103_[4 : 0] = _zz_98_[6 : 2];
  end

  assign _zz_104_ = _zz_98_[12];
  always @ (*) begin
    _zz_105_[9] = _zz_104_;
    _zz_105_[8] = _zz_104_;
    _zz_105_[7] = _zz_104_;
    _zz_105_[6] = _zz_104_;
    _zz_105_[5] = _zz_104_;
    _zz_105_[4] = _zz_104_;
    _zz_105_[3] = _zz_104_;
    _zz_105_[2] = _zz_104_;
    _zz_105_[1] = _zz_104_;
    _zz_105_[0] = _zz_104_;
  end

  assign _zz_106_ = {{{{{{{{_zz_105_,_zz_98_[8]},_zz_98_[10 : 9]},_zz_98_[6]},_zz_98_[7]},_zz_98_[2]},_zz_98_[11]},_zz_98_[5 : 3]},(1'b0)};
  assign _zz_107_ = _zz_98_[12];
  always @ (*) begin
    _zz_108_[14] = _zz_107_;
    _zz_108_[13] = _zz_107_;
    _zz_108_[12] = _zz_107_;
    _zz_108_[11] = _zz_107_;
    _zz_108_[10] = _zz_107_;
    _zz_108_[9] = _zz_107_;
    _zz_108_[8] = _zz_107_;
    _zz_108_[7] = _zz_107_;
    _zz_108_[6] = _zz_107_;
    _zz_108_[5] = _zz_107_;
    _zz_108_[4] = _zz_107_;
    _zz_108_[3] = _zz_107_;
    _zz_108_[2] = _zz_107_;
    _zz_108_[1] = _zz_107_;
    _zz_108_[0] = _zz_107_;
  end

  assign _zz_109_ = _zz_98_[12];
  always @ (*) begin
    _zz_110_[2] = _zz_109_;
    _zz_110_[1] = _zz_109_;
    _zz_110_[0] = _zz_109_;
  end

  assign _zz_111_ = _zz_98_[12];
  always @ (*) begin
    _zz_112_[9] = _zz_111_;
    _zz_112_[8] = _zz_111_;
    _zz_112_[7] = _zz_111_;
    _zz_112_[6] = _zz_111_;
    _zz_112_[5] = _zz_111_;
    _zz_112_[4] = _zz_111_;
    _zz_112_[3] = _zz_111_;
    _zz_112_[2] = _zz_111_;
    _zz_112_[1] = _zz_111_;
    _zz_112_[0] = _zz_111_;
  end

  assign _zz_113_ = {{{{{{{{_zz_112_,_zz_98_[8]},_zz_98_[10 : 9]},_zz_98_[6]},_zz_98_[7]},_zz_98_[2]},_zz_98_[11]},_zz_98_[5 : 3]},(1'b0)};
  assign _zz_114_ = _zz_98_[12];
  always @ (*) begin
    _zz_115_[4] = _zz_114_;
    _zz_115_[3] = _zz_114_;
    _zz_115_[2] = _zz_114_;
    _zz_115_[1] = _zz_114_;
    _zz_115_[0] = _zz_114_;
  end

  assign _zz_116_ = {{{{{_zz_115_,_zz_98_[6 : 5]},_zz_98_[2]},_zz_98_[11 : 10]},_zz_98_[4 : 3]},(1'b0)};
  assign _zz_117_ = (5'b00000);
  assign _zz_118_ = (5'b00001);
  assign _zz_119_ = (5'b00010);
  assign _zz_120_ = (_zz_98_[11 : 10] != (2'b11));
  always @ (*) begin
    case(_zz_221_)
      2'b00 : begin
        _zz_121_ = (3'b000);
      end
      2'b01 : begin
        _zz_121_ = (3'b100);
      end
      2'b10 : begin
        _zz_121_ = (3'b110);
      end
      default : begin
        _zz_121_ = (3'b111);
      end
    endcase
  end

  always @ (*) begin
    case(_zz_222_)
      2'b00 : begin
        _zz_122_ = (3'b101);
      end
      2'b01 : begin
        _zz_122_ = (3'b101);
      end
      2'b10 : begin
        _zz_122_ = (3'b111);
      end
      default : begin
        _zz_122_ = _zz_121_;
      end
    endcase
  end

  assign _zz_123_ = _zz_98_[12];
  always @ (*) begin
    _zz_124_[6] = _zz_123_;
    _zz_124_[5] = _zz_123_;
    _zz_124_[4] = _zz_123_;
    _zz_124_[3] = _zz_123_;
    _zz_124_[2] = _zz_123_;
    _zz_124_[1] = _zz_123_;
    _zz_124_[0] = _zz_123_;
  end

  assign IBusSimplePlugin_decompressor_inputBeforeStage_valid = (IBusSimplePlugin_decompressor_isRvc ? (IBusSimplePlugin_decompressor_bufferValid || IBusSimplePlugin_iBusRsp_output_valid) : (IBusSimplePlugin_iBusRsp_output_valid && (IBusSimplePlugin_decompressor_bufferValid || (! IBusSimplePlugin_iBusRsp_output_payload_pc[1]))));
  assign IBusSimplePlugin_decompressor_inputBeforeStage_payload_pc = IBusSimplePlugin_iBusRsp_output_payload_pc;
  assign IBusSimplePlugin_decompressor_inputBeforeStage_payload_isRvc = IBusSimplePlugin_decompressor_isRvc;
  assign IBusSimplePlugin_decompressor_inputBeforeStage_payload_rsp_inst = (IBusSimplePlugin_decompressor_isRvc ? IBusSimplePlugin_decompressor_decompressed : IBusSimplePlugin_decompressor_raw);
  assign IBusSimplePlugin_iBusRsp_output_ready = ((! IBusSimplePlugin_decompressor_inputBeforeStage_valid) || (! (((! IBusSimplePlugin_decompressor_inputBeforeStage_ready) || ((IBusSimplePlugin_decompressor_isRvc && (! IBusSimplePlugin_iBusRsp_output_payload_pc[1])) && (IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[17 : 16] != (2'b11)))) || (((! IBusSimplePlugin_decompressor_isRvc) && IBusSimplePlugin_decompressor_bufferValid) && (IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[17 : 16] != (2'b11))))));
  always @ (*) begin
    IBusSimplePlugin_decompressor_bufferFill = 1'b0;
    if(_zz_202_)begin
      if(_zz_203_)begin
        IBusSimplePlugin_decompressor_bufferFill = 1'b1;
      end
    end
  end

  assign IBusSimplePlugin_decompressor_inputBeforeStage_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_125_;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_126_;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_127_;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_128_;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_129_;
  assign _zz_87_ = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusSimplePlugin_decompressor_inputBeforeStage_payload_rsp_inst);
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_0;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_1;
  assign IBusSimplePlugin_pcValids_2 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_pcValids_3 = IBusSimplePlugin_injector_nextPcCalc_valids_3;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @ (*) begin
    decode_arbitration_isValid = (IBusSimplePlugin_injector_decodeInput_valid && (! IBusSimplePlugin_injector_decodeRemoved));
    case(_zz_188_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b100 : begin
      end
      default : begin
      end
    endcase
  end

  assign _zz_86_ = IBusSimplePlugin_decodePc_pcReg;
  assign _zz_85_ = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign _zz_84_ = IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign _zz_83_ = (decode_PC + _zz_236_);
  assign iBus_cmd_valid = IBusSimplePlugin_cmd_valid;
  assign IBusSimplePlugin_cmd_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_payload_pc;
  assign IBusSimplePlugin_pendingCmdNext = (_zz_237_ - _zz_241_);
  assign IBusSimplePlugin_cmd_valid = ((IBusSimplePlugin_iBusRsp_stages_1_input_valid && IBusSimplePlugin_iBusRsp_stages_1_output_ready) && (IBusSimplePlugin_pendingCmd != (3'b111)));
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_1_input_payload[31 : 2],(2'b00)};
  assign iBus_rsp_takeWhen_valid = (iBus_rsp_valid && (! (IBusSimplePlugin_rspJoin_discardCounter != (3'b000))));
  assign iBus_rsp_takeWhen_payload_error = iBus_rsp_payload_error;
  assign iBus_rsp_takeWhen_payload_inst = iBus_rsp_payload_inst;
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_valid = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_2_output_payload;
  always @ (*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBufferOutput_payload_error;
    if((! IBusSimplePlugin_rspJoin_rspBufferOutput_valid))begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBufferOutput_payload_inst;
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_redoRequired = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_2_output_valid && IBusSimplePlugin_rspJoin_rspBufferOutput_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_iBusRsp_stages_2_output_ready = (IBusSimplePlugin_iBusRsp_stages_2_output_valid ? (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready) : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBufferOutput_ready = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign _zz_130_ = (! (IBusSimplePlugin_rspJoin_exceptionDetected || IBusSimplePlugin_rspJoin_redoRequired));
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_130_);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_130_);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  assign _zz_131_ = 1'b0;
  always @ (*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT)begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_131_));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_132_ = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_132_ = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_132_ = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_132_;
  assign _zz_81_ = dBus_cmd_payload_address[1 : 0];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_133_ = (4'b0001);
      end
      2'b01 : begin
        _zz_133_ = (4'b0011);
      end
      default : begin
        _zz_133_ = (4'b1111);
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_133_ <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_address = execute_SRC_ADD;
  assign _zz_80_ = dBus_rsp_data;
  always @ (*) begin
    writeBack_DBusSimplePlugin_rspShifted = writeBack_MEMORY_READ_DATA;
    case(writeBack_MEMORY_ADDRESS_LOW)
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[15 : 8];
      end
      2'b10 : begin
        writeBack_DBusSimplePlugin_rspShifted[15 : 0] = writeBack_MEMORY_READ_DATA[31 : 16];
      end
      2'b11 : begin
        writeBack_DBusSimplePlugin_rspShifted[7 : 0] = writeBack_MEMORY_READ_DATA[31 : 24];
      end
      default : begin
      end
    endcase
  end

  assign _zz_134_ = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_135_[31] = _zz_134_;
    _zz_135_[30] = _zz_134_;
    _zz_135_[29] = _zz_134_;
    _zz_135_[28] = _zz_134_;
    _zz_135_[27] = _zz_134_;
    _zz_135_[26] = _zz_134_;
    _zz_135_[25] = _zz_134_;
    _zz_135_[24] = _zz_134_;
    _zz_135_[23] = _zz_134_;
    _zz_135_[22] = _zz_134_;
    _zz_135_[21] = _zz_134_;
    _zz_135_[20] = _zz_134_;
    _zz_135_[19] = _zz_134_;
    _zz_135_[18] = _zz_134_;
    _zz_135_[17] = _zz_134_;
    _zz_135_[16] = _zz_134_;
    _zz_135_[15] = _zz_134_;
    _zz_135_[14] = _zz_134_;
    _zz_135_[13] = _zz_134_;
    _zz_135_[12] = _zz_134_;
    _zz_135_[11] = _zz_134_;
    _zz_135_[10] = _zz_134_;
    _zz_135_[9] = _zz_134_;
    _zz_135_[8] = _zz_134_;
    _zz_135_[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_136_ = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_137_[31] = _zz_136_;
    _zz_137_[30] = _zz_136_;
    _zz_137_[29] = _zz_136_;
    _zz_137_[28] = _zz_136_;
    _zz_137_[27] = _zz_136_;
    _zz_137_[26] = _zz_136_;
    _zz_137_[25] = _zz_136_;
    _zz_137_[24] = _zz_136_;
    _zz_137_[23] = _zz_136_;
    _zz_137_[22] = _zz_136_;
    _zz_137_[21] = _zz_136_;
    _zz_137_[20] = _zz_136_;
    _zz_137_[19] = _zz_136_;
    _zz_137_[18] = _zz_136_;
    _zz_137_[17] = _zz_136_;
    _zz_137_[16] = _zz_136_;
    _zz_137_[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_223_)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_135_;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_137_;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  always @ (*) begin
    CsrPlugin_privilege = (2'b11);
    if(CsrPlugin_forceMachineWire)begin
      CsrPlugin_privilege = (2'b11);
    end
  end

  assign _zz_138_ = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_139_ = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_140_ = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = (2'b11);
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege = ((CsrPlugin_privilege < CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped) ? CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped : CsrPlugin_privilege);
  assign CsrPlugin_exceptionPortCtrl_exceptionValids_decode = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_execute = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
    if(CsrPlugin_selfException_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b1;
    end
    if(execute_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_execute = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_memory = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
    if(memory_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_memory = 1'b0;
    end
  end

  always @ (*) begin
    CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
    if(writeBack_arbitration_isFlushed)begin
      CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack = 1'b0;
    end
  end

  assign CsrPlugin_exceptionPendings_0 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  assign CsrPlugin_exceptionPendings_1 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  assign CsrPlugin_exceptionPendings_2 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  assign CsrPlugin_exceptionPendings_3 = CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  assign CsrPlugin_exception = (CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack && CsrPlugin_allowException);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = ((! ({writeBack_arbitration_isValid,{memory_arbitration_isValid,execute_arbitration_isValid}} != (3'b000))) && IBusSimplePlugin_pcValids_3);
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != (3'b000)))begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
    if(CsrPlugin_hadException)begin
      CsrPlugin_pipelineLiberator_done = 1'b0;
    end
  end

  assign CsrPlugin_interruptJump = ((CsrPlugin_interrupt_valid && CsrPlugin_pipelineLiberator_done) && CsrPlugin_allowInterrupts);
  always @ (*) begin
    CsrPlugin_targetPrivilege = CsrPlugin_interrupt_targetPrivilege;
    if(CsrPlugin_hadException)begin
      CsrPlugin_targetPrivilege = CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
    end
  end

  always @ (*) begin
    CsrPlugin_trapCause = CsrPlugin_interrupt_code;
    if(CsrPlugin_hadException)begin
      CsrPlugin_trapCause = CsrPlugin_exceptionPortCtrl_exceptionContext_code;
    end
  end

  always @ (*) begin
    CsrPlugin_xtvec_mode = (2'bxx);
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    CsrPlugin_xtvec_base = (30'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx);
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign _zz_77_ = (! (((decode_INSTRUCTION[14 : 13] == (2'b01)) && (decode_INSTRUCTION[19 : 15] == (5'b00000))) || ((decode_INSTRUCTION[14 : 13] == (2'b11)) && (decode_INSTRUCTION[19 : 15] == (5'b00000)))));
  assign _zz_76_ = (decode_INSTRUCTION[13 : 7] != (7'b0100000));
  always @ (*) begin
    execute_CsrPlugin_inWfi = 1'b0;
    if(_zz_194_)begin
      execute_CsrPlugin_inWfi = 1'b1;
    end
  end

  assign execute_CsrPlugin_blockedBySideEffects = ({writeBack_arbitration_isValid,memory_arbitration_isValid} != (2'b00));
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    case(execute_CsrPlugin_csrAddress)
      12'b001100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111100010001 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b111100010100 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b101100000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b101110000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001101000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001100000101 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b101100000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111100010011 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000011 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b110000000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001100000001 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b001101000000 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b111100010010 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001100000100 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b101110000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      12'b110010000000 : begin
        if(execute_CSR_READ_OPCODE)begin
          execute_CsrPlugin_illegalAccess = 1'b0;
        end
      end
      12'b001101000010 : begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
      default : begin
      end
    endcase
    if((CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]))begin
      execute_CsrPlugin_illegalAccess = 1'b1;
    end
    if(((! execute_arbitration_isValid) || (! execute_IS_CSR)))begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
  end

  always @ (*) begin
    execute_CsrPlugin_illegalInstruction = 1'b0;
    if((execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)))begin
      if((CsrPlugin_privilege < execute_INSTRUCTION[29 : 28]))begin
        execute_CsrPlugin_illegalInstruction = 1'b1;
      end
    end
  end

  always @ (*) begin
    CsrPlugin_selfException_valid = 1'b0;
    if(_zz_204_)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(_zz_205_)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_selfException_payload_code = (4'bxxxx);
    if(_zz_204_)begin
      CsrPlugin_selfException_payload_code = (4'b0010);
    end
    if(_zz_205_)begin
      case(CsrPlugin_privilege)
        2'b00 : begin
          CsrPlugin_selfException_payload_code = (4'b1000);
        end
        default : begin
          CsrPlugin_selfException_payload_code = (4'b1011);
        end
      endcase
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  always @ (*) begin
    execute_CsrPlugin_readData = (32'b00000000000000000000000000000000);
    case(execute_CsrPlugin_csrAddress)
      12'b001100000000 : begin
        execute_CsrPlugin_readData[12 : 11] = CsrPlugin_mstatus_MPP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mstatus_MPIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mstatus_MIE;
      end
      12'b111100010001 : begin
        execute_CsrPlugin_readData[3 : 0] = (4'b1011);
      end
      12'b111100010100 : begin
      end
      12'b001101000001 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mepc;
      end
      12'b101100000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[31 : 0];
      end
      12'b101110000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[63 : 32];
      end
      12'b001101000100 : begin
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mip_MEIP;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mip_MTIP;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mip_MSIP;
      end
      12'b001100000101 : begin
        execute_CsrPlugin_readData[31 : 2] = CsrPlugin_mtvec_base;
        execute_CsrPlugin_readData[1 : 0] = CsrPlugin_mtvec_mode;
      end
      12'b101100000010 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_minstret[31 : 0];
      end
      12'b111100010011 : begin
        execute_CsrPlugin_readData[5 : 0] = (6'b100001);
      end
      12'b001101000011 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mtval;
      end
      12'b110000000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[31 : 0];
      end
      12'b001100000001 : begin
        execute_CsrPlugin_readData[31 : 30] = CsrPlugin_misa_base;
        execute_CsrPlugin_readData[25 : 0] = CsrPlugin_misa_extensions;
      end
      12'b001101000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mscratch;
      end
      12'b111100010010 : begin
        execute_CsrPlugin_readData[4 : 0] = (5'b10110);
      end
      12'b001100000100 : begin
        execute_CsrPlugin_readData[11 : 11] = CsrPlugin_mie_MEIE;
        execute_CsrPlugin_readData[7 : 7] = CsrPlugin_mie_MTIE;
        execute_CsrPlugin_readData[3 : 3] = CsrPlugin_mie_MSIE;
      end
      12'b101110000010 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_minstret[63 : 32];
      end
      12'b110010000000 : begin
        execute_CsrPlugin_readData[31 : 0] = CsrPlugin_mcycle[63 : 32];
      end
      12'b001101000010 : begin
        execute_CsrPlugin_readData[31 : 31] = CsrPlugin_mcause_interrupt;
        execute_CsrPlugin_readData[3 : 0] = CsrPlugin_mcause_exceptionCode;
      end
      default : begin
      end
    endcase
  end

  assign execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
  assign execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
  assign execute_CsrPlugin_writeEnable = ((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readEnable = ((execute_CsrPlugin_readInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readToWriteData = execute_CsrPlugin_readData;
  always @ (*) begin
    case(_zz_224_)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_SRC1;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_142_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000000100)) == (32'b00000000000000000000000000000100));
  assign _zz_143_ = ((decode_INSTRUCTION & (32'b00000000000000000000000000110000)) == (32'b00000000000000000000000000010000));
  assign _zz_144_ = ((decode_INSTRUCTION & (32'b00000000000000000110000000000100)) == (32'b00000000000000000010000000000000));
  assign _zz_145_ = ((decode_INSTRUCTION & (32'b00000000000000000000000001001000)) == (32'b00000000000000000000000001001000));
  assign _zz_146_ = ((decode_INSTRUCTION & (32'b00000000000000000100000001010000)) == (32'b00000000000000000100000001010000));
  assign _zz_147_ = ((decode_INSTRUCTION & (32'b00000000000000000001000000000000)) == (32'b00000000000000000000000000000000));
  assign _zz_141_ = {(((decode_INSTRUCTION & _zz_320_) == (32'b00000010000000000000000000110000)) != (1'b0)),{({_zz_321_,{_zz_322_,_zz_323_}} != (3'b000)),{(_zz_147_ != (1'b0)),{(_zz_324_ != _zz_325_),{_zz_326_,{_zz_327_,_zz_328_}}}}}};
  assign _zz_148_ = _zz_141_[1 : 0];
  assign _zz_72_ = _zz_148_;
  assign _zz_71_ = _zz_244_[0];
  assign _zz_70_ = _zz_245_[0];
  assign _zz_69_ = _zz_246_[0];
  assign _zz_68_ = _zz_247_[0];
  assign _zz_67_ = _zz_248_[0];
  assign _zz_66_ = _zz_249_[0];
  assign _zz_65_ = _zz_250_[0];
  assign _zz_64_ = _zz_251_[0];
  assign _zz_149_ = _zz_141_[12 : 11];
  assign _zz_63_ = _zz_149_;
  assign _zz_62_ = _zz_252_[0];
  assign _zz_61_ = _zz_253_[0];
  assign _zz_150_ = _zz_141_[16 : 15];
  assign _zz_60_ = _zz_150_;
  assign _zz_151_ = _zz_141_[18 : 17];
  assign _zz_59_ = _zz_151_;
  assign _zz_58_ = _zz_254_[0];
  assign _zz_57_ = _zz_255_[0];
  assign _zz_152_ = _zz_141_[22 : 21];
  assign _zz_56_ = _zz_152_;
  assign _zz_153_ = _zz_141_[24 : 23];
  assign _zz_55_ = _zz_153_;
  assign _zz_54_ = _zz_256_[0];
  assign _zz_154_ = _zz_141_[27 : 26];
  assign _zz_53_ = _zz_154_;
  assign _zz_52_ = _zz_257_[0];
  assign _zz_51_ = _zz_258_[0];
  assign _zz_50_ = _zz_259_[0];
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_189_;
  assign decode_RegFilePlugin_rs2Data = _zz_190_;
  assign _zz_49_ = decode_RegFilePlugin_rs1Data;
  assign _zz_48_ = decode_RegFilePlugin_rs2Data;
  always @ (*) begin
    lastStageRegFileWrite_valid = (_zz_46_ && writeBack_arbitration_isFiring);
    if(_zz_155_)begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  assign lastStageRegFileWrite_payload_address = _zz_45_[11 : 7];
  assign lastStageRegFileWrite_payload_data = _zz_79_;
  always @ (*) begin
    case(execute_ALU_BITWISE_CTRL)
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 & execute_SRC2);
      end
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 | execute_SRC2);
      end
      default : begin
        execute_IntAluPlugin_bitwise = (execute_SRC1 ^ execute_SRC2);
      end
    endcase
  end

  always @ (*) begin
    case(execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_BITWISE : begin
        _zz_156_ = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_156_ = {31'd0, _zz_260_};
      end
      default : begin
        _zz_156_ = execute_SRC_ADD_SUB;
      end
    endcase
  end

  assign _zz_43_ = _zz_156_;
  assign _zz_41_ = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  always @ (*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_157_ = _zz_38_;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_157_ = {29'd0, _zz_261_};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_157_ = {decode_INSTRUCTION[31 : 12],(12'b000000000000)};
      end
      default : begin
        _zz_157_ = {27'd0, _zz_262_};
      end
    endcase
  end

  assign _zz_40_ = _zz_157_;
  assign _zz_158_ = _zz_263_[11];
  always @ (*) begin
    _zz_159_[19] = _zz_158_;
    _zz_159_[18] = _zz_158_;
    _zz_159_[17] = _zz_158_;
    _zz_159_[16] = _zz_158_;
    _zz_159_[15] = _zz_158_;
    _zz_159_[14] = _zz_158_;
    _zz_159_[13] = _zz_158_;
    _zz_159_[12] = _zz_158_;
    _zz_159_[11] = _zz_158_;
    _zz_159_[10] = _zz_158_;
    _zz_159_[9] = _zz_158_;
    _zz_159_[8] = _zz_158_;
    _zz_159_[7] = _zz_158_;
    _zz_159_[6] = _zz_158_;
    _zz_159_[5] = _zz_158_;
    _zz_159_[4] = _zz_158_;
    _zz_159_[3] = _zz_158_;
    _zz_159_[2] = _zz_158_;
    _zz_159_[1] = _zz_158_;
    _zz_159_[0] = _zz_158_;
  end

  assign _zz_160_ = _zz_264_[11];
  always @ (*) begin
    _zz_161_[19] = _zz_160_;
    _zz_161_[18] = _zz_160_;
    _zz_161_[17] = _zz_160_;
    _zz_161_[16] = _zz_160_;
    _zz_161_[15] = _zz_160_;
    _zz_161_[14] = _zz_160_;
    _zz_161_[13] = _zz_160_;
    _zz_161_[12] = _zz_160_;
    _zz_161_[11] = _zz_160_;
    _zz_161_[10] = _zz_160_;
    _zz_161_[9] = _zz_160_;
    _zz_161_[8] = _zz_160_;
    _zz_161_[7] = _zz_160_;
    _zz_161_[6] = _zz_160_;
    _zz_161_[5] = _zz_160_;
    _zz_161_[4] = _zz_160_;
    _zz_161_[3] = _zz_160_;
    _zz_161_[2] = _zz_160_;
    _zz_161_[1] = _zz_160_;
    _zz_161_[0] = _zz_160_;
  end

  always @ (*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_162_ = _zz_35_;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_162_ = {_zz_159_,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_162_ = {_zz_161_,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_162_ = _zz_34_;
      end
    endcase
  end

  assign _zz_37_ = _zz_162_;
  always @ (*) begin
    execute_SrcPlugin_addSub = _zz_265_;
    if(execute_SRC2_FORCE_ZERO)begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign _zz_33_ = execute_SrcPlugin_addSub;
  assign _zz_32_ = execute_SrcPlugin_addSub;
  assign _zz_31_ = execute_SrcPlugin_less;
  assign execute_MulPlugin_a = execute_SRC1;
  assign execute_MulPlugin_b = execute_SRC2;
  always @ (*) begin
    case(_zz_206_)
      2'b01 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_aSigned = 1'b1;
      end
      default : begin
        execute_MulPlugin_aSigned = 1'b0;
      end
    endcase
  end

  always @ (*) begin
    case(_zz_206_)
      2'b01 : begin
        execute_MulPlugin_bSigned = 1'b1;
      end
      2'b10 : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
      default : begin
        execute_MulPlugin_bSigned = 1'b0;
      end
    endcase
  end

  assign execute_MulPlugin_aULow = execute_MulPlugin_a[15 : 0];
  assign execute_MulPlugin_bULow = execute_MulPlugin_b[15 : 0];
  assign execute_MulPlugin_aSLow = {1'b0,execute_MulPlugin_a[15 : 0]};
  assign execute_MulPlugin_bSLow = {1'b0,execute_MulPlugin_b[15 : 0]};
  assign execute_MulPlugin_aHigh = {(execute_MulPlugin_aSigned && execute_MulPlugin_a[31]),execute_MulPlugin_a[31 : 16]};
  assign execute_MulPlugin_bHigh = {(execute_MulPlugin_bSigned && execute_MulPlugin_b[31]),execute_MulPlugin_b[31 : 16]};
  assign _zz_30_ = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign _zz_29_ = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign _zz_28_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign _zz_27_ = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign _zz_26_ = ($signed(_zz_272_) + $signed(_zz_280_));
  assign writeBack_MulPlugin_result = ($signed(_zz_281_) + $signed(_zz_282_));
  assign memory_DivPlugin_frontendOk = 1'b1;
  always @ (*) begin
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_191_)begin
      if(_zz_207_)begin
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
    end
  end

  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_208_)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_counter_willOverflowIfInc = (memory_DivPlugin_div_counter_value == (6'b100001));
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_counter_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_286_);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = (6'b000000);
    end
  end

  assign _zz_163_ = memory_DivPlugin_rs1[31 : 0];
  assign _zz_164_ = {memory_DivPlugin_accumulator[31 : 0],_zz_163_[31]};
  assign _zz_165_ = (_zz_164_ - _zz_287_);
  assign _zz_166_ = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_167_ = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_168_ = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_169_[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_169_[31 : 0] = execute_RS1;
  end

  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_defaultEncoding_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == (4'b0000));
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
        _zz_170_ = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_170_ = _zz_300_;
      end
    endcase
  end

  always @ (*) begin
    _zz_171_ = 1'b0;
    if(_zz_174_)begin
      if((_zz_175_ == decode_INSTRUCTION[19 : 15]))begin
        _zz_171_ = 1'b1;
      end
    end
    if(_zz_209_)begin
      if(_zz_210_)begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_171_ = 1'b1;
        end
      end
    end
    if(_zz_211_)begin
      if(_zz_212_)begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_171_ = 1'b1;
        end
      end
    end
    if(_zz_213_)begin
      if(_zz_214_)begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_171_ = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_171_ = 1'b0;
    end
  end

  always @ (*) begin
    _zz_172_ = 1'b0;
    if(_zz_174_)begin
      if((_zz_175_ == decode_INSTRUCTION[24 : 20]))begin
        _zz_172_ = 1'b1;
      end
    end
    if(_zz_209_)begin
      if(_zz_210_)begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_172_ = 1'b1;
        end
      end
    end
    if(_zz_211_)begin
      if(_zz_212_)begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_172_ = 1'b1;
        end
      end
    end
    if(_zz_213_)begin
      if(_zz_214_)begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_172_ = 1'b1;
        end
      end
    end
    if((! decode_RS2_USE))begin
      _zz_172_ = 1'b0;
    end
  end

  assign _zz_173_ = (_zz_46_ && writeBack_arbitration_isFiring);
  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_176_ = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_176_ == (3'b000))) begin
        _zz_177_ = execute_BranchPlugin_eq;
    end else if((_zz_176_ == (3'b001))) begin
        _zz_177_ = (! execute_BranchPlugin_eq);
    end else if((((_zz_176_ & (3'b101)) == (3'b101)))) begin
        _zz_177_ = (! execute_SRC_LESS);
    end else begin
        _zz_177_ = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_178_ = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_178_ = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_178_ = 1'b1;
      end
      default : begin
        _zz_178_ = _zz_177_;
      end
    endcase
  end

  assign _zz_23_ = _zz_178_;
  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JALR) ? execute_RS1 : execute_PC);
  assign _zz_179_ = _zz_302_[19];
  always @ (*) begin
    _zz_180_[10] = _zz_179_;
    _zz_180_[9] = _zz_179_;
    _zz_180_[8] = _zz_179_;
    _zz_180_[7] = _zz_179_;
    _zz_180_[6] = _zz_179_;
    _zz_180_[5] = _zz_179_;
    _zz_180_[4] = _zz_179_;
    _zz_180_[3] = _zz_179_;
    _zz_180_[2] = _zz_179_;
    _zz_180_[1] = _zz_179_;
    _zz_180_[0] = _zz_179_;
  end

  assign _zz_181_ = _zz_303_[11];
  always @ (*) begin
    _zz_182_[19] = _zz_181_;
    _zz_182_[18] = _zz_181_;
    _zz_182_[17] = _zz_181_;
    _zz_182_[16] = _zz_181_;
    _zz_182_[15] = _zz_181_;
    _zz_182_[14] = _zz_181_;
    _zz_182_[13] = _zz_181_;
    _zz_182_[12] = _zz_181_;
    _zz_182_[11] = _zz_181_;
    _zz_182_[10] = _zz_181_;
    _zz_182_[9] = _zz_181_;
    _zz_182_[8] = _zz_181_;
    _zz_182_[7] = _zz_181_;
    _zz_182_[6] = _zz_181_;
    _zz_182_[5] = _zz_181_;
    _zz_182_[4] = _zz_181_;
    _zz_182_[3] = _zz_181_;
    _zz_182_[2] = _zz_181_;
    _zz_182_[1] = _zz_181_;
    _zz_182_[0] = _zz_181_;
  end

  assign _zz_183_ = _zz_304_[11];
  always @ (*) begin
    _zz_184_[18] = _zz_183_;
    _zz_184_[17] = _zz_183_;
    _zz_184_[16] = _zz_183_;
    _zz_184_[15] = _zz_183_;
    _zz_184_[14] = _zz_183_;
    _zz_184_[13] = _zz_183_;
    _zz_184_[12] = _zz_183_;
    _zz_184_[11] = _zz_183_;
    _zz_184_[10] = _zz_183_;
    _zz_184_[9] = _zz_183_;
    _zz_184_[8] = _zz_183_;
    _zz_184_[7] = _zz_183_;
    _zz_184_[6] = _zz_183_;
    _zz_184_[5] = _zz_183_;
    _zz_184_[4] = _zz_183_;
    _zz_184_[3] = _zz_183_;
    _zz_184_[2] = _zz_183_;
    _zz_184_[1] = _zz_183_;
    _zz_184_[0] = _zz_183_;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_185_ = {{_zz_180_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_185_ = {_zz_182_,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_185_ = {{_zz_184_,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_185_;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign _zz_21_ = {execute_BranchPlugin_branchAdder[31 : 1],(1'b0)};
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  always @ (*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid)begin
      case(_zz_215_)
        6'b000000 : begin
        end
        6'b000001 : begin
          if(debug_bus_cmd_payload_wr)begin
            debug_bus_cmd_ready = IBusSimplePlugin_injectionPort_ready;
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (*) begin
    debug_bus_rsp_data = DebugPlugin_busReadDataReg;
    if((! _zz_186_))begin
      debug_bus_rsp_data[0] = DebugPlugin_resetIt;
      debug_bus_rsp_data[1] = DebugPlugin_haltIt;
      debug_bus_rsp_data[2] = DebugPlugin_isPipBusy;
      debug_bus_rsp_data[3] = DebugPlugin_haltedByBreak;
      debug_bus_rsp_data[4] = DebugPlugin_stepIt;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_injectionPort_valid = 1'b0;
    if(debug_bus_cmd_valid)begin
      case(_zz_215_)
        6'b000000 : begin
        end
        6'b000001 : begin
          if(debug_bus_cmd_payload_wr)begin
            IBusSimplePlugin_injectionPort_valid = 1'b1;
          end
        end
        default : begin
        end
      endcase
    end
  end

  assign IBusSimplePlugin_injectionPort_payload = debug_bus_cmd_payload_data;
  assign _zz_20_ = ((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0));
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign _zz_39_ = _zz_59_;
  assign _zz_19_ = decode_BRANCH_CTRL;
  assign _zz_17_ = _zz_60_;
  assign _zz_22_ = decode_to_execute_BRANCH_CTRL;
  assign _zz_16_ = decode_ALU_BITWISE_CTRL;
  assign _zz_14_ = _zz_56_;
  assign _zz_44_ = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_13_ = decode_SHIFT_CTRL;
  assign _zz_11_ = _zz_55_;
  assign _zz_24_ = decode_to_execute_SHIFT_CTRL;
  assign _zz_10_ = decode_ALU_CTRL;
  assign _zz_8_ = _zz_53_;
  assign _zz_42_ = decode_to_execute_ALU_CTRL;
  assign _zz_36_ = _zz_72_;
  assign _zz_7_ = decode_ENV_CTRL;
  assign _zz_4_ = execute_ENV_CTRL;
  assign _zz_2_ = memory_ENV_CTRL;
  assign _zz_5_ = _zz_63_;
  assign _zz_75_ = decode_to_execute_ENV_CTRL;
  assign _zz_74_ = execute_to_memory_ENV_CTRL;
  assign _zz_78_ = memory_to_writeBack_ENV_CTRL;
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != (3'b000)) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != (4'b0000)));
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != (2'b00)) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != (3'b000)));
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != (1'b0)) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != (2'b00)));
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != (1'b0)));
  assign decode_arbitration_isStuckByOthers = (decode_arbitration_haltByOther || (((1'b0 || execute_arbitration_isStuck) || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign decode_arbitration_isStuck = (decode_arbitration_haltItself || decode_arbitration_isStuckByOthers);
  assign decode_arbitration_isMoving = ((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt));
  assign decode_arbitration_isFiring = ((decode_arbitration_isValid && (! decode_arbitration_isStuck)) && (! decode_arbitration_removeIt));
  assign execute_arbitration_isStuckByOthers = (execute_arbitration_haltByOther || ((1'b0 || memory_arbitration_isStuck) || writeBack_arbitration_isStuck));
  assign execute_arbitration_isStuck = (execute_arbitration_haltItself || execute_arbitration_isStuckByOthers);
  assign execute_arbitration_isMoving = ((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt));
  assign execute_arbitration_isFiring = ((execute_arbitration_isValid && (! execute_arbitration_isStuck)) && (! execute_arbitration_removeIt));
  assign memory_arbitration_isStuckByOthers = (memory_arbitration_haltByOther || (1'b0 || writeBack_arbitration_isStuck));
  assign memory_arbitration_isStuck = (memory_arbitration_haltItself || memory_arbitration_isStuckByOthers);
  assign memory_arbitration_isMoving = ((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt));
  assign memory_arbitration_isFiring = ((memory_arbitration_isValid && (! memory_arbitration_isStuck)) && (! memory_arbitration_removeIt));
  assign writeBack_arbitration_isStuckByOthers = (writeBack_arbitration_haltByOther || 1'b0);
  assign writeBack_arbitration_isStuck = (writeBack_arbitration_haltItself || writeBack_arbitration_isStuckByOthers);
  assign writeBack_arbitration_isMoving = ((! writeBack_arbitration_isStuck) && (! writeBack_arbitration_removeIt));
  assign writeBack_arbitration_isFiring = ((writeBack_arbitration_isValid && (! writeBack_arbitration_isStuck)) && (! writeBack_arbitration_removeIt));
  always @ (*) begin
    IBusSimplePlugin_injectionPort_ready = 1'b0;
    case(_zz_188_)
      3'b000 : begin
      end
      3'b001 : begin
      end
      3'b010 : begin
      end
      3'b011 : begin
      end
      3'b100 : begin
        IBusSimplePlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      IBusSimplePlugin_fetchPc_pcReg <= (32'b10000000000000000000000000000000);
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      IBusSimplePlugin_decodePc_pcReg <= (32'b10000000000000000000000000000000);
      _zz_94_ <= 1'b0;
      _zz_96_ <= 1'b0;
      IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      _zz_125_ <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_injector_decodeRemoved <= 1'b0;
      IBusSimplePlugin_pendingCmd <= (3'b000);
      IBusSimplePlugin_rspJoin_discardCounter <= (3'b000);
      CsrPlugin_misa_base <= (2'b01);
      CsrPlugin_misa_extensions <= (26'b00000000000000000001000010);
      CsrPlugin_mtvec_mode <= (2'b00);
      CsrPlugin_mtvec_base <= (30'b000000000000000000000000001000);
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= (2'b11);
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_lastStageWasWfi <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      _zz_155_ <= 1'b1;
      memory_DivPlugin_div_counter_value <= (6'b000000);
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_174_ <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_188_ <= (3'b000);
      memory_to_writeBack_REGFILE_WRITE_DATA <= (32'b00000000000000000000000000000000);
      memory_to_writeBack_INSTRUCTION <= (32'b00000000000000000000000000000000);
    end else begin
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if((IBusSimplePlugin_fetchPc_corrected || IBusSimplePlugin_fetchPc_pcRegPropagate))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetcherflushIt) || IBusSimplePlugin_fetchPc_pcRegPropagate)))begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if((decode_arbitration_isFiring && (! IBusSimplePlugin_decodePc_injectedDecode)))begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_decodePc_pcPlus;
      end
      if((IBusSimplePlugin_jump_pcLoad_valid && ((! decode_arbitration_isStuck) || decode_arbitration_removeIt)))begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_jump_pcLoad_payload;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        _zz_94_ <= 1'b0;
      end
      if(_zz_92_)begin
        _zz_94_ <= IBusSimplePlugin_iBusRsp_stages_0_output_valid;
      end
      if(IBusSimplePlugin_iBusRsp_stages_1_output_ready)begin
        _zz_96_ <= IBusSimplePlugin_iBusRsp_stages_1_output_valid;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        _zz_96_ <= 1'b0;
      end
      if((IBusSimplePlugin_decompressor_inputBeforeStage_valid && IBusSimplePlugin_decompressor_inputBeforeStage_ready))begin
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(_zz_202_)begin
        if(_zz_203_)begin
          IBusSimplePlugin_decompressor_bufferValid <= 1'b1;
        end else begin
          IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
        end
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(IBusSimplePlugin_decompressor_inputBeforeStage_ready)begin
        _zz_125_ <= IBusSimplePlugin_decompressor_inputBeforeStage_valid;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        _zz_125_ <= 1'b0;
      end
      if((! 1'b0))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        IBusSimplePlugin_injector_decodeRemoved <= 1'b1;
      end
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_injector_decodeRemoved <= 1'b0;
      end
      IBusSimplePlugin_pendingCmd <= IBusSimplePlugin_pendingCmdNext;
      IBusSimplePlugin_rspJoin_discardCounter <= (IBusSimplePlugin_rspJoin_discardCounter - _zz_243_);
      if(IBusSimplePlugin_fetcherflushIt)begin
        IBusSimplePlugin_rspJoin_discardCounter <= IBusSimplePlugin_pendingCmdNext;
      end
      if((! execute_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
      end
      if((! memory_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= (CsrPlugin_exceptionPortCtrl_exceptionValids_execute && (! execute_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
      end
      if((! writeBack_arbitration_isStuck))begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= (CsrPlugin_exceptionPortCtrl_exceptionValids_memory && (! memory_arbitration_isStuck));
      end else begin
        CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      end
      CsrPlugin_interrupt_valid <= 1'b0;
      if(_zz_216_)begin
        if(_zz_217_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_218_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_219_)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      CsrPlugin_lastStageWasWfi <= (writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(_zz_198_)begin
        case(CsrPlugin_targetPrivilege)
          2'b11 : begin
            CsrPlugin_mstatus_MIE <= 1'b0;
            CsrPlugin_mstatus_MPIE <= CsrPlugin_mstatus_MIE;
            CsrPlugin_mstatus_MPP <= CsrPlugin_privilege;
          end
          default : begin
          end
        endcase
      end
      if(_zz_199_)begin
        case(_zz_201_)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= (2'b00);
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= ({_zz_140_,{_zz_139_,_zz_138_}} != (3'b000));
      _zz_155_ <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      if(_zz_193_)begin
        if(_zz_195_)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_174_ <= _zz_173_;
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_25_;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if(((! execute_arbitration_isStuck) || execute_arbitration_removeIt))begin
        execute_arbitration_isValid <= 1'b0;
      end
      if(((! decode_arbitration_isStuck) && (! decode_arbitration_removeIt)))begin
        execute_arbitration_isValid <= decode_arbitration_isValid;
      end
      if(((! memory_arbitration_isStuck) || memory_arbitration_removeIt))begin
        memory_arbitration_isValid <= 1'b0;
      end
      if(((! execute_arbitration_isStuck) && (! execute_arbitration_removeIt)))begin
        memory_arbitration_isValid <= execute_arbitration_isValid;
      end
      if(((! writeBack_arbitration_isStuck) || writeBack_arbitration_removeIt))begin
        writeBack_arbitration_isValid <= 1'b0;
      end
      if(((! memory_arbitration_isStuck) && (! memory_arbitration_removeIt)))begin
        writeBack_arbitration_isValid <= memory_arbitration_isValid;
      end
      case(_zz_188_)
        3'b000 : begin
          if(IBusSimplePlugin_injectionPort_valid)begin
            _zz_188_ <= (3'b001);
          end
        end
        3'b001 : begin
          _zz_188_ <= (3'b010);
        end
        3'b010 : begin
          _zz_188_ <= (3'b011);
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_188_ <= (3'b100);
          end
        end
        3'b100 : begin
          _zz_188_ <= (3'b000);
        end
        default : begin
        end
      endcase
      case(execute_CsrPlugin_csrAddress)
        12'b001100000000 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
            CsrPlugin_mstatus_MPIE <= _zz_305_[0];
            CsrPlugin_mstatus_MIE <= _zz_306_[0];
          end
        end
        12'b111100010001 : begin
        end
        12'b111100010100 : begin
        end
        12'b001101000001 : begin
        end
        12'b101100000000 : begin
        end
        12'b101110000000 : begin
        end
        12'b001101000100 : begin
        end
        12'b001100000101 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mtvec_base <= execute_CsrPlugin_writeData[31 : 2];
            CsrPlugin_mtvec_mode <= execute_CsrPlugin_writeData[1 : 0];
          end
        end
        12'b101100000010 : begin
        end
        12'b111100010011 : begin
        end
        12'b001101000011 : begin
        end
        12'b110000000000 : begin
        end
        12'b001100000001 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_misa_base <= execute_CsrPlugin_writeData[31 : 30];
            CsrPlugin_misa_extensions <= execute_CsrPlugin_writeData[25 : 0];
          end
        end
        12'b001101000000 : begin
        end
        12'b111100010010 : begin
        end
        12'b001100000100 : begin
          if(execute_CsrPlugin_writeEnable)begin
            CsrPlugin_mie_MEIE <= _zz_308_[0];
            CsrPlugin_mie_MTIE <= _zz_309_[0];
            CsrPlugin_mie_MSIE <= _zz_310_[0];
          end
        end
        12'b101110000010 : begin
        end
        12'b110010000000 : begin
        end
        12'b001101000010 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    if(IBusSimplePlugin_iBusRsp_stages_1_output_ready)begin
      _zz_97_ <= IBusSimplePlugin_iBusRsp_stages_1_output_payload;
    end
    if(_zz_202_)begin
      IBusSimplePlugin_decompressor_bufferData <= IBusSimplePlugin_iBusRsp_output_payload_rsp_inst[31 : 16];
    end
    if(IBusSimplePlugin_decompressor_inputBeforeStage_ready)begin
      _zz_126_ <= IBusSimplePlugin_decompressor_inputBeforeStage_payload_pc;
      _zz_127_ <= IBusSimplePlugin_decompressor_inputBeforeStage_payload_rsp_error;
      _zz_128_ <= IBusSimplePlugin_decompressor_inputBeforeStage_payload_rsp_inst;
      _zz_129_ <= IBusSimplePlugin_decompressor_inputBeforeStage_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready)begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_decompressor_raw;
    end
    if(!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow memory stage stall when read happend");
    end
    if(!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck))) begin
      $display("ERROR DBusSimplePlugin doesn't allow writeback stage stall when read happend");
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + (64'b0000000000000000000000000000000000000000000000000000000000000001));
    end
    if(CsrPlugin_selfException_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(_zz_216_)begin
      if(_zz_217_)begin
        CsrPlugin_interrupt_code <= (4'b0111);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_218_)begin
        CsrPlugin_interrupt_code <= (4'b0011);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
      if(_zz_219_)begin
        CsrPlugin_interrupt_code <= (4'b1011);
        CsrPlugin_interrupt_targetPrivilege <= (2'b11);
      end
    end
    if(_zz_198_)begin
      case(CsrPlugin_targetPrivilege)
        2'b11 : begin
          CsrPlugin_mcause_interrupt <= (! CsrPlugin_hadException);
          CsrPlugin_mcause_exceptionCode <= CsrPlugin_trapCause;
          CsrPlugin_mepc <= writeBack_PC;
          if(CsrPlugin_hadException)begin
            CsrPlugin_mtval <= CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
          end
        end
        default : begin
        end
      endcase
    end
    if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
      memory_DivPlugin_div_done <= 1'b1;
    end
    if((! memory_arbitration_isStuck))begin
      memory_DivPlugin_div_done <= 1'b0;
    end
    if(_zz_191_)begin
      if(_zz_207_)begin
        memory_DivPlugin_rs1[31 : 0] <= _zz_288_[31:0];
        memory_DivPlugin_accumulator[31 : 0] <= ((! _zz_165_[32]) ? _zz_289_ : _zz_290_);
        if((memory_DivPlugin_div_counter_value == (6'b100000)))begin
          memory_DivPlugin_div_result <= _zz_291_[31:0];
        end
      end
    end
    if(_zz_208_)begin
      memory_DivPlugin_accumulator <= (65'b00000000000000000000000000000000000000000000000000000000000000000);
      memory_DivPlugin_rs1 <= ((_zz_168_ ? (~ _zz_169_) : _zz_169_) + _zz_297_);
      memory_DivPlugin_rs2 <= ((_zz_167_ ? (~ execute_RS2) : execute_RS2) + _zz_299_);
      memory_DivPlugin_div_needRevert <= ((_zz_168_ ^ (_zz_167_ && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == (32'b00000000000000000000000000000000)) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    if(_zz_193_)begin
      if(_zz_195_)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - (5'b00001));
      end
    end
    if(_zz_173_)begin
      _zz_175_ <= _zz_45_[11 : 7];
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_82_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_18_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= _zz_35_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_15_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1 <= decode_SRC1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= _zz_34_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= execute_PC;
    end
    if(((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack)))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_12_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_MUL <= decode_IS_MUL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_MUL <= execute_IS_MUL;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_IS_MUL <= memory_IS_MUL;
    end
    if(((! memory_arbitration_isStuck) && (! execute_arbitration_isStuckByOthers)))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_73_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_ENABLE <= decode_MEMORY_ENABLE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ENABLE <= execute_MEMORY_ENABLE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ENABLE <= memory_MEMORY_ENABLE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= _zz_38_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_9_;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_MEMORY_STORE <= decode_MEMORY_STORE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_STORE <= execute_MEMORY_STORE;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_STORE <= memory_MEMORY_STORE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2 <= decode_SRC2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_6_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_3_;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_1_;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if((((! IBusSimplePlugin_iBusRsp_output_ready) && (IBusSimplePlugin_decompressor_inputBeforeStage_valid && IBusSimplePlugin_decompressor_inputBeforeStage_ready)) && (! IBusSimplePlugin_fetcherflushIt)))begin
      _zz_97_[1] <= 1'b1;
    end
    if((_zz_188_ != (3'b000)))begin
      _zz_128_ <= IBusSimplePlugin_injectionPort_payload;
    end
    case(execute_CsrPlugin_csrAddress)
      12'b001100000000 : begin
      end
      12'b111100010001 : begin
      end
      12'b111100010100 : begin
      end
      12'b001101000001 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b101100000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcycle[31 : 0] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b101110000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcycle[63 : 32] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b001101000100 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mip_MSIP <= _zz_307_[0];
        end
      end
      12'b001100000101 : begin
      end
      12'b101100000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_minstret[31 : 0] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111100010011 : begin
      end
      12'b001101000011 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtval <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b110000000000 : begin
      end
      12'b001100000001 : begin
      end
      12'b001101000000 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mscratch <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b111100010010 : begin
      end
      12'b001100000100 : begin
      end
      12'b101110000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_minstret[63 : 32] <= execute_CsrPlugin_writeData[31 : 0];
        end
      end
      12'b110010000000 : begin
      end
      12'b001101000010 : begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mcause_interrupt <= _zz_311_[0];
          CsrPlugin_mcause_exceptionCode <= execute_CsrPlugin_writeData[3 : 0];
        end
      end
      default : begin
      end
    endcase
  end

  always @ (posedge io_mainClk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= (({writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}} != (4'b0000)) || IBusSimplePlugin_incomingInstruction);
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_79_;
    end
    _zz_186_ <= debug_bus_cmd_payload_address[2];
    if(_zz_196_)begin
      DebugPlugin_busReadDataReg <= execute_PC;
    end
    DebugPlugin_resetIt_regNext <= DebugPlugin_resetIt;
  end

  always @ (posedge io_mainClk or posedge resetCtrl_mainClkReset) begin
    if (resetCtrl_mainClkReset) begin
      DebugPlugin_resetIt <= 1'b0;
      DebugPlugin_haltIt <= 1'b0;
      DebugPlugin_stepIt <= 1'b0;
      DebugPlugin_godmode <= 1'b0;
      DebugPlugin_haltedByBreak <= 1'b0;
      _zz_187_ <= 1'b0;
    end else begin
      if((DebugPlugin_haltIt && (! DebugPlugin_isPipBusy)))begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid)begin
        case(_zz_215_)
          6'b000000 : begin
            if(debug_bus_cmd_payload_wr)begin
              DebugPlugin_stepIt <= debug_bus_cmd_payload_data[4];
              if(debug_bus_cmd_payload_data[16])begin
                DebugPlugin_resetIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[24])begin
                DebugPlugin_resetIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[17])begin
                DebugPlugin_haltIt <= 1'b1;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltIt <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_haltedByBreak <= 1'b0;
              end
              if(debug_bus_cmd_payload_data[25])begin
                DebugPlugin_godmode <= 1'b0;
              end
            end
          end
          6'b000001 : begin
          end
          default : begin
          end
        endcase
      end
      if(_zz_196_)begin
        if(_zz_197_)begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(_zz_200_)begin
        if(decode_arbitration_isValid)begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      _zz_187_ <= (DebugPlugin_stepIt && decode_arbitration_isFiring);
    end
  end

endmodule

module JtagBridge (
      input   io_jtag_tms,
      input   io_jtag_tdi,
      output  io_jtag_tdo,
      input   io_jtag_tck,
      output  io_remote_cmd_valid,
      input   io_remote_cmd_ready,
      output  io_remote_cmd_payload_last,
      output [0:0] io_remote_cmd_payload_fragment,
      input   io_remote_rsp_valid,
      output  io_remote_rsp_ready,
      input   io_remote_rsp_payload_error,
      input  [31:0] io_remote_rsp_payload_data,
      input   io_mainClk,
      input   resetCtrl_mainClkReset);
  wire  flowCCByToggle_1__io_output_valid;
  wire  flowCCByToggle_1__io_output_payload_last;
  wire [0:0] flowCCByToggle_1__io_output_payload_fragment;
  wire  _zz_2_;
  wire  _zz_3_;
  wire [3:0] _zz_4_;
  wire [3:0] _zz_5_;
  wire [3:0] _zz_6_;
  wire  system_cmd_valid;
  wire  system_cmd_payload_last;
  wire [0:0] system_cmd_payload_fragment;
  reg  system_rsp_valid;
  reg  system_rsp_payload_error;
  reg [31:0] system_rsp_payload_data;
  wire `JtagState_defaultEncoding_type jtag_tap_fsm_stateNext;
  reg `JtagState_defaultEncoding_type jtag_tap_fsm_state = `JtagState_defaultEncoding_RESET;
  reg `JtagState_defaultEncoding_type _zz_1_;
  reg [3:0] jtag_tap_instruction;
  reg [3:0] jtag_tap_instructionShift;
  reg  jtag_tap_bypass;
  reg  jtag_tap_tdoUnbufferd;
  reg  jtag_tap_tdoUnbufferd_regNext;
  wire [0:0] jtag_idcodeArea_instructionId;
  wire  jtag_idcodeArea_instructionHit;
  reg [31:0] jtag_idcodeArea_shifter;
  wire [1:0] jtag_writeArea_instructionId;
  wire  jtag_writeArea_instructionHit;
  reg  jtag_writeArea_source_valid;
  wire  jtag_writeArea_source_payload_last;
  wire [0:0] jtag_writeArea_source_payload_fragment;
  wire [1:0] jtag_readArea_instructionId;
  wire  jtag_readArea_instructionHit;
  reg [33:0] jtag_readArea_shifter;
  `ifndef SYNTHESIS
  reg [79:0] jtag_tap_fsm_stateNext_string;
  reg [79:0] jtag_tap_fsm_state_string;
  reg [79:0] _zz_1__string;
  `endif

  assign _zz_2_ = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_3_ = (jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT);
  assign _zz_4_ = {3'd0, jtag_idcodeArea_instructionId};
  assign _zz_5_ = {2'd0, jtag_writeArea_instructionId};
  assign _zz_6_ = {2'd0, jtag_readArea_instructionId};
  FlowCCByToggle flowCCByToggle_1_ ( 
    .io_input_valid(jtag_writeArea_source_valid),
    .io_input_payload_last(jtag_writeArea_source_payload_last),
    .io_input_payload_fragment(jtag_writeArea_source_payload_fragment),
    .io_output_valid(flowCCByToggle_1__io_output_valid),
    .io_output_payload_last(flowCCByToggle_1__io_output_payload_last),
    .io_output_payload_fragment(flowCCByToggle_1__io_output_payload_fragment),
    .io_jtag_tck(io_jtag_tck),
    .io_mainClk(io_mainClk),
    .resetCtrl_mainClkReset(resetCtrl_mainClkReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(jtag_tap_fsm_stateNext)
      `JtagState_defaultEncoding_RESET : jtag_tap_fsm_stateNext_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : jtag_tap_fsm_stateNext_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : jtag_tap_fsm_stateNext_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : jtag_tap_fsm_stateNext_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : jtag_tap_fsm_stateNext_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : jtag_tap_fsm_stateNext_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : jtag_tap_fsm_stateNext_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : jtag_tap_fsm_stateNext_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : jtag_tap_fsm_stateNext_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : jtag_tap_fsm_stateNext_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : jtag_tap_fsm_stateNext_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : jtag_tap_fsm_stateNext_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : jtag_tap_fsm_stateNext_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : jtag_tap_fsm_stateNext_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : jtag_tap_fsm_stateNext_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : jtag_tap_fsm_stateNext_string = "DR_UPDATE ";
      default : jtag_tap_fsm_stateNext_string = "??????????";
    endcase
  end
  always @(*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_RESET : jtag_tap_fsm_state_string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : jtag_tap_fsm_state_string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : jtag_tap_fsm_state_string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : jtag_tap_fsm_state_string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : jtag_tap_fsm_state_string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : jtag_tap_fsm_state_string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : jtag_tap_fsm_state_string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : jtag_tap_fsm_state_string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : jtag_tap_fsm_state_string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : jtag_tap_fsm_state_string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : jtag_tap_fsm_state_string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : jtag_tap_fsm_state_string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : jtag_tap_fsm_state_string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : jtag_tap_fsm_state_string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : jtag_tap_fsm_state_string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : jtag_tap_fsm_state_string = "DR_UPDATE ";
      default : jtag_tap_fsm_state_string = "??????????";
    endcase
  end
  always @(*) begin
    case(_zz_1_)
      `JtagState_defaultEncoding_RESET : _zz_1__string = "RESET     ";
      `JtagState_defaultEncoding_IDLE : _zz_1__string = "IDLE      ";
      `JtagState_defaultEncoding_IR_SELECT : _zz_1__string = "IR_SELECT ";
      `JtagState_defaultEncoding_IR_CAPTURE : _zz_1__string = "IR_CAPTURE";
      `JtagState_defaultEncoding_IR_SHIFT : _zz_1__string = "IR_SHIFT  ";
      `JtagState_defaultEncoding_IR_EXIT1 : _zz_1__string = "IR_EXIT1  ";
      `JtagState_defaultEncoding_IR_PAUSE : _zz_1__string = "IR_PAUSE  ";
      `JtagState_defaultEncoding_IR_EXIT2 : _zz_1__string = "IR_EXIT2  ";
      `JtagState_defaultEncoding_IR_UPDATE : _zz_1__string = "IR_UPDATE ";
      `JtagState_defaultEncoding_DR_SELECT : _zz_1__string = "DR_SELECT ";
      `JtagState_defaultEncoding_DR_CAPTURE : _zz_1__string = "DR_CAPTURE";
      `JtagState_defaultEncoding_DR_SHIFT : _zz_1__string = "DR_SHIFT  ";
      `JtagState_defaultEncoding_DR_EXIT1 : _zz_1__string = "DR_EXIT1  ";
      `JtagState_defaultEncoding_DR_PAUSE : _zz_1__string = "DR_PAUSE  ";
      `JtagState_defaultEncoding_DR_EXIT2 : _zz_1__string = "DR_EXIT2  ";
      `JtagState_defaultEncoding_DR_UPDATE : _zz_1__string = "DR_UPDATE ";
      default : _zz_1__string = "??????????";
    endcase
  end
  `endif

  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_rsp_ready = 1'b1;
  always @ (*) begin
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IDLE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_IR_SELECT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IR_CAPTURE);
      end
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT1 : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_EXIT1 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_PAUSE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_EXIT2 : `JtagState_defaultEncoding_IR_PAUSE);
      end
      `JtagState_defaultEncoding_IR_EXIT2 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_UPDATE : `JtagState_defaultEncoding_IR_SHIFT);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      `JtagState_defaultEncoding_DR_SELECT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_IR_SELECT : `JtagState_defaultEncoding_DR_CAPTURE);
      end
      `JtagState_defaultEncoding_DR_CAPTURE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT1 : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_EXIT1 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_PAUSE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_EXIT2 : `JtagState_defaultEncoding_DR_PAUSE);
      end
      `JtagState_defaultEncoding_DR_EXIT2 : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_UPDATE : `JtagState_defaultEncoding_DR_SHIFT);
      end
      `JtagState_defaultEncoding_DR_UPDATE : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_DR_SELECT : `JtagState_defaultEncoding_IDLE);
      end
      default : begin
        _zz_1_ = (io_jtag_tms ? `JtagState_defaultEncoding_RESET : `JtagState_defaultEncoding_IDLE);
      end
    endcase
  end

  assign jtag_tap_fsm_stateNext = _zz_1_;
  always @ (*) begin
    jtag_tap_tdoUnbufferd = jtag_tap_bypass;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_tdoUnbufferd = jtag_tap_instructionShift[0];
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_instructionHit)begin
      if(_zz_2_)begin
        jtag_tap_tdoUnbufferd = jtag_idcodeArea_shifter[0];
      end
    end
    if(jtag_readArea_instructionHit)begin
      if(_zz_3_)begin
        jtag_tap_tdoUnbufferd = jtag_readArea_shifter[0];
      end
    end
  end

  assign io_jtag_tdo = jtag_tap_tdoUnbufferd_regNext;
  assign jtag_idcodeArea_instructionId = (1'b1);
  assign jtag_idcodeArea_instructionHit = (jtag_tap_instruction == _zz_4_);
  assign jtag_writeArea_instructionId = (2'b10);
  assign jtag_writeArea_instructionHit = (jtag_tap_instruction == _zz_5_);
  always @ (*) begin
    jtag_writeArea_source_valid = 1'b0;
    if(jtag_writeArea_instructionHit)begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_SHIFT))begin
        jtag_writeArea_source_valid = 1'b1;
      end
    end
  end

  assign jtag_writeArea_source_payload_last = io_jtag_tms;
  assign jtag_writeArea_source_payload_fragment[0] = io_jtag_tdi;
  assign system_cmd_valid = flowCCByToggle_1__io_output_valid;
  assign system_cmd_payload_last = flowCCByToggle_1__io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCByToggle_1__io_output_payload_fragment;
  assign jtag_readArea_instructionId = (2'b11);
  assign jtag_readArea_instructionHit = (jtag_tap_instruction == _zz_6_);
  always @ (posedge io_mainClk) begin
    if(io_remote_cmd_valid)begin
      system_rsp_valid <= 1'b0;
    end
    if((io_remote_rsp_valid && io_remote_rsp_ready))begin
      system_rsp_valid <= 1'b1;
      system_rsp_payload_error <= io_remote_rsp_payload_error;
      system_rsp_payload_data <= io_remote_rsp_payload_data;
    end
  end

  always @ (posedge io_jtag_tck) begin
    jtag_tap_fsm_state <= jtag_tap_fsm_stateNext;
    case(jtag_tap_fsm_state)
      `JtagState_defaultEncoding_IR_CAPTURE : begin
        jtag_tap_instructionShift <= jtag_tap_instruction;
      end
      `JtagState_defaultEncoding_IR_SHIFT : begin
        jtag_tap_instructionShift <= ({io_jtag_tdi,jtag_tap_instructionShift} >>> 1);
      end
      `JtagState_defaultEncoding_IR_UPDATE : begin
        jtag_tap_instruction <= jtag_tap_instructionShift;
      end
      `JtagState_defaultEncoding_DR_SHIFT : begin
        jtag_tap_bypass <= io_jtag_tdi;
      end
      default : begin
      end
    endcase
    if(jtag_idcodeArea_instructionHit)begin
      if(_zz_2_)begin
        jtag_idcodeArea_shifter <= ({io_jtag_tdi,jtag_idcodeArea_shifter} >>> 1);
      end
    end
    if((jtag_tap_fsm_state == `JtagState_defaultEncoding_RESET))begin
      jtag_idcodeArea_shifter <= (32'b00010000000000000001111111111111);
      jtag_tap_instruction <= {3'd0, jtag_idcodeArea_instructionId};
    end
    if(jtag_readArea_instructionHit)begin
      if((jtag_tap_fsm_state == `JtagState_defaultEncoding_DR_CAPTURE))begin
        jtag_readArea_shifter <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if(_zz_3_)begin
        jtag_readArea_shifter <= ({io_jtag_tdi,jtag_readArea_shifter} >>> 1);
      end
    end
  end

  always @ (negedge io_jtag_tck) begin
    jtag_tap_tdoUnbufferd_regNext <= jtag_tap_tdoUnbufferd;
  end

endmodule

module SystemDebugger (
      input   io_remote_cmd_valid,
      output  io_remote_cmd_ready,
      input   io_remote_cmd_payload_last,
      input  [0:0] io_remote_cmd_payload_fragment,
      output  io_remote_rsp_valid,
      input   io_remote_rsp_ready,
      output  io_remote_rsp_payload_error,
      output [31:0] io_remote_rsp_payload_data,
      output  io_mem_cmd_valid,
      input   io_mem_cmd_ready,
      output [31:0] io_mem_cmd_payload_address,
      output [31:0] io_mem_cmd_payload_data,
      output  io_mem_cmd_payload_wr,
      output [1:0] io_mem_cmd_payload_size,
      input   io_mem_rsp_valid,
      input  [31:0] io_mem_rsp_payload,
      input   io_mainClk,
      input   resetCtrl_mainClkReset);
  wire  _zz_2_;
  wire [0:0] _zz_3_;
  reg [66:0] dispatcher_dataShifter;
  reg  dispatcher_dataLoaded;
  reg [7:0] dispatcher_headerShifter;
  wire [7:0] dispatcher_header;
  reg  dispatcher_headerLoaded;
  reg [2:0] dispatcher_counter;
  wire [66:0] _zz_1_;
  assign _zz_2_ = (dispatcher_headerLoaded == 1'b0);
  assign _zz_3_ = _zz_1_[64 : 64];
  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_1_ = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_1_[31 : 0];
  assign io_mem_cmd_payload_data = _zz_1_[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_3_[0];
  assign io_mem_cmd_payload_size = _zz_1_[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == (8'b00000000)));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @ (posedge io_mainClk or posedge resetCtrl_mainClkReset) begin
    if (resetCtrl_mainClkReset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= (3'b000);
    end else begin
      if(io_remote_cmd_valid)begin
        if(_zz_2_)begin
          dispatcher_counter <= (dispatcher_counter + (3'b001));
          if((dispatcher_counter == (3'b111)))begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last)begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= (3'b000);
        end
      end
      if((io_mem_cmd_valid && io_mem_cmd_ready))begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(io_remote_cmd_valid)begin
      if(_zz_2_)begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end

endmodule

module MuraxPipelinedMemoryBusRam (
      input   io_bus_cmd_valid,
      output  io_bus_cmd_ready,
      input   io_bus_cmd_payload_write,
      input  [31:0] io_bus_cmd_payload_address,
      input  [31:0] io_bus_cmd_payload_data,
      input  [3:0] io_bus_cmd_payload_mask,
      output  io_bus_rsp_valid,
      output [31:0] io_bus_rsp_payload_data,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg [31:0] _zz_4_;
  wire [15:0] _zz_5_;
  reg  _zz_1_;
  wire [29:0] _zz_2_;
  wire [31:0] _zz_3_;
  reg [7:0] ram_symbol0 [0:65535];
  reg [7:0] ram_symbol1 [0:65535];
  reg [7:0] ram_symbol2 [0:65535];
  reg [7:0] ram_symbol3 [0:65535];
  reg [7:0] _zz_6_;
  reg [7:0] _zz_7_;
  reg [7:0] _zz_8_;
  reg [7:0] _zz_9_;
  assign _zz_5_ = _zz_2_[15:0];
  always @ (*) begin
    _zz_4_ = {_zz_9_, _zz_8_, _zz_7_, _zz_6_};
  end
  always @ (posedge io_mainClk) begin
    if(io_bus_cmd_payload_mask[0] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol0[_zz_5_] <= _zz_3_[7 : 0];
    end
    if(io_bus_cmd_payload_mask[1] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol1[_zz_5_] <= _zz_3_[15 : 8];
    end
    if(io_bus_cmd_payload_mask[2] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol2[_zz_5_] <= _zz_3_[23 : 16];
    end
    if(io_bus_cmd_payload_mask[3] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol3[_zz_5_] <= _zz_3_[31 : 24];
    end
    if(io_bus_cmd_valid) begin
      _zz_6_ <= ram_symbol0[_zz_5_];
      _zz_7_ <= ram_symbol1[_zz_5_];
      _zz_8_ <= ram_symbol2[_zz_5_];
      _zz_9_ <= ram_symbol3[_zz_5_];
    end
  end

  assign io_bus_rsp_valid = _zz_1_;
  assign _zz_2_ = (io_bus_cmd_payload_address >>> 2);
  assign _zz_3_ = io_bus_cmd_payload_data;
  assign io_bus_rsp_payload_data = _zz_4_;
  assign io_bus_cmd_ready = 1'b1;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      _zz_1_ <= 1'b0;
    end else begin
      _zz_1_ <= ((io_bus_cmd_valid && io_bus_cmd_ready) && (! io_bus_cmd_payload_write));
    end
  end

endmodule

module PipelinedMemoryBusToApbBridge (
      input   io_pipelinedMemoryBus_cmd_valid,
      output  io_pipelinedMemoryBus_cmd_ready,
      input   io_pipelinedMemoryBus_cmd_payload_write,
      input  [31:0] io_pipelinedMemoryBus_cmd_payload_address,
      input  [31:0] io_pipelinedMemoryBus_cmd_payload_data,
      input  [3:0] io_pipelinedMemoryBus_cmd_payload_mask,
      output  io_pipelinedMemoryBus_rsp_valid,
      output [31:0] io_pipelinedMemoryBus_rsp_payload_data,
      output [19:0] io_apb_PADDR,
      output [0:0] io_apb_PSEL,
      output  io_apb_PENABLE,
      input   io_apb_PREADY,
      output  io_apb_PWRITE,
      output [31:0] io_apb_PWDATA,
      input  [31:0] io_apb_PRDATA,
      input   io_apb_PSLVERROR,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_1_;
  wire  _zz_2_;
  wire  pipelinedMemoryBusStage_cmd_valid;
  reg  pipelinedMemoryBusStage_cmd_ready;
  wire  pipelinedMemoryBusStage_cmd_payload_write;
  wire [31:0] pipelinedMemoryBusStage_cmd_payload_address;
  wire [31:0] pipelinedMemoryBusStage_cmd_payload_data;
  wire [3:0] pipelinedMemoryBusStage_cmd_payload_mask;
  reg  pipelinedMemoryBusStage_rsp_valid;
  wire [31:0] pipelinedMemoryBusStage_rsp_payload_data;
  wire  io_pipelinedMemoryBus_cmd_halfPipe_valid;
  wire  io_pipelinedMemoryBus_cmd_halfPipe_ready;
  wire  io_pipelinedMemoryBus_cmd_halfPipe_payload_write;
  wire [31:0] io_pipelinedMemoryBus_cmd_halfPipe_payload_address;
  wire [31:0] io_pipelinedMemoryBus_cmd_halfPipe_payload_data;
  wire [3:0] io_pipelinedMemoryBus_cmd_halfPipe_payload_mask;
  reg  io_pipelinedMemoryBus_cmd_halfPipe_regs_valid;
  reg  io_pipelinedMemoryBus_cmd_halfPipe_regs_ready;
  reg  io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_write;
  reg [31:0] io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_address;
  reg [31:0] io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_data;
  reg [3:0] io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_mask;
  reg  pipelinedMemoryBusStage_rsp_m2sPipe_valid;
  reg [31:0] pipelinedMemoryBusStage_rsp_m2sPipe_payload_data;
  reg  state;
  assign _zz_1_ = (! state);
  assign _zz_2_ = (! io_pipelinedMemoryBus_cmd_halfPipe_regs_valid);
  assign io_pipelinedMemoryBus_cmd_halfPipe_valid = io_pipelinedMemoryBus_cmd_halfPipe_regs_valid;
  assign io_pipelinedMemoryBus_cmd_halfPipe_payload_write = io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_write;
  assign io_pipelinedMemoryBus_cmd_halfPipe_payload_address = io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_address;
  assign io_pipelinedMemoryBus_cmd_halfPipe_payload_data = io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_data;
  assign io_pipelinedMemoryBus_cmd_halfPipe_payload_mask = io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_mask;
  assign io_pipelinedMemoryBus_cmd_ready = io_pipelinedMemoryBus_cmd_halfPipe_regs_ready;
  assign pipelinedMemoryBusStage_cmd_valid = io_pipelinedMemoryBus_cmd_halfPipe_valid;
  assign io_pipelinedMemoryBus_cmd_halfPipe_ready = pipelinedMemoryBusStage_cmd_ready;
  assign pipelinedMemoryBusStage_cmd_payload_write = io_pipelinedMemoryBus_cmd_halfPipe_payload_write;
  assign pipelinedMemoryBusStage_cmd_payload_address = io_pipelinedMemoryBus_cmd_halfPipe_payload_address;
  assign pipelinedMemoryBusStage_cmd_payload_data = io_pipelinedMemoryBus_cmd_halfPipe_payload_data;
  assign pipelinedMemoryBusStage_cmd_payload_mask = io_pipelinedMemoryBus_cmd_halfPipe_payload_mask;
  assign io_pipelinedMemoryBus_rsp_valid = pipelinedMemoryBusStage_rsp_m2sPipe_valid;
  assign io_pipelinedMemoryBus_rsp_payload_data = pipelinedMemoryBusStage_rsp_m2sPipe_payload_data;
  always @ (*) begin
    pipelinedMemoryBusStage_cmd_ready = 1'b0;
    if(! _zz_1_) begin
      if(io_apb_PREADY)begin
        pipelinedMemoryBusStage_cmd_ready = 1'b1;
      end
    end
  end

  assign io_apb_PSEL[0] = pipelinedMemoryBusStage_cmd_valid;
  assign io_apb_PENABLE = state;
  assign io_apb_PWRITE = pipelinedMemoryBusStage_cmd_payload_write;
  assign io_apb_PADDR = pipelinedMemoryBusStage_cmd_payload_address[19:0];
  assign io_apb_PWDATA = pipelinedMemoryBusStage_cmd_payload_data;
  always @ (*) begin
    pipelinedMemoryBusStage_rsp_valid = 1'b0;
    if(! _zz_1_) begin
      if(io_apb_PREADY)begin
        pipelinedMemoryBusStage_rsp_valid = (! pipelinedMemoryBusStage_cmd_payload_write);
      end
    end
  end

  assign pipelinedMemoryBusStage_rsp_payload_data = io_apb_PRDATA;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      io_pipelinedMemoryBus_cmd_halfPipe_regs_valid <= 1'b0;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_ready <= 1'b1;
      pipelinedMemoryBusStage_rsp_m2sPipe_valid <= 1'b0;
      state <= 1'b0;
    end else begin
      if(_zz_2_)begin
        io_pipelinedMemoryBus_cmd_halfPipe_regs_valid <= io_pipelinedMemoryBus_cmd_valid;
        io_pipelinedMemoryBus_cmd_halfPipe_regs_ready <= (! io_pipelinedMemoryBus_cmd_valid);
      end else begin
        io_pipelinedMemoryBus_cmd_halfPipe_regs_valid <= (! io_pipelinedMemoryBus_cmd_halfPipe_ready);
        io_pipelinedMemoryBus_cmd_halfPipe_regs_ready <= io_pipelinedMemoryBus_cmd_halfPipe_ready;
      end
      pipelinedMemoryBusStage_rsp_m2sPipe_valid <= pipelinedMemoryBusStage_rsp_valid;
      if(_zz_1_)begin
        state <= pipelinedMemoryBusStage_cmd_valid;
      end else begin
        if(io_apb_PREADY)begin
          state <= 1'b0;
        end
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_2_)begin
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_write <= io_pipelinedMemoryBus_cmd_payload_write;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_address <= io_pipelinedMemoryBus_cmd_payload_address;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_data <= io_pipelinedMemoryBus_cmd_payload_data;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_mask <= io_pipelinedMemoryBus_cmd_payload_mask;
    end
    if(pipelinedMemoryBusStage_rsp_valid)begin
      pipelinedMemoryBusStage_rsp_m2sPipe_payload_data <= pipelinedMemoryBusStage_rsp_payload_data;
    end
  end

endmodule

module Apb3Gpio (
      input  [3:0] io_apb_PADDR,
      input  [0:0] io_apb_PSEL,
      input   io_apb_PENABLE,
      output  io_apb_PREADY,
      input   io_apb_PWRITE,
      input  [31:0] io_apb_PWDATA,
      output reg [31:0] io_apb_PRDATA,
      output  io_apb_PSLVERROR,
      input  [31:0] io_gpio_read,
      output [31:0] io_gpio_write,
      output [31:0] io_gpio_writeEnable,
      output [31:0] io_value,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire [31:0] bufferCC_4__io_dataOut;
  wire  ctrl_askWrite;
  wire  ctrl_askRead;
  wire  ctrl_doWrite;
  wire  ctrl_doRead;
  reg [31:0] io_gpio_write_driver;
  reg [31:0] io_gpio_writeEnable_driver;
  BufferCC_2_ bufferCC_4_ ( 
    .io_dataIn(io_gpio_read),
    .io_dataOut(bufferCC_4__io_dataOut),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  assign io_value = bufferCC_4__io_dataOut;
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = (32'b00000000000000000000000000000000);
    case(io_apb_PADDR)
      4'b0000 : begin
        io_apb_PRDATA[31 : 0] = io_value;
      end
      4'b0100 : begin
        io_apb_PRDATA[31 : 0] = io_gpio_write_driver;
      end
      4'b1000 : begin
        io_apb_PRDATA[31 : 0] = io_gpio_writeEnable_driver;
      end
      default : begin
      end
    endcase
  end

  assign io_apb_PSLVERROR = 1'b0;
  assign ctrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign ctrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign ctrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign ctrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign io_gpio_write = io_gpio_write_driver;
  assign io_gpio_writeEnable = io_gpio_writeEnable_driver;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      io_gpio_writeEnable_driver <= (32'b00000000000000000000000000000000);
    end else begin
      case(io_apb_PADDR)
        4'b0000 : begin
        end
        4'b0100 : begin
        end
        4'b1000 : begin
          if(ctrl_doWrite)begin
            io_gpio_writeEnable_driver <= io_apb_PWDATA[31 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    case(io_apb_PADDR)
      4'b0000 : begin
      end
      4'b0100 : begin
        if(ctrl_doWrite)begin
          io_gpio_write_driver <= io_apb_PWDATA[31 : 0];
        end
      end
      4'b1000 : begin
      end
      default : begin
      end
    endcase
  end

endmodule

module Apb3UartCtrl (
      input  [3:0] io_apb_PADDR,
      input  [0:0] io_apb_PSEL,
      input   io_apb_PENABLE,
      output  io_apb_PREADY,
      input   io_apb_PWRITE,
      input  [31:0] io_apb_PWDATA,
      output reg [31:0] io_apb_PRDATA,
      output  io_uart_txd,
      input   io_uart_rxd,
      output  io_interrupt,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_3_;
  reg  _zz_4_;
  wire  _zz_5_;
  wire  uartCtrl_1__io_write_ready;
  wire  uartCtrl_1__io_read_valid;
  wire [7:0] uartCtrl_1__io_read_payload;
  wire  uartCtrl_1__io_uart_txd;
  wire  bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  wire  bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
  wire [7:0] bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload;
  wire [4:0] bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy;
  wire [4:0] bridge_write_streamUnbuffered_queueWithOccupancy_io_availability;
  wire  uartCtrl_1__io_read_queueWithOccupancy_io_push_ready;
  wire  uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid;
  wire [7:0] uartCtrl_1__io_read_queueWithOccupancy_io_pop_payload;
  wire [4:0] uartCtrl_1__io_read_queueWithOccupancy_io_occupancy;
  wire [4:0] uartCtrl_1__io_read_queueWithOccupancy_io_availability;
  wire [0:0] _zz_6_;
  wire [0:0] _zz_7_;
  wire [4:0] _zz_8_;
  wire  busCtrl_askWrite;
  wire  busCtrl_askRead;
  wire  busCtrl_doWrite;
  wire  busCtrl_doRead;
  wire [2:0] bridge_uartConfigReg_frame_dataLength;
  wire `UartStopType_defaultEncoding_type bridge_uartConfigReg_frame_stop;
  wire `UartParityType_defaultEncoding_type bridge_uartConfigReg_frame_parity;
  reg [19:0] bridge_uartConfigReg_clockDivider;
  reg  _zz_1_;
  wire  bridge_write_streamUnbuffered_valid;
  wire  bridge_write_streamUnbuffered_ready;
  wire [7:0] bridge_write_streamUnbuffered_payload;
  reg  bridge_interruptCtrl_writeIntEnable;
  reg  bridge_interruptCtrl_readIntEnable;
  wire  bridge_interruptCtrl_readInt;
  wire  bridge_interruptCtrl_writeInt;
  wire  bridge_interruptCtrl_interrupt;
  wire [7:0] _zz_2_;
  `ifndef SYNTHESIS
  reg [23:0] bridge_uartConfigReg_frame_stop_string;
  reg [31:0] bridge_uartConfigReg_frame_parity_string;
  `endif

  function [19:0] zz_bridge_uartConfigReg_clockDivider(input dummy);
    begin
      zz_bridge_uartConfigReg_clockDivider = (20'b00000000000000000000);
      zz_bridge_uartConfigReg_clockDivider = (20'b00000000000001010101);
    end
  endfunction
  wire [19:0] _zz_9_;
  assign _zz_6_ = io_apb_PWDATA[0 : 0];
  assign _zz_7_ = io_apb_PWDATA[1 : 1];
  assign _zz_8_ = ((5'b10000) - bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy);
  UartCtrl uartCtrl_1_ ( 
    .io_config_frame_dataLength(bridge_uartConfigReg_frame_dataLength),
    .io_config_frame_stop(bridge_uartConfigReg_frame_stop),
    .io_config_frame_parity(bridge_uartConfigReg_frame_parity),
    .io_config_clockDivider(bridge_uartConfigReg_clockDivider),
    .io_write_valid(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid),
    .io_write_ready(uartCtrl_1__io_write_ready),
    .io_write_payload(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload),
    .io_read_valid(uartCtrl_1__io_read_valid),
    .io_read_payload(uartCtrl_1__io_read_payload),
    .io_uart_txd(uartCtrl_1__io_uart_txd),
    .io_uart_rxd(io_uart_rxd),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  StreamFifo bridge_write_streamUnbuffered_queueWithOccupancy ( 
    .io_push_valid(bridge_write_streamUnbuffered_valid),
    .io_push_ready(bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready),
    .io_push_payload(bridge_write_streamUnbuffered_payload),
    .io_pop_valid(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid),
    .io_pop_ready(uartCtrl_1__io_write_ready),
    .io_pop_payload(bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload),
    .io_flush(_zz_3_),
    .io_occupancy(bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy),
    .io_availability(bridge_write_streamUnbuffered_queueWithOccupancy_io_availability),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  StreamFifo uartCtrl_1__io_read_queueWithOccupancy ( 
    .io_push_valid(uartCtrl_1__io_read_valid),
    .io_push_ready(uartCtrl_1__io_read_queueWithOccupancy_io_push_ready),
    .io_push_payload(uartCtrl_1__io_read_payload),
    .io_pop_valid(uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid),
    .io_pop_ready(_zz_4_),
    .io_pop_payload(uartCtrl_1__io_read_queueWithOccupancy_io_pop_payload),
    .io_flush(_zz_5_),
    .io_occupancy(uartCtrl_1__io_read_queueWithOccupancy_io_occupancy),
    .io_availability(uartCtrl_1__io_read_queueWithOccupancy_io_availability),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(bridge_uartConfigReg_frame_stop)
      `UartStopType_defaultEncoding_ONE : bridge_uartConfigReg_frame_stop_string = "ONE";
      `UartStopType_defaultEncoding_TWO : bridge_uartConfigReg_frame_stop_string = "TWO";
      default : bridge_uartConfigReg_frame_stop_string = "???";
    endcase
  end
  always @(*) begin
    case(bridge_uartConfigReg_frame_parity)
      `UartParityType_defaultEncoding_NONE : bridge_uartConfigReg_frame_parity_string = "NONE";
      `UartParityType_defaultEncoding_EVEN : bridge_uartConfigReg_frame_parity_string = "EVEN";
      `UartParityType_defaultEncoding_ODD : bridge_uartConfigReg_frame_parity_string = "ODD ";
      default : bridge_uartConfigReg_frame_parity_string = "????";
    endcase
  end
  `endif

  assign io_uart_txd = uartCtrl_1__io_uart_txd;
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = (32'b00000000000000000000000000000000);
    case(io_apb_PADDR)
      4'b0000 : begin
        io_apb_PRDATA[16 : 16] = (uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid ^ 1'b0);
        io_apb_PRDATA[7 : 0] = uartCtrl_1__io_read_queueWithOccupancy_io_pop_payload;
      end
      4'b0100 : begin
        io_apb_PRDATA[20 : 16] = _zz_8_;
        io_apb_PRDATA[28 : 24] = uartCtrl_1__io_read_queueWithOccupancy_io_occupancy;
        io_apb_PRDATA[0 : 0] = bridge_interruptCtrl_writeIntEnable;
        io_apb_PRDATA[1 : 1] = bridge_interruptCtrl_readIntEnable;
        io_apb_PRDATA[8 : 8] = bridge_interruptCtrl_writeInt;
        io_apb_PRDATA[9 : 9] = bridge_interruptCtrl_readInt;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign _zz_9_ = zz_bridge_uartConfigReg_clockDivider(1'b0);
  always @ (*) bridge_uartConfigReg_clockDivider = _zz_9_;
  assign bridge_uartConfigReg_frame_dataLength = (3'b111);
  assign bridge_uartConfigReg_frame_parity = `UartParityType_defaultEncoding_NONE;
  assign bridge_uartConfigReg_frame_stop = `UartStopType_defaultEncoding_ONE;
  always @ (*) begin
    _zz_1_ = 1'b0;
    case(io_apb_PADDR)
      4'b0000 : begin
        if(busCtrl_doWrite)begin
          _zz_1_ = 1'b1;
        end
      end
      4'b0100 : begin
      end
      default : begin
      end
    endcase
  end

  assign bridge_write_streamUnbuffered_valid = _zz_1_;
  assign bridge_write_streamUnbuffered_payload = _zz_2_;
  assign bridge_write_streamUnbuffered_ready = bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  always @ (*) begin
    _zz_4_ = 1'b0;
    case(io_apb_PADDR)
      4'b0000 : begin
        if(busCtrl_doRead)begin
          _zz_4_ = 1'b1;
        end
      end
      4'b0100 : begin
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_readInt = (bridge_interruptCtrl_readIntEnable && uartCtrl_1__io_read_queueWithOccupancy_io_pop_valid);
  assign bridge_interruptCtrl_writeInt = (bridge_interruptCtrl_writeIntEnable && (! bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid));
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_readInt || bridge_interruptCtrl_writeInt);
  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign _zz_2_ = io_apb_PWDATA[7 : 0];
  assign _zz_3_ = 1'b0;
  assign _zz_5_ = 1'b0;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      bridge_interruptCtrl_writeIntEnable <= 1'b0;
      bridge_interruptCtrl_readIntEnable <= 1'b0;
    end else begin
      case(io_apb_PADDR)
        4'b0000 : begin
        end
        4'b0100 : begin
          if(busCtrl_doWrite)begin
            bridge_interruptCtrl_writeIntEnable <= _zz_6_[0];
            bridge_interruptCtrl_readIntEnable <= _zz_7_[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

endmodule

module MuraxApb3Timer (
      input  [7:0] io_apb_PADDR,
      input  [0:0] io_apb_PSEL,
      input   io_apb_PENABLE,
      output  io_apb_PREADY,
      input   io_apb_PWRITE,
      input  [31:0] io_apb_PWDATA,
      output reg [31:0] io_apb_PRDATA,
      output  io_apb_PSLVERROR,
      output  io_interrupt,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_7_;
  wire  _zz_8_;
  wire  _zz_9_;
  wire  _zz_10_;
  reg [1:0] _zz_11_;
  reg [1:0] _zz_12_;
  wire  prescaler_1__io_overflow;
  wire  timerA_io_full;
  wire [15:0] timerA_io_value;
  wire  timerB_io_full;
  wire [15:0] timerB_io_value;
  wire [1:0] interruptCtrl_1__io_pendings;
  wire  busCtrl_askWrite;
  wire  busCtrl_askRead;
  wire  busCtrl_doWrite;
  wire  busCtrl_doRead;
  reg [15:0] _zz_1_;
  reg  _zz_2_;
  reg [1:0] timerABridge_ticksEnable;
  reg [0:0] timerABridge_clearsEnable;
  reg  timerABridge_busClearing;
  reg [15:0] timerA_io_limit_driver;
  reg  _zz_3_;
  reg  _zz_4_;
  reg [1:0] timerBBridge_ticksEnable;
  reg [0:0] timerBBridge_clearsEnable;
  reg  timerBBridge_busClearing;
  reg [15:0] timerB_io_limit_driver;
  reg  _zz_5_;
  reg  _zz_6_;
  reg [1:0] interruptCtrl_1__io_masks_driver;
  Prescaler prescaler_1_ ( 
    .io_clear(_zz_2_),
    .io_limit(_zz_1_),
    .io_overflow(prescaler_1__io_overflow),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  Timer timerA ( 
    .io_tick(_zz_7_),
    .io_clear(_zz_8_),
    .io_limit(timerA_io_limit_driver),
    .io_full(timerA_io_full),
    .io_value(timerA_io_value),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  Timer timerB ( 
    .io_tick(_zz_9_),
    .io_clear(_zz_10_),
    .io_limit(timerB_io_limit_driver),
    .io_full(timerB_io_full),
    .io_value(timerB_io_value),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  InterruptCtrl interruptCtrl_1_ ( 
    .io_inputs(_zz_11_),
    .io_clears(_zz_12_),
    .io_masks(interruptCtrl_1__io_masks_driver),
    .io_pendings(interruptCtrl_1__io_pendings),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = (32'b00000000000000000000000000000000);
    case(io_apb_PADDR)
      8'b00000000 : begin
        io_apb_PRDATA[15 : 0] = _zz_1_;
      end
      8'b01000000 : begin
        io_apb_PRDATA[1 : 0] = timerABridge_ticksEnable;
        io_apb_PRDATA[16 : 16] = timerABridge_clearsEnable;
      end
      8'b01000100 : begin
        io_apb_PRDATA[15 : 0] = timerA_io_limit_driver;
      end
      8'b01001000 : begin
        io_apb_PRDATA[15 : 0] = timerA_io_value;
      end
      8'b01010000 : begin
        io_apb_PRDATA[1 : 0] = timerBBridge_ticksEnable;
        io_apb_PRDATA[16 : 16] = timerBBridge_clearsEnable;
      end
      8'b01010100 : begin
        io_apb_PRDATA[15 : 0] = timerB_io_limit_driver;
      end
      8'b01011000 : begin
        io_apb_PRDATA[15 : 0] = timerB_io_value;
      end
      8'b00010000 : begin
        io_apb_PRDATA[1 : 0] = interruptCtrl_1__io_pendings;
      end
      8'b00010100 : begin
        io_apb_PRDATA[1 : 0] = interruptCtrl_1__io_masks_driver;
      end
      default : begin
      end
    endcase
  end

  assign io_apb_PSLVERROR = 1'b0;
  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  always @ (*) begin
    _zz_2_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
        if(busCtrl_doWrite)begin
          _zz_2_ = 1'b1;
        end
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
      end
      8'b01001000 : begin
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
      end
      8'b01011000 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    timerABridge_busClearing = 1'b0;
    if(_zz_3_)begin
      timerABridge_busClearing = 1'b1;
    end
    if(_zz_4_)begin
      timerABridge_busClearing = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
        if(busCtrl_doWrite)begin
          _zz_3_ = 1'b1;
        end
      end
      8'b01001000 : begin
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
      end
      8'b01011000 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_4_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
      end
      8'b01001000 : begin
        if(busCtrl_doWrite)begin
          _zz_4_ = 1'b1;
        end
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
      end
      8'b01011000 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

  assign _zz_8_ = (((timerABridge_clearsEnable & timerA_io_full) != (1'b0)) || timerABridge_busClearing);
  assign _zz_7_ = ((timerABridge_ticksEnable & {prescaler_1__io_overflow,1'b1}) != (2'b00));
  always @ (*) begin
    timerBBridge_busClearing = 1'b0;
    if(_zz_5_)begin
      timerBBridge_busClearing = 1'b1;
    end
    if(_zz_6_)begin
      timerBBridge_busClearing = 1'b1;
    end
  end

  always @ (*) begin
    _zz_5_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
      end
      8'b01001000 : begin
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
        if(busCtrl_doWrite)begin
          _zz_5_ = 1'b1;
        end
      end
      8'b01011000 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_6_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
      end
      8'b01001000 : begin
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
      end
      8'b01011000 : begin
        if(busCtrl_doWrite)begin
          _zz_6_ = 1'b1;
        end
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

  assign _zz_10_ = (((timerBBridge_clearsEnable & timerB_io_full) != (1'b0)) || timerBBridge_busClearing);
  assign _zz_9_ = ((timerBBridge_ticksEnable & {prescaler_1__io_overflow,1'b1}) != (2'b00));
  always @ (*) begin
    _zz_12_ = (2'b00);
    case(io_apb_PADDR)
      8'b00000000 : begin
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
      end
      8'b01001000 : begin
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
      end
      8'b01011000 : begin
      end
      8'b00010000 : begin
        if(busCtrl_doWrite)begin
          _zz_12_ = io_apb_PWDATA[1 : 0];
        end
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_11_[0] = timerA_io_full;
    _zz_11_[1] = timerB_io_full;
  end

  assign io_interrupt = (interruptCtrl_1__io_pendings != (2'b00));
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      timerABridge_ticksEnable <= (2'b00);
      timerABridge_clearsEnable <= (1'b0);
      timerBBridge_ticksEnable <= (2'b00);
      timerBBridge_clearsEnable <= (1'b0);
      interruptCtrl_1__io_masks_driver <= (2'b00);
    end else begin
      case(io_apb_PADDR)
        8'b00000000 : begin
        end
        8'b01000000 : begin
          if(busCtrl_doWrite)begin
            timerABridge_ticksEnable <= io_apb_PWDATA[1 : 0];
            timerABridge_clearsEnable <= io_apb_PWDATA[16 : 16];
          end
        end
        8'b01000100 : begin
        end
        8'b01001000 : begin
        end
        8'b01010000 : begin
          if(busCtrl_doWrite)begin
            timerBBridge_ticksEnable <= io_apb_PWDATA[1 : 0];
            timerBBridge_clearsEnable <= io_apb_PWDATA[16 : 16];
          end
        end
        8'b01010100 : begin
        end
        8'b01011000 : begin
        end
        8'b00010000 : begin
        end
        8'b00010100 : begin
          if(busCtrl_doWrite)begin
            interruptCtrl_1__io_masks_driver <= io_apb_PWDATA[1 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    case(io_apb_PADDR)
      8'b00000000 : begin
        if(busCtrl_doWrite)begin
          _zz_1_ <= io_apb_PWDATA[15 : 0];
        end
      end
      8'b01000000 : begin
      end
      8'b01000100 : begin
        if(busCtrl_doWrite)begin
          timerA_io_limit_driver <= io_apb_PWDATA[15 : 0];
        end
      end
      8'b01001000 : begin
      end
      8'b01010000 : begin
      end
      8'b01010100 : begin
        if(busCtrl_doWrite)begin
          timerB_io_limit_driver <= io_apb_PWDATA[15 : 0];
        end
      end
      8'b01011000 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      default : begin
      end
    endcase
  end

endmodule

module Apb3SpiMasterCtrl (
      input  [7:0] io_apb_PADDR,
      input  [0:0] io_apb_PSEL,
      input   io_apb_PENABLE,
      output  io_apb_PREADY,
      input   io_apb_PWRITE,
      input  [31:0] io_apb_PWDATA,
      output reg [31:0] io_apb_PRDATA,
      output [0:0] io_spi_ss,
      output  io_spi_sclk,
      output  io_spi_mosi,
      input   io_spi_miso,
      output  io_interrupt,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  wire  _zz_11_;
  reg  _zz_12_;
  wire  _zz_13_;
  wire  spiCtrl_io_cmd_ready;
  wire  spiCtrl_io_rsp_valid;
  wire [7:0] spiCtrl_io_rsp_payload;
  wire  spiCtrl_io_spi_sclk;
  wire  spiCtrl_io_spi_mosi;
  wire [0:0] spiCtrl_io_spi_ss;
  wire  bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready;
  wire  bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid;
  wire `SpiMasterCtrlCmdMode_defaultEncoding_type bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_mode;
  wire [8:0] bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_args;
  wire [5:0] bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_occupancy;
  wire [5:0] bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability;
  wire  spiCtrl_io_rsp_queueWithOccupancy_io_push_ready;
  wire  spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid;
  wire [7:0] spiCtrl_io_rsp_queueWithOccupancy_io_pop_payload;
  wire [5:0] spiCtrl_io_rsp_queueWithOccupancy_io_occupancy;
  wire [5:0] spiCtrl_io_rsp_queueWithOccupancy_io_availability;
  wire [0:0] _zz_14_;
  wire [0:0] _zz_15_;
  wire [0:0] _zz_16_;
  wire [0:0] _zz_17_;
  wire [0:0] _zz_18_;
  wire [0:0] _zz_19_;
  wire [0:0] _zz_20_;
  wire  busCtrl_askWrite;
  wire  busCtrl_askRead;
  wire  busCtrl_doWrite;
  wire  busCtrl_doRead;
  wire  bridge_cmdLogic_streamUnbuffered_valid;
  wire  bridge_cmdLogic_streamUnbuffered_ready;
  wire `SpiMasterCtrlCmdMode_defaultEncoding_type bridge_cmdLogic_streamUnbuffered_payload_mode;
  reg [8:0] bridge_cmdLogic_streamUnbuffered_payload_args;
  reg  _zz_1_;
  wire [7:0] bridge_cmdLogic_dataCmd_data;
  wire  bridge_cmdLogic_dataCmd_read;
  reg  bridge_interruptCtrl_cmdIntEnable;
  reg  bridge_interruptCtrl_rspIntEnable;
  wire  bridge_interruptCtrl_cmdInt;
  wire  bridge_interruptCtrl_rspInt;
  wire  bridge_interruptCtrl_interrupt;
  reg  _zz_2_;
  reg  _zz_3_;
  reg [15:0] _zz_4_;
  reg [0:0] _zz_5_;
  reg [15:0] _zz_6_;
  reg [15:0] _zz_7_;
  reg [15:0] _zz_8_;
  wire `SpiMasterCtrlCmdMode_defaultEncoding_type _zz_9_;
  wire [1:0] _zz_10_;
  `ifndef SYNTHESIS
  reg [31:0] bridge_cmdLogic_streamUnbuffered_payload_mode_string;
  reg [31:0] _zz_9__string;
  `endif

  assign _zz_14_ = _zz_15_[0];
  assign _zz_15_ = io_apb_PWDATA[24 : 24];
  assign _zz_16_ = io_apb_PWDATA[24 : 24];
  assign _zz_17_ = io_apb_PWDATA[0 : 0];
  assign _zz_18_ = io_apb_PWDATA[1 : 1];
  assign _zz_19_ = _zz_10_[0 : 0];
  assign _zz_20_ = _zz_10_[1 : 1];
  SpiMasterCtrl spiCtrl ( 
    .io_config_kind_cpol(_zz_2_),
    .io_config_kind_cpha(_zz_3_),
    .io_config_sclkToogle(_zz_4_),
    .io_config_ss_activeHigh(_zz_5_),
    .io_config_ss_setup(_zz_6_),
    .io_config_ss_hold(_zz_7_),
    .io_config_ss_disable(_zz_8_),
    .io_cmd_valid(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid),
    .io_cmd_ready(spiCtrl_io_cmd_ready),
    .io_cmd_payload_mode(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_mode),
    .io_cmd_payload_args(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_args),
    .io_rsp_valid(spiCtrl_io_rsp_valid),
    .io_rsp_payload(spiCtrl_io_rsp_payload),
    .io_spi_ss(spiCtrl_io_spi_ss),
    .io_spi_sclk(spiCtrl_io_spi_sclk),
    .io_spi_mosi(spiCtrl_io_spi_mosi),
    .io_spi_miso(io_spi_miso),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  StreamFifo_2_ bridge_cmdLogic_streamUnbuffered_queueWithAvailability ( 
    .io_push_valid(bridge_cmdLogic_streamUnbuffered_valid),
    .io_push_ready(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready),
    .io_push_payload_mode(bridge_cmdLogic_streamUnbuffered_payload_mode),
    .io_push_payload_args(bridge_cmdLogic_streamUnbuffered_payload_args),
    .io_pop_valid(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid),
    .io_pop_ready(spiCtrl_io_cmd_ready),
    .io_pop_payload_mode(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_mode),
    .io_pop_payload_args(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_payload_args),
    .io_flush(_zz_11_),
    .io_occupancy(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_occupancy),
    .io_availability(bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  StreamFifo_3_ spiCtrl_io_rsp_queueWithOccupancy ( 
    .io_push_valid(spiCtrl_io_rsp_valid),
    .io_push_ready(spiCtrl_io_rsp_queueWithOccupancy_io_push_ready),
    .io_push_payload(spiCtrl_io_rsp_payload),
    .io_pop_valid(spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid),
    .io_pop_ready(_zz_12_),
    .io_pop_payload(spiCtrl_io_rsp_queueWithOccupancy_io_pop_payload),
    .io_flush(_zz_13_),
    .io_occupancy(spiCtrl_io_rsp_queueWithOccupancy_io_occupancy),
    .io_availability(spiCtrl_io_rsp_queueWithOccupancy_io_availability),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  `ifndef SYNTHESIS
  always @(*) begin
    case(bridge_cmdLogic_streamUnbuffered_payload_mode)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : bridge_cmdLogic_streamUnbuffered_payload_mode_string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : bridge_cmdLogic_streamUnbuffered_payload_mode_string = "SS  ";
      default : bridge_cmdLogic_streamUnbuffered_payload_mode_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_9_)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : _zz_9__string = "DATA";
      `SpiMasterCtrlCmdMode_defaultEncoding_SS : _zz_9__string = "SS  ";
      default : _zz_9__string = "????";
    endcase
  end
  `endif

  assign io_spi_ss = spiCtrl_io_spi_ss;
  assign io_spi_sclk = spiCtrl_io_spi_sclk;
  assign io_spi_mosi = spiCtrl_io_spi_mosi;
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = (32'b00000000000000000000000000000000);
    case(io_apb_PADDR)
      8'b00000000 : begin
        io_apb_PRDATA[31 : 31] = (spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid ^ 1'b0);
        io_apb_PRDATA[7 : 0] = spiCtrl_io_rsp_queueWithOccupancy_io_pop_payload;
        io_apb_PRDATA[21 : 16] = spiCtrl_io_rsp_queueWithOccupancy_io_occupancy;
      end
      8'b00000100 : begin
        io_apb_PRDATA[21 : 16] = bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_availability;
        io_apb_PRDATA[0 : 0] = bridge_interruptCtrl_cmdIntEnable;
        io_apb_PRDATA[1 : 1] = bridge_interruptCtrl_rspIntEnable;
        io_apb_PRDATA[8 : 8] = bridge_interruptCtrl_cmdInt;
        io_apb_PRDATA[9 : 9] = bridge_interruptCtrl_rspInt;
      end
      8'b00001000 : begin
      end
      8'b00001100 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      8'b00011000 : begin
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  always @ (*) begin
    _zz_1_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
        if(busCtrl_doWrite)begin
          _zz_1_ = 1'b1;
        end
      end
      8'b00000100 : begin
      end
      8'b00001000 : begin
      end
      8'b00001100 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      8'b00011000 : begin
      end
      default : begin
      end
    endcase
  end

  assign bridge_cmdLogic_streamUnbuffered_valid = _zz_1_;
  always @ (*) begin
    case(bridge_cmdLogic_streamUnbuffered_payload_mode)
      `SpiMasterCtrlCmdMode_defaultEncoding_DATA : begin
        bridge_cmdLogic_streamUnbuffered_payload_args = {bridge_cmdLogic_dataCmd_read,bridge_cmdLogic_dataCmd_data};
      end
      default : begin
        bridge_cmdLogic_streamUnbuffered_payload_args = {8'd0, _zz_14_};
      end
    endcase
  end

  assign bridge_cmdLogic_streamUnbuffered_ready = bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_push_ready;
  always @ (*) begin
    _zz_12_ = 1'b0;
    case(io_apb_PADDR)
      8'b00000000 : begin
        if(busCtrl_doRead)begin
          _zz_12_ = 1'b1;
        end
      end
      8'b00000100 : begin
      end
      8'b00001000 : begin
      end
      8'b00001100 : begin
      end
      8'b00010000 : begin
      end
      8'b00010100 : begin
      end
      8'b00011000 : begin
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_cmdInt = (bridge_interruptCtrl_cmdIntEnable && (! bridge_cmdLogic_streamUnbuffered_queueWithAvailability_io_pop_valid));
  assign bridge_interruptCtrl_rspInt = (bridge_interruptCtrl_rspIntEnable && spiCtrl_io_rsp_queueWithOccupancy_io_pop_valid);
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_rspInt || bridge_interruptCtrl_cmdInt);
  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign bridge_cmdLogic_dataCmd_data = io_apb_PWDATA[7 : 0];
  assign bridge_cmdLogic_dataCmd_read = _zz_16_[0];
  assign _zz_9_ = io_apb_PWDATA[28 : 28];
  assign bridge_cmdLogic_streamUnbuffered_payload_mode = _zz_9_;
  assign _zz_10_ = io_apb_PWDATA[1 : 0];
  assign _zz_11_ = 1'b0;
  assign _zz_13_ = 1'b0;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      bridge_interruptCtrl_cmdIntEnable <= 1'b0;
      bridge_interruptCtrl_rspIntEnable <= 1'b0;
      _zz_5_ <= (1'b0);
    end else begin
      case(io_apb_PADDR)
        8'b00000000 : begin
        end
        8'b00000100 : begin
          if(busCtrl_doWrite)begin
            bridge_interruptCtrl_cmdIntEnable <= _zz_17_[0];
            bridge_interruptCtrl_rspIntEnable <= _zz_18_[0];
          end
        end
        8'b00001000 : begin
          if(busCtrl_doWrite)begin
            _zz_5_ <= io_apb_PWDATA[4 : 4];
          end
        end
        8'b00001100 : begin
        end
        8'b00010000 : begin
        end
        8'b00010100 : begin
        end
        8'b00011000 : begin
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    case(io_apb_PADDR)
      8'b00000000 : begin
      end
      8'b00000100 : begin
      end
      8'b00001000 : begin
        if(busCtrl_doWrite)begin
          _zz_2_ <= _zz_19_[0];
          _zz_3_ <= _zz_20_[0];
        end
      end
      8'b00001100 : begin
        if(busCtrl_doWrite)begin
          _zz_4_ <= io_apb_PWDATA[15 : 0];
        end
      end
      8'b00010000 : begin
        if(busCtrl_doWrite)begin
          _zz_6_ <= io_apb_PWDATA[15 : 0];
        end
      end
      8'b00010100 : begin
        if(busCtrl_doWrite)begin
          _zz_7_ <= io_apb_PWDATA[15 : 0];
        end
      end
      8'b00011000 : begin
        if(busCtrl_doWrite)begin
          _zz_8_ <= io_apb_PWDATA[15 : 0];
        end
      end
      default : begin
      end
    endcase
  end

endmodule

module Apb3Decoder (
      input  [19:0] io_input_PADDR,
      input  [0:0] io_input_PSEL,
      input   io_input_PENABLE,
      output reg  io_input_PREADY,
      input   io_input_PWRITE,
      input  [31:0] io_input_PWDATA,
      output [31:0] io_input_PRDATA,
      output reg  io_input_PSLVERROR,
      output [19:0] io_output_PADDR,
      output reg [3:0] io_output_PSEL,
      output  io_output_PENABLE,
      input   io_output_PREADY,
      output  io_output_PWRITE,
      output [31:0] io_output_PWDATA,
      input  [31:0] io_output_PRDATA,
      input   io_output_PSLVERROR);
  wire  _zz_1_;
  assign _zz_1_ = (io_input_PSEL[0] && (io_output_PSEL == (4'b0000)));
  assign io_output_PADDR = io_input_PADDR;
  assign io_output_PENABLE = io_input_PENABLE;
  assign io_output_PWRITE = io_input_PWRITE;
  assign io_output_PWDATA = io_input_PWDATA;
  always @ (*) begin
    io_output_PSEL[0] = (((io_input_PADDR & (~ (20'b00000000111111111111))) == (20'b00000000000000000000)) && io_input_PSEL[0]);
    io_output_PSEL[1] = (((io_input_PADDR & (~ (20'b00000000111111111111))) == (20'b00010000000000000000)) && io_input_PSEL[0]);
    io_output_PSEL[2] = (((io_input_PADDR & (~ (20'b00000000111111111111))) == (20'b00100000000000000000)) && io_input_PSEL[0]);
    io_output_PSEL[3] = (((io_input_PADDR & (~ (20'b00000000111111111111))) == (20'b00110000000000000000)) && io_input_PSEL[0]);
  end

  always @ (*) begin
    io_input_PREADY = io_output_PREADY;
    if(_zz_1_)begin
      io_input_PREADY = 1'b1;
    end
  end

  assign io_input_PRDATA = io_output_PRDATA;
  always @ (*) begin
    io_input_PSLVERROR = io_output_PSLVERROR;
    if(_zz_1_)begin
      io_input_PSLVERROR = 1'b1;
    end
  end

endmodule

module Apb3Router (
      input  [19:0] io_input_PADDR,
      input  [3:0] io_input_PSEL,
      input   io_input_PENABLE,
      output  io_input_PREADY,
      input   io_input_PWRITE,
      input  [31:0] io_input_PWDATA,
      output [31:0] io_input_PRDATA,
      output  io_input_PSLVERROR,
      output [19:0] io_outputs_0_PADDR,
      output [0:0] io_outputs_0_PSEL,
      output  io_outputs_0_PENABLE,
      input   io_outputs_0_PREADY,
      output  io_outputs_0_PWRITE,
      output [31:0] io_outputs_0_PWDATA,
      input  [31:0] io_outputs_0_PRDATA,
      input   io_outputs_0_PSLVERROR,
      output [19:0] io_outputs_1_PADDR,
      output [0:0] io_outputs_1_PSEL,
      output  io_outputs_1_PENABLE,
      input   io_outputs_1_PREADY,
      output  io_outputs_1_PWRITE,
      output [31:0] io_outputs_1_PWDATA,
      input  [31:0] io_outputs_1_PRDATA,
      input   io_outputs_1_PSLVERROR,
      output [19:0] io_outputs_2_PADDR,
      output [0:0] io_outputs_2_PSEL,
      output  io_outputs_2_PENABLE,
      input   io_outputs_2_PREADY,
      output  io_outputs_2_PWRITE,
      output [31:0] io_outputs_2_PWDATA,
      input  [31:0] io_outputs_2_PRDATA,
      input   io_outputs_2_PSLVERROR,
      output [19:0] io_outputs_3_PADDR,
      output [0:0] io_outputs_3_PSEL,
      output  io_outputs_3_PENABLE,
      input   io_outputs_3_PREADY,
      output  io_outputs_3_PWRITE,
      output [31:0] io_outputs_3_PWDATA,
      input  [31:0] io_outputs_3_PRDATA,
      input   io_outputs_3_PSLVERROR,
      input   io_mainClk,
      input   resetCtrl_systemReset);
  reg  _zz_4_;
  reg [31:0] _zz_5_;
  reg  _zz_6_;
  wire  _zz_1_;
  wire  _zz_2_;
  wire  _zz_3_;
  reg [1:0] selIndex;
  always @(*) begin
    case(selIndex)
      2'b00 : begin
        _zz_4_ = io_outputs_0_PREADY;
        _zz_5_ = io_outputs_0_PRDATA;
        _zz_6_ = io_outputs_0_PSLVERROR;
      end
      2'b01 : begin
        _zz_4_ = io_outputs_1_PREADY;
        _zz_5_ = io_outputs_1_PRDATA;
        _zz_6_ = io_outputs_1_PSLVERROR;
      end
      2'b10 : begin
        _zz_4_ = io_outputs_2_PREADY;
        _zz_5_ = io_outputs_2_PRDATA;
        _zz_6_ = io_outputs_2_PSLVERROR;
      end
      default : begin
        _zz_4_ = io_outputs_3_PREADY;
        _zz_5_ = io_outputs_3_PRDATA;
        _zz_6_ = io_outputs_3_PSLVERROR;
      end
    endcase
  end

  assign io_outputs_0_PADDR = io_input_PADDR;
  assign io_outputs_0_PENABLE = io_input_PENABLE;
  assign io_outputs_0_PSEL[0] = io_input_PSEL[0];
  assign io_outputs_0_PWRITE = io_input_PWRITE;
  assign io_outputs_0_PWDATA = io_input_PWDATA;
  assign io_outputs_1_PADDR = io_input_PADDR;
  assign io_outputs_1_PENABLE = io_input_PENABLE;
  assign io_outputs_1_PSEL[0] = io_input_PSEL[1];
  assign io_outputs_1_PWRITE = io_input_PWRITE;
  assign io_outputs_1_PWDATA = io_input_PWDATA;
  assign io_outputs_2_PADDR = io_input_PADDR;
  assign io_outputs_2_PENABLE = io_input_PENABLE;
  assign io_outputs_2_PSEL[0] = io_input_PSEL[2];
  assign io_outputs_2_PWRITE = io_input_PWRITE;
  assign io_outputs_2_PWDATA = io_input_PWDATA;
  assign io_outputs_3_PADDR = io_input_PADDR;
  assign io_outputs_3_PENABLE = io_input_PENABLE;
  assign io_outputs_3_PSEL[0] = io_input_PSEL[3];
  assign io_outputs_3_PWRITE = io_input_PWRITE;
  assign io_outputs_3_PWDATA = io_input_PWDATA;
  assign _zz_1_ = io_input_PSEL[3];
  assign _zz_2_ = (io_input_PSEL[1] || _zz_1_);
  assign _zz_3_ = (io_input_PSEL[2] || _zz_1_);
  assign io_input_PREADY = _zz_4_;
  assign io_input_PRDATA = _zz_5_;
  assign io_input_PSLVERROR = _zz_6_;
  always @ (posedge io_mainClk) begin
    selIndex <= {_zz_3_,_zz_2_};
  end

endmodule

module Murax (
      input   io_asyncReset,
      input   io_mainClk,
      input   io_jtag_tms,
      input   io_jtag_tdi,
      output  io_jtag_tdo,
      input   io_jtag_tck,
      input  [31:0] io_gpioA_read,
      output [31:0] io_gpioA_write,
      output [31:0] io_gpioA_writeEnable,
      output  io_uart_txd,
      input   io_uart_rxd,
      output [0:0] io_spi_ss,
      output  io_spi_sclk,
      output  io_spi_mosi,
      input   io_spi_miso);
  wire  _zz_5_;
  wire [7:0] _zz_6_;
  reg  _zz_7_;
  reg  _zz_8_;
  wire [3:0] _zz_9_;
  wire [3:0] _zz_10_;
  wire [7:0] _zz_11_;
  wire [7:0] _zz_12_;
  wire  _zz_13_;
  wire  _zz_14_;
  reg [31:0] _zz_15_;
  wire  bufferCC_4__io_dataOut;
  wire  system_mainBusArbiter_io_iBus_cmd_ready;
  wire  system_mainBusArbiter_io_iBus_rsp_valid;
  wire  system_mainBusArbiter_io_iBus_rsp_payload_error;
  wire [31:0] system_mainBusArbiter_io_iBus_rsp_payload_inst;
  wire  system_mainBusArbiter_io_dBus_cmd_ready;
  wire  system_mainBusArbiter_io_dBus_rsp_ready;
  wire  system_mainBusArbiter_io_dBus_rsp_error;
  wire [31:0] system_mainBusArbiter_io_dBus_rsp_data;
  wire  system_mainBusArbiter_io_masterBus_cmd_valid;
  wire  system_mainBusArbiter_io_masterBus_cmd_payload_write;
  wire [31:0] system_mainBusArbiter_io_masterBus_cmd_payload_address;
  wire [31:0] system_mainBusArbiter_io_masterBus_cmd_payload_data;
  wire [3:0] system_mainBusArbiter_io_masterBus_cmd_payload_mask;
  wire  system_cpu_iBus_cmd_valid;
  wire [31:0] system_cpu_iBus_cmd_payload_pc;
  wire  system_cpu_debug_bus_cmd_ready;
  wire [31:0] system_cpu_debug_bus_rsp_data;
  wire  system_cpu_debug_resetOut;
  wire  system_cpu_dBus_cmd_valid;
  wire  system_cpu_dBus_cmd_payload_wr;
  wire [31:0] system_cpu_dBus_cmd_payload_address;
  wire [31:0] system_cpu_dBus_cmd_payload_data;
  wire [1:0] system_cpu_dBus_cmd_payload_size;
  wire  jtagBridge_1__io_jtag_tdo;
  wire  jtagBridge_1__io_remote_cmd_valid;
  wire  jtagBridge_1__io_remote_cmd_payload_last;
  wire [0:0] jtagBridge_1__io_remote_cmd_payload_fragment;
  wire  jtagBridge_1__io_remote_rsp_ready;
  wire  systemDebugger_1__io_remote_cmd_ready;
  wire  systemDebugger_1__io_remote_rsp_valid;
  wire  systemDebugger_1__io_remote_rsp_payload_error;
  wire [31:0] systemDebugger_1__io_remote_rsp_payload_data;
  wire  systemDebugger_1__io_mem_cmd_valid;
  wire [31:0] systemDebugger_1__io_mem_cmd_payload_address;
  wire [31:0] systemDebugger_1__io_mem_cmd_payload_data;
  wire  systemDebugger_1__io_mem_cmd_payload_wr;
  wire [1:0] systemDebugger_1__io_mem_cmd_payload_size;
  wire  system_ram_io_bus_cmd_ready;
  wire  system_ram_io_bus_rsp_valid;
  wire [31:0] system_ram_io_bus_rsp_payload_data;
  wire  system_apbBridge_io_pipelinedMemoryBus_cmd_ready;
  wire  system_apbBridge_io_pipelinedMemoryBus_rsp_valid;
  wire [31:0] system_apbBridge_io_pipelinedMemoryBus_rsp_payload_data;
  wire [19:0] system_apbBridge_io_apb_PADDR;
  wire [0:0] system_apbBridge_io_apb_PSEL;
  wire  system_apbBridge_io_apb_PENABLE;
  wire  system_apbBridge_io_apb_PWRITE;
  wire [31:0] system_apbBridge_io_apb_PWDATA;
  wire  system_gpioACtrl_io_apb_PREADY;
  wire [31:0] system_gpioACtrl_io_apb_PRDATA;
  wire  system_gpioACtrl_io_apb_PSLVERROR;
  wire [31:0] system_gpioACtrl_io_gpio_write;
  wire [31:0] system_gpioACtrl_io_gpio_writeEnable;
  wire [31:0] system_gpioACtrl_io_value;
  wire  system_uartCtrl_io_apb_PREADY;
  wire [31:0] system_uartCtrl_io_apb_PRDATA;
  wire  system_uartCtrl_io_uart_txd;
  wire  system_uartCtrl_io_interrupt;
  wire  system_timer_io_apb_PREADY;
  wire [31:0] system_timer_io_apb_PRDATA;
  wire  system_timer_io_apb_PSLVERROR;
  wire  system_timer_io_interrupt;
  wire  system_spiCtrl_io_apb_PREADY;
  wire [31:0] system_spiCtrl_io_apb_PRDATA;
  wire  system_spiCtrl_io_spi_sclk;
  wire  system_spiCtrl_io_spi_mosi;
  wire [0:0] system_spiCtrl_io_spi_ss;
  wire  system_spiCtrl_io_interrupt;
  wire  io_apb_decoder_io_input_PREADY;
  wire [31:0] io_apb_decoder_io_input_PRDATA;
  wire  io_apb_decoder_io_input_PSLVERROR;
  wire [19:0] io_apb_decoder_io_output_PADDR;
  wire [3:0] io_apb_decoder_io_output_PSEL;
  wire  io_apb_decoder_io_output_PENABLE;
  wire  io_apb_decoder_io_output_PWRITE;
  wire [31:0] io_apb_decoder_io_output_PWDATA;
  wire  apb3Router_1__io_input_PREADY;
  wire [31:0] apb3Router_1__io_input_PRDATA;
  wire  apb3Router_1__io_input_PSLVERROR;
  wire [19:0] apb3Router_1__io_outputs_0_PADDR;
  wire [0:0] apb3Router_1__io_outputs_0_PSEL;
  wire  apb3Router_1__io_outputs_0_PENABLE;
  wire  apb3Router_1__io_outputs_0_PWRITE;
  wire [31:0] apb3Router_1__io_outputs_0_PWDATA;
  wire [19:0] apb3Router_1__io_outputs_1_PADDR;
  wire [0:0] apb3Router_1__io_outputs_1_PSEL;
  wire  apb3Router_1__io_outputs_1_PENABLE;
  wire  apb3Router_1__io_outputs_1_PWRITE;
  wire [31:0] apb3Router_1__io_outputs_1_PWDATA;
  wire [19:0] apb3Router_1__io_outputs_2_PADDR;
  wire [0:0] apb3Router_1__io_outputs_2_PSEL;
  wire  apb3Router_1__io_outputs_2_PENABLE;
  wire  apb3Router_1__io_outputs_2_PWRITE;
  wire [31:0] apb3Router_1__io_outputs_2_PWDATA;
  wire [19:0] apb3Router_1__io_outputs_3_PADDR;
  wire [0:0] apb3Router_1__io_outputs_3_PSEL;
  wire  apb3Router_1__io_outputs_3_PENABLE;
  wire  apb3Router_1__io_outputs_3_PWRITE;
  wire [31:0] apb3Router_1__io_outputs_3_PWDATA;
  wire  _zz_16_;
  wire  _zz_17_;
  wire  _zz_18_;
  reg  resetCtrl_mainClkResetUnbuffered;
  reg [5:0] resetCtrl_systemClkResetCounter = (6'b000000);
  wire [5:0] _zz_1_;
  reg  resetCtrl_mainClkReset;
  reg  resetCtrl_systemReset;
  reg  system_timerInterrupt;
  reg  system_externalInterrupt;
  wire  system_cpu_dBus_cmd_halfPipe_valid;
  wire  system_cpu_dBus_cmd_halfPipe_ready;
  wire  system_cpu_dBus_cmd_halfPipe_payload_wr;
  wire [31:0] system_cpu_dBus_cmd_halfPipe_payload_address;
  wire [31:0] system_cpu_dBus_cmd_halfPipe_payload_data;
  wire [1:0] system_cpu_dBus_cmd_halfPipe_payload_size;
  reg  system_cpu_dBus_cmd_halfPipe_regs_valid;
  reg  system_cpu_dBus_cmd_halfPipe_regs_ready;
  reg  system_cpu_dBus_cmd_halfPipe_regs_payload_wr;
  reg [31:0] system_cpu_dBus_cmd_halfPipe_regs_payload_address;
  reg [31:0] system_cpu_dBus_cmd_halfPipe_regs_payload_data;
  reg [1:0] system_cpu_dBus_cmd_halfPipe_regs_payload_size;
  reg  system_cpu_debug_resetOut_regNext;
  reg  _zz_2_;
  wire  system_mainBusDecoder_logic_masterPipelined_cmd_valid;
  reg  system_mainBusDecoder_logic_masterPipelined_cmd_ready;
  wire  system_mainBusDecoder_logic_masterPipelined_cmd_payload_write;
  wire [31:0] system_mainBusDecoder_logic_masterPipelined_cmd_payload_address;
  wire [31:0] system_mainBusDecoder_logic_masterPipelined_cmd_payload_data;
  wire [3:0] system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask;
  wire  system_mainBusDecoder_logic_masterPipelined_rsp_valid;
  wire [31:0] system_mainBusDecoder_logic_masterPipelined_rsp_payload_data;
  wire  system_mainBusDecoder_logic_hits_0;
  wire  _zz_3_;
  wire  system_mainBusDecoder_logic_hits_1;
  wire  _zz_4_;
  wire  system_mainBusDecoder_logic_noHit;
  reg  system_mainBusDecoder_logic_rspPending;
  reg  system_mainBusDecoder_logic_rspNoHit;
  reg [0:0] system_mainBusDecoder_logic_rspSourceId;
  assign _zz_16_ = (resetCtrl_systemClkResetCounter != _zz_1_);
  assign _zz_17_ = (system_mainBusDecoder_logic_rspPending && (! system_mainBusDecoder_logic_masterPipelined_rsp_valid));
  assign _zz_18_ = (! system_cpu_dBus_cmd_halfPipe_regs_valid);
  BufferCC_3_ bufferCC_4_ ( 
    .io_dataIn(io_asyncReset),
    .io_dataOut(bufferCC_4__io_dataOut),
    .io_mainClk(io_mainClk) 
  );
  MuraxMasterArbiter system_mainBusArbiter ( 
    .io_iBus_cmd_valid(system_cpu_iBus_cmd_valid),
    .io_iBus_cmd_ready(system_mainBusArbiter_io_iBus_cmd_ready),
    .io_iBus_cmd_payload_pc(system_cpu_iBus_cmd_payload_pc),
    .io_iBus_rsp_valid(system_mainBusArbiter_io_iBus_rsp_valid),
    .io_iBus_rsp_payload_error(system_mainBusArbiter_io_iBus_rsp_payload_error),
    .io_iBus_rsp_payload_inst(system_mainBusArbiter_io_iBus_rsp_payload_inst),
    .io_dBus_cmd_valid(system_cpu_dBus_cmd_halfPipe_valid),
    .io_dBus_cmd_ready(system_mainBusArbiter_io_dBus_cmd_ready),
    .io_dBus_cmd_payload_wr(system_cpu_dBus_cmd_halfPipe_payload_wr),
    .io_dBus_cmd_payload_address(system_cpu_dBus_cmd_halfPipe_payload_address),
    .io_dBus_cmd_payload_data(system_cpu_dBus_cmd_halfPipe_payload_data),
    .io_dBus_cmd_payload_size(system_cpu_dBus_cmd_halfPipe_payload_size),
    .io_dBus_rsp_ready(system_mainBusArbiter_io_dBus_rsp_ready),
    .io_dBus_rsp_error(system_mainBusArbiter_io_dBus_rsp_error),
    .io_dBus_rsp_data(system_mainBusArbiter_io_dBus_rsp_data),
    .io_masterBus_cmd_valid(system_mainBusArbiter_io_masterBus_cmd_valid),
    .io_masterBus_cmd_ready(system_mainBusDecoder_logic_masterPipelined_cmd_ready),
    .io_masterBus_cmd_payload_write(system_mainBusArbiter_io_masterBus_cmd_payload_write),
    .io_masterBus_cmd_payload_address(system_mainBusArbiter_io_masterBus_cmd_payload_address),
    .io_masterBus_cmd_payload_data(system_mainBusArbiter_io_masterBus_cmd_payload_data),
    .io_masterBus_cmd_payload_mask(system_mainBusArbiter_io_masterBus_cmd_payload_mask),
    .io_masterBus_rsp_valid(system_mainBusDecoder_logic_masterPipelined_rsp_valid),
    .io_masterBus_rsp_payload_data(system_mainBusDecoder_logic_masterPipelined_rsp_payload_data),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  VexRiscv system_cpu ( 
    .iBus_cmd_valid(system_cpu_iBus_cmd_valid),
    .iBus_cmd_ready(system_mainBusArbiter_io_iBus_cmd_ready),
    .iBus_cmd_payload_pc(system_cpu_iBus_cmd_payload_pc),
    .iBus_rsp_valid(system_mainBusArbiter_io_iBus_rsp_valid),
    .iBus_rsp_payload_error(system_mainBusArbiter_io_iBus_rsp_payload_error),
    .iBus_rsp_payload_inst(system_mainBusArbiter_io_iBus_rsp_payload_inst),
    .timerInterrupt(system_timerInterrupt),
    .externalInterrupt(system_externalInterrupt),
    .softwareInterrupt(_zz_5_),
    .debug_bus_cmd_valid(systemDebugger_1__io_mem_cmd_valid),
    .debug_bus_cmd_ready(system_cpu_debug_bus_cmd_ready),
    .debug_bus_cmd_payload_wr(systemDebugger_1__io_mem_cmd_payload_wr),
    .debug_bus_cmd_payload_address(_zz_6_),
    .debug_bus_cmd_payload_data(systemDebugger_1__io_mem_cmd_payload_data),
    .debug_bus_rsp_data(system_cpu_debug_bus_rsp_data),
    .debug_resetOut(system_cpu_debug_resetOut),
    .dBus_cmd_valid(system_cpu_dBus_cmd_valid),
    .dBus_cmd_ready(system_cpu_dBus_cmd_halfPipe_regs_ready),
    .dBus_cmd_payload_wr(system_cpu_dBus_cmd_payload_wr),
    .dBus_cmd_payload_address(system_cpu_dBus_cmd_payload_address),
    .dBus_cmd_payload_data(system_cpu_dBus_cmd_payload_data),
    .dBus_cmd_payload_size(system_cpu_dBus_cmd_payload_size),
    .dBus_rsp_ready(system_mainBusArbiter_io_dBus_rsp_ready),
    .dBus_rsp_error(system_mainBusArbiter_io_dBus_rsp_error),
    .dBus_rsp_data(system_mainBusArbiter_io_dBus_rsp_data),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset),
    .resetCtrl_mainClkReset(resetCtrl_mainClkReset) 
  );
  JtagBridge jtagBridge_1_ ( 
    .io_jtag_tms(io_jtag_tms),
    .io_jtag_tdi(io_jtag_tdi),
    .io_jtag_tdo(jtagBridge_1__io_jtag_tdo),
    .io_jtag_tck(io_jtag_tck),
    .io_remote_cmd_valid(jtagBridge_1__io_remote_cmd_valid),
    .io_remote_cmd_ready(systemDebugger_1__io_remote_cmd_ready),
    .io_remote_cmd_payload_last(jtagBridge_1__io_remote_cmd_payload_last),
    .io_remote_cmd_payload_fragment(jtagBridge_1__io_remote_cmd_payload_fragment),
    .io_remote_rsp_valid(systemDebugger_1__io_remote_rsp_valid),
    .io_remote_rsp_ready(jtagBridge_1__io_remote_rsp_ready),
    .io_remote_rsp_payload_error(systemDebugger_1__io_remote_rsp_payload_error),
    .io_remote_rsp_payload_data(systemDebugger_1__io_remote_rsp_payload_data),
    .io_mainClk(io_mainClk),
    .resetCtrl_mainClkReset(resetCtrl_mainClkReset) 
  );
  SystemDebugger systemDebugger_1_ ( 
    .io_remote_cmd_valid(jtagBridge_1__io_remote_cmd_valid),
    .io_remote_cmd_ready(systemDebugger_1__io_remote_cmd_ready),
    .io_remote_cmd_payload_last(jtagBridge_1__io_remote_cmd_payload_last),
    .io_remote_cmd_payload_fragment(jtagBridge_1__io_remote_cmd_payload_fragment),
    .io_remote_rsp_valid(systemDebugger_1__io_remote_rsp_valid),
    .io_remote_rsp_ready(jtagBridge_1__io_remote_rsp_ready),
    .io_remote_rsp_payload_error(systemDebugger_1__io_remote_rsp_payload_error),
    .io_remote_rsp_payload_data(systemDebugger_1__io_remote_rsp_payload_data),
    .io_mem_cmd_valid(systemDebugger_1__io_mem_cmd_valid),
    .io_mem_cmd_ready(system_cpu_debug_bus_cmd_ready),
    .io_mem_cmd_payload_address(systemDebugger_1__io_mem_cmd_payload_address),
    .io_mem_cmd_payload_data(systemDebugger_1__io_mem_cmd_payload_data),
    .io_mem_cmd_payload_wr(systemDebugger_1__io_mem_cmd_payload_wr),
    .io_mem_cmd_payload_size(systemDebugger_1__io_mem_cmd_payload_size),
    .io_mem_rsp_valid(_zz_2_),
    .io_mem_rsp_payload(system_cpu_debug_bus_rsp_data),
    .io_mainClk(io_mainClk),
    .resetCtrl_mainClkReset(resetCtrl_mainClkReset) 
  );
  MuraxPipelinedMemoryBusRam system_ram ( 
    .io_bus_cmd_valid(_zz_7_),
    .io_bus_cmd_ready(system_ram_io_bus_cmd_ready),
    .io_bus_cmd_payload_write(_zz_3_),
    .io_bus_cmd_payload_address(system_mainBusDecoder_logic_masterPipelined_cmd_payload_address),
    .io_bus_cmd_payload_data(system_mainBusDecoder_logic_masterPipelined_cmd_payload_data),
    .io_bus_cmd_payload_mask(system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask),
    .io_bus_rsp_valid(system_ram_io_bus_rsp_valid),
    .io_bus_rsp_payload_data(system_ram_io_bus_rsp_payload_data),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  PipelinedMemoryBusToApbBridge system_apbBridge ( 
    .io_pipelinedMemoryBus_cmd_valid(_zz_8_),
    .io_pipelinedMemoryBus_cmd_ready(system_apbBridge_io_pipelinedMemoryBus_cmd_ready),
    .io_pipelinedMemoryBus_cmd_payload_write(_zz_4_),
    .io_pipelinedMemoryBus_cmd_payload_address(system_mainBusDecoder_logic_masterPipelined_cmd_payload_address),
    .io_pipelinedMemoryBus_cmd_payload_data(system_mainBusDecoder_logic_masterPipelined_cmd_payload_data),
    .io_pipelinedMemoryBus_cmd_payload_mask(system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask),
    .io_pipelinedMemoryBus_rsp_valid(system_apbBridge_io_pipelinedMemoryBus_rsp_valid),
    .io_pipelinedMemoryBus_rsp_payload_data(system_apbBridge_io_pipelinedMemoryBus_rsp_payload_data),
    .io_apb_PADDR(system_apbBridge_io_apb_PADDR),
    .io_apb_PSEL(system_apbBridge_io_apb_PSEL),
    .io_apb_PENABLE(system_apbBridge_io_apb_PENABLE),
    .io_apb_PREADY(io_apb_decoder_io_input_PREADY),
    .io_apb_PWRITE(system_apbBridge_io_apb_PWRITE),
    .io_apb_PWDATA(system_apbBridge_io_apb_PWDATA),
    .io_apb_PRDATA(io_apb_decoder_io_input_PRDATA),
    .io_apb_PSLVERROR(io_apb_decoder_io_input_PSLVERROR),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  Apb3Gpio system_gpioACtrl ( 
    .io_apb_PADDR(_zz_9_),
    .io_apb_PSEL(apb3Router_1__io_outputs_0_PSEL),
    .io_apb_PENABLE(apb3Router_1__io_outputs_0_PENABLE),
    .io_apb_PREADY(system_gpioACtrl_io_apb_PREADY),
    .io_apb_PWRITE(apb3Router_1__io_outputs_0_PWRITE),
    .io_apb_PWDATA(apb3Router_1__io_outputs_0_PWDATA),
    .io_apb_PRDATA(system_gpioACtrl_io_apb_PRDATA),
    .io_apb_PSLVERROR(system_gpioACtrl_io_apb_PSLVERROR),
    .io_gpio_read(io_gpioA_read),
    .io_gpio_write(system_gpioACtrl_io_gpio_write),
    .io_gpio_writeEnable(system_gpioACtrl_io_gpio_writeEnable),
    .io_value(system_gpioACtrl_io_value),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  Apb3UartCtrl system_uartCtrl ( 
    .io_apb_PADDR(_zz_10_),
    .io_apb_PSEL(apb3Router_1__io_outputs_1_PSEL),
    .io_apb_PENABLE(apb3Router_1__io_outputs_1_PENABLE),
    .io_apb_PREADY(system_uartCtrl_io_apb_PREADY),
    .io_apb_PWRITE(apb3Router_1__io_outputs_1_PWRITE),
    .io_apb_PWDATA(apb3Router_1__io_outputs_1_PWDATA),
    .io_apb_PRDATA(system_uartCtrl_io_apb_PRDATA),
    .io_uart_txd(system_uartCtrl_io_uart_txd),
    .io_uart_rxd(io_uart_rxd),
    .io_interrupt(system_uartCtrl_io_interrupt),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  MuraxApb3Timer system_timer ( 
    .io_apb_PADDR(_zz_11_),
    .io_apb_PSEL(apb3Router_1__io_outputs_2_PSEL),
    .io_apb_PENABLE(apb3Router_1__io_outputs_2_PENABLE),
    .io_apb_PREADY(system_timer_io_apb_PREADY),
    .io_apb_PWRITE(apb3Router_1__io_outputs_2_PWRITE),
    .io_apb_PWDATA(apb3Router_1__io_outputs_2_PWDATA),
    .io_apb_PRDATA(system_timer_io_apb_PRDATA),
    .io_apb_PSLVERROR(system_timer_io_apb_PSLVERROR),
    .io_interrupt(system_timer_io_interrupt),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  Apb3SpiMasterCtrl system_spiCtrl ( 
    .io_apb_PADDR(_zz_12_),
    .io_apb_PSEL(apb3Router_1__io_outputs_3_PSEL),
    .io_apb_PENABLE(apb3Router_1__io_outputs_3_PENABLE),
    .io_apb_PREADY(system_spiCtrl_io_apb_PREADY),
    .io_apb_PWRITE(apb3Router_1__io_outputs_3_PWRITE),
    .io_apb_PWDATA(apb3Router_1__io_outputs_3_PWDATA),
    .io_apb_PRDATA(system_spiCtrl_io_apb_PRDATA),
    .io_spi_ss(system_spiCtrl_io_spi_ss),
    .io_spi_sclk(system_spiCtrl_io_spi_sclk),
    .io_spi_mosi(system_spiCtrl_io_spi_mosi),
    .io_spi_miso(io_spi_miso),
    .io_interrupt(system_spiCtrl_io_interrupt),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  Apb3Decoder io_apb_decoder ( 
    .io_input_PADDR(system_apbBridge_io_apb_PADDR),
    .io_input_PSEL(system_apbBridge_io_apb_PSEL),
    .io_input_PENABLE(system_apbBridge_io_apb_PENABLE),
    .io_input_PREADY(io_apb_decoder_io_input_PREADY),
    .io_input_PWRITE(system_apbBridge_io_apb_PWRITE),
    .io_input_PWDATA(system_apbBridge_io_apb_PWDATA),
    .io_input_PRDATA(io_apb_decoder_io_input_PRDATA),
    .io_input_PSLVERROR(io_apb_decoder_io_input_PSLVERROR),
    .io_output_PADDR(io_apb_decoder_io_output_PADDR),
    .io_output_PSEL(io_apb_decoder_io_output_PSEL),
    .io_output_PENABLE(io_apb_decoder_io_output_PENABLE),
    .io_output_PREADY(apb3Router_1__io_input_PREADY),
    .io_output_PWRITE(io_apb_decoder_io_output_PWRITE),
    .io_output_PWDATA(io_apb_decoder_io_output_PWDATA),
    .io_output_PRDATA(apb3Router_1__io_input_PRDATA),
    .io_output_PSLVERROR(apb3Router_1__io_input_PSLVERROR) 
  );
  Apb3Router apb3Router_1_ ( 
    .io_input_PADDR(io_apb_decoder_io_output_PADDR),
    .io_input_PSEL(io_apb_decoder_io_output_PSEL),
    .io_input_PENABLE(io_apb_decoder_io_output_PENABLE),
    .io_input_PREADY(apb3Router_1__io_input_PREADY),
    .io_input_PWRITE(io_apb_decoder_io_output_PWRITE),
    .io_input_PWDATA(io_apb_decoder_io_output_PWDATA),
    .io_input_PRDATA(apb3Router_1__io_input_PRDATA),
    .io_input_PSLVERROR(apb3Router_1__io_input_PSLVERROR),
    .io_outputs_0_PADDR(apb3Router_1__io_outputs_0_PADDR),
    .io_outputs_0_PSEL(apb3Router_1__io_outputs_0_PSEL),
    .io_outputs_0_PENABLE(apb3Router_1__io_outputs_0_PENABLE),
    .io_outputs_0_PREADY(system_gpioACtrl_io_apb_PREADY),
    .io_outputs_0_PWRITE(apb3Router_1__io_outputs_0_PWRITE),
    .io_outputs_0_PWDATA(apb3Router_1__io_outputs_0_PWDATA),
    .io_outputs_0_PRDATA(system_gpioACtrl_io_apb_PRDATA),
    .io_outputs_0_PSLVERROR(system_gpioACtrl_io_apb_PSLVERROR),
    .io_outputs_1_PADDR(apb3Router_1__io_outputs_1_PADDR),
    .io_outputs_1_PSEL(apb3Router_1__io_outputs_1_PSEL),
    .io_outputs_1_PENABLE(apb3Router_1__io_outputs_1_PENABLE),
    .io_outputs_1_PREADY(system_uartCtrl_io_apb_PREADY),
    .io_outputs_1_PWRITE(apb3Router_1__io_outputs_1_PWRITE),
    .io_outputs_1_PWDATA(apb3Router_1__io_outputs_1_PWDATA),
    .io_outputs_1_PRDATA(system_uartCtrl_io_apb_PRDATA),
    .io_outputs_1_PSLVERROR(_zz_13_),
    .io_outputs_2_PADDR(apb3Router_1__io_outputs_2_PADDR),
    .io_outputs_2_PSEL(apb3Router_1__io_outputs_2_PSEL),
    .io_outputs_2_PENABLE(apb3Router_1__io_outputs_2_PENABLE),
    .io_outputs_2_PREADY(system_timer_io_apb_PREADY),
    .io_outputs_2_PWRITE(apb3Router_1__io_outputs_2_PWRITE),
    .io_outputs_2_PWDATA(apb3Router_1__io_outputs_2_PWDATA),
    .io_outputs_2_PRDATA(system_timer_io_apb_PRDATA),
    .io_outputs_2_PSLVERROR(system_timer_io_apb_PSLVERROR),
    .io_outputs_3_PADDR(apb3Router_1__io_outputs_3_PADDR),
    .io_outputs_3_PSEL(apb3Router_1__io_outputs_3_PSEL),
    .io_outputs_3_PENABLE(apb3Router_1__io_outputs_3_PENABLE),
    .io_outputs_3_PREADY(system_spiCtrl_io_apb_PREADY),
    .io_outputs_3_PWRITE(apb3Router_1__io_outputs_3_PWRITE),
    .io_outputs_3_PWDATA(apb3Router_1__io_outputs_3_PWDATA),
    .io_outputs_3_PRDATA(system_spiCtrl_io_apb_PRDATA),
    .io_outputs_3_PSLVERROR(_zz_14_),
    .io_mainClk(io_mainClk),
    .resetCtrl_systemReset(resetCtrl_systemReset) 
  );
  always @(*) begin
    case(system_mainBusDecoder_logic_rspSourceId)
      1'b0 : begin
        _zz_15_ = system_ram_io_bus_rsp_payload_data;
      end
      default : begin
        _zz_15_ = system_apbBridge_io_pipelinedMemoryBus_rsp_payload_data;
      end
    endcase
  end

  always @ (*) begin
    resetCtrl_mainClkResetUnbuffered = 1'b0;
    if(_zz_16_)begin
      resetCtrl_mainClkResetUnbuffered = 1'b1;
    end
  end

  assign _zz_1_[5 : 0] = (6'b111111);
  always @ (*) begin
    system_timerInterrupt = 1'b0;
    if(system_timer_io_interrupt)begin
      system_timerInterrupt = 1'b1;
    end
  end

  always @ (*) begin
    system_externalInterrupt = 1'b0;
    if(system_uartCtrl_io_interrupt)begin
      system_externalInterrupt = 1'b1;
    end
  end

  assign system_cpu_dBus_cmd_halfPipe_valid = system_cpu_dBus_cmd_halfPipe_regs_valid;
  assign system_cpu_dBus_cmd_halfPipe_payload_wr = system_cpu_dBus_cmd_halfPipe_regs_payload_wr;
  assign system_cpu_dBus_cmd_halfPipe_payload_address = system_cpu_dBus_cmd_halfPipe_regs_payload_address;
  assign system_cpu_dBus_cmd_halfPipe_payload_data = system_cpu_dBus_cmd_halfPipe_regs_payload_data;
  assign system_cpu_dBus_cmd_halfPipe_payload_size = system_cpu_dBus_cmd_halfPipe_regs_payload_size;
  assign system_cpu_dBus_cmd_halfPipe_ready = system_mainBusArbiter_io_dBus_cmd_ready;
  assign _zz_6_ = systemDebugger_1__io_mem_cmd_payload_address[7:0];
  assign io_jtag_tdo = jtagBridge_1__io_jtag_tdo;
  assign io_gpioA_write = system_gpioACtrl_io_gpio_write;
  assign io_gpioA_writeEnable = system_gpioACtrl_io_gpio_writeEnable;
  assign io_uart_txd = system_uartCtrl_io_uart_txd;
  assign io_spi_ss = system_spiCtrl_io_spi_ss;
  assign io_spi_sclk = system_spiCtrl_io_spi_sclk;
  assign io_spi_mosi = system_spiCtrl_io_spi_mosi;
  assign _zz_9_ = apb3Router_1__io_outputs_0_PADDR[3:0];
  assign _zz_10_ = apb3Router_1__io_outputs_1_PADDR[3:0];
  assign _zz_13_ = 1'b0;
  assign _zz_11_ = apb3Router_1__io_outputs_2_PADDR[7:0];
  assign _zz_12_ = apb3Router_1__io_outputs_3_PADDR[7:0];
  assign _zz_14_ = 1'b0;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_valid = system_mainBusArbiter_io_masterBus_cmd_valid;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_write = system_mainBusArbiter_io_masterBus_cmd_payload_write;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_address = system_mainBusArbiter_io_masterBus_cmd_payload_address;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_data = system_mainBusArbiter_io_masterBus_cmd_payload_data;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask = system_mainBusArbiter_io_masterBus_cmd_payload_mask;
  assign system_mainBusDecoder_logic_hits_0 = ((system_mainBusDecoder_logic_masterPipelined_cmd_payload_address & (~ (32'b00000000000000111111111111111111))) == (32'b10000000000000000000000000000000));
  always @ (*) begin
    _zz_7_ = (system_mainBusDecoder_logic_masterPipelined_cmd_valid && system_mainBusDecoder_logic_hits_0);
    if(_zz_17_)begin
      _zz_7_ = 1'b0;
    end
  end

  assign _zz_3_ = system_mainBusDecoder_logic_masterPipelined_cmd_payload_write;
  assign system_mainBusDecoder_logic_hits_1 = ((system_mainBusDecoder_logic_masterPipelined_cmd_payload_address & (~ (32'b00000000000011111111111111111111))) == (32'b11110000000000000000000000000000));
  always @ (*) begin
    _zz_8_ = (system_mainBusDecoder_logic_masterPipelined_cmd_valid && system_mainBusDecoder_logic_hits_1);
    if(_zz_17_)begin
      _zz_8_ = 1'b0;
    end
  end

  assign _zz_4_ = system_mainBusDecoder_logic_masterPipelined_cmd_payload_write;
  assign system_mainBusDecoder_logic_noHit = (! ({system_mainBusDecoder_logic_hits_1,system_mainBusDecoder_logic_hits_0} != (2'b00)));
  always @ (*) begin
    system_mainBusDecoder_logic_masterPipelined_cmd_ready = (({(system_mainBusDecoder_logic_hits_1 && system_apbBridge_io_pipelinedMemoryBus_cmd_ready),(system_mainBusDecoder_logic_hits_0 && system_ram_io_bus_cmd_ready)} != (2'b00)) || system_mainBusDecoder_logic_noHit);
    if(_zz_17_)begin
      system_mainBusDecoder_logic_masterPipelined_cmd_ready = 1'b0;
    end
  end

  assign system_mainBusDecoder_logic_masterPipelined_rsp_valid = (({system_apbBridge_io_pipelinedMemoryBus_rsp_valid,system_ram_io_bus_rsp_valid} != (2'b00)) || (system_mainBusDecoder_logic_rspPending && system_mainBusDecoder_logic_rspNoHit));
  assign system_mainBusDecoder_logic_masterPipelined_rsp_payload_data = _zz_15_;
  assign _zz_5_ = 1'b0;
  always @ (posedge io_mainClk) begin
    if(_zz_16_)begin
      resetCtrl_systemClkResetCounter <= (resetCtrl_systemClkResetCounter + (6'b000001));
    end
    if(bufferCC_4__io_dataOut)begin
      resetCtrl_systemClkResetCounter <= (6'b000000);
    end
  end

  always @ (posedge io_mainClk) begin
    resetCtrl_mainClkReset <= resetCtrl_mainClkResetUnbuffered;
    resetCtrl_systemReset <= resetCtrl_mainClkResetUnbuffered;
    if(system_cpu_debug_resetOut_regNext)begin
      resetCtrl_systemReset <= 1'b1;
    end
  end

  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      system_cpu_dBus_cmd_halfPipe_regs_valid <= 1'b0;
      system_cpu_dBus_cmd_halfPipe_regs_ready <= 1'b1;
      system_mainBusDecoder_logic_rspPending <= 1'b0;
      system_mainBusDecoder_logic_rspNoHit <= 1'b0;
    end else begin
      if(_zz_18_)begin
        system_cpu_dBus_cmd_halfPipe_regs_valid <= system_cpu_dBus_cmd_valid;
        system_cpu_dBus_cmd_halfPipe_regs_ready <= (! system_cpu_dBus_cmd_valid);
      end else begin
        system_cpu_dBus_cmd_halfPipe_regs_valid <= (! system_cpu_dBus_cmd_halfPipe_ready);
        system_cpu_dBus_cmd_halfPipe_regs_ready <= system_cpu_dBus_cmd_halfPipe_ready;
      end
      if(system_mainBusDecoder_logic_masterPipelined_rsp_valid)begin
        system_mainBusDecoder_logic_rspPending <= 1'b0;
      end
      if(((system_mainBusDecoder_logic_masterPipelined_cmd_valid && system_mainBusDecoder_logic_masterPipelined_cmd_ready) && (! system_mainBusDecoder_logic_masterPipelined_cmd_payload_write)))begin
        system_mainBusDecoder_logic_rspPending <= 1'b1;
      end
      system_mainBusDecoder_logic_rspNoHit <= 1'b0;
      if(system_mainBusDecoder_logic_noHit)begin
        system_mainBusDecoder_logic_rspNoHit <= 1'b1;
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_18_)begin
      system_cpu_dBus_cmd_halfPipe_regs_payload_wr <= system_cpu_dBus_cmd_payload_wr;
      system_cpu_dBus_cmd_halfPipe_regs_payload_address <= system_cpu_dBus_cmd_payload_address;
      system_cpu_dBus_cmd_halfPipe_regs_payload_data <= system_cpu_dBus_cmd_payload_data;
      system_cpu_dBus_cmd_halfPipe_regs_payload_size <= system_cpu_dBus_cmd_payload_size;
    end
    if((system_mainBusDecoder_logic_masterPipelined_cmd_valid && system_mainBusDecoder_logic_masterPipelined_cmd_ready))begin
      system_mainBusDecoder_logic_rspSourceId <= system_mainBusDecoder_logic_hits_1;
    end
  end

  always @ (posedge io_mainClk) begin
    system_cpu_debug_resetOut_regNext <= system_cpu_debug_resetOut;
  end

  always @ (posedge io_mainClk or posedge resetCtrl_mainClkReset) begin
    if (resetCtrl_mainClkReset) begin
      _zz_2_ <= 1'b0;
    end else begin
      _zz_2_ <= (systemDebugger_1__io_mem_cmd_valid && system_cpu_debug_bus_cmd_ready);
    end
  end

endmodule

