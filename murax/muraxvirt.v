// Generator : SpinalHDL v1.4.3    git head : 576e21d75d59eccc250dec63ef3094d9ee1fd051
// Component : Murax
// Git hash  : 576e21d75d59eccc250dec63ef3094d9ee1fd051


`define BranchCtrlEnum_defaultEncoding_type [1:0]
`define BranchCtrlEnum_defaultEncoding_INC 2'b00
`define BranchCtrlEnum_defaultEncoding_B 2'b01
`define BranchCtrlEnum_defaultEncoding_JAL 2'b10
`define BranchCtrlEnum_defaultEncoding_JALR 2'b11

`define ShiftCtrlEnum_defaultEncoding_type [1:0]
`define ShiftCtrlEnum_defaultEncoding_DISABLE_1 2'b00
`define ShiftCtrlEnum_defaultEncoding_SLL_1 2'b01
`define ShiftCtrlEnum_defaultEncoding_SRL_1 2'b10
`define ShiftCtrlEnum_defaultEncoding_SRA_1 2'b11

`define AluBitwiseCtrlEnum_defaultEncoding_type [1:0]
`define AluBitwiseCtrlEnum_defaultEncoding_XOR_1 2'b00
`define AluBitwiseCtrlEnum_defaultEncoding_OR_1 2'b01
`define AluBitwiseCtrlEnum_defaultEncoding_AND_1 2'b10

`define AluCtrlEnum_defaultEncoding_type [1:0]
`define AluCtrlEnum_defaultEncoding_ADD_SUB 2'b00
`define AluCtrlEnum_defaultEncoding_SLT_SLTU 2'b01
`define AluCtrlEnum_defaultEncoding_BITWISE 2'b10

`define EnvCtrlEnum_defaultEncoding_type [1:0]
`define EnvCtrlEnum_defaultEncoding_NONE 2'b00
`define EnvCtrlEnum_defaultEncoding_XRET 2'b01
`define EnvCtrlEnum_defaultEncoding_WFI 2'b10
`define EnvCtrlEnum_defaultEncoding_ECALL 2'b11

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


module muraxvirt (
  input               io_xasyncReset,
  input               io_mainClk,
  output              io_uart_txd,
  input               io_uart_rxd
);
  wire                _zz_5;
  wire                _zz_6;
  wire       [7:0]    _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  reg                 _zz_10;
  reg                 _zz_11;
  wire       [3:0]    _zz_12;
  wire       [4:0]    _zz_13;
  wire       [7:0]    _zz_14;
  wire                _zz_15;
  reg        [31:0]   _zz_16;
  wire                bufferCC_4_io_dataOut;
  wire                system_mainBusArbiter_io_iBus_cmd_ready;
  wire                system_mainBusArbiter_io_iBus_rsp_valid;
  wire                system_mainBusArbiter_io_iBus_rsp_payload_error;
  wire       [31:0]   system_mainBusArbiter_io_iBus_rsp_payload_inst;
  wire                system_mainBusArbiter_io_dBus_cmd_ready;
  wire                system_mainBusArbiter_io_dBus_rsp_ready;
  wire                system_mainBusArbiter_io_dBus_rsp_error;
  wire       [31:0]   system_mainBusArbiter_io_dBus_rsp_data;
  wire                system_mainBusArbiter_io_masterBus_cmd_valid;
  wire                system_mainBusArbiter_io_masterBus_cmd_payload_write;
  wire       [31:0]   system_mainBusArbiter_io_masterBus_cmd_payload_address;
  wire       [31:0]   system_mainBusArbiter_io_masterBus_cmd_payload_data;
  wire       [3:0]    system_mainBusArbiter_io_masterBus_cmd_payload_mask;
  wire                system_cpu_iBus_cmd_valid;
  wire       [31:0]   system_cpu_iBus_cmd_payload_pc;
  wire                system_cpu_debug_bus_cmd_ready;
  wire       [31:0]   system_cpu_debug_bus_rsp_data;
  wire                system_cpu_debug_resetOut;
  wire                system_cpu_dBus_cmd_valid;
  wire                system_cpu_dBus_cmd_payload_wr;
  wire       [31:0]   system_cpu_dBus_cmd_payload_address;
  wire       [31:0]   system_cpu_dBus_cmd_payload_data;
  wire       [1:0]    system_cpu_dBus_cmd_payload_size;
  wire                virtual_jtag_1_virtual_state_cdr;
  wire                virtual_jtag_1_virtual_state_sdr;
  wire                virtual_jtag_1_tck;
  wire                virtual_jtag_1_tdi;
  wire                virtual_jtag_1_virtual_state_udr;
  wire                jtagBridgeNoTap_1_io_ctrl_tdo;
  wire                jtagBridgeNoTap_1_io_remote_cmd_valid;
  wire                jtagBridgeNoTap_1_io_remote_cmd_payload_last;
  wire       [0:0]    jtagBridgeNoTap_1_io_remote_cmd_payload_fragment;
  wire                jtagBridgeNoTap_1_io_remote_rsp_ready;
  wire                systemDebugger_1_io_remote_cmd_ready;
  wire                systemDebugger_1_io_remote_rsp_valid;
  wire                systemDebugger_1_io_remote_rsp_payload_error;
  wire       [31:0]   systemDebugger_1_io_remote_rsp_payload_data;
  wire                systemDebugger_1_io_mem_cmd_valid;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_address;
  wire       [31:0]   systemDebugger_1_io_mem_cmd_payload_data;
  wire                systemDebugger_1_io_mem_cmd_payload_wr;
  wire       [1:0]    systemDebugger_1_io_mem_cmd_payload_size;
  wire                system_ram_io_bus_cmd_ready;
  wire                system_ram_io_bus_rsp_valid;
  wire       [31:0]   system_ram_io_bus_rsp_payload_data;
  wire                system_apbBridge_io_pipelinedMemoryBus_cmd_ready;
  wire                system_apbBridge_io_pipelinedMemoryBus_rsp_valid;
  wire       [31:0]   system_apbBridge_io_pipelinedMemoryBus_rsp_payload_data;
  wire       [19:0]   system_apbBridge_io_apb_PADDR;
  wire       [0:0]    system_apbBridge_io_apb_PSEL;
  wire                system_apbBridge_io_apb_PENABLE;
  wire                system_apbBridge_io_apb_PWRITE;
  wire       [31:0]   system_apbBridge_io_apb_PWDATA;
  wire                system_gpioACtrl_io_apb_PREADY;
  wire       [31:0]   system_gpioACtrl_io_apb_PRDATA;
  wire                system_gpioACtrl_io_apb_PSLVERROR;
  wire                system_uartCtrl_io_apb_PREADY;
  wire       [31:0]   system_uartCtrl_io_apb_PRDATA;
  wire                system_uartCtrl_io_uart_txd;
  wire                system_uartCtrl_io_interrupt;
  wire                system_timer_io_apb_PREADY;
  wire       [31:0]   system_timer_io_apb_PRDATA;
  wire                system_timer_io_apb_PSLVERROR;
  wire                system_timer_io_interrupt;
  wire                io_apb_decoder_io_input_PREADY;
  wire       [31:0]   io_apb_decoder_io_input_PRDATA;
  wire                io_apb_decoder_io_input_PSLVERROR;
  wire       [19:0]   io_apb_decoder_io_output_PADDR;
  wire       [2:0]    io_apb_decoder_io_output_PSEL;
  wire                io_apb_decoder_io_output_PENABLE;
  wire                io_apb_decoder_io_output_PWRITE;
  wire       [31:0]   io_apb_decoder_io_output_PWDATA;
  wire                apb3Router_1_io_input_PREADY;
  wire       [31:0]   apb3Router_1_io_input_PRDATA;
  wire                apb3Router_1_io_input_PSLVERROR;
  wire       [19:0]   apb3Router_1_io_outputs_0_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_0_PSEL;
  wire                apb3Router_1_io_outputs_0_PENABLE;
  wire                apb3Router_1_io_outputs_0_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_0_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_1_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_1_PSEL;
  wire                apb3Router_1_io_outputs_1_PENABLE;
  wire                apb3Router_1_io_outputs_1_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_1_PWDATA;
  wire       [19:0]   apb3Router_1_io_outputs_2_PADDR;
  wire       [0:0]    apb3Router_1_io_outputs_2_PSEL;
  wire                apb3Router_1_io_outputs_2_PENABLE;
  wire                apb3Router_1_io_outputs_2_PWRITE;
  wire       [31:0]   apb3Router_1_io_outputs_2_PWDATA;
  wire                _zz_17;
  wire                _zz_18;
  wire                _zz_19;
  reg                 resetCtrl_mainClkResetUnbuffered;
  reg        [5:0]    resetCtrl_systemClkResetCounter = 6'h0;
  wire       [5:0]    _zz_1;
  reg                 resetCtrl_mainClkReset;
  reg                 resetCtrl_systemReset;
  reg                 system_timerInterrupt;
  reg                 system_externalInterrupt;
  wire                system_cpu_dBus_cmd_halfPipe_valid;
  wire                system_cpu_dBus_cmd_halfPipe_ready;
  wire                system_cpu_dBus_cmd_halfPipe_payload_wr;
  wire       [31:0]   system_cpu_dBus_cmd_halfPipe_payload_address;
  wire       [31:0]   system_cpu_dBus_cmd_halfPipe_payload_data;
  wire       [1:0]    system_cpu_dBus_cmd_halfPipe_payload_size;
  reg                 system_cpu_dBus_cmd_halfPipe_regs_valid;
  reg                 system_cpu_dBus_cmd_halfPipe_regs_ready;
  reg                 system_cpu_dBus_cmd_halfPipe_regs_payload_wr;
  reg        [31:0]   system_cpu_dBus_cmd_halfPipe_regs_payload_address;
  reg        [31:0]   system_cpu_dBus_cmd_halfPipe_regs_payload_data;
  reg        [1:0]    system_cpu_dBus_cmd_halfPipe_regs_payload_size;
  reg                 system_cpu_debug_resetOut_regNext;
  reg                 _zz_2;
  wire                system_mainBusDecoder_logic_masterPipelined_cmd_valid;
  reg                 system_mainBusDecoder_logic_masterPipelined_cmd_ready;
  wire                system_mainBusDecoder_logic_masterPipelined_cmd_payload_write;
  wire       [31:0]   system_mainBusDecoder_logic_masterPipelined_cmd_payload_address;
  wire       [31:0]   system_mainBusDecoder_logic_masterPipelined_cmd_payload_data;
  wire       [3:0]    system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask;
  wire                system_mainBusDecoder_logic_masterPipelined_rsp_valid;
  wire       [31:0]   system_mainBusDecoder_logic_masterPipelined_rsp_payload_data;
  wire                system_mainBusDecoder_logic_hits_0;
  wire                _zz_3;
  wire                system_mainBusDecoder_logic_hits_1;
  wire                _zz_4;
  wire                system_mainBusDecoder_logic_noHit;
  reg                 system_mainBusDecoder_logic_rspPending;
  reg                 system_mainBusDecoder_logic_rspNoHit;
  reg        [0:0]    system_mainBusDecoder_logic_rspSourceId;

  assign _zz_17 = (resetCtrl_systemClkResetCounter != _zz_1);
  assign _zz_18 = (system_mainBusDecoder_logic_rspPending && (! system_mainBusDecoder_logic_masterPipelined_rsp_valid));
  assign _zz_19 = (! system_cpu_dBus_cmd_halfPipe_regs_valid);
  BufferCC_3 bufferCC_4 (
    .io_dataIn     (_zz_5                  ), //i
    .io_dataOut    (bufferCC_4_io_dataOut  ), //o
    .io_mainClk    (io_mainClk             )  //i
  );
  MuraxMasterArbiter system_mainBusArbiter (
    .io_iBus_cmd_valid                   (system_cpu_iBus_cmd_valid                                           ), //i
    .io_iBus_cmd_ready                   (system_mainBusArbiter_io_iBus_cmd_ready                             ), //o
    .io_iBus_cmd_payload_pc              (system_cpu_iBus_cmd_payload_pc[31:0]                                ), //i
    .io_iBus_rsp_valid                   (system_mainBusArbiter_io_iBus_rsp_valid                             ), //o
    .io_iBus_rsp_payload_error           (system_mainBusArbiter_io_iBus_rsp_payload_error                     ), //o
    .io_iBus_rsp_payload_inst            (system_mainBusArbiter_io_iBus_rsp_payload_inst[31:0]                ), //o
    .io_dBus_cmd_valid                   (system_cpu_dBus_cmd_halfPipe_valid                                  ), //i
    .io_dBus_cmd_ready                   (system_mainBusArbiter_io_dBus_cmd_ready                             ), //o
    .io_dBus_cmd_payload_wr              (system_cpu_dBus_cmd_halfPipe_payload_wr                             ), //i
    .io_dBus_cmd_payload_address         (system_cpu_dBus_cmd_halfPipe_payload_address[31:0]                  ), //i
    .io_dBus_cmd_payload_data            (system_cpu_dBus_cmd_halfPipe_payload_data[31:0]                     ), //i
    .io_dBus_cmd_payload_size            (system_cpu_dBus_cmd_halfPipe_payload_size[1:0]                      ), //i
    .io_dBus_rsp_ready                   (system_mainBusArbiter_io_dBus_rsp_ready                             ), //o
    .io_dBus_rsp_error                   (system_mainBusArbiter_io_dBus_rsp_error                             ), //o
    .io_dBus_rsp_data                    (system_mainBusArbiter_io_dBus_rsp_data[31:0]                        ), //o
    .io_masterBus_cmd_valid              (system_mainBusArbiter_io_masterBus_cmd_valid                        ), //o
    .io_masterBus_cmd_ready              (system_mainBusDecoder_logic_masterPipelined_cmd_ready               ), //i
    .io_masterBus_cmd_payload_write      (system_mainBusArbiter_io_masterBus_cmd_payload_write                ), //o
    .io_masterBus_cmd_payload_address    (system_mainBusArbiter_io_masterBus_cmd_payload_address[31:0]        ), //o
    .io_masterBus_cmd_payload_data       (system_mainBusArbiter_io_masterBus_cmd_payload_data[31:0]           ), //o
    .io_masterBus_cmd_payload_mask       (system_mainBusArbiter_io_masterBus_cmd_payload_mask[3:0]            ), //o
    .io_masterBus_rsp_valid              (system_mainBusDecoder_logic_masterPipelined_rsp_valid               ), //i
    .io_masterBus_rsp_payload_data       (system_mainBusDecoder_logic_masterPipelined_rsp_payload_data[31:0]  ), //i
    .io_mainClk                          (io_mainClk                                                          ), //i
    .resetCtrl_systemReset               (resetCtrl_systemReset                                               )  //i
  );
  VexRiscv system_cpu (
    .iBus_cmd_valid                   (system_cpu_iBus_cmd_valid                             ), //o
    .iBus_cmd_ready                   (system_mainBusArbiter_io_iBus_cmd_ready               ), //i
    .iBus_cmd_payload_pc              (system_cpu_iBus_cmd_payload_pc[31:0]                  ), //o
    .iBus_rsp_valid                   (system_mainBusArbiter_io_iBus_rsp_valid               ), //i
    .iBus_rsp_payload_error           (system_mainBusArbiter_io_iBus_rsp_payload_error       ), //i
    .iBus_rsp_payload_inst            (system_mainBusArbiter_io_iBus_rsp_payload_inst[31:0]  ), //i
    .timerInterrupt                   (system_timerInterrupt                                 ), //i
    .externalInterrupt                (system_externalInterrupt                              ), //i
    .softwareInterrupt                (_zz_6                                                 ), //i
    .debug_bus_cmd_valid              (systemDebugger_1_io_mem_cmd_valid                     ), //i
    .debug_bus_cmd_ready              (system_cpu_debug_bus_cmd_ready                        ), //o
    .debug_bus_cmd_payload_wr         (systemDebugger_1_io_mem_cmd_payload_wr                ), //i
    .debug_bus_cmd_payload_address    (_zz_7[7:0]                                            ), //i
    .debug_bus_cmd_payload_data       (systemDebugger_1_io_mem_cmd_payload_data[31:0]        ), //i
    .debug_bus_rsp_data               (system_cpu_debug_bus_rsp_data[31:0]                   ), //o
    .debug_resetOut                   (system_cpu_debug_resetOut                             ), //o
    .dBus_cmd_valid                   (system_cpu_dBus_cmd_valid                             ), //o
    .dBus_cmd_ready                   (system_cpu_dBus_cmd_halfPipe_regs_ready               ), //i
    .dBus_cmd_payload_wr              (system_cpu_dBus_cmd_payload_wr                        ), //o
    .dBus_cmd_payload_address         (system_cpu_dBus_cmd_payload_address[31:0]             ), //o
    .dBus_cmd_payload_data            (system_cpu_dBus_cmd_payload_data[31:0]                ), //o
    .dBus_cmd_payload_size            (system_cpu_dBus_cmd_payload_size[1:0]                 ), //o
    .dBus_rsp_ready                   (system_mainBusArbiter_io_dBus_rsp_ready               ), //i
    .dBus_rsp_error                   (system_mainBusArbiter_io_dBus_rsp_error               ), //i
    .dBus_rsp_data                    (system_mainBusArbiter_io_dBus_rsp_data[31:0]          ), //i
    .io_mainClk                       (io_mainClk                                            ), //i
    .resetCtrl_systemReset            (resetCtrl_systemReset                                 ), //i
    .resetCtrl_mainClkReset           (resetCtrl_mainClkReset                                )  //i
  );
  virtual_jtag virtual_jtag_1 (
    .virtual_state_cdr    (virtual_jtag_1_virtual_state_cdr  ), //o
    .virtual_state_sdr    (virtual_jtag_1_virtual_state_sdr  ), //o
    .tck                  (virtual_jtag_1_tck                ), //o
    .tdi                  (virtual_jtag_1_tdi                ), //o
    .virtual_state_udr    (virtual_jtag_1_virtual_state_udr  ), //o
    .tdo                  (jtagBridgeNoTap_1_io_ctrl_tdo     )  //i
  );
  JtagBridgeNoTap jtagBridgeNoTap_1 (
    .io_ctrl_tdi                       (virtual_jtag_1_tdi                                 ), //i
    .io_ctrl_enable                    (_zz_8                                              ), //i
    .io_ctrl_capture                   (virtual_jtag_1_virtual_state_cdr                   ), //i
    .io_ctrl_shift                     (virtual_jtag_1_virtual_state_sdr                   ), //i
    .io_ctrl_update                    (virtual_jtag_1_virtual_state_udr                   ), //i
    .io_ctrl_reset                     (_zz_9                                              ), //i
    .io_ctrl_tdo                       (jtagBridgeNoTap_1_io_ctrl_tdo                      ), //o
    .io_remote_cmd_valid               (jtagBridgeNoTap_1_io_remote_cmd_valid              ), //o
    .io_remote_cmd_ready               (systemDebugger_1_io_remote_cmd_ready               ), //i
    .io_remote_cmd_payload_last        (jtagBridgeNoTap_1_io_remote_cmd_payload_last       ), //o
    .io_remote_cmd_payload_fragment    (jtagBridgeNoTap_1_io_remote_cmd_payload_fragment   ), //o
    .io_remote_rsp_valid               (systemDebugger_1_io_remote_rsp_valid               ), //i
    .io_remote_rsp_ready               (jtagBridgeNoTap_1_io_remote_rsp_ready              ), //o
    .io_remote_rsp_payload_error       (systemDebugger_1_io_remote_rsp_payload_error       ), //i
    .io_remote_rsp_payload_data        (systemDebugger_1_io_remote_rsp_payload_data[31:0]  ), //i
    .io_mainClk                        (io_mainClk                                         ), //i
    .resetCtrl_mainClkReset            (resetCtrl_mainClkReset                             ), //i
    .tck                               (virtual_jtag_1_tck                                 )  //i
  );
  SystemDebugger systemDebugger_1 (
    .io_remote_cmd_valid               (jtagBridgeNoTap_1_io_remote_cmd_valid              ), //i
    .io_remote_cmd_ready               (systemDebugger_1_io_remote_cmd_ready               ), //o
    .io_remote_cmd_payload_last        (jtagBridgeNoTap_1_io_remote_cmd_payload_last       ), //i
    .io_remote_cmd_payload_fragment    (jtagBridgeNoTap_1_io_remote_cmd_payload_fragment   ), //i
    .io_remote_rsp_valid               (systemDebugger_1_io_remote_rsp_valid               ), //o
    .io_remote_rsp_ready               (jtagBridgeNoTap_1_io_remote_rsp_ready              ), //i
    .io_remote_rsp_payload_error       (systemDebugger_1_io_remote_rsp_payload_error       ), //o
    .io_remote_rsp_payload_data        (systemDebugger_1_io_remote_rsp_payload_data[31:0]  ), //o
    .io_mem_cmd_valid                  (systemDebugger_1_io_mem_cmd_valid                  ), //o
    .io_mem_cmd_ready                  (system_cpu_debug_bus_cmd_ready                     ), //i
    .io_mem_cmd_payload_address        (systemDebugger_1_io_mem_cmd_payload_address[31:0]  ), //o
    .io_mem_cmd_payload_data           (systemDebugger_1_io_mem_cmd_payload_data[31:0]     ), //o
    .io_mem_cmd_payload_wr             (systemDebugger_1_io_mem_cmd_payload_wr             ), //o
    .io_mem_cmd_payload_size           (systemDebugger_1_io_mem_cmd_payload_size[1:0]      ), //o
    .io_mem_rsp_valid                  (_zz_2                                              ), //i
    .io_mem_rsp_payload                (system_cpu_debug_bus_rsp_data[31:0]                ), //i
    .io_mainClk                        (io_mainClk                                         ), //i
    .resetCtrl_mainClkReset            (resetCtrl_mainClkReset                             )  //i
  );
  MuraxPipelinedMemoryBusRam system_ram (
    .io_bus_cmd_valid              (_zz_10                                                                 ), //i
    .io_bus_cmd_ready              (system_ram_io_bus_cmd_ready                                            ), //o
    .io_bus_cmd_payload_write      (_zz_3                                                                  ), //i
    .io_bus_cmd_payload_address    (system_mainBusDecoder_logic_masterPipelined_cmd_payload_address[31:0]  ), //i
    .io_bus_cmd_payload_data       (system_mainBusDecoder_logic_masterPipelined_cmd_payload_data[31:0]     ), //i
    .io_bus_cmd_payload_mask       (system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask[3:0]      ), //i
    .io_bus_rsp_valid              (system_ram_io_bus_rsp_valid                                            ), //o
    .io_bus_rsp_payload_data       (system_ram_io_bus_rsp_payload_data[31:0]                               ), //o
    .io_mainClk                    (io_mainClk                                                             ), //i
    .resetCtrl_systemReset         (resetCtrl_systemReset                                                  )  //i
  );
  PipelinedMemoryBusToApbBridge system_apbBridge (
    .io_pipelinedMemoryBus_cmd_valid              (_zz_11                                                                 ), //i
    .io_pipelinedMemoryBus_cmd_ready              (system_apbBridge_io_pipelinedMemoryBus_cmd_ready                       ), //o
    .io_pipelinedMemoryBus_cmd_payload_write      (_zz_4                                                                  ), //i
    .io_pipelinedMemoryBus_cmd_payload_address    (system_mainBusDecoder_logic_masterPipelined_cmd_payload_address[31:0]  ), //i
    .io_pipelinedMemoryBus_cmd_payload_data       (system_mainBusDecoder_logic_masterPipelined_cmd_payload_data[31:0]     ), //i
    .io_pipelinedMemoryBus_cmd_payload_mask       (system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask[3:0]      ), //i
    .io_pipelinedMemoryBus_rsp_valid              (system_apbBridge_io_pipelinedMemoryBus_rsp_valid                       ), //o
    .io_pipelinedMemoryBus_rsp_payload_data       (system_apbBridge_io_pipelinedMemoryBus_rsp_payload_data[31:0]          ), //o
    .io_apb_PADDR                                 (system_apbBridge_io_apb_PADDR[19:0]                                    ), //o
    .io_apb_PSEL                                  (system_apbBridge_io_apb_PSEL                                           ), //o
    .io_apb_PENABLE                               (system_apbBridge_io_apb_PENABLE                                        ), //o
    .io_apb_PREADY                                (io_apb_decoder_io_input_PREADY                                         ), //i
    .io_apb_PWRITE                                (system_apbBridge_io_apb_PWRITE                                         ), //o
    .io_apb_PWDATA                                (system_apbBridge_io_apb_PWDATA[31:0]                                   ), //o
    .io_apb_PRDATA                                (io_apb_decoder_io_input_PRDATA[31:0]                                   ), //i
    .io_apb_PSLVERROR                             (io_apb_decoder_io_input_PSLVERROR                                      ), //i
    .io_mainClk                                   (io_mainClk                                                             ), //i
    .resetCtrl_systemReset                        (resetCtrl_systemReset                                                  )  //i
  );
  Apb3Gpio system_gpioACtrl (
    .io_apb_PADDR             (_zz_12[3:0]                             ), //i
    .io_apb_PSEL              (apb3Router_1_io_outputs_0_PSEL          ), //i
    .io_apb_PENABLE           (apb3Router_1_io_outputs_0_PENABLE       ), //i
    .io_apb_PREADY            (system_gpioACtrl_io_apb_PREADY          ), //o
    .io_apb_PWRITE            (apb3Router_1_io_outputs_0_PWRITE        ), //i
    .io_apb_PWDATA            (apb3Router_1_io_outputs_0_PWDATA[31:0]  ), //i
    .io_apb_PRDATA            (system_gpioACtrl_io_apb_PRDATA[31:0]    ), //o
    .io_apb_PSLVERROR         (system_gpioACtrl_io_apb_PSLVERROR       ), //o
    .io_mainClk               (io_mainClk                              ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                   )  //i
  );
  Apb3UartCtrl system_uartCtrl (
    .io_apb_PADDR             (_zz_13[4:0]                             ), //i
    .io_apb_PSEL              (apb3Router_1_io_outputs_1_PSEL          ), //i
    .io_apb_PENABLE           (apb3Router_1_io_outputs_1_PENABLE       ), //i
    .io_apb_PREADY            (system_uartCtrl_io_apb_PREADY           ), //o
    .io_apb_PWRITE            (apb3Router_1_io_outputs_1_PWRITE        ), //i
    .io_apb_PWDATA            (apb3Router_1_io_outputs_1_PWDATA[31:0]  ), //i
    .io_apb_PRDATA            (system_uartCtrl_io_apb_PRDATA[31:0]     ), //o
    .io_uart_txd              (system_uartCtrl_io_uart_txd             ), //o
    .io_uart_rxd              (io_uart_rxd                             ), //i
    .io_interrupt             (system_uartCtrl_io_interrupt            ), //o
    .io_mainClk               (io_mainClk                              ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                   )  //i
  );
  MuraxApb3Timer system_timer (
    .io_apb_PADDR             (_zz_14[7:0]                             ), //i
    .io_apb_PSEL              (apb3Router_1_io_outputs_2_PSEL          ), //i
    .io_apb_PENABLE           (apb3Router_1_io_outputs_2_PENABLE       ), //i
    .io_apb_PREADY            (system_timer_io_apb_PREADY              ), //o
    .io_apb_PWRITE            (apb3Router_1_io_outputs_2_PWRITE        ), //i
    .io_apb_PWDATA            (apb3Router_1_io_outputs_2_PWDATA[31:0]  ), //i
    .io_apb_PRDATA            (system_timer_io_apb_PRDATA[31:0]        ), //o
    .io_apb_PSLVERROR         (system_timer_io_apb_PSLVERROR           ), //o
    .io_interrupt             (system_timer_io_interrupt               ), //o
    .io_mainClk               (io_mainClk                              ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                   )  //i
  );
  Apb3Decoder io_apb_decoder (
    .io_input_PADDR         (system_apbBridge_io_apb_PADDR[19:0]    ), //i
    .io_input_PSEL          (system_apbBridge_io_apb_PSEL           ), //i
    .io_input_PENABLE       (system_apbBridge_io_apb_PENABLE        ), //i
    .io_input_PREADY        (io_apb_decoder_io_input_PREADY         ), //o
    .io_input_PWRITE        (system_apbBridge_io_apb_PWRITE         ), //i
    .io_input_PWDATA        (system_apbBridge_io_apb_PWDATA[31:0]   ), //i
    .io_input_PRDATA        (io_apb_decoder_io_input_PRDATA[31:0]   ), //o
    .io_input_PSLVERROR     (io_apb_decoder_io_input_PSLVERROR      ), //o
    .io_output_PADDR        (io_apb_decoder_io_output_PADDR[19:0]   ), //o
    .io_output_PSEL         (io_apb_decoder_io_output_PSEL[2:0]     ), //o
    .io_output_PENABLE      (io_apb_decoder_io_output_PENABLE       ), //o
    .io_output_PREADY       (apb3Router_1_io_input_PREADY           ), //i
    .io_output_PWRITE       (io_apb_decoder_io_output_PWRITE        ), //o
    .io_output_PWDATA       (io_apb_decoder_io_output_PWDATA[31:0]  ), //o
    .io_output_PRDATA       (apb3Router_1_io_input_PRDATA[31:0]     ), //i
    .io_output_PSLVERROR    (apb3Router_1_io_input_PSLVERROR        )  //i
  );
  Apb3Router apb3Router_1 (
    .io_input_PADDR            (io_apb_decoder_io_output_PADDR[19:0]    ), //i
    .io_input_PSEL             (io_apb_decoder_io_output_PSEL[2:0]      ), //i
    .io_input_PENABLE          (io_apb_decoder_io_output_PENABLE        ), //i
    .io_input_PREADY           (apb3Router_1_io_input_PREADY            ), //o
    .io_input_PWRITE           (io_apb_decoder_io_output_PWRITE         ), //i
    .io_input_PWDATA           (io_apb_decoder_io_output_PWDATA[31:0]   ), //i
    .io_input_PRDATA           (apb3Router_1_io_input_PRDATA[31:0]      ), //o
    .io_input_PSLVERROR        (apb3Router_1_io_input_PSLVERROR         ), //o
    .io_outputs_0_PADDR        (apb3Router_1_io_outputs_0_PADDR[19:0]   ), //o
    .io_outputs_0_PSEL         (apb3Router_1_io_outputs_0_PSEL          ), //o
    .io_outputs_0_PENABLE      (apb3Router_1_io_outputs_0_PENABLE       ), //o
    .io_outputs_0_PREADY       (system_gpioACtrl_io_apb_PREADY          ), //i
    .io_outputs_0_PWRITE       (apb3Router_1_io_outputs_0_PWRITE        ), //o
    .io_outputs_0_PWDATA       (apb3Router_1_io_outputs_0_PWDATA[31:0]  ), //o
    .io_outputs_0_PRDATA       (system_gpioACtrl_io_apb_PRDATA[31:0]    ), //i
    .io_outputs_0_PSLVERROR    (system_gpioACtrl_io_apb_PSLVERROR       ), //i
    .io_outputs_1_PADDR        (apb3Router_1_io_outputs_1_PADDR[19:0]   ), //o
    .io_outputs_1_PSEL         (apb3Router_1_io_outputs_1_PSEL          ), //o
    .io_outputs_1_PENABLE      (apb3Router_1_io_outputs_1_PENABLE       ), //o
    .io_outputs_1_PREADY       (system_uartCtrl_io_apb_PREADY           ), //i
    .io_outputs_1_PWRITE       (apb3Router_1_io_outputs_1_PWRITE        ), //o
    .io_outputs_1_PWDATA       (apb3Router_1_io_outputs_1_PWDATA[31:0]  ), //o
    .io_outputs_1_PRDATA       (system_uartCtrl_io_apb_PRDATA[31:0]     ), //i
    .io_outputs_1_PSLVERROR    (_zz_15                                  ), //i
    .io_outputs_2_PADDR        (apb3Router_1_io_outputs_2_PADDR[19:0]   ), //o
    .io_outputs_2_PSEL         (apb3Router_1_io_outputs_2_PSEL          ), //o
    .io_outputs_2_PENABLE      (apb3Router_1_io_outputs_2_PENABLE       ), //o
    .io_outputs_2_PREADY       (system_timer_io_apb_PREADY              ), //i
    .io_outputs_2_PWRITE       (apb3Router_1_io_outputs_2_PWRITE        ), //o
    .io_outputs_2_PWDATA       (apb3Router_1_io_outputs_2_PWDATA[31:0]  ), //o
    .io_outputs_2_PRDATA       (system_timer_io_apb_PRDATA[31:0]        ), //i
    .io_outputs_2_PSLVERROR    (system_timer_io_apb_PSLVERROR           ), //i
    .io_mainClk                (io_mainClk                              ), //i
    .resetCtrl_systemReset     (resetCtrl_systemReset                   )  //i
  );
  always @(*) begin
    case(system_mainBusDecoder_logic_rspSourceId)
      1'b0 : begin
        _zz_16 = system_ram_io_bus_rsp_payload_data;
      end
      default : begin
        _zz_16 = system_apbBridge_io_pipelinedMemoryBus_rsp_payload_data;
      end
    endcase
  end

  always @ (*) begin
    resetCtrl_mainClkResetUnbuffered = 1'b0;
    if(_zz_17)begin
      resetCtrl_mainClkResetUnbuffered = 1'b1;
    end
  end

  assign _zz_1[5 : 0] = 6'h3f;
  assign _zz_5 = (! io_xasyncReset);
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
  assign _zz_8 = 1'b1;
  assign _zz_9 = 1'b0;
  assign _zz_7 = systemDebugger_1_io_mem_cmd_payload_address[7:0];
  assign io_uart_txd = system_uartCtrl_io_uart_txd;
  assign _zz_12 = apb3Router_1_io_outputs_0_PADDR[3:0];
  assign _zz_13 = apb3Router_1_io_outputs_1_PADDR[4:0];
  assign _zz_15 = 1'b0;
  assign _zz_14 = apb3Router_1_io_outputs_2_PADDR[7:0];
  assign system_mainBusDecoder_logic_masterPipelined_cmd_valid = system_mainBusArbiter_io_masterBus_cmd_valid;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_write = system_mainBusArbiter_io_masterBus_cmd_payload_write;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_address = system_mainBusArbiter_io_masterBus_cmd_payload_address;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_data = system_mainBusArbiter_io_masterBus_cmd_payload_data;
  assign system_mainBusDecoder_logic_masterPipelined_cmd_payload_mask = system_mainBusArbiter_io_masterBus_cmd_payload_mask;
  assign system_mainBusDecoder_logic_hits_0 = ((system_mainBusDecoder_logic_masterPipelined_cmd_payload_address & (~ 32'h0001ffff)) == 32'h80000000);
  always @ (*) begin
    _zz_10 = (system_mainBusDecoder_logic_masterPipelined_cmd_valid && system_mainBusDecoder_logic_hits_0);
    if(_zz_18)begin
      _zz_10 = 1'b0;
    end
  end

  assign _zz_3 = system_mainBusDecoder_logic_masterPipelined_cmd_payload_write;
  assign system_mainBusDecoder_logic_hits_1 = ((system_mainBusDecoder_logic_masterPipelined_cmd_payload_address & (~ 32'h000fffff)) == 32'hf0000000);
  always @ (*) begin
    _zz_11 = (system_mainBusDecoder_logic_masterPipelined_cmd_valid && system_mainBusDecoder_logic_hits_1);
    if(_zz_18)begin
      _zz_11 = 1'b0;
    end
  end

  assign _zz_4 = system_mainBusDecoder_logic_masterPipelined_cmd_payload_write;
  assign system_mainBusDecoder_logic_noHit = (! ({system_mainBusDecoder_logic_hits_1,system_mainBusDecoder_logic_hits_0} != 2'b00));
  always @ (*) begin
    system_mainBusDecoder_logic_masterPipelined_cmd_ready = (({(system_mainBusDecoder_logic_hits_1 && system_apbBridge_io_pipelinedMemoryBus_cmd_ready),(system_mainBusDecoder_logic_hits_0 && system_ram_io_bus_cmd_ready)} != 2'b00) || system_mainBusDecoder_logic_noHit);
    if(_zz_18)begin
      system_mainBusDecoder_logic_masterPipelined_cmd_ready = 1'b0;
    end
  end

  assign system_mainBusDecoder_logic_masterPipelined_rsp_valid = (({system_apbBridge_io_pipelinedMemoryBus_rsp_valid,system_ram_io_bus_rsp_valid} != 2'b00) || (system_mainBusDecoder_logic_rspPending && system_mainBusDecoder_logic_rspNoHit));
  assign system_mainBusDecoder_logic_masterPipelined_rsp_payload_data = _zz_16;
  assign _zz_6 = 1'b0;
  always @ (posedge io_mainClk) begin
    if(_zz_17)begin
      resetCtrl_systemClkResetCounter <= (resetCtrl_systemClkResetCounter + 6'h01);
    end
    if(bufferCC_4_io_dataOut)begin
      resetCtrl_systemClkResetCounter <= 6'h0;
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
      if(_zz_19)begin
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
    if(_zz_19)begin
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
      _zz_2 <= 1'b0;
    end else begin
      _zz_2 <= (systemDebugger_1_io_mem_cmd_valid && system_cpu_debug_bus_cmd_ready);
    end
  end


endmodule

module Apb3Router (
  input      [19:0]   io_input_PADDR,
  input      [2:0]    io_input_PSEL,
  input               io_input_PENABLE,
  output              io_input_PREADY,
  input               io_input_PWRITE,
  input      [31:0]   io_input_PWDATA,
  output     [31:0]   io_input_PRDATA,
  output              io_input_PSLVERROR,
  output     [19:0]   io_outputs_0_PADDR,
  output     [0:0]    io_outputs_0_PSEL,
  output              io_outputs_0_PENABLE,
  input               io_outputs_0_PREADY,
  output              io_outputs_0_PWRITE,
  output     [31:0]   io_outputs_0_PWDATA,
  input      [31:0]   io_outputs_0_PRDATA,
  input               io_outputs_0_PSLVERROR,
  output     [19:0]   io_outputs_1_PADDR,
  output     [0:0]    io_outputs_1_PSEL,
  output              io_outputs_1_PENABLE,
  input               io_outputs_1_PREADY,
  output              io_outputs_1_PWRITE,
  output     [31:0]   io_outputs_1_PWDATA,
  input      [31:0]   io_outputs_1_PRDATA,
  input               io_outputs_1_PSLVERROR,
  output     [19:0]   io_outputs_2_PADDR,
  output     [0:0]    io_outputs_2_PSEL,
  output              io_outputs_2_PENABLE,
  input               io_outputs_2_PREADY,
  output              io_outputs_2_PWRITE,
  output     [31:0]   io_outputs_2_PWDATA,
  input      [31:0]   io_outputs_2_PRDATA,
  input               io_outputs_2_PSLVERROR,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  reg                 _zz_3;
  reg        [31:0]   _zz_4;
  reg                 _zz_5;
  wire                _zz_1;
  wire                _zz_2;
  reg        [1:0]    selIndex;

  always @(*) begin
    case(selIndex)
      2'b00 : begin
        _zz_3 = io_outputs_0_PREADY;
        _zz_4 = io_outputs_0_PRDATA;
        _zz_5 = io_outputs_0_PSLVERROR;
      end
      2'b01 : begin
        _zz_3 = io_outputs_1_PREADY;
        _zz_4 = io_outputs_1_PRDATA;
        _zz_5 = io_outputs_1_PSLVERROR;
      end
      default : begin
        _zz_3 = io_outputs_2_PREADY;
        _zz_4 = io_outputs_2_PRDATA;
        _zz_5 = io_outputs_2_PSLVERROR;
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
  assign _zz_1 = io_input_PSEL[1];
  assign _zz_2 = io_input_PSEL[2];
  assign io_input_PREADY = _zz_3;
  assign io_input_PRDATA = _zz_4;
  assign io_input_PSLVERROR = _zz_5;
  always @ (posedge io_mainClk) begin
    selIndex <= {_zz_2,_zz_1};
  end


endmodule

module Apb3Decoder (
  input      [19:0]   io_input_PADDR,
  input      [0:0]    io_input_PSEL,
  input               io_input_PENABLE,
  output reg          io_input_PREADY,
  input               io_input_PWRITE,
  input      [31:0]   io_input_PWDATA,
  output     [31:0]   io_input_PRDATA,
  output reg          io_input_PSLVERROR,
  output     [19:0]   io_output_PADDR,
  output reg [2:0]    io_output_PSEL,
  output              io_output_PENABLE,
  input               io_output_PREADY,
  output              io_output_PWRITE,
  output     [31:0]   io_output_PWDATA,
  input      [31:0]   io_output_PRDATA,
  input               io_output_PSLVERROR
);
  wire                _zz_1;

  assign _zz_1 = (io_input_PSEL[0] && (io_output_PSEL == 3'b000));
  assign io_output_PADDR = io_input_PADDR;
  assign io_output_PENABLE = io_input_PENABLE;
  assign io_output_PWRITE = io_input_PWRITE;
  assign io_output_PWDATA = io_input_PWDATA;
  always @ (*) begin
    io_output_PSEL[0] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h0) && io_input_PSEL[0]);
    io_output_PSEL[1] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h10000) && io_input_PSEL[0]);
    io_output_PSEL[2] = (((io_input_PADDR & (~ 20'h00fff)) == 20'h20000) && io_input_PSEL[0]);
  end

  always @ (*) begin
    io_input_PREADY = io_output_PREADY;
    if(_zz_1)begin
      io_input_PREADY = 1'b1;
    end
  end

  assign io_input_PRDATA = io_output_PRDATA;
  always @ (*) begin
    io_input_PSLVERROR = io_output_PSLVERROR;
    if(_zz_1)begin
      io_input_PSLVERROR = 1'b1;
    end
  end


endmodule

module MuraxApb3Timer (
  input      [7:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output reg [31:0]   io_apb_PRDATA,
  output              io_apb_PSLVERROR,
  output              io_interrupt,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_7;
  wire                _zz_8;
  wire                _zz_9;
  wire                _zz_10;
  reg        [1:0]    _zz_11;
  reg        [1:0]    _zz_12;
  wire                prescaler_1_io_overflow;
  wire                timerA_io_full;
  wire       [15:0]   timerA_io_value;
  wire                timerB_io_full;
  wire       [15:0]   timerB_io_value;
  wire       [1:0]    interruptCtrl_1_io_pendings;
  wire                busCtrl_askWrite;
  wire                busCtrl_askRead;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  reg        [15:0]   _zz_1;
  reg                 _zz_2;
  reg        [1:0]    timerABridge_ticksEnable;
  reg        [0:0]    timerABridge_clearsEnable;
  reg                 timerABridge_busClearing;
  reg        [15:0]   timerA_io_limit_driver;
  reg                 _zz_3;
  reg                 _zz_4;
  reg        [1:0]    timerBBridge_ticksEnable;
  reg        [0:0]    timerBBridge_clearsEnable;
  reg                 timerBBridge_busClearing;
  reg        [15:0]   timerB_io_limit_driver;
  reg                 _zz_5;
  reg                 _zz_6;
  reg        [1:0]    interruptCtrl_1_io_masks_driver;

  Prescaler prescaler_1 (
    .io_clear                 (_zz_2                    ), //i
    .io_limit                 (_zz_1[15:0]              ), //i
    .io_overflow              (prescaler_1_io_overflow  ), //o
    .io_mainClk               (io_mainClk               ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset    )  //i
  );
  Timer timerA (
    .io_tick                  (_zz_7                         ), //i
    .io_clear                 (_zz_8                         ), //i
    .io_limit                 (timerA_io_limit_driver[15:0]  ), //i
    .io_full                  (timerA_io_full                ), //o
    .io_value                 (timerA_io_value[15:0]         ), //o
    .io_mainClk               (io_mainClk                    ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset         )  //i
  );
  Timer timerB (
    .io_tick                  (_zz_9                         ), //i
    .io_clear                 (_zz_10                        ), //i
    .io_limit                 (timerB_io_limit_driver[15:0]  ), //i
    .io_full                  (timerB_io_full                ), //o
    .io_value                 (timerB_io_value[15:0]         ), //o
    .io_mainClk               (io_mainClk                    ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset         )  //i
  );
  InterruptCtrl interruptCtrl_1 (
    .io_inputs                (_zz_11[1:0]                           ), //i
    .io_clears                (_zz_12[1:0]                           ), //i
    .io_masks                 (interruptCtrl_1_io_masks_driver[1:0]  ), //i
    .io_pendings              (interruptCtrl_1_io_pendings[1:0]      ), //o
    .io_mainClk               (io_mainClk                            ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                 )  //i
  );
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      8'h0 : begin
        io_apb_PRDATA[15 : 0] = _zz_1;
      end
      8'h40 : begin
        io_apb_PRDATA[1 : 0] = timerABridge_ticksEnable;
        io_apb_PRDATA[16 : 16] = timerABridge_clearsEnable;
      end
      8'h44 : begin
        io_apb_PRDATA[15 : 0] = timerA_io_limit_driver;
      end
      8'h48 : begin
        io_apb_PRDATA[15 : 0] = timerA_io_value;
      end
      8'h50 : begin
        io_apb_PRDATA[1 : 0] = timerBBridge_ticksEnable;
        io_apb_PRDATA[16 : 16] = timerBBridge_clearsEnable;
      end
      8'h54 : begin
        io_apb_PRDATA[15 : 0] = timerB_io_limit_driver;
      end
      8'h58 : begin
        io_apb_PRDATA[15 : 0] = timerB_io_value;
      end
      8'h10 : begin
        io_apb_PRDATA[1 : 0] = interruptCtrl_1_io_pendings;
      end
      8'h14 : begin
        io_apb_PRDATA[1 : 0] = interruptCtrl_1_io_masks_driver;
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
    _zz_2 = 1'b0;
    case(io_apb_PADDR)
      8'h0 : begin
        if(busCtrl_doWrite)begin
          _zz_2 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    timerABridge_busClearing = 1'b0;
    if(_zz_3)begin
      timerABridge_busClearing = 1'b1;
    end
    if(_zz_4)begin
      timerABridge_busClearing = 1'b1;
    end
  end

  always @ (*) begin
    _zz_3 = 1'b0;
    case(io_apb_PADDR)
      8'h44 : begin
        if(busCtrl_doWrite)begin
          _zz_3 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_4 = 1'b0;
    case(io_apb_PADDR)
      8'h48 : begin
        if(busCtrl_doWrite)begin
          _zz_4 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign _zz_8 = (((timerABridge_clearsEnable & timerA_io_full) != 1'b0) || timerABridge_busClearing);
  assign _zz_7 = ((timerABridge_ticksEnable & {prescaler_1_io_overflow,1'b1}) != 2'b00);
  always @ (*) begin
    timerBBridge_busClearing = 1'b0;
    if(_zz_5)begin
      timerBBridge_busClearing = 1'b1;
    end
    if(_zz_6)begin
      timerBBridge_busClearing = 1'b1;
    end
  end

  always @ (*) begin
    _zz_5 = 1'b0;
    case(io_apb_PADDR)
      8'h54 : begin
        if(busCtrl_doWrite)begin
          _zz_5 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_6 = 1'b0;
    case(io_apb_PADDR)
      8'h58 : begin
        if(busCtrl_doWrite)begin
          _zz_6 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign _zz_10 = (((timerBBridge_clearsEnable & timerB_io_full) != 1'b0) || timerBBridge_busClearing);
  assign _zz_9 = ((timerBBridge_ticksEnable & {prescaler_1_io_overflow,1'b1}) != 2'b00);
  always @ (*) begin
    _zz_12 = 2'b00;
    case(io_apb_PADDR)
      8'h10 : begin
        if(busCtrl_doWrite)begin
          _zz_12 = io_apb_PWDATA[1 : 0];
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_11[0] = timerA_io_full;
    _zz_11[1] = timerB_io_full;
  end

  assign io_interrupt = (interruptCtrl_1_io_pendings != 2'b00);
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      timerABridge_ticksEnable <= 2'b00;
      timerABridge_clearsEnable <= 1'b0;
      timerBBridge_ticksEnable <= 2'b00;
      timerBBridge_clearsEnable <= 1'b0;
      interruptCtrl_1_io_masks_driver <= 2'b00;
    end else begin
      case(io_apb_PADDR)
        8'h40 : begin
          if(busCtrl_doWrite)begin
            timerABridge_ticksEnable <= io_apb_PWDATA[1 : 0];
            timerABridge_clearsEnable <= io_apb_PWDATA[16 : 16];
          end
        end
        8'h50 : begin
          if(busCtrl_doWrite)begin
            timerBBridge_ticksEnable <= io_apb_PWDATA[1 : 0];
            timerBBridge_clearsEnable <= io_apb_PWDATA[16 : 16];
          end
        end
        8'h14 : begin
          if(busCtrl_doWrite)begin
            interruptCtrl_1_io_masks_driver <= io_apb_PWDATA[1 : 0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    case(io_apb_PADDR)
      8'h0 : begin
        if(busCtrl_doWrite)begin
          _zz_1 <= io_apb_PWDATA[15 : 0];
        end
      end
      8'h44 : begin
        if(busCtrl_doWrite)begin
          timerA_io_limit_driver <= io_apb_PWDATA[15 : 0];
        end
      end
      8'h54 : begin
        if(busCtrl_doWrite)begin
          timerB_io_limit_driver <= io_apb_PWDATA[15 : 0];
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module Apb3UartCtrl (
  input      [4:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output reg [31:0]   io_apb_PRDATA,
  output              io_uart_txd,
  input               io_uart_rxd,
  output              io_interrupt,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_7;
  reg                 _zz_8;
  wire                _zz_9;
  wire                uartCtrl_1_io_write_ready;
  wire                uartCtrl_1_io_read_valid;
  wire       [7:0]    uartCtrl_1_io_read_payload;
  wire                uartCtrl_1_io_uart_txd;
  wire                uartCtrl_1_io_readError;
  wire                uartCtrl_1_io_readBreak;
  wire                bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  wire                bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload;
  wire       [4:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy;
  wire       [4:0]    bridge_write_streamUnbuffered_queueWithOccupancy_io_availability;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_push_ready;
  wire                uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
  wire       [7:0]    uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  wire       [4:0]    uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
  wire       [4:0]    uartCtrl_1_io_read_queueWithOccupancy_io_availability;
  wire       [0:0]    _zz_10;
  wire       [0:0]    _zz_11;
  wire       [0:0]    _zz_12;
  wire       [0:0]    _zz_13;
  wire       [0:0]    _zz_14;
  wire       [0:0]    _zz_15;
  wire       [0:0]    _zz_16;
  wire       [0:0]    _zz_17;
  wire       [0:0]    _zz_18;
  wire       [0:0]    _zz_19;
  wire       [0:0]    _zz_20;
  wire       [0:0]    _zz_21;
  wire       [4:0]    _zz_22;
  wire                busCtrl_askWrite;
  wire                busCtrl_askRead;
  wire                busCtrl_doWrite;
  wire                busCtrl_doRead;
  wire       [2:0]    bridge_uartConfigReg_frame_dataLength;
  wire       `UartStopType_defaultEncoding_type bridge_uartConfigReg_frame_stop;
  wire       `UartParityType_defaultEncoding_type bridge_uartConfigReg_frame_parity;
  reg        [19:0]   bridge_uartConfigReg_clockDivider;
  reg                 _zz_1;
  wire                bridge_write_streamUnbuffered_valid;
  wire                bridge_write_streamUnbuffered_ready;
  wire       [7:0]    bridge_write_streamUnbuffered_payload;
  reg                 bridge_read_streamBreaked_valid;
  reg                 bridge_read_streamBreaked_ready;
  wire       [7:0]    bridge_read_streamBreaked_payload;
  reg                 bridge_interruptCtrl_writeIntEnable;
  reg                 bridge_interruptCtrl_readIntEnable;
  wire                bridge_interruptCtrl_readInt;
  wire                bridge_interruptCtrl_writeInt;
  wire                bridge_interruptCtrl_interrupt;
  reg                 bridge_misc_readError;
  reg                 _zz_2;
  reg                 bridge_misc_readOverflowError;
  reg                 _zz_3;
  reg                 bridge_misc_breakDetected;
  reg                 uartCtrl_1_io_readBreak_regNext;
  reg                 _zz_4;
  reg                 bridge_misc_doBreak;
  reg                 _zz_5;
  reg                 _zz_6;
  `ifndef SYNTHESIS
  reg [23:0] bridge_uartConfigReg_frame_stop_string;
  reg [31:0] bridge_uartConfigReg_frame_parity_string;
  `endif

  function [19:0] zz_bridge_uartConfigReg_clockDivider(input dummy);
    begin
      zz_bridge_uartConfigReg_clockDivider = 20'h0;
      zz_bridge_uartConfigReg_clockDivider = 20'h00055;
    end
  endfunction
  wire [19:0] _zz_23;

  assign _zz_10 = io_apb_PWDATA[0 : 0];
  assign _zz_11 = 1'b0;
  assign _zz_12 = io_apb_PWDATA[1 : 1];
  assign _zz_13 = 1'b0;
  assign _zz_14 = io_apb_PWDATA[9 : 9];
  assign _zz_15 = 1'b0;
  assign _zz_16 = io_apb_PWDATA[10 : 10];
  assign _zz_17 = 1'b1;
  assign _zz_18 = io_apb_PWDATA[11 : 11];
  assign _zz_19 = 1'b0;
  assign _zz_20 = io_apb_PWDATA[0 : 0];
  assign _zz_21 = io_apb_PWDATA[1 : 1];
  assign _zz_22 = (5'h10 - bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy);
  UartCtrl uartCtrl_1 (
    .io_config_frame_dataLength    (bridge_uartConfigReg_frame_dataLength[2:0]                            ), //i
    .io_config_frame_stop          (bridge_uartConfigReg_frame_stop                                       ), //i
    .io_config_frame_parity        (bridge_uartConfigReg_frame_parity[1:0]                                ), //i
    .io_config_clockDivider        (bridge_uartConfigReg_clockDivider[19:0]                               ), //i
    .io_write_valid                (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid         ), //i
    .io_write_ready                (uartCtrl_1_io_write_ready                                             ), //o
    .io_write_payload              (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload[7:0]  ), //i
    .io_read_valid                 (uartCtrl_1_io_read_valid                                              ), //o
    .io_read_ready                 (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready                   ), //i
    .io_read_payload               (uartCtrl_1_io_read_payload[7:0]                                       ), //o
    .io_uart_txd                   (uartCtrl_1_io_uart_txd                                                ), //o
    .io_uart_rxd                   (io_uart_rxd                                                           ), //i
    .io_readError                  (uartCtrl_1_io_readError                                               ), //o
    .io_writeBreak                 (bridge_misc_doBreak                                                   ), //i
    .io_readBreak                  (uartCtrl_1_io_readBreak                                               ), //o
    .io_mainClk                    (io_mainClk                                                            ), //i
    .resetCtrl_systemReset         (resetCtrl_systemReset                                                 )  //i
  );
  StreamFifo bridge_write_streamUnbuffered_queueWithOccupancy (
    .io_push_valid            (bridge_write_streamUnbuffered_valid                                    ), //i
    .io_push_ready            (bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready         ), //o
    .io_push_payload          (bridge_write_streamUnbuffered_payload[7:0]                             ), //i
    .io_pop_valid             (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid          ), //o
    .io_pop_ready             (uartCtrl_1_io_write_ready                                              ), //i
    .io_pop_payload           (bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_payload[7:0]   ), //o
    .io_flush                 (_zz_7                                                                  ), //i
    .io_occupancy             (bridge_write_streamUnbuffered_queueWithOccupancy_io_occupancy[4:0]     ), //o
    .io_availability          (bridge_write_streamUnbuffered_queueWithOccupancy_io_availability[4:0]  ), //o
    .io_mainClk               (io_mainClk                                                             ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                                                  )  //i
  );
  StreamFifo uartCtrl_1_io_read_queueWithOccupancy (
    .io_push_valid            (uartCtrl_1_io_read_valid                                    ), //i
    .io_push_ready            (uartCtrl_1_io_read_queueWithOccupancy_io_push_ready         ), //o
    .io_push_payload          (uartCtrl_1_io_read_payload[7:0]                             ), //i
    .io_pop_valid             (uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid          ), //o
    .io_pop_ready             (_zz_8                                                       ), //i
    .io_pop_payload           (uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload[7:0]   ), //o
    .io_flush                 (_zz_9                                                       ), //i
    .io_occupancy             (uartCtrl_1_io_read_queueWithOccupancy_io_occupancy[4:0]     ), //o
    .io_availability          (uartCtrl_1_io_read_queueWithOccupancy_io_availability[4:0]  ), //o
    .io_mainClk               (io_mainClk                                                  ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                                       )  //i
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

  assign io_uart_txd = uartCtrl_1_io_uart_txd;
  assign io_apb_PREADY = 1'b1;
  always @ (*) begin
    io_apb_PRDATA = 32'h0;
    case(io_apb_PADDR)
      5'h0 : begin
        io_apb_PRDATA[16 : 16] = (bridge_read_streamBreaked_valid ^ 1'b0);
        io_apb_PRDATA[7 : 0] = bridge_read_streamBreaked_payload;
      end
      5'h04 : begin
        io_apb_PRDATA[20 : 16] = _zz_22;
        io_apb_PRDATA[15 : 15] = bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid;
        io_apb_PRDATA[28 : 24] = uartCtrl_1_io_read_queueWithOccupancy_io_occupancy;
        io_apb_PRDATA[0 : 0] = bridge_interruptCtrl_writeIntEnable;
        io_apb_PRDATA[1 : 1] = bridge_interruptCtrl_readIntEnable;
        io_apb_PRDATA[8 : 8] = bridge_interruptCtrl_writeInt;
        io_apb_PRDATA[9 : 9] = bridge_interruptCtrl_readInt;
      end
      5'h10 : begin
        io_apb_PRDATA[0 : 0] = bridge_misc_readError;
        io_apb_PRDATA[1 : 1] = bridge_misc_readOverflowError;
        io_apb_PRDATA[8 : 8] = uartCtrl_1_io_readBreak;
        io_apb_PRDATA[9 : 9] = bridge_misc_breakDetected;
      end
      default : begin
      end
    endcase
  end

  assign busCtrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign busCtrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign busCtrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign busCtrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));
  assign _zz_23 = zz_bridge_uartConfigReg_clockDivider(1'b0);
  always @ (*) bridge_uartConfigReg_clockDivider = _zz_23;
  assign bridge_uartConfigReg_frame_dataLength = 3'b111;
  assign bridge_uartConfigReg_frame_parity = `UartParityType_defaultEncoding_NONE;
  assign bridge_uartConfigReg_frame_stop = `UartStopType_defaultEncoding_ONE;
  always @ (*) begin
    _zz_1 = 1'b0;
    case(io_apb_PADDR)
      5'h0 : begin
        if(busCtrl_doWrite)begin
          _zz_1 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_write_streamUnbuffered_valid = _zz_1;
  assign bridge_write_streamUnbuffered_payload = io_apb_PWDATA[7 : 0];
  assign bridge_write_streamUnbuffered_ready = bridge_write_streamUnbuffered_queueWithOccupancy_io_push_ready;
  always @ (*) begin
    bridge_read_streamBreaked_valid = uartCtrl_1_io_read_queueWithOccupancy_io_pop_valid;
    if(uartCtrl_1_io_readBreak)begin
      bridge_read_streamBreaked_valid = 1'b0;
    end
  end

  always @ (*) begin
    _zz_8 = bridge_read_streamBreaked_ready;
    if(uartCtrl_1_io_readBreak)begin
      _zz_8 = 1'b1;
    end
  end

  assign bridge_read_streamBreaked_payload = uartCtrl_1_io_read_queueWithOccupancy_io_pop_payload;
  always @ (*) begin
    bridge_read_streamBreaked_ready = 1'b0;
    case(io_apb_PADDR)
      5'h0 : begin
        if(busCtrl_doRead)begin
          bridge_read_streamBreaked_ready = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign bridge_interruptCtrl_readInt = (bridge_interruptCtrl_readIntEnable && bridge_read_streamBreaked_valid);
  assign bridge_interruptCtrl_writeInt = (bridge_interruptCtrl_writeIntEnable && (! bridge_write_streamUnbuffered_queueWithOccupancy_io_pop_valid));
  assign bridge_interruptCtrl_interrupt = (bridge_interruptCtrl_readInt || bridge_interruptCtrl_writeInt);
  always @ (*) begin
    _zz_2 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite)begin
          _zz_2 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_3 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite)begin
          _zz_3 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_4 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite)begin
          _zz_4 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_5 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite)begin
          _zz_5 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_6 = 1'b0;
    case(io_apb_PADDR)
      5'h10 : begin
        if(busCtrl_doWrite)begin
          _zz_6 = 1'b1;
        end
      end
      default : begin
      end
    endcase
  end

  assign io_interrupt = bridge_interruptCtrl_interrupt;
  assign _zz_7 = 1'b0;
  assign _zz_9 = 1'b0;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      bridge_interruptCtrl_writeIntEnable <= 1'b0;
      bridge_interruptCtrl_readIntEnable <= 1'b0;
      bridge_misc_readError <= 1'b0;
      bridge_misc_readOverflowError <= 1'b0;
      bridge_misc_breakDetected <= 1'b0;
      bridge_misc_doBreak <= 1'b0;
    end else begin
      if(_zz_2)begin
        if(_zz_10[0])begin
          bridge_misc_readError <= _zz_11[0];
        end
      end
      if(uartCtrl_1_io_readError)begin
        bridge_misc_readError <= 1'b1;
      end
      if(_zz_3)begin
        if(_zz_12[0])begin
          bridge_misc_readOverflowError <= _zz_13[0];
        end
      end
      if((uartCtrl_1_io_read_valid && (! uartCtrl_1_io_read_queueWithOccupancy_io_push_ready)))begin
        bridge_misc_readOverflowError <= 1'b1;
      end
      if((uartCtrl_1_io_readBreak && (! uartCtrl_1_io_readBreak_regNext)))begin
        bridge_misc_breakDetected <= 1'b1;
      end
      if(_zz_4)begin
        if(_zz_14[0])begin
          bridge_misc_breakDetected <= _zz_15[0];
        end
      end
      if(_zz_5)begin
        if(_zz_16[0])begin
          bridge_misc_doBreak <= _zz_17[0];
        end
      end
      if(_zz_6)begin
        if(_zz_18[0])begin
          bridge_misc_doBreak <= _zz_19[0];
        end
      end
      case(io_apb_PADDR)
        5'h04 : begin
          if(busCtrl_doWrite)begin
            bridge_interruptCtrl_writeIntEnable <= _zz_20[0];
            bridge_interruptCtrl_readIntEnable <= _zz_21[0];
          end
        end
        default : begin
        end
      endcase
    end
  end

  always @ (posedge io_mainClk) begin
    uartCtrl_1_io_readBreak_regNext <= uartCtrl_1_io_readBreak;
  end


endmodule

module Apb3Gpio (
  input      [3:0]    io_apb_PADDR,
  input      [0:0]    io_apb_PSEL,
  input               io_apb_PENABLE,
  output              io_apb_PREADY,
  input               io_apb_PWRITE,
  input      [31:0]   io_apb_PWDATA,
  output     [31:0]   io_apb_PRDATA,
  output              io_apb_PSLVERROR,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                ctrl_askWrite;
  wire                ctrl_askRead;
  wire                ctrl_doWrite;
  wire                ctrl_doRead;

  BufferCC_2 io_gpio_read_buffercc (
    .io_mainClk               (io_mainClk             ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset  )  //i
  );
  assign io_apb_PREADY = 1'b1;
  assign io_apb_PRDATA = 32'h0;
  assign io_apb_PSLVERROR = 1'b0;
  assign ctrl_askWrite = ((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PWRITE);
  assign ctrl_askRead = ((io_apb_PSEL[0] && io_apb_PENABLE) && (! io_apb_PWRITE));
  assign ctrl_doWrite = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && io_apb_PWRITE);
  assign ctrl_doRead = (((io_apb_PSEL[0] && io_apb_PENABLE) && io_apb_PREADY) && (! io_apb_PWRITE));

endmodule

module PipelinedMemoryBusToApbBridge (
  input               io_pipelinedMemoryBus_cmd_valid,
  output              io_pipelinedMemoryBus_cmd_ready,
  input               io_pipelinedMemoryBus_cmd_payload_write,
  input      [31:0]   io_pipelinedMemoryBus_cmd_payload_address,
  input      [31:0]   io_pipelinedMemoryBus_cmd_payload_data,
  input      [3:0]    io_pipelinedMemoryBus_cmd_payload_mask,
  output              io_pipelinedMemoryBus_rsp_valid,
  output     [31:0]   io_pipelinedMemoryBus_rsp_payload_data,
  output     [19:0]   io_apb_PADDR,
  output     [0:0]    io_apb_PSEL,
  output              io_apb_PENABLE,
  input               io_apb_PREADY,
  output              io_apb_PWRITE,
  output     [31:0]   io_apb_PWDATA,
  input      [31:0]   io_apb_PRDATA,
  input               io_apb_PSLVERROR,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_1;
  wire                _zz_2;
  wire                pipelinedMemoryBusStage_cmd_valid;
  reg                 pipelinedMemoryBusStage_cmd_ready;
  wire                pipelinedMemoryBusStage_cmd_payload_write;
  wire       [31:0]   pipelinedMemoryBusStage_cmd_payload_address;
  wire       [31:0]   pipelinedMemoryBusStage_cmd_payload_data;
  wire       [3:0]    pipelinedMemoryBusStage_cmd_payload_mask;
  reg                 pipelinedMemoryBusStage_rsp_valid;
  wire       [31:0]   pipelinedMemoryBusStage_rsp_payload_data;
  wire                io_pipelinedMemoryBus_cmd_halfPipe_valid;
  wire                io_pipelinedMemoryBus_cmd_halfPipe_ready;
  wire                io_pipelinedMemoryBus_cmd_halfPipe_payload_write;
  wire       [31:0]   io_pipelinedMemoryBus_cmd_halfPipe_payload_address;
  wire       [31:0]   io_pipelinedMemoryBus_cmd_halfPipe_payload_data;
  wire       [3:0]    io_pipelinedMemoryBus_cmd_halfPipe_payload_mask;
  reg                 io_pipelinedMemoryBus_cmd_halfPipe_regs_valid;
  reg                 io_pipelinedMemoryBus_cmd_halfPipe_regs_ready;
  reg                 io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_write;
  reg        [31:0]   io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_address;
  reg        [31:0]   io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_data;
  reg        [3:0]    io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_mask;
  reg                 pipelinedMemoryBusStage_rsp_regNext_valid;
  reg        [31:0]   pipelinedMemoryBusStage_rsp_regNext_payload_data;
  reg                 state;

  assign _zz_1 = (! state);
  assign _zz_2 = (! io_pipelinedMemoryBus_cmd_halfPipe_regs_valid);
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
  assign io_pipelinedMemoryBus_rsp_valid = pipelinedMemoryBusStage_rsp_regNext_valid;
  assign io_pipelinedMemoryBus_rsp_payload_data = pipelinedMemoryBusStage_rsp_regNext_payload_data;
  always @ (*) begin
    pipelinedMemoryBusStage_cmd_ready = 1'b0;
    if(! _zz_1) begin
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
    if(! _zz_1) begin
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
      pipelinedMemoryBusStage_rsp_regNext_valid <= 1'b0;
      state <= 1'b0;
    end else begin
      if(_zz_2)begin
        io_pipelinedMemoryBus_cmd_halfPipe_regs_valid <= io_pipelinedMemoryBus_cmd_valid;
        io_pipelinedMemoryBus_cmd_halfPipe_regs_ready <= (! io_pipelinedMemoryBus_cmd_valid);
      end else begin
        io_pipelinedMemoryBus_cmd_halfPipe_regs_valid <= (! io_pipelinedMemoryBus_cmd_halfPipe_ready);
        io_pipelinedMemoryBus_cmd_halfPipe_regs_ready <= io_pipelinedMemoryBus_cmd_halfPipe_ready;
      end
      pipelinedMemoryBusStage_rsp_regNext_valid <= pipelinedMemoryBusStage_rsp_valid;
      if(_zz_1)begin
        state <= pipelinedMemoryBusStage_cmd_valid;
      end else begin
        if(io_apb_PREADY)begin
          state <= 1'b0;
        end
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_2)begin
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_write <= io_pipelinedMemoryBus_cmd_payload_write;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_address <= io_pipelinedMemoryBus_cmd_payload_address;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_data <= io_pipelinedMemoryBus_cmd_payload_data;
      io_pipelinedMemoryBus_cmd_halfPipe_regs_payload_mask <= io_pipelinedMemoryBus_cmd_payload_mask;
    end
    pipelinedMemoryBusStage_rsp_regNext_payload_data <= pipelinedMemoryBusStage_rsp_payload_data;
  end


endmodule

module MuraxPipelinedMemoryBusRam (
  input               io_bus_cmd_valid,
  output              io_bus_cmd_ready,
  input               io_bus_cmd_payload_write,
  input      [31:0]   io_bus_cmd_payload_address,
  input      [31:0]   io_bus_cmd_payload_data,
  input      [3:0]    io_bus_cmd_payload_mask,
  output              io_bus_rsp_valid,
  output     [31:0]   io_bus_rsp_payload_data,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  reg        [31:0]   _zz_4;
  wire       [14:0]   _zz_5;
  reg                 _zz_1;
  wire       [29:0]   _zz_2;
  wire       [31:0]   _zz_3;
  reg [7:0] ram_symbol0 [0:32767];
  reg [7:0] ram_symbol1 [0:32767];
  reg [7:0] ram_symbol2 [0:32767];
  reg [7:0] ram_symbol3 [0:32767];
  reg [7:0] _zz_6;
  reg [7:0] _zz_7;
  reg [7:0] _zz_8;
  reg [7:0] _zz_9;

  assign _zz_5 = _zz_2[14:0];
  always @ (*) begin
    _zz_4 = {_zz_9, _zz_8, _zz_7, _zz_6};
  end
  always @ (posedge io_mainClk) begin
    if(io_bus_cmd_valid) begin
      _zz_6 <= ram_symbol0[_zz_5];
      _zz_7 <= ram_symbol1[_zz_5];
      _zz_8 <= ram_symbol2[_zz_5];
      _zz_9 <= ram_symbol3[_zz_5];
    end
  end

  always @ (posedge io_mainClk) begin
    if(io_bus_cmd_payload_mask[0] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol0[_zz_5] <= _zz_3[7 : 0];
    end
    if(io_bus_cmd_payload_mask[1] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol1[_zz_5] <= _zz_3[15 : 8];
    end
    if(io_bus_cmd_payload_mask[2] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol2[_zz_5] <= _zz_3[23 : 16];
    end
    if(io_bus_cmd_payload_mask[3] && io_bus_cmd_valid && io_bus_cmd_payload_write ) begin
      ram_symbol3[_zz_5] <= _zz_3[31 : 24];
    end
  end

  assign io_bus_rsp_valid = _zz_1;
  assign _zz_2 = (io_bus_cmd_payload_address >>> 2);
  assign _zz_3 = io_bus_cmd_payload_data;
  assign io_bus_rsp_payload_data = _zz_4;
  assign io_bus_cmd_ready = 1'b1;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      _zz_1 <= 1'b0;
    end else begin
      _zz_1 <= ((io_bus_cmd_valid && io_bus_cmd_ready) && (! io_bus_cmd_payload_write));
    end
  end


endmodule

module SystemDebugger (
  input               io_remote_cmd_valid,
  output              io_remote_cmd_ready,
  input               io_remote_cmd_payload_last,
  input      [0:0]    io_remote_cmd_payload_fragment,
  output              io_remote_rsp_valid,
  input               io_remote_rsp_ready,
  output              io_remote_rsp_payload_error,
  output     [31:0]   io_remote_rsp_payload_data,
  output              io_mem_cmd_valid,
  input               io_mem_cmd_ready,
  output     [31:0]   io_mem_cmd_payload_address,
  output     [31:0]   io_mem_cmd_payload_data,
  output              io_mem_cmd_payload_wr,
  output     [1:0]    io_mem_cmd_payload_size,
  input               io_mem_rsp_valid,
  input      [31:0]   io_mem_rsp_payload,
  input               io_mainClk,
  input               resetCtrl_mainClkReset
);
  wire                _zz_2;
  wire       [0:0]    _zz_3;
  reg        [66:0]   dispatcher_dataShifter;
  reg                 dispatcher_dataLoaded;
  reg        [7:0]    dispatcher_headerShifter;
  wire       [7:0]    dispatcher_header;
  reg                 dispatcher_headerLoaded;
  reg        [2:0]    dispatcher_counter;
  wire       [66:0]   _zz_1;

  assign _zz_2 = (dispatcher_headerLoaded == 1'b0);
  assign _zz_3 = _zz_1[64 : 64];
  assign dispatcher_header = dispatcher_headerShifter[7 : 0];
  assign io_remote_cmd_ready = (! dispatcher_dataLoaded);
  assign _zz_1 = dispatcher_dataShifter[66 : 0];
  assign io_mem_cmd_payload_address = _zz_1[31 : 0];
  assign io_mem_cmd_payload_data = _zz_1[63 : 32];
  assign io_mem_cmd_payload_wr = _zz_3[0];
  assign io_mem_cmd_payload_size = _zz_1[66 : 65];
  assign io_mem_cmd_valid = (dispatcher_dataLoaded && (dispatcher_header == 8'h0));
  assign io_remote_rsp_valid = io_mem_rsp_valid;
  assign io_remote_rsp_payload_error = 1'b0;
  assign io_remote_rsp_payload_data = io_mem_rsp_payload;
  always @ (posedge io_mainClk or posedge resetCtrl_mainClkReset) begin
    if (resetCtrl_mainClkReset) begin
      dispatcher_dataLoaded <= 1'b0;
      dispatcher_headerLoaded <= 1'b0;
      dispatcher_counter <= 3'b000;
    end else begin
      if(io_remote_cmd_valid)begin
        if(_zz_2)begin
          dispatcher_counter <= (dispatcher_counter + 3'b001);
          if((dispatcher_counter == 3'b111))begin
            dispatcher_headerLoaded <= 1'b1;
          end
        end
        if(io_remote_cmd_payload_last)begin
          dispatcher_headerLoaded <= 1'b1;
          dispatcher_dataLoaded <= 1'b1;
          dispatcher_counter <= 3'b000;
        end
      end
      if(((dispatcher_headerLoaded && dispatcher_dataLoaded) && (! (io_mem_cmd_valid && (! io_mem_cmd_ready)))))begin
        dispatcher_headerLoaded <= 1'b0;
        dispatcher_dataLoaded <= 1'b0;
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(io_remote_cmd_valid)begin
      if(_zz_2)begin
        dispatcher_headerShifter <= ({io_remote_cmd_payload_fragment,dispatcher_headerShifter} >>> 1);
      end else begin
        dispatcher_dataShifter <= ({io_remote_cmd_payload_fragment,dispatcher_dataShifter} >>> 1);
      end
    end
  end


endmodule

module JtagBridgeNoTap (
  input               io_ctrl_tdi,
  input               io_ctrl_enable,
  input               io_ctrl_capture,
  input               io_ctrl_shift,
  input               io_ctrl_update,
  input               io_ctrl_reset,
  output              io_ctrl_tdo,
  output              io_remote_cmd_valid,
  input               io_remote_cmd_ready,
  output              io_remote_cmd_payload_last,
  output     [0:0]    io_remote_cmd_payload_fragment,
  input               io_remote_rsp_valid,
  output              io_remote_rsp_ready,
  input               io_remote_rsp_payload_error,
  input      [31:0]   io_remote_rsp_payload_data,
  input               io_mainClk,
  input               resetCtrl_mainClkReset,
  input               tck
);
  wire                _zz_9;
  wire                flowCCByToggle_1_io_output_valid;
  wire                flowCCByToggle_1_io_output_payload_last;
  wire       [0:0]    flowCCByToggle_1_io_output_payload_fragment;
  wire                _zz_10;
  wire                _zz_11;
  wire                system_cmd_valid;
  wire                system_cmd_payload_last;
  wire       [0:0]    system_cmd_payload_fragment;
  reg                 system_rsp_valid;
  reg                 system_rsp_payload_error;
  reg        [31:0]   system_rsp_payload_data;
  wire                jtag_wrapper_ctrl_tdi;
  wire                jtag_wrapper_ctrl_enable;
  wire                jtag_wrapper_ctrl_capture;
  wire                jtag_wrapper_ctrl_shift;
  wire                jtag_wrapper_ctrl_update;
  wire                jtag_wrapper_ctrl_reset;
  reg                 jtag_wrapper_ctrl_tdo;
  reg        [1:0]    jtag_wrapper_header;
  wire       [1:0]    jtag_wrapper_headerNext;
  reg        [0:0]    jtag_wrapper_counter;
  reg                 jtag_wrapper_done;
  reg                 jtag_wrapper_sendCapture;
  reg                 jtag_wrapper_sendShift;
  reg                 jtag_wrapper_sendUpdate;
  wire                _zz_1;
  wire                _zz_2;
  wire       [0:0]    _zz_3;
  reg                 _zz_4;
  reg                 _zz_5;
  wire                _zz_6;
  reg        [33:0]   _zz_7;
  wire                _zz_8;

  assign _zz_10 = (! jtag_wrapper_done);
  assign _zz_11 = (jtag_wrapper_counter == 1'b1);
  FlowCCByToggle flowCCByToggle_1 (
    .io_input_valid                (_zz_4                                        ), //i
    .io_input_payload_last         (_zz_9                                        ), //i
    .io_input_payload_fragment     (_zz_3                                        ), //i
    .io_output_valid               (flowCCByToggle_1_io_output_valid             ), //o
    .io_output_payload_last        (flowCCByToggle_1_io_output_payload_last      ), //o
    .io_output_payload_fragment    (flowCCByToggle_1_io_output_payload_fragment  ), //o
    .tck                           (tck                                          ), //i
    .io_mainClk                    (io_mainClk                                   ), //i
    .resetCtrl_mainClkReset        (resetCtrl_mainClkReset                       )  //i
  );
  assign io_remote_cmd_valid = system_cmd_valid;
  assign io_remote_cmd_payload_last = system_cmd_payload_last;
  assign io_remote_cmd_payload_fragment = system_cmd_payload_fragment;
  assign io_remote_rsp_ready = 1'b1;
  assign jtag_wrapper_headerNext = ({jtag_wrapper_ctrl_tdi,jtag_wrapper_header} >>> 1);
  always @ (*) begin
    jtag_wrapper_sendCapture = 1'b0;
    if(jtag_wrapper_ctrl_enable)begin
      if(jtag_wrapper_ctrl_shift)begin
        if(_zz_10)begin
          if(_zz_11)begin
            jtag_wrapper_sendCapture = 1'b1;
          end
        end
      end
    end
  end

  always @ (*) begin
    jtag_wrapper_sendShift = 1'b0;
    if(jtag_wrapper_ctrl_enable)begin
      if(jtag_wrapper_ctrl_shift)begin
        if(! _zz_10) begin
          jtag_wrapper_sendShift = 1'b1;
        end
      end
    end
  end

  always @ (*) begin
    jtag_wrapper_sendUpdate = 1'b0;
    if(jtag_wrapper_ctrl_enable)begin
      if(jtag_wrapper_ctrl_update)begin
        jtag_wrapper_sendUpdate = 1'b1;
      end
    end
  end

  always @ (*) begin
    jtag_wrapper_ctrl_tdo = 1'b0;
    if(_zz_6)begin
      jtag_wrapper_ctrl_tdo = 1'b0;
    end
    if(_zz_8)begin
      jtag_wrapper_ctrl_tdo = _zz_7[0];
    end
  end

  assign jtag_wrapper_ctrl_tdi = io_ctrl_tdi;
  assign jtag_wrapper_ctrl_enable = io_ctrl_enable;
  assign jtag_wrapper_ctrl_capture = io_ctrl_capture;
  assign jtag_wrapper_ctrl_shift = io_ctrl_shift;
  assign jtag_wrapper_ctrl_update = io_ctrl_update;
  assign jtag_wrapper_ctrl_reset = io_ctrl_reset;
  assign io_ctrl_tdo = jtag_wrapper_ctrl_tdo;
  assign _zz_3[0] = _zz_5;
  assign _zz_9 = (! (_zz_1 && _zz_2));
  assign system_cmd_valid = flowCCByToggle_1_io_output_valid;
  assign system_cmd_payload_last = flowCCByToggle_1_io_output_payload_last;
  assign system_cmd_payload_fragment = flowCCByToggle_1_io_output_payload_fragment;
  assign _zz_6 = (jtag_wrapper_header == 2'b00);
  assign _zz_1 = 1'b1;
  assign _zz_2 = (_zz_6 && jtag_wrapper_sendShift);
  assign _zz_8 = (jtag_wrapper_header == 2'b01);
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

  always @ (posedge tck) begin
    if(jtag_wrapper_ctrl_enable)begin
      if(jtag_wrapper_ctrl_capture)begin
        jtag_wrapper_done <= 1'b0;
        jtag_wrapper_counter <= 1'b0;
      end
      if(jtag_wrapper_ctrl_shift)begin
        if(_zz_10)begin
          jtag_wrapper_counter <= (jtag_wrapper_counter + 1'b1);
          jtag_wrapper_header <= jtag_wrapper_headerNext;
          if(_zz_11)begin
            jtag_wrapper_done <= 1'b1;
          end
        end
      end
    end
    _zz_4 <= (_zz_1 && _zz_2);
    _zz_5 <= jtag_wrapper_ctrl_tdi;
    if(1'b1)begin
      if(((jtag_wrapper_headerNext == 2'b01) && jtag_wrapper_sendCapture))begin
        _zz_7 <= {{system_rsp_payload_data,system_rsp_payload_error},system_rsp_valid};
      end
      if((_zz_8 && jtag_wrapper_sendShift))begin
        _zz_7 <= ({jtag_wrapper_ctrl_tdi,_zz_7} >>> 1);
      end
    end
  end


endmodule

module VexRiscv (
  output              iBus_cmd_valid,
  input               iBus_cmd_ready,
  output     [31:0]   iBus_cmd_payload_pc,
  input               iBus_rsp_valid,
  input               iBus_rsp_payload_error,
  input      [31:0]   iBus_rsp_payload_inst,
  input               timerInterrupt,
  input               externalInterrupt,
  input               softwareInterrupt,
  input               debug_bus_cmd_valid,
  output reg          debug_bus_cmd_ready,
  input               debug_bus_cmd_payload_wr,
  input      [7:0]    debug_bus_cmd_payload_address,
  input      [31:0]   debug_bus_cmd_payload_data,
  output reg [31:0]   debug_bus_rsp_data,
  output              debug_resetOut,
  output              dBus_cmd_valid,
  input               dBus_cmd_ready,
  output              dBus_cmd_payload_wr,
  output     [31:0]   dBus_cmd_payload_address,
  output     [31:0]   dBus_cmd_payload_data,
  output     [1:0]    dBus_cmd_payload_size,
  input               dBus_rsp_ready,
  input               dBus_rsp_error,
  input      [31:0]   dBus_rsp_data,
  input               io_mainClk,
  input               resetCtrl_systemReset,
  input               resetCtrl_mainClkReset
);
  wire                _zz_162;
  wire                _zz_163;
  reg        [31:0]   _zz_164;
  reg        [31:0]   _zz_165;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  wire       [0:0]    IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy;
  wire                _zz_166;
  wire                _zz_167;
  wire                _zz_168;
  wire                _zz_169;
  wire                _zz_170;
  wire                _zz_171;
  wire                _zz_172;
  wire                _zz_173;
  wire                _zz_174;
  wire       [1:0]    _zz_175;
  wire                _zz_176;
  wire                _zz_177;
  wire                _zz_178;
  wire                _zz_179;
  wire       [1:0]    _zz_180;
  wire                _zz_181;
  wire                _zz_182;
  wire                _zz_183;
  wire                _zz_184;
  wire                _zz_185;
  wire                _zz_186;
  wire                _zz_187;
  wire                _zz_188;
  wire       [5:0]    _zz_189;
  wire                _zz_190;
  wire                _zz_191;
  wire                _zz_192;
  wire                _zz_193;
  wire                _zz_194;
  wire                _zz_195;
  wire       [4:0]    _zz_196;
  wire       [1:0]    _zz_197;
  wire       [1:0]    _zz_198;
  wire       [1:0]    _zz_199;
  wire                _zz_200;
  wire       [1:0]    _zz_201;
  wire       [51:0]   _zz_202;
  wire       [51:0]   _zz_203;
  wire       [51:0]   _zz_204;
  wire       [32:0]   _zz_205;
  wire       [51:0]   _zz_206;
  wire       [49:0]   _zz_207;
  wire       [51:0]   _zz_208;
  wire       [49:0]   _zz_209;
  wire       [51:0]   _zz_210;
  wire       [0:0]    _zz_211;
  wire       [0:0]    _zz_212;
  wire       [0:0]    _zz_213;
  wire       [0:0]    _zz_214;
  wire       [0:0]    _zz_215;
  wire       [0:0]    _zz_216;
  wire       [0:0]    _zz_217;
  wire       [0:0]    _zz_218;
  wire       [0:0]    _zz_219;
  wire       [0:0]    _zz_220;
  wire       [2:0]    _zz_221;
  wire       [31:0]   _zz_222;
  wire       [0:0]    _zz_223;
  wire       [0:0]    _zz_224;
  wire       [0:0]    _zz_225;
  wire       [0:0]    _zz_226;
  wire       [0:0]    _zz_227;
  wire       [0:0]    _zz_228;
  wire       [1:0]    _zz_229;
  wire       [1:0]    _zz_230;
  wire       [2:0]    _zz_231;
  wire       [31:0]   _zz_232;
  wire       [2:0]    _zz_233;
  wire       [31:0]   _zz_234;
  wire       [31:0]   _zz_235;
  wire       [11:0]   _zz_236;
  wire       [11:0]   _zz_237;
  wire       [2:0]    _zz_238;
  wire       [0:0]    _zz_239;
  wire       [2:0]    _zz_240;
  wire       [0:0]    _zz_241;
  wire       [2:0]    _zz_242;
  wire       [0:0]    _zz_243;
  wire       [2:0]    _zz_244;
  wire       [0:0]    _zz_245;
  wire       [2:0]    _zz_246;
  wire       [4:0]    _zz_247;
  wire       [11:0]   _zz_248;
  wire       [11:0]   _zz_249;
  wire       [31:0]   _zz_250;
  wire       [31:0]   _zz_251;
  wire       [31:0]   _zz_252;
  wire       [31:0]   _zz_253;
  wire       [31:0]   _zz_254;
  wire       [31:0]   _zz_255;
  wire       [31:0]   _zz_256;
  wire       [65:0]   _zz_257;
  wire       [65:0]   _zz_258;
  wire       [31:0]   _zz_259;
  wire       [31:0]   _zz_260;
  wire       [0:0]    _zz_261;
  wire       [5:0]    _zz_262;
  wire       [32:0]   _zz_263;
  wire       [31:0]   _zz_264;
  wire       [31:0]   _zz_265;
  wire       [32:0]   _zz_266;
  wire       [32:0]   _zz_267;
  wire       [32:0]   _zz_268;
  wire       [32:0]   _zz_269;
  wire       [0:0]    _zz_270;
  wire       [32:0]   _zz_271;
  wire       [0:0]    _zz_272;
  wire       [32:0]   _zz_273;
  wire       [0:0]    _zz_274;
  wire       [31:0]   _zz_275;
  wire       [31:0]   _zz_276;
  wire       [32:0]   _zz_277;
  wire       [19:0]   _zz_278;
  wire       [11:0]   _zz_279;
  wire       [11:0]   _zz_280;
  wire       [0:0]    _zz_281;
  wire       [0:0]    _zz_282;
  wire       [0:0]    _zz_283;
  wire       [0:0]    _zz_284;
  wire       [0:0]    _zz_285;
  wire       [0:0]    _zz_286;
  wire       [0:0]    _zz_287;
  wire                _zz_288;
  wire                _zz_289;
  wire                _zz_290;
  wire                _zz_291;
  wire       [6:0]    _zz_292;
  wire       [4:0]    _zz_293;
  wire                _zz_294;
  wire       [4:0]    _zz_295;
  wire       [31:0]   _zz_296;
  wire                _zz_297;
  wire                _zz_298;
  wire       [1:0]    _zz_299;
  wire       [1:0]    _zz_300;
  wire                _zz_301;
  wire       [0:0]    _zz_302;
  wire       [24:0]   _zz_303;
  wire       [31:0]   _zz_304;
  wire       [31:0]   _zz_305;
  wire       [31:0]   _zz_306;
  wire       [31:0]   _zz_307;
  wire                _zz_308;
  wire       [0:0]    _zz_309;
  wire       [0:0]    _zz_310;
  wire       [0:0]    _zz_311;
  wire       [0:0]    _zz_312;
  wire                _zz_313;
  wire       [0:0]    _zz_314;
  wire       [21:0]   _zz_315;
  wire       [31:0]   _zz_316;
  wire       [31:0]   _zz_317;
  wire       [31:0]   _zz_318;
  wire       [31:0]   _zz_319;
  wire                _zz_320;
  wire       [2:0]    _zz_321;
  wire       [2:0]    _zz_322;
  wire                _zz_323;
  wire       [0:0]    _zz_324;
  wire       [18:0]   _zz_325;
  wire       [31:0]   _zz_326;
  wire       [31:0]   _zz_327;
  wire                _zz_328;
  wire                _zz_329;
  wire       [31:0]   _zz_330;
  wire       [31:0]   _zz_331;
  wire                _zz_332;
  wire       [1:0]    _zz_333;
  wire       [1:0]    _zz_334;
  wire                _zz_335;
  wire       [0:0]    _zz_336;
  wire       [15:0]   _zz_337;
  wire       [31:0]   _zz_338;
  wire       [31:0]   _zz_339;
  wire       [31:0]   _zz_340;
  wire       [31:0]   _zz_341;
  wire                _zz_342;
  wire                _zz_343;
  wire       [1:0]    _zz_344;
  wire       [1:0]    _zz_345;
  wire                _zz_346;
  wire       [0:0]    _zz_347;
  wire       [12:0]   _zz_348;
  wire       [31:0]   _zz_349;
  wire       [31:0]   _zz_350;
  wire       [31:0]   _zz_351;
  wire       [31:0]   _zz_352;
  wire       [31:0]   _zz_353;
  wire       [31:0]   _zz_354;
  wire       [0:0]    _zz_355;
  wire       [2:0]    _zz_356;
  wire       [1:0]    _zz_357;
  wire       [1:0]    _zz_358;
  wire                _zz_359;
  wire       [0:0]    _zz_360;
  wire       [9:0]    _zz_361;
  wire       [31:0]   _zz_362;
  wire       [31:0]   _zz_363;
  wire       [31:0]   _zz_364;
  wire                _zz_365;
  wire                _zz_366;
  wire       [31:0]   _zz_367;
  wire       [31:0]   _zz_368;
  wire       [31:0]   _zz_369;
  wire       [31:0]   _zz_370;
  wire                _zz_371;
  wire                _zz_372;
  wire                _zz_373;
  wire       [4:0]    _zz_374;
  wire       [4:0]    _zz_375;
  wire                _zz_376;
  wire       [0:0]    _zz_377;
  wire       [6:0]    _zz_378;
  wire       [31:0]   _zz_379;
  wire       [31:0]   _zz_380;
  wire       [31:0]   _zz_381;
  wire       [31:0]   _zz_382;
  wire       [31:0]   _zz_383;
  wire                _zz_384;
  wire       [0:0]    _zz_385;
  wire       [2:0]    _zz_386;
  wire       [0:0]    _zz_387;
  wire       [1:0]    _zz_388;
  wire       [5:0]    _zz_389;
  wire       [5:0]    _zz_390;
  wire                _zz_391;
  wire       [0:0]    _zz_392;
  wire       [4:0]    _zz_393;
  wire       [31:0]   _zz_394;
  wire       [31:0]   _zz_395;
  wire                _zz_396;
  wire       [31:0]   _zz_397;
  wire       [31:0]   _zz_398;
  wire                _zz_399;
  wire       [0:0]    _zz_400;
  wire       [2:0]    _zz_401;
  wire                _zz_402;
  wire       [0:0]    _zz_403;
  wire       [0:0]    _zz_404;
  wire       [3:0]    _zz_405;
  wire       [3:0]    _zz_406;
  wire                _zz_407;
  wire       [0:0]    _zz_408;
  wire       [1:0]    _zz_409;
  wire       [31:0]   _zz_410;
  wire       [31:0]   _zz_411;
  wire       [31:0]   _zz_412;
  wire       [31:0]   _zz_413;
  wire                _zz_414;
  wire       [0:0]    _zz_415;
  wire       [0:0]    _zz_416;
  wire       [31:0]   _zz_417;
  wire       [31:0]   _zz_418;
  wire       [31:0]   _zz_419;
  wire                _zz_420;
  wire       [0:0]    _zz_421;
  wire       [1:0]    _zz_422;
  wire                _zz_423;
  wire       [2:0]    _zz_424;
  wire       [2:0]    _zz_425;
  wire                _zz_426;
  wire                _zz_427;
  wire       [31:0]   _zz_428;
  wire       [31:0]   _zz_429;
  wire       [31:0]   _zz_430;
  wire       [31:0]   _zz_431;
  wire       [31:0]   _zz_432;
  wire       [31:0]   _zz_433;
  wire       [31:0]   _zz_434;
  wire       [31:0]   _zz_435;
  wire                _zz_436;
  wire       [31:0]   _zz_437;
  wire                _zz_438;
  wire       [0:0]    _zz_439;
  wire       [0:0]    _zz_440;
  wire       [0:0]    _zz_441;
  wire       [0:0]    _zz_442;
  wire       [0:0]    _zz_443;
  wire       [0:0]    _zz_444;
  wire       [31:0]   _zz_445;
  wire       [51:0]   memory_MUL_LOW;
  wire       [31:0]   memory_MEMORY_READ_DATA;
  wire       [31:0]   execute_BRANCH_CALC;
  wire                execute_BRANCH_DO;
  wire       [33:0]   memory_MUL_HH;
  wire       [33:0]   execute_MUL_HH;
  wire       [33:0]   execute_MUL_HL;
  wire       [33:0]   execute_MUL_LH;
  wire       [31:0]   execute_MUL_LL;
  wire       [31:0]   writeBack_REGFILE_WRITE_DATA;
  wire       [31:0]   execute_REGFILE_WRITE_DATA;
  wire       [1:0]    memory_MEMORY_ADDRESS_LOW;
  wire       [1:0]    execute_MEMORY_ADDRESS_LOW;
  wire                decode_DO_EBREAK;
  wire       [31:0]   decode_SRC2;
  wire       [31:0]   decode_SRC1;
  wire                decode_SRC2_FORCE_ZERO;
  wire       [31:0]   decode_RS2;
  wire       [31:0]   decode_RS1;
  wire       `BranchCtrlEnum_defaultEncoding_type decode_BRANCH_CTRL;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_1;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_2;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_3;
  wire       `ShiftCtrlEnum_defaultEncoding_type decode_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_4;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_5;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_6;
  wire                decode_IS_RS2_SIGNED;
  wire                decode_IS_RS1_SIGNED;
  wire                decode_IS_DIV;
  wire                memory_IS_MUL;
  wire                execute_IS_MUL;
  wire                decode_IS_MUL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type decode_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_7;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_8;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_9;
  wire                decode_SRC_LESS_UNSIGNED;
  wire       `AluCtrlEnum_defaultEncoding_type decode_ALU_CTRL;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_10;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_11;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_12;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_13;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_14;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_15;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_16;
  wire       `EnvCtrlEnum_defaultEncoding_type decode_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_17;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_18;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_19;
  wire                decode_IS_CSR;
  wire                decode_MEMORY_STORE;
  wire                execute_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_MEMORY_STAGE;
  wire                decode_BYPASSABLE_EXECUTE_STAGE;
  wire                decode_MEMORY_ENABLE;
  wire                decode_CSR_READ_OPCODE;
  wire                decode_CSR_WRITE_OPCODE;
  wire       [31:0]   writeBack_FORMAL_PC_NEXT;
  wire       [31:0]   memory_FORMAL_PC_NEXT;
  wire       [31:0]   execute_FORMAL_PC_NEXT;
  wire       [31:0]   decode_FORMAL_PC_NEXT;
  wire       [31:0]   memory_PC;
  wire                execute_DO_EBREAK;
  wire                decode_IS_EBREAK;
  wire       [31:0]   memory_BRANCH_CALC;
  wire                memory_BRANCH_DO;
  wire       [31:0]   execute_PC;
  wire       `BranchCtrlEnum_defaultEncoding_type execute_BRANCH_CTRL;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_20;
  wire                decode_RS2_USE;
  wire                decode_RS1_USE;
  wire                execute_REGFILE_WRITE_VALID;
  wire                execute_BYPASSABLE_EXECUTE_STAGE;
  wire                memory_REGFILE_WRITE_VALID;
  wire                memory_BYPASSABLE_MEMORY_STAGE;
  wire                writeBack_REGFILE_WRITE_VALID;
  wire       [31:0]   memory_REGFILE_WRITE_DATA;
  wire       `ShiftCtrlEnum_defaultEncoding_type execute_SHIFT_CTRL;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_21;
  wire                execute_IS_RS1_SIGNED;
  wire                execute_IS_DIV;
  wire                execute_IS_RS2_SIGNED;
  reg        [31:0]   _zz_22;
  wire       [31:0]   memory_INSTRUCTION;
  wire                memory_IS_DIV;
  wire                writeBack_IS_MUL;
  wire       [33:0]   writeBack_MUL_HH;
  wire       [51:0]   writeBack_MUL_LOW;
  wire       [33:0]   memory_MUL_HL;
  wire       [33:0]   memory_MUL_LH;
  wire       [31:0]   memory_MUL_LL;
  (* keep , syn_keep *) wire       [31:0]   execute_RS1 /* synthesis syn_keep = 1 */ ;
  wire                execute_SRC_LESS_UNSIGNED;
  wire                execute_SRC2_FORCE_ZERO;
  wire                execute_SRC_USE_SUB_LESS;
  wire       [31:0]   _zz_23;
  wire       [31:0]   _zz_24;
  wire       `Src2CtrlEnum_defaultEncoding_type decode_SRC2_CTRL;
  wire       `Src2CtrlEnum_defaultEncoding_type _zz_25;
  wire       [31:0]   _zz_26;
  wire       `Src1CtrlEnum_defaultEncoding_type decode_SRC1_CTRL;
  wire       `Src1CtrlEnum_defaultEncoding_type _zz_27;
  wire                decode_SRC_USE_SUB_LESS;
  wire                decode_SRC_ADD_ZERO;
  wire       [31:0]   execute_SRC_ADD_SUB;
  wire                execute_SRC_LESS;
  wire       `AluCtrlEnum_defaultEncoding_type execute_ALU_CTRL;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_28;
  wire       [31:0]   execute_SRC2;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type execute_ALU_BITWISE_CTRL;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_29;
  wire       [31:0]   _zz_30;
  wire                _zz_31;
  reg                 _zz_32;
  wire       [31:0]   decode_INSTRUCTION_ANTICIPATED;
  reg                 decode_REGFILE_WRITE_VALID;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_33;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_34;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_35;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_36;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_37;
  wire       `Src2CtrlEnum_defaultEncoding_type _zz_38;
  wire       `Src1CtrlEnum_defaultEncoding_type _zz_39;
  reg        [31:0]   _zz_40;
  wire       [31:0]   execute_SRC1;
  wire                execute_CSR_READ_OPCODE;
  wire                execute_CSR_WRITE_OPCODE;
  wire                execute_IS_CSR;
  wire       `EnvCtrlEnum_defaultEncoding_type memory_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_41;
  wire       `EnvCtrlEnum_defaultEncoding_type execute_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_42;
  wire       `EnvCtrlEnum_defaultEncoding_type writeBack_ENV_CTRL;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_43;
  wire                writeBack_MEMORY_STORE;
  reg        [31:0]   _zz_44;
  wire                writeBack_MEMORY_ENABLE;
  wire       [1:0]    writeBack_MEMORY_ADDRESS_LOW;
  wire       [31:0]   writeBack_MEMORY_READ_DATA;
  wire                memory_MEMORY_STORE;
  wire                memory_MEMORY_ENABLE;
  wire       [31:0]   execute_SRC_ADD;
  (* keep , syn_keep *) wire       [31:0]   execute_RS2 /* synthesis syn_keep = 1 */ ;
  wire       [31:0]   execute_INSTRUCTION;
  wire                execute_MEMORY_STORE;
  wire                execute_MEMORY_ENABLE;
  wire                execute_ALIGNEMENT_FAULT;
  reg        [31:0]   _zz_45;
  wire       [31:0]   decode_PC;
  wire       [31:0]   decode_INSTRUCTION;
  wire                decode_IS_RVC;
  wire       [31:0]   writeBack_PC;
  wire       [31:0]   writeBack_INSTRUCTION;
  reg                 decode_arbitration_haltItself;
  reg                 decode_arbitration_haltByOther;
  reg                 decode_arbitration_removeIt;
  wire                decode_arbitration_flushIt;
  wire                decode_arbitration_flushNext;
  reg                 decode_arbitration_isValid;
  wire                decode_arbitration_isStuck;
  wire                decode_arbitration_isStuckByOthers;
  wire                decode_arbitration_isFlushed;
  wire                decode_arbitration_isMoving;
  wire                decode_arbitration_isFiring;
  reg                 execute_arbitration_haltItself;
  reg                 execute_arbitration_haltByOther;
  reg                 execute_arbitration_removeIt;
  reg                 execute_arbitration_flushIt;
  reg                 execute_arbitration_flushNext;
  reg                 execute_arbitration_isValid;
  wire                execute_arbitration_isStuck;
  wire                execute_arbitration_isStuckByOthers;
  wire                execute_arbitration_isFlushed;
  wire                execute_arbitration_isMoving;
  wire                execute_arbitration_isFiring;
  reg                 memory_arbitration_haltItself;
  wire                memory_arbitration_haltByOther;
  reg                 memory_arbitration_removeIt;
  wire                memory_arbitration_flushIt;
  reg                 memory_arbitration_flushNext;
  reg                 memory_arbitration_isValid;
  wire                memory_arbitration_isStuck;
  wire                memory_arbitration_isStuckByOthers;
  wire                memory_arbitration_isFlushed;
  wire                memory_arbitration_isMoving;
  wire                memory_arbitration_isFiring;
  wire                writeBack_arbitration_haltItself;
  wire                writeBack_arbitration_haltByOther;
  reg                 writeBack_arbitration_removeIt;
  wire                writeBack_arbitration_flushIt;
  reg                 writeBack_arbitration_flushNext;
  reg                 writeBack_arbitration_isValid;
  wire                writeBack_arbitration_isStuck;
  wire                writeBack_arbitration_isStuckByOthers;
  wire                writeBack_arbitration_isFlushed;
  wire                writeBack_arbitration_isMoving;
  wire                writeBack_arbitration_isFiring;
  wire       [31:0]   lastStageInstruction /* verilator public */ ;
  wire       [31:0]   lastStagePc /* verilator public */ ;
  wire                lastStageIsValid /* verilator public */ ;
  wire                lastStageIsFiring /* verilator public */ ;
  reg                 IBusSimplePlugin_fetcherHalt;
  reg                 IBusSimplePlugin_incomingInstruction;
  wire                IBusSimplePlugin_pcValids_0;
  wire                IBusSimplePlugin_pcValids_1;
  wire                IBusSimplePlugin_pcValids_2;
  wire                IBusSimplePlugin_pcValids_3;
  reg                 CsrPlugin_inWfi /* verilator public */ ;
  reg                 CsrPlugin_thirdPartyWake;
  reg                 CsrPlugin_jumpInterface_valid;
  reg        [31:0]   CsrPlugin_jumpInterface_payload;
  wire                CsrPlugin_exceptionPendings_0;
  wire                CsrPlugin_exceptionPendings_1;
  wire                CsrPlugin_exceptionPendings_2;
  wire                CsrPlugin_exceptionPendings_3;
  wire                contextSwitching;
  reg        [1:0]    CsrPlugin_privilege;
  reg                 CsrPlugin_forceMachineWire;
  reg                 CsrPlugin_selfException_valid;
  reg        [3:0]    CsrPlugin_selfException_payload_code;
  wire       [31:0]   CsrPlugin_selfException_payload_badAddr;
  reg                 CsrPlugin_allowInterrupts;
  reg                 CsrPlugin_allowException;
  wire                BranchPlugin_jumpInterface_valid;
  wire       [31:0]   BranchPlugin_jumpInterface_payload;
  reg                 IBusSimplePlugin_injectionPort_valid;
  reg                 IBusSimplePlugin_injectionPort_ready;
  wire       [31:0]   IBusSimplePlugin_injectionPort_payload;
  wire                IBusSimplePlugin_externalFlush;
  wire                IBusSimplePlugin_jump_pcLoad_valid;
  wire       [31:0]   IBusSimplePlugin_jump_pcLoad_payload;
  wire       [1:0]    _zz_46;
  wire                IBusSimplePlugin_fetchPc_output_valid;
  wire                IBusSimplePlugin_fetchPc_output_ready;
  wire       [31:0]   IBusSimplePlugin_fetchPc_output_payload;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pcReg /* verilator public */ ;
  reg                 IBusSimplePlugin_fetchPc_correction;
  reg                 IBusSimplePlugin_fetchPc_correctionReg;
  wire                IBusSimplePlugin_fetchPc_corrected;
  reg                 IBusSimplePlugin_fetchPc_pcRegPropagate;
  reg                 IBusSimplePlugin_fetchPc_booted;
  reg                 IBusSimplePlugin_fetchPc_inc;
  reg        [31:0]   IBusSimplePlugin_fetchPc_pc;
  reg                 IBusSimplePlugin_fetchPc_flushed;
  reg                 IBusSimplePlugin_decodePc_flushed;
  reg        [31:0]   IBusSimplePlugin_decodePc_pcReg /* verilator public */ ;
  wire       [31:0]   IBusSimplePlugin_decodePc_pcPlus;
  reg                 IBusSimplePlugin_decodePc_injectedDecode;
  wire                IBusSimplePlugin_iBusRsp_redoFetch;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_0_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_0_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_0_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_1_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_1_output_payload;
  reg                 IBusSimplePlugin_iBusRsp_stages_1_halt;
  wire                IBusSimplePlugin_iBusRsp_stages_2_input_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_2_input_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_2_input_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_2_output_valid;
  wire                IBusSimplePlugin_iBusRsp_stages_2_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_stages_2_output_payload;
  wire                IBusSimplePlugin_iBusRsp_stages_2_halt;
  wire                _zz_47;
  wire                _zz_48;
  wire                _zz_49;
  wire                IBusSimplePlugin_iBusRsp_flush;
  wire                _zz_50;
  wire                _zz_51;
  reg                 _zz_52;
  wire                _zz_53;
  reg                 _zz_54;
  reg        [31:0]   _zz_55;
  reg                 IBusSimplePlugin_iBusRsp_readyForError;
  wire                IBusSimplePlugin_iBusRsp_output_valid;
  wire                IBusSimplePlugin_iBusRsp_output_ready;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_pc;
  wire                IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  wire                IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_input_valid;
  wire                IBusSimplePlugin_decompressor_input_ready;
  wire       [31:0]   IBusSimplePlugin_decompressor_input_payload_pc;
  wire                IBusSimplePlugin_decompressor_input_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_decompressor_input_payload_rsp_inst;
  wire                IBusSimplePlugin_decompressor_input_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_output_valid;
  wire                IBusSimplePlugin_decompressor_output_ready;
  wire       [31:0]   IBusSimplePlugin_decompressor_output_payload_pc;
  wire                IBusSimplePlugin_decompressor_output_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_decompressor_output_payload_rsp_inst;
  wire                IBusSimplePlugin_decompressor_output_payload_isRvc;
  wire                IBusSimplePlugin_decompressor_flushNext;
  wire                IBusSimplePlugin_decompressor_consumeCurrent;
  reg                 IBusSimplePlugin_decompressor_bufferValid;
  reg        [15:0]   IBusSimplePlugin_decompressor_bufferData;
  wire                IBusSimplePlugin_decompressor_isInputLowRvc;
  wire                IBusSimplePlugin_decompressor_isInputHighRvc;
  reg                 IBusSimplePlugin_decompressor_throw2BytesReg;
  wire                IBusSimplePlugin_decompressor_throw2Bytes;
  wire                IBusSimplePlugin_decompressor_unaligned;
  wire       [31:0]   IBusSimplePlugin_decompressor_raw;
  wire                IBusSimplePlugin_decompressor_isRvc;
  wire       [15:0]   _zz_56;
  reg        [31:0]   IBusSimplePlugin_decompressor_decompressed;
  wire       [4:0]    _zz_57;
  wire       [4:0]    _zz_58;
  wire       [11:0]   _zz_59;
  wire                _zz_60;
  reg        [11:0]   _zz_61;
  wire                _zz_62;
  reg        [9:0]    _zz_63;
  wire       [20:0]   _zz_64;
  wire                _zz_65;
  reg        [14:0]   _zz_66;
  wire                _zz_67;
  reg        [2:0]    _zz_68;
  wire                _zz_69;
  reg        [9:0]    _zz_70;
  wire       [20:0]   _zz_71;
  wire                _zz_72;
  reg        [4:0]    _zz_73;
  wire       [12:0]   _zz_74;
  wire       [4:0]    _zz_75;
  wire       [4:0]    _zz_76;
  wire       [4:0]    _zz_77;
  wire                _zz_78;
  reg        [2:0]    _zz_79;
  reg        [2:0]    _zz_80;
  wire                _zz_81;
  reg        [6:0]    _zz_82;
  wire                IBusSimplePlugin_decompressor_bufferFill;
  wire                IBusSimplePlugin_injector_decodeInput_valid;
  wire                IBusSimplePlugin_injector_decodeInput_ready;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_pc;
  wire                IBusSimplePlugin_injector_decodeInput_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  wire                IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  reg                 _zz_83;
  reg        [31:0]   _zz_84;
  reg                 _zz_85;
  reg        [31:0]   _zz_86;
  reg                 _zz_87;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_0;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_1;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_2;
  reg                 IBusSimplePlugin_injector_nextPcCalc_valids_3;
  reg        [31:0]   IBusSimplePlugin_injector_formal_rawInDecode;
  wire                IBusSimplePlugin_cmd_valid;
  wire                IBusSimplePlugin_cmd_ready;
  wire       [31:0]   IBusSimplePlugin_cmd_payload_pc;
  wire                IBusSimplePlugin_pending_inc;
  wire                IBusSimplePlugin_pending_dec;
  reg        [2:0]    IBusSimplePlugin_pending_value;
  wire       [2:0]    IBusSimplePlugin_pending_next;
  wire                IBusSimplePlugin_cmdFork_canEmit;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_valid;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_ready;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  reg        [2:0]    IBusSimplePlugin_rspJoin_rspBuffer_discardCounter;
  wire                IBusSimplePlugin_rspJoin_rspBuffer_flush;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_pc;
  reg                 IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  wire                IBusSimplePlugin_rspJoin_join_valid;
  wire                IBusSimplePlugin_rspJoin_join_ready;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_pc;
  wire                IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  wire       [31:0]   IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  wire                IBusSimplePlugin_rspJoin_join_payload_isRvc;
  wire                IBusSimplePlugin_rspJoin_exceptionDetected;
  wire                _zz_88;
  wire                _zz_89;
  reg                 execute_DBusSimplePlugin_skipCmd;
  reg        [31:0]   _zz_90;
  reg        [3:0]    _zz_91;
  wire       [3:0]    execute_DBusSimplePlugin_formalMask;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspShifted;
  wire                _zz_92;
  reg        [31:0]   _zz_93;
  wire                _zz_94;
  reg        [31:0]   _zz_95;
  reg        [31:0]   writeBack_DBusSimplePlugin_rspFormated;
  reg        [1:0]    CsrPlugin_misa_base;
  reg        [25:0]   CsrPlugin_misa_extensions;
  reg        [1:0]    CsrPlugin_mtvec_mode;
  reg        [29:0]   CsrPlugin_mtvec_base;
  reg        [31:0]   CsrPlugin_mepc;
  reg                 CsrPlugin_mstatus_MIE;
  reg                 CsrPlugin_mstatus_MPIE;
  reg        [1:0]    CsrPlugin_mstatus_MPP;
  reg                 CsrPlugin_mip_MEIP;
  reg                 CsrPlugin_mip_MTIP;
  reg                 CsrPlugin_mip_MSIP;
  reg                 CsrPlugin_mie_MEIE;
  reg                 CsrPlugin_mie_MTIE;
  reg                 CsrPlugin_mie_MSIE;
  reg        [31:0]   CsrPlugin_mscratch;
  reg                 CsrPlugin_mcause_interrupt;
  reg        [3:0]    CsrPlugin_mcause_exceptionCode;
  reg        [31:0]   CsrPlugin_mtval;
  reg        [63:0]   CsrPlugin_mcycle = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  reg        [63:0]   CsrPlugin_minstret = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire                _zz_96;
  wire                _zz_97;
  wire                _zz_98;
  wire                CsrPlugin_exceptionPortCtrl_exceptionValids_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack;
  wire                CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory;
  reg                 CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack;
  reg        [3:0]    CsrPlugin_exceptionPortCtrl_exceptionContext_code;
  reg        [31:0]   CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped;
  wire       [1:0]    CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilege;
  reg                 CsrPlugin_interrupt_valid;
  reg        [3:0]    CsrPlugin_interrupt_code /* verilator public */ ;
  reg        [1:0]    CsrPlugin_interrupt_targetPrivilege;
  wire                CsrPlugin_exception;
  reg                 CsrPlugin_lastStageWasWfi;
  reg                 CsrPlugin_pipelineLiberator_pcValids_0;
  reg                 CsrPlugin_pipelineLiberator_pcValids_1;
  reg                 CsrPlugin_pipelineLiberator_pcValids_2;
  wire                CsrPlugin_pipelineLiberator_active;
  reg                 CsrPlugin_pipelineLiberator_done;
  wire                CsrPlugin_interruptJump /* verilator public */ ;
  reg                 CsrPlugin_hadException /* verilator public */ ;
  reg        [1:0]    CsrPlugin_targetPrivilege;
  reg        [3:0]    CsrPlugin_trapCause;
  reg        [1:0]    CsrPlugin_xtvec_mode;
  reg        [29:0]   CsrPlugin_xtvec_base;
  reg                 execute_CsrPlugin_wfiWake;
  wire                execute_CsrPlugin_blockedBySideEffects;
  reg                 execute_CsrPlugin_illegalAccess;
  reg                 execute_CsrPlugin_illegalInstruction;
  wire       [31:0]   execute_CsrPlugin_readData;
  reg                 execute_CsrPlugin_writeInstruction;
  reg                 execute_CsrPlugin_readInstruction;
  wire                execute_CsrPlugin_writeEnable;
  wire                execute_CsrPlugin_readEnable;
  wire       [31:0]   execute_CsrPlugin_readToWriteData;
  reg        [31:0]   execute_CsrPlugin_writeData;
  wire       [11:0]   execute_CsrPlugin_csrAddress;
  wire       [30:0]   _zz_99;
  wire                _zz_100;
  wire                _zz_101;
  wire                _zz_102;
  wire                _zz_103;
  wire                _zz_104;
  wire                _zz_105;
  wire       `Src1CtrlEnum_defaultEncoding_type _zz_106;
  wire       `Src2CtrlEnum_defaultEncoding_type _zz_107;
  wire       `EnvCtrlEnum_defaultEncoding_type _zz_108;
  wire       `AluCtrlEnum_defaultEncoding_type _zz_109;
  wire       `AluBitwiseCtrlEnum_defaultEncoding_type _zz_110;
  wire       `ShiftCtrlEnum_defaultEncoding_type _zz_111;
  wire       `BranchCtrlEnum_defaultEncoding_type _zz_112;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress1;
  wire       [4:0]    decode_RegFilePlugin_regFileReadAddress2;
  wire       [31:0]   decode_RegFilePlugin_rs1Data;
  wire       [31:0]   decode_RegFilePlugin_rs2Data;
  reg                 lastStageRegFileWrite_valid /* verilator public */ ;
  wire       [4:0]    lastStageRegFileWrite_payload_address /* verilator public */ ;
  wire       [31:0]   lastStageRegFileWrite_payload_data /* verilator public */ ;
  reg                 _zz_113;
  reg        [31:0]   execute_IntAluPlugin_bitwise;
  reg        [31:0]   _zz_114;
  reg        [31:0]   _zz_115;
  wire                _zz_116;
  reg        [19:0]   _zz_117;
  wire                _zz_118;
  reg        [19:0]   _zz_119;
  reg        [31:0]   _zz_120;
  reg        [31:0]   execute_SrcPlugin_addSub;
  wire                execute_SrcPlugin_less;
  reg                 execute_MulPlugin_aSigned;
  reg                 execute_MulPlugin_bSigned;
  wire       [31:0]   execute_MulPlugin_a;
  wire       [31:0]   execute_MulPlugin_b;
  wire       [15:0]   execute_MulPlugin_aULow;
  wire       [15:0]   execute_MulPlugin_bULow;
  wire       [16:0]   execute_MulPlugin_aSLow;
  wire       [16:0]   execute_MulPlugin_bSLow;
  wire       [16:0]   execute_MulPlugin_aHigh;
  wire       [16:0]   execute_MulPlugin_bHigh;
  wire       [65:0]   writeBack_MulPlugin_result;
  reg        [32:0]   memory_DivPlugin_rs1;
  reg        [31:0]   memory_DivPlugin_rs2;
  reg        [64:0]   memory_DivPlugin_accumulator;
  wire                memory_DivPlugin_frontendOk;
  reg                 memory_DivPlugin_div_needRevert;
  reg                 memory_DivPlugin_div_counter_willIncrement;
  reg                 memory_DivPlugin_div_counter_willClear;
  reg        [5:0]    memory_DivPlugin_div_counter_valueNext;
  reg        [5:0]    memory_DivPlugin_div_counter_value;
  wire                memory_DivPlugin_div_counter_willOverflowIfInc;
  wire                memory_DivPlugin_div_counter_willOverflow;
  reg                 memory_DivPlugin_div_done;
  reg        [31:0]   memory_DivPlugin_div_result;
  wire       [31:0]   _zz_121;
  wire       [32:0]   memory_DivPlugin_div_stage_0_remainderShifted;
  wire       [32:0]   memory_DivPlugin_div_stage_0_remainderMinusDenominator;
  wire       [31:0]   memory_DivPlugin_div_stage_0_outRemainder;
  wire       [31:0]   memory_DivPlugin_div_stage_0_outNumerator;
  wire       [31:0]   _zz_122;
  wire                _zz_123;
  wire                _zz_124;
  reg        [32:0]   _zz_125;
  reg                 execute_LightShifterPlugin_isActive;
  wire                execute_LightShifterPlugin_isShift;
  reg        [4:0]    execute_LightShifterPlugin_amplitudeReg;
  wire       [4:0]    execute_LightShifterPlugin_amplitude;
  wire       [31:0]   execute_LightShifterPlugin_shiftInput;
  wire                execute_LightShifterPlugin_done;
  reg        [31:0]   _zz_126;
  reg                 _zz_127;
  reg                 _zz_128;
  reg                 _zz_129;
  reg        [4:0]    _zz_130;
  wire                execute_BranchPlugin_eq;
  wire       [2:0]    _zz_131;
  reg                 _zz_132;
  reg                 _zz_133;
  wire       [31:0]   execute_BranchPlugin_branch_src1;
  wire                _zz_134;
  reg        [10:0]   _zz_135;
  wire                _zz_136;
  reg        [19:0]   _zz_137;
  wire                _zz_138;
  reg        [18:0]   _zz_139;
  reg        [31:0]   _zz_140;
  wire       [31:0]   execute_BranchPlugin_branch_src2;
  wire       [31:0]   execute_BranchPlugin_branchAdder;
  reg                 DebugPlugin_firstCycle;
  reg                 DebugPlugin_secondCycle;
  reg                 DebugPlugin_resetIt;
  reg                 DebugPlugin_haltIt;
  reg                 DebugPlugin_stepIt;
  reg                 DebugPlugin_isPipBusy;
  reg                 DebugPlugin_godmode;
  reg                 DebugPlugin_haltedByBreak;
  reg        [31:0]   DebugPlugin_busReadDataReg;
  reg                 _zz_141;
  wire                DebugPlugin_allowEBreak;
  reg                 _zz_142;
  reg                 DebugPlugin_resetIt_regNext;
  reg        [31:0]   decode_to_execute_PC;
  reg        [31:0]   execute_to_memory_PC;
  reg        [31:0]   memory_to_writeBack_PC;
  reg        [31:0]   decode_to_execute_INSTRUCTION;
  reg        [31:0]   execute_to_memory_INSTRUCTION;
  reg        [31:0]   memory_to_writeBack_INSTRUCTION;
  reg        [31:0]   decode_to_execute_FORMAL_PC_NEXT;
  reg        [31:0]   execute_to_memory_FORMAL_PC_NEXT;
  reg        [31:0]   memory_to_writeBack_FORMAL_PC_NEXT;
  reg                 decode_to_execute_CSR_WRITE_OPCODE;
  reg                 decode_to_execute_CSR_READ_OPCODE;
  reg                 decode_to_execute_SRC_USE_SUB_LESS;
  reg                 decode_to_execute_MEMORY_ENABLE;
  reg                 execute_to_memory_MEMORY_ENABLE;
  reg                 memory_to_writeBack_MEMORY_ENABLE;
  reg                 decode_to_execute_REGFILE_WRITE_VALID;
  reg                 execute_to_memory_REGFILE_WRITE_VALID;
  reg                 memory_to_writeBack_REGFILE_WRITE_VALID;
  reg                 decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  reg                 decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  reg                 execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  reg                 decode_to_execute_MEMORY_STORE;
  reg                 execute_to_memory_MEMORY_STORE;
  reg                 memory_to_writeBack_MEMORY_STORE;
  reg                 decode_to_execute_IS_CSR;
  reg        `EnvCtrlEnum_defaultEncoding_type decode_to_execute_ENV_CTRL;
  reg        `EnvCtrlEnum_defaultEncoding_type execute_to_memory_ENV_CTRL;
  reg        `EnvCtrlEnum_defaultEncoding_type memory_to_writeBack_ENV_CTRL;
  reg        `AluCtrlEnum_defaultEncoding_type decode_to_execute_ALU_CTRL;
  reg                 decode_to_execute_SRC_LESS_UNSIGNED;
  reg        `AluBitwiseCtrlEnum_defaultEncoding_type decode_to_execute_ALU_BITWISE_CTRL;
  reg                 decode_to_execute_IS_MUL;
  reg                 execute_to_memory_IS_MUL;
  reg                 memory_to_writeBack_IS_MUL;
  reg                 decode_to_execute_IS_DIV;
  reg                 execute_to_memory_IS_DIV;
  reg                 decode_to_execute_IS_RS1_SIGNED;
  reg                 decode_to_execute_IS_RS2_SIGNED;
  reg        `ShiftCtrlEnum_defaultEncoding_type decode_to_execute_SHIFT_CTRL;
  reg        `BranchCtrlEnum_defaultEncoding_type decode_to_execute_BRANCH_CTRL;
  reg        [31:0]   decode_to_execute_RS1;
  reg        [31:0]   decode_to_execute_RS2;
  reg                 decode_to_execute_SRC2_FORCE_ZERO;
  reg        [31:0]   decode_to_execute_SRC1;
  reg        [31:0]   decode_to_execute_SRC2;
  reg                 decode_to_execute_DO_EBREAK;
  reg        [1:0]    execute_to_memory_MEMORY_ADDRESS_LOW;
  reg        [1:0]    memory_to_writeBack_MEMORY_ADDRESS_LOW;
  reg        [31:0]   execute_to_memory_REGFILE_WRITE_DATA;
  reg        [31:0]   memory_to_writeBack_REGFILE_WRITE_DATA;
  reg        [31:0]   execute_to_memory_MUL_LL;
  reg        [33:0]   execute_to_memory_MUL_LH;
  reg        [33:0]   execute_to_memory_MUL_HL;
  reg        [33:0]   execute_to_memory_MUL_HH;
  reg        [33:0]   memory_to_writeBack_MUL_HH;
  reg                 execute_to_memory_BRANCH_DO;
  reg        [31:0]   execute_to_memory_BRANCH_CALC;
  reg        [31:0]   memory_to_writeBack_MEMORY_READ_DATA;
  reg        [51:0]   memory_to_writeBack_MUL_LOW;
  reg        [2:0]    _zz_143;
  reg                 execute_CsrPlugin_csr_3857;
  reg                 execute_CsrPlugin_csr_3858;
  reg                 execute_CsrPlugin_csr_3859;
  reg                 execute_CsrPlugin_csr_3860;
  reg                 execute_CsrPlugin_csr_769;
  reg                 execute_CsrPlugin_csr_768;
  reg                 execute_CsrPlugin_csr_836;
  reg                 execute_CsrPlugin_csr_772;
  reg                 execute_CsrPlugin_csr_773;
  reg                 execute_CsrPlugin_csr_833;
  reg                 execute_CsrPlugin_csr_832;
  reg                 execute_CsrPlugin_csr_834;
  reg                 execute_CsrPlugin_csr_835;
  reg                 execute_CsrPlugin_csr_2816;
  reg                 execute_CsrPlugin_csr_2944;
  reg                 execute_CsrPlugin_csr_2818;
  reg                 execute_CsrPlugin_csr_2946;
  reg                 execute_CsrPlugin_csr_3072;
  reg                 execute_CsrPlugin_csr_3200;
  reg        [31:0]   _zz_144;
  reg        [31:0]   _zz_145;
  reg        [31:0]   _zz_146;
  reg        [31:0]   _zz_147;
  reg        [31:0]   _zz_148;
  reg        [31:0]   _zz_149;
  reg        [31:0]   _zz_150;
  reg        [31:0]   _zz_151;
  reg        [31:0]   _zz_152;
  reg        [31:0]   _zz_153;
  reg        [31:0]   _zz_154;
  reg        [31:0]   _zz_155;
  reg        [31:0]   _zz_156;
  reg        [31:0]   _zz_157;
  reg        [31:0]   _zz_158;
  reg        [31:0]   _zz_159;
  reg        [31:0]   _zz_160;
  reg        [31:0]   _zz_161;
  `ifndef SYNTHESIS
  reg [31:0] decode_BRANCH_CTRL_string;
  reg [31:0] _zz_1_string;
  reg [31:0] _zz_2_string;
  reg [31:0] _zz_3_string;
  reg [71:0] decode_SHIFT_CTRL_string;
  reg [71:0] _zz_4_string;
  reg [71:0] _zz_5_string;
  reg [71:0] _zz_6_string;
  reg [39:0] decode_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_7_string;
  reg [39:0] _zz_8_string;
  reg [39:0] _zz_9_string;
  reg [63:0] decode_ALU_CTRL_string;
  reg [63:0] _zz_10_string;
  reg [63:0] _zz_11_string;
  reg [63:0] _zz_12_string;
  reg [39:0] _zz_13_string;
  reg [39:0] _zz_14_string;
  reg [39:0] _zz_15_string;
  reg [39:0] _zz_16_string;
  reg [39:0] decode_ENV_CTRL_string;
  reg [39:0] _zz_17_string;
  reg [39:0] _zz_18_string;
  reg [39:0] _zz_19_string;
  reg [31:0] execute_BRANCH_CTRL_string;
  reg [31:0] _zz_20_string;
  reg [71:0] execute_SHIFT_CTRL_string;
  reg [71:0] _zz_21_string;
  reg [23:0] decode_SRC2_CTRL_string;
  reg [23:0] _zz_25_string;
  reg [95:0] decode_SRC1_CTRL_string;
  reg [95:0] _zz_27_string;
  reg [63:0] execute_ALU_CTRL_string;
  reg [63:0] _zz_28_string;
  reg [39:0] execute_ALU_BITWISE_CTRL_string;
  reg [39:0] _zz_29_string;
  reg [31:0] _zz_33_string;
  reg [71:0] _zz_34_string;
  reg [39:0] _zz_35_string;
  reg [63:0] _zz_36_string;
  reg [39:0] _zz_37_string;
  reg [23:0] _zz_38_string;
  reg [95:0] _zz_39_string;
  reg [39:0] memory_ENV_CTRL_string;
  reg [39:0] _zz_41_string;
  reg [39:0] execute_ENV_CTRL_string;
  reg [39:0] _zz_42_string;
  reg [39:0] writeBack_ENV_CTRL_string;
  reg [39:0] _zz_43_string;
  reg [95:0] _zz_106_string;
  reg [23:0] _zz_107_string;
  reg [39:0] _zz_108_string;
  reg [63:0] _zz_109_string;
  reg [39:0] _zz_110_string;
  reg [71:0] _zz_111_string;
  reg [31:0] _zz_112_string;
  reg [39:0] decode_to_execute_ENV_CTRL_string;
  reg [39:0] execute_to_memory_ENV_CTRL_string;
  reg [39:0] memory_to_writeBack_ENV_CTRL_string;
  reg [63:0] decode_to_execute_ALU_CTRL_string;
  reg [39:0] decode_to_execute_ALU_BITWISE_CTRL_string;
  reg [71:0] decode_to_execute_SHIFT_CTRL_string;
  reg [31:0] decode_to_execute_BRANCH_CTRL_string;
  `endif

  reg [31:0] RegFilePlugin_regFile [0:31] /* verilator public */ ;

  assign _zz_166 = (memory_arbitration_isValid && memory_IS_DIV);
  assign _zz_167 = (execute_arbitration_isValid && execute_IS_CSR);
  assign _zz_168 = ((execute_arbitration_isValid && execute_LightShifterPlugin_isShift) && (execute_SRC2[4 : 0] != 5'h0));
  assign _zz_169 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
  assign _zz_170 = (execute_arbitration_isValid && execute_DO_EBREAK);
  assign _zz_171 = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) == 1'b0);
  assign _zz_172 = (CsrPlugin_hadException || CsrPlugin_interruptJump);
  assign _zz_173 = (writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET));
  assign _zz_174 = (DebugPlugin_stepIt && IBusSimplePlugin_incomingInstruction);
  assign _zz_175 = writeBack_INSTRUCTION[29 : 28];
  assign _zz_176 = (IBusSimplePlugin_jump_pcLoad_valid && ((! decode_arbitration_isStuck) || decode_arbitration_removeIt));
  assign _zz_177 = (CsrPlugin_privilege < execute_CsrPlugin_csrAddress[9 : 8]);
  assign _zz_178 = (execute_CsrPlugin_illegalAccess || execute_CsrPlugin_illegalInstruction);
  assign _zz_179 = (execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_ECALL));
  assign _zz_180 = execute_INSTRUCTION[13 : 12];
  assign _zz_181 = (memory_DivPlugin_frontendOk && (! memory_DivPlugin_div_done));
  assign _zz_182 = (! memory_arbitration_isStuck);
  assign _zz_183 = (writeBack_arbitration_isValid && writeBack_REGFILE_WRITE_VALID);
  assign _zz_184 = (1'b1 || (! 1'b1));
  assign _zz_185 = (memory_arbitration_isValid && memory_REGFILE_WRITE_VALID);
  assign _zz_186 = (1'b1 || (! memory_BYPASSABLE_MEMORY_STAGE));
  assign _zz_187 = (execute_arbitration_isValid && execute_REGFILE_WRITE_VALID);
  assign _zz_188 = (1'b1 || (! execute_BYPASSABLE_EXECUTE_STAGE));
  assign _zz_189 = debug_bus_cmd_payload_address[7 : 2];
  assign _zz_190 = (IBusSimplePlugin_decompressor_output_ready && IBusSimplePlugin_decompressor_input_valid);
  assign _zz_191 = (CsrPlugin_mstatus_MIE || (CsrPlugin_privilege < 2'b11));
  assign _zz_192 = ((_zz_96 && 1'b1) && (! 1'b0));
  assign _zz_193 = ((_zz_97 && 1'b1) && (! 1'b0));
  assign _zz_194 = ((_zz_98 && 1'b1) && (! 1'b0));
  assign _zz_195 = (! execute_arbitration_isStuckByOthers);
  assign _zz_196 = {_zz_56[1 : 0],_zz_56[15 : 13]};
  assign _zz_197 = _zz_56[6 : 5];
  assign _zz_198 = _zz_56[11 : 10];
  assign _zz_199 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_200 = execute_INSTRUCTION[13];
  assign _zz_201 = writeBack_INSTRUCTION[13 : 12];
  assign _zz_202 = ($signed(_zz_203) + $signed(_zz_208));
  assign _zz_203 = ($signed(_zz_204) + $signed(_zz_206));
  assign _zz_204 = 52'h0;
  assign _zz_205 = {1'b0,memory_MUL_LL};
  assign _zz_206 = {{19{_zz_205[32]}}, _zz_205};
  assign _zz_207 = ({16'd0,memory_MUL_LH} <<< 16);
  assign _zz_208 = {{2{_zz_207[49]}}, _zz_207};
  assign _zz_209 = ({16'd0,memory_MUL_HL} <<< 16);
  assign _zz_210 = {{2{_zz_209[49]}}, _zz_209};
  assign _zz_211 = _zz_99[25 : 25];
  assign _zz_212 = _zz_99[24 : 24];
  assign _zz_213 = _zz_99[23 : 23];
  assign _zz_214 = _zz_99[22 : 22];
  assign _zz_215 = _zz_99[18 : 18];
  assign _zz_216 = _zz_99[12 : 12];
  assign _zz_217 = _zz_99[10 : 10];
  assign _zz_218 = _zz_99[9 : 9];
  assign _zz_219 = _zz_99[8 : 8];
  assign _zz_220 = _zz_99[3 : 3];
  assign _zz_221 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_222 = {29'd0, _zz_221};
  assign _zz_223 = _zz_99[30 : 30];
  assign _zz_224 = _zz_99[11 : 11];
  assign _zz_225 = _zz_99[4 : 4];
  assign _zz_226 = _zz_99[2 : 2];
  assign _zz_227 = _zz_99[21 : 21];
  assign _zz_228 = _zz_99[7 : 7];
  assign _zz_229 = (_zz_46 & (~ _zz_230));
  assign _zz_230 = (_zz_46 - 2'b01);
  assign _zz_231 = {IBusSimplePlugin_fetchPc_inc,2'b00};
  assign _zz_232 = {29'd0, _zz_231};
  assign _zz_233 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_234 = {29'd0, _zz_233};
  assign _zz_235 = {{_zz_66,_zz_56[6 : 2]},12'h0};
  assign _zz_236 = {{{4'b0000,_zz_56[8 : 7]},_zz_56[12 : 9]},2'b00};
  assign _zz_237 = {{{4'b0000,_zz_56[8 : 7]},_zz_56[12 : 9]},2'b00};
  assign _zz_238 = (IBusSimplePlugin_pending_value + _zz_240);
  assign _zz_239 = IBusSimplePlugin_pending_inc;
  assign _zz_240 = {2'd0, _zz_239};
  assign _zz_241 = IBusSimplePlugin_pending_dec;
  assign _zz_242 = {2'd0, _zz_241};
  assign _zz_243 = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000));
  assign _zz_244 = {2'd0, _zz_243};
  assign _zz_245 = execute_SRC_LESS;
  assign _zz_246 = (decode_IS_RVC ? 3'b010 : 3'b100);
  assign _zz_247 = decode_INSTRUCTION[19 : 15];
  assign _zz_248 = decode_INSTRUCTION[31 : 20];
  assign _zz_249 = {decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]};
  assign _zz_250 = ($signed(_zz_251) + $signed(_zz_254));
  assign _zz_251 = ($signed(_zz_252) + $signed(_zz_253));
  assign _zz_252 = execute_SRC1;
  assign _zz_253 = (execute_SRC_USE_SUB_LESS ? (~ execute_SRC2) : execute_SRC2);
  assign _zz_254 = (execute_SRC_USE_SUB_LESS ? _zz_255 : _zz_256);
  assign _zz_255 = 32'h00000001;
  assign _zz_256 = 32'h0;
  assign _zz_257 = {{14{writeBack_MUL_LOW[51]}}, writeBack_MUL_LOW};
  assign _zz_258 = ({32'd0,writeBack_MUL_HH} <<< 32);
  assign _zz_259 = writeBack_MUL_LOW[31 : 0];
  assign _zz_260 = writeBack_MulPlugin_result[63 : 32];
  assign _zz_261 = memory_DivPlugin_div_counter_willIncrement;
  assign _zz_262 = {5'd0, _zz_261};
  assign _zz_263 = {1'd0, memory_DivPlugin_rs2};
  assign _zz_264 = memory_DivPlugin_div_stage_0_remainderMinusDenominator[31:0];
  assign _zz_265 = memory_DivPlugin_div_stage_0_remainderShifted[31:0];
  assign _zz_266 = {_zz_121,(! memory_DivPlugin_div_stage_0_remainderMinusDenominator[32])};
  assign _zz_267 = _zz_268;
  assign _zz_268 = _zz_269;
  assign _zz_269 = ({1'b0,(memory_DivPlugin_div_needRevert ? (~ _zz_122) : _zz_122)} + _zz_271);
  assign _zz_270 = memory_DivPlugin_div_needRevert;
  assign _zz_271 = {32'd0, _zz_270};
  assign _zz_272 = _zz_124;
  assign _zz_273 = {32'd0, _zz_272};
  assign _zz_274 = _zz_123;
  assign _zz_275 = {31'd0, _zz_274};
  assign _zz_276 = (_zz_277 >>> 1);
  assign _zz_277 = {((execute_SHIFT_CTRL == `ShiftCtrlEnum_defaultEncoding_SRA_1) && execute_LightShifterPlugin_shiftInput[31]),execute_LightShifterPlugin_shiftInput};
  assign _zz_278 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]};
  assign _zz_279 = execute_INSTRUCTION[31 : 20];
  assign _zz_280 = {{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]};
  assign _zz_281 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_282 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_283 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_284 = execute_CsrPlugin_writeData[11 : 11];
  assign _zz_285 = execute_CsrPlugin_writeData[7 : 7];
  assign _zz_286 = execute_CsrPlugin_writeData[3 : 3];
  assign _zz_287 = execute_CsrPlugin_writeData[31 : 31];
  assign _zz_288 = 1'b1;
  assign _zz_289 = 1'b1;
  assign _zz_290 = (_zz_56[11 : 10] == 2'b01);
  assign _zz_291 = ((_zz_56[11 : 10] == 2'b11) && (_zz_56[6 : 5] == 2'b00));
  assign _zz_292 = 7'h0;
  assign _zz_293 = _zz_56[6 : 2];
  assign _zz_294 = _zz_56[12];
  assign _zz_295 = _zz_56[11 : 7];
  assign _zz_296 = 32'h10103050;
  assign _zz_297 = ((decode_INSTRUCTION & 32'h0000001c) == 32'h00000004);
  assign _zz_298 = ((decode_INSTRUCTION & 32'h00000058) == 32'h00000040);
  assign _zz_299 = {(_zz_304 == _zz_305),(_zz_306 == _zz_307)};
  assign _zz_300 = 2'b00;
  assign _zz_301 = ({_zz_308,{_zz_309,_zz_310}} != 3'b000);
  assign _zz_302 = (_zz_105 != 1'b0);
  assign _zz_303 = {(_zz_311 != _zz_312),{_zz_313,{_zz_314,_zz_315}}};
  assign _zz_304 = (decode_INSTRUCTION & 32'h00007034);
  assign _zz_305 = 32'h00005010;
  assign _zz_306 = (decode_INSTRUCTION & 32'h02007064);
  assign _zz_307 = 32'h00005020;
  assign _zz_308 = ((decode_INSTRUCTION & 32'h40003054) == 32'h40001010);
  assign _zz_309 = ((decode_INSTRUCTION & _zz_316) == 32'h00001010);
  assign _zz_310 = ((decode_INSTRUCTION & _zz_317) == 32'h00001010);
  assign _zz_311 = _zz_105;
  assign _zz_312 = 1'b0;
  assign _zz_313 = ((_zz_318 == _zz_319) != 1'b0);
  assign _zz_314 = (_zz_320 != 1'b0);
  assign _zz_315 = {(_zz_321 != _zz_322),{_zz_323,{_zz_324,_zz_325}}};
  assign _zz_316 = 32'h00007034;
  assign _zz_317 = 32'h02007054;
  assign _zz_318 = (decode_INSTRUCTION & 32'h02004064);
  assign _zz_319 = 32'h02004020;
  assign _zz_320 = ((decode_INSTRUCTION & 32'h02004074) == 32'h02000030);
  assign _zz_321 = {(_zz_326 == _zz_327),{_zz_328,_zz_329}};
  assign _zz_322 = 3'b000;
  assign _zz_323 = ((_zz_330 == _zz_331) != 1'b0);
  assign _zz_324 = (_zz_332 != 1'b0);
  assign _zz_325 = {(_zz_333 != _zz_334),{_zz_335,{_zz_336,_zz_337}}};
  assign _zz_326 = (decode_INSTRUCTION & 32'h00000064);
  assign _zz_327 = 32'h00000024;
  assign _zz_328 = ((decode_INSTRUCTION & 32'h00003034) == 32'h00001010);
  assign _zz_329 = ((decode_INSTRUCTION & 32'h02003054) == 32'h00001010);
  assign _zz_330 = (decode_INSTRUCTION & 32'h00001000);
  assign _zz_331 = 32'h00001000;
  assign _zz_332 = ((decode_INSTRUCTION & 32'h00003000) == 32'h00002000);
  assign _zz_333 = {(_zz_338 == _zz_339),(_zz_340 == _zz_341)};
  assign _zz_334 = 2'b00;
  assign _zz_335 = ({_zz_342,_zz_343} != 2'b00);
  assign _zz_336 = (_zz_101 != 1'b0);
  assign _zz_337 = {(_zz_344 != _zz_345),{_zz_346,{_zz_347,_zz_348}}};
  assign _zz_338 = (decode_INSTRUCTION & 32'h00002010);
  assign _zz_339 = 32'h00002000;
  assign _zz_340 = (decode_INSTRUCTION & 32'h00005000);
  assign _zz_341 = 32'h00001000;
  assign _zz_342 = ((decode_INSTRUCTION & 32'h00006004) == 32'h00006000);
  assign _zz_343 = ((decode_INSTRUCTION & 32'h00005004) == 32'h00004000);
  assign _zz_344 = {(_zz_349 == _zz_350),(_zz_351 == _zz_352)};
  assign _zz_345 = 2'b00;
  assign _zz_346 = ((_zz_353 == _zz_354) != 1'b0);
  assign _zz_347 = ({_zz_355,_zz_356} != 4'b0000);
  assign _zz_348 = {(_zz_357 != _zz_358),{_zz_359,{_zz_360,_zz_361}}};
  assign _zz_349 = (decode_INSTRUCTION & 32'h10203050);
  assign _zz_350 = 32'h10000050;
  assign _zz_351 = (decode_INSTRUCTION & 32'h10103050);
  assign _zz_352 = 32'h00000050;
  assign _zz_353 = (decode_INSTRUCTION & 32'h00103050);
  assign _zz_354 = 32'h00000050;
  assign _zz_355 = ((decode_INSTRUCTION & _zz_362) == 32'h00002040);
  assign _zz_356 = {(_zz_363 == _zz_364),{_zz_365,_zz_366}};
  assign _zz_357 = {(_zz_367 == _zz_368),(_zz_369 == _zz_370)};
  assign _zz_358 = 2'b00;
  assign _zz_359 = ({_zz_371,_zz_372} != 2'b00);
  assign _zz_360 = (_zz_373 != 1'b0);
  assign _zz_361 = {(_zz_374 != _zz_375),{_zz_376,{_zz_377,_zz_378}}};
  assign _zz_362 = 32'h00002040;
  assign _zz_363 = (decode_INSTRUCTION & 32'h00001040);
  assign _zz_364 = 32'h00001040;
  assign _zz_365 = ((decode_INSTRUCTION & _zz_379) == 32'h00000040);
  assign _zz_366 = ((decode_INSTRUCTION & _zz_380) == 32'h00000040);
  assign _zz_367 = (decode_INSTRUCTION & 32'h00001050);
  assign _zz_368 = 32'h00001050;
  assign _zz_369 = (decode_INSTRUCTION & 32'h00002050);
  assign _zz_370 = 32'h00002050;
  assign _zz_371 = ((decode_INSTRUCTION & _zz_381) == 32'h00000020);
  assign _zz_372 = ((decode_INSTRUCTION & _zz_382) == 32'h00000020);
  assign _zz_373 = ((decode_INSTRUCTION & _zz_383) == 32'h00000020);
  assign _zz_374 = {_zz_384,{_zz_385,_zz_386}};
  assign _zz_375 = 5'h0;
  assign _zz_376 = ({_zz_387,_zz_388} != 3'b000);
  assign _zz_377 = (_zz_389 != _zz_390);
  assign _zz_378 = {_zz_391,{_zz_392,_zz_393}};
  assign _zz_379 = 32'h00100040;
  assign _zz_380 = 32'h00000050;
  assign _zz_381 = 32'h00000034;
  assign _zz_382 = 32'h00000064;
  assign _zz_383 = 32'h00000020;
  assign _zz_384 = ((decode_INSTRUCTION & 32'h00000040) == 32'h00000040);
  assign _zz_385 = _zz_102;
  assign _zz_386 = {(_zz_394 == _zz_395),{_zz_104,_zz_396}};
  assign _zz_387 = _zz_102;
  assign _zz_388 = {_zz_104,(_zz_397 == _zz_398)};
  assign _zz_389 = {_zz_103,{_zz_399,{_zz_400,_zz_401}}};
  assign _zz_390 = 6'h0;
  assign _zz_391 = ({_zz_102,_zz_402} != 2'b00);
  assign _zz_392 = ({_zz_403,_zz_404} != 2'b00);
  assign _zz_393 = {(_zz_405 != _zz_406),{_zz_407,{_zz_408,_zz_409}}};
  assign _zz_394 = (decode_INSTRUCTION & 32'h00004020);
  assign _zz_395 = 32'h00004020;
  assign _zz_396 = ((decode_INSTRUCTION & _zz_410) == 32'h00000020);
  assign _zz_397 = (decode_INSTRUCTION & 32'h02000060);
  assign _zz_398 = 32'h00000020;
  assign _zz_399 = ((decode_INSTRUCTION & _zz_411) == 32'h00001010);
  assign _zz_400 = (_zz_412 == _zz_413);
  assign _zz_401 = {_zz_414,{_zz_415,_zz_416}};
  assign _zz_402 = ((decode_INSTRUCTION & _zz_417) == 32'h00000020);
  assign _zz_403 = _zz_102;
  assign _zz_404 = (_zz_418 == _zz_419);
  assign _zz_405 = {_zz_420,{_zz_421,_zz_422}};
  assign _zz_406 = 4'b0000;
  assign _zz_407 = (_zz_423 != 1'b0);
  assign _zz_408 = (_zz_424 != _zz_425);
  assign _zz_409 = {_zz_426,_zz_427};
  assign _zz_410 = 32'h02000020;
  assign _zz_411 = 32'h00001010;
  assign _zz_412 = (decode_INSTRUCTION & 32'h00002010);
  assign _zz_413 = 32'h00002010;
  assign _zz_414 = ((decode_INSTRUCTION & _zz_428) == 32'h00000010);
  assign _zz_415 = (_zz_429 == _zz_430);
  assign _zz_416 = (_zz_431 == _zz_432);
  assign _zz_417 = 32'h00000070;
  assign _zz_418 = (decode_INSTRUCTION & 32'h00000020);
  assign _zz_419 = 32'h0;
  assign _zz_420 = ((decode_INSTRUCTION & _zz_433) == 32'h0);
  assign _zz_421 = (_zz_434 == _zz_435);
  assign _zz_422 = {_zz_101,_zz_436};
  assign _zz_423 = ((decode_INSTRUCTION & _zz_437) == 32'h0);
  assign _zz_424 = {_zz_438,{_zz_439,_zz_440}};
  assign _zz_425 = 3'b000;
  assign _zz_426 = ({_zz_441,_zz_442} != 2'b00);
  assign _zz_427 = ({_zz_443,_zz_444} != 2'b00);
  assign _zz_428 = 32'h00000050;
  assign _zz_429 = (decode_INSTRUCTION & 32'h0000000c);
  assign _zz_430 = 32'h00000004;
  assign _zz_431 = (decode_INSTRUCTION & 32'h00000028);
  assign _zz_432 = 32'h0;
  assign _zz_433 = 32'h00000044;
  assign _zz_434 = (decode_INSTRUCTION & 32'h00000018);
  assign _zz_435 = 32'h0;
  assign _zz_436 = ((decode_INSTRUCTION & 32'h00005004) == 32'h00001000);
  assign _zz_437 = 32'h00000058;
  assign _zz_438 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000040);
  assign _zz_439 = ((decode_INSTRUCTION & 32'h00002014) == 32'h00002010);
  assign _zz_440 = ((decode_INSTRUCTION & 32'h40004034) == 32'h40000030);
  assign _zz_441 = ((decode_INSTRUCTION & 32'h00000014) == 32'h00000004);
  assign _zz_442 = _zz_100;
  assign _zz_443 = ((decode_INSTRUCTION & 32'h00000044) == 32'h00000004);
  assign _zz_444 = _zz_100;
  assign _zz_445 = 32'h0;
  always @ (posedge io_mainClk) begin
    if(_zz_288) begin
      _zz_164 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress1];
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_289) begin
      _zz_165 <= RegFilePlugin_regFile[decode_RegFilePlugin_regFileReadAddress2];
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_32) begin
      RegFilePlugin_regFile[lastStageRegFileWrite_payload_address] <= lastStageRegFileWrite_payload_data;
    end
  end

  StreamFifoLowLatency IBusSimplePlugin_rspJoin_rspBuffer_c (
    .io_push_valid            (iBus_rsp_valid                                                  ), //i
    .io_push_ready            (IBusSimplePlugin_rspJoin_rspBuffer_c_io_push_ready              ), //o
    .io_push_payload_error    (iBus_rsp_payload_error                                          ), //i
    .io_push_payload_inst     (iBus_rsp_payload_inst[31:0]                                     ), //i
    .io_pop_valid             (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid               ), //o
    .io_pop_ready             (_zz_162                                                         ), //i
    .io_pop_payload_error     (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error       ), //o
    .io_pop_payload_inst      (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst[31:0]  ), //o
    .io_flush                 (_zz_163                                                         ), //i
    .io_occupancy             (IBusSimplePlugin_rspJoin_rspBuffer_c_io_occupancy               ), //o
    .io_mainClk               (io_mainClk                                                      ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset                                           )  //i
  );
  `ifndef SYNTHESIS
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
    case(_zz_1)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_1_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_1_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_1_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_1_string = "JALR";
      default : _zz_1_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_2)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_2_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_2_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_2_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_2_string = "JALR";
      default : _zz_2_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_3)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_3_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_3_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_3_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_3_string = "JALR";
      default : _zz_3_string = "????";
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
    case(_zz_4)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_4_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_4_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_4_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_4_string = "SRA_1    ";
      default : _zz_4_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_5)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_5_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_5_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_5_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_5_string = "SRA_1    ";
      default : _zz_5_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_6)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_6_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_6_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_6_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_6_string = "SRA_1    ";
      default : _zz_6_string = "?????????";
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
    case(_zz_7)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_7_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_7_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_7_string = "AND_1";
      default : _zz_7_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_8)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_8_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_8_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_8_string = "AND_1";
      default : _zz_8_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_9)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_9_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_9_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_9_string = "AND_1";
      default : _zz_9_string = "?????";
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
    case(_zz_10)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_10_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_10_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_10_string = "BITWISE ";
      default : _zz_10_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_11)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_11_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_11_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_11_string = "BITWISE ";
      default : _zz_11_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_12)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_12_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_12_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_12_string = "BITWISE ";
      default : _zz_12_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_13)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_13_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_13_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_13_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_13_string = "ECALL";
      default : _zz_13_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_14)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_14_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_14_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_14_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_14_string = "ECALL";
      default : _zz_14_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_15)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_15_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_15_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_15_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_15_string = "ECALL";
      default : _zz_15_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_16)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_16_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_16_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_16_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_16_string = "ECALL";
      default : _zz_16_string = "?????";
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
    case(_zz_17)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_17_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_17_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_17_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_17_string = "ECALL";
      default : _zz_17_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_18)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_18_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_18_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_18_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_18_string = "ECALL";
      default : _zz_18_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_19)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_19_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_19_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_19_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_19_string = "ECALL";
      default : _zz_19_string = "?????";
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
    case(_zz_20)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_20_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_20_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_20_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_20_string = "JALR";
      default : _zz_20_string = "????";
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
    case(_zz_21)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_21_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_21_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_21_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_21_string = "SRA_1    ";
      default : _zz_21_string = "?????????";
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
    case(_zz_25)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_25_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_25_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_25_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_25_string = "PC ";
      default : _zz_25_string = "???";
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
    case(_zz_27)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_27_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_27_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_27_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_27_string = "URS1        ";
      default : _zz_27_string = "????????????";
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
    case(_zz_28)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_28_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_28_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_28_string = "BITWISE ";
      default : _zz_28_string = "????????";
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
    case(_zz_29)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_29_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_29_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_29_string = "AND_1";
      default : _zz_29_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_33)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_33_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_33_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_33_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_33_string = "JALR";
      default : _zz_33_string = "????";
    endcase
  end
  always @(*) begin
    case(_zz_34)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_34_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_34_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_34_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_34_string = "SRA_1    ";
      default : _zz_34_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_35)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_35_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_35_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_35_string = "AND_1";
      default : _zz_35_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_36)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_36_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_36_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_36_string = "BITWISE ";
      default : _zz_36_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_37)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_37_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_37_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_37_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_37_string = "ECALL";
      default : _zz_37_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_38)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_38_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_38_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_38_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_38_string = "PC ";
      default : _zz_38_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_39)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_39_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_39_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_39_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_39_string = "URS1        ";
      default : _zz_39_string = "????????????";
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
    case(_zz_41)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_41_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_41_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_41_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_41_string = "ECALL";
      default : _zz_41_string = "?????";
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
    case(_zz_42)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_42_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_42_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_42_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_42_string = "ECALL";
      default : _zz_42_string = "?????";
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
    case(_zz_43)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_43_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_43_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_43_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_43_string = "ECALL";
      default : _zz_43_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_106)
      `Src1CtrlEnum_defaultEncoding_RS : _zz_106_string = "RS          ";
      `Src1CtrlEnum_defaultEncoding_IMU : _zz_106_string = "IMU         ";
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : _zz_106_string = "PC_INCREMENT";
      `Src1CtrlEnum_defaultEncoding_URS1 : _zz_106_string = "URS1        ";
      default : _zz_106_string = "????????????";
    endcase
  end
  always @(*) begin
    case(_zz_107)
      `Src2CtrlEnum_defaultEncoding_RS : _zz_107_string = "RS ";
      `Src2CtrlEnum_defaultEncoding_IMI : _zz_107_string = "IMI";
      `Src2CtrlEnum_defaultEncoding_IMS : _zz_107_string = "IMS";
      `Src2CtrlEnum_defaultEncoding_PC : _zz_107_string = "PC ";
      default : _zz_107_string = "???";
    endcase
  end
  always @(*) begin
    case(_zz_108)
      `EnvCtrlEnum_defaultEncoding_NONE : _zz_108_string = "NONE ";
      `EnvCtrlEnum_defaultEncoding_XRET : _zz_108_string = "XRET ";
      `EnvCtrlEnum_defaultEncoding_WFI : _zz_108_string = "WFI  ";
      `EnvCtrlEnum_defaultEncoding_ECALL : _zz_108_string = "ECALL";
      default : _zz_108_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_109)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : _zz_109_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : _zz_109_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : _zz_109_string = "BITWISE ";
      default : _zz_109_string = "????????";
    endcase
  end
  always @(*) begin
    case(_zz_110)
      `AluBitwiseCtrlEnum_defaultEncoding_XOR_1 : _zz_110_string = "XOR_1";
      `AluBitwiseCtrlEnum_defaultEncoding_OR_1 : _zz_110_string = "OR_1 ";
      `AluBitwiseCtrlEnum_defaultEncoding_AND_1 : _zz_110_string = "AND_1";
      default : _zz_110_string = "?????";
    endcase
  end
  always @(*) begin
    case(_zz_111)
      `ShiftCtrlEnum_defaultEncoding_DISABLE_1 : _zz_111_string = "DISABLE_1";
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : _zz_111_string = "SLL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRL_1 : _zz_111_string = "SRL_1    ";
      `ShiftCtrlEnum_defaultEncoding_SRA_1 : _zz_111_string = "SRA_1    ";
      default : _zz_111_string = "?????????";
    endcase
  end
  always @(*) begin
    case(_zz_112)
      `BranchCtrlEnum_defaultEncoding_INC : _zz_112_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : _zz_112_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : _zz_112_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : _zz_112_string = "JALR";
      default : _zz_112_string = "????";
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
  always @(*) begin
    case(decode_to_execute_ALU_CTRL)
      `AluCtrlEnum_defaultEncoding_ADD_SUB : decode_to_execute_ALU_CTRL_string = "ADD_SUB ";
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : decode_to_execute_ALU_CTRL_string = "SLT_SLTU";
      `AluCtrlEnum_defaultEncoding_BITWISE : decode_to_execute_ALU_CTRL_string = "BITWISE ";
      default : decode_to_execute_ALU_CTRL_string = "????????";
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
    case(decode_to_execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : decode_to_execute_BRANCH_CTRL_string = "INC ";
      `BranchCtrlEnum_defaultEncoding_B : decode_to_execute_BRANCH_CTRL_string = "B   ";
      `BranchCtrlEnum_defaultEncoding_JAL : decode_to_execute_BRANCH_CTRL_string = "JAL ";
      `BranchCtrlEnum_defaultEncoding_JALR : decode_to_execute_BRANCH_CTRL_string = "JALR";
      default : decode_to_execute_BRANCH_CTRL_string = "????";
    endcase
  end
  `endif

  assign memory_MUL_LOW = ($signed(_zz_202) + $signed(_zz_210));
  assign memory_MEMORY_READ_DATA = dBus_rsp_data;
  assign execute_BRANCH_CALC = {execute_BranchPlugin_branchAdder[31 : 1],1'b0};
  assign execute_BRANCH_DO = _zz_133;
  assign memory_MUL_HH = execute_to_memory_MUL_HH;
  assign execute_MUL_HH = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bHigh));
  assign execute_MUL_HL = ($signed(execute_MulPlugin_aHigh) * $signed(execute_MulPlugin_bSLow));
  assign execute_MUL_LH = ($signed(execute_MulPlugin_aSLow) * $signed(execute_MulPlugin_bHigh));
  assign execute_MUL_LL = (execute_MulPlugin_aULow * execute_MulPlugin_bULow);
  assign writeBack_REGFILE_WRITE_DATA = memory_to_writeBack_REGFILE_WRITE_DATA;
  assign execute_REGFILE_WRITE_DATA = _zz_114;
  assign memory_MEMORY_ADDRESS_LOW = execute_to_memory_MEMORY_ADDRESS_LOW;
  assign execute_MEMORY_ADDRESS_LOW = dBus_cmd_payload_address[1 : 0];
  assign decode_DO_EBREAK = (((! DebugPlugin_haltIt) && (decode_IS_EBREAK || 1'b0)) && DebugPlugin_allowEBreak);
  assign decode_SRC2 = _zz_120;
  assign decode_SRC1 = _zz_115;
  assign decode_SRC2_FORCE_ZERO = (decode_SRC_ADD_ZERO && (! decode_SRC_USE_SUB_LESS));
  assign decode_RS2 = decode_RegFilePlugin_rs2Data;
  assign decode_RS1 = decode_RegFilePlugin_rs1Data;
  assign decode_BRANCH_CTRL = _zz_1;
  assign _zz_2 = _zz_3;
  assign decode_SHIFT_CTRL = _zz_4;
  assign _zz_5 = _zz_6;
  assign decode_IS_RS2_SIGNED = _zz_211[0];
  assign decode_IS_RS1_SIGNED = _zz_212[0];
  assign decode_IS_DIV = _zz_213[0];
  assign memory_IS_MUL = execute_to_memory_IS_MUL;
  assign execute_IS_MUL = decode_to_execute_IS_MUL;
  assign decode_IS_MUL = _zz_214[0];
  assign decode_ALU_BITWISE_CTRL = _zz_7;
  assign _zz_8 = _zz_9;
  assign decode_SRC_LESS_UNSIGNED = _zz_215[0];
  assign decode_ALU_CTRL = _zz_10;
  assign _zz_11 = _zz_12;
  assign _zz_13 = _zz_14;
  assign _zz_15 = _zz_16;
  assign decode_ENV_CTRL = _zz_17;
  assign _zz_18 = _zz_19;
  assign decode_IS_CSR = _zz_216[0];
  assign decode_MEMORY_STORE = _zz_217[0];
  assign execute_BYPASSABLE_MEMORY_STAGE = decode_to_execute_BYPASSABLE_MEMORY_STAGE;
  assign decode_BYPASSABLE_MEMORY_STAGE = _zz_218[0];
  assign decode_BYPASSABLE_EXECUTE_STAGE = _zz_219[0];
  assign decode_MEMORY_ENABLE = _zz_220[0];
  assign decode_CSR_READ_OPCODE = (decode_INSTRUCTION[13 : 7] != 7'h20);
  assign decode_CSR_WRITE_OPCODE = (! (((decode_INSTRUCTION[14 : 13] == 2'b01) && (decode_INSTRUCTION[19 : 15] == 5'h0)) || ((decode_INSTRUCTION[14 : 13] == 2'b11) && (decode_INSTRUCTION[19 : 15] == 5'h0))));
  assign writeBack_FORMAL_PC_NEXT = memory_to_writeBack_FORMAL_PC_NEXT;
  assign memory_FORMAL_PC_NEXT = execute_to_memory_FORMAL_PC_NEXT;
  assign execute_FORMAL_PC_NEXT = decode_to_execute_FORMAL_PC_NEXT;
  assign decode_FORMAL_PC_NEXT = (decode_PC + _zz_222);
  assign memory_PC = execute_to_memory_PC;
  assign execute_DO_EBREAK = decode_to_execute_DO_EBREAK;
  assign decode_IS_EBREAK = _zz_223[0];
  assign memory_BRANCH_CALC = execute_to_memory_BRANCH_CALC;
  assign memory_BRANCH_DO = execute_to_memory_BRANCH_DO;
  assign execute_PC = decode_to_execute_PC;
  assign execute_BRANCH_CTRL = _zz_20;
  assign decode_RS2_USE = _zz_224[0];
  assign decode_RS1_USE = _zz_225[0];
  assign execute_REGFILE_WRITE_VALID = decode_to_execute_REGFILE_WRITE_VALID;
  assign execute_BYPASSABLE_EXECUTE_STAGE = decode_to_execute_BYPASSABLE_EXECUTE_STAGE;
  assign memory_REGFILE_WRITE_VALID = execute_to_memory_REGFILE_WRITE_VALID;
  assign memory_BYPASSABLE_MEMORY_STAGE = execute_to_memory_BYPASSABLE_MEMORY_STAGE;
  assign writeBack_REGFILE_WRITE_VALID = memory_to_writeBack_REGFILE_WRITE_VALID;
  assign memory_REGFILE_WRITE_DATA = execute_to_memory_REGFILE_WRITE_DATA;
  assign execute_SHIFT_CTRL = _zz_21;
  assign execute_IS_RS1_SIGNED = decode_to_execute_IS_RS1_SIGNED;
  assign execute_IS_DIV = decode_to_execute_IS_DIV;
  assign execute_IS_RS2_SIGNED = decode_to_execute_IS_RS2_SIGNED;
  always @ (*) begin
    _zz_22 = memory_REGFILE_WRITE_DATA;
    if(_zz_166)begin
      _zz_22 = memory_DivPlugin_div_result;
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
  assign execute_RS1 = decode_to_execute_RS1;
  assign execute_SRC_LESS_UNSIGNED = decode_to_execute_SRC_LESS_UNSIGNED;
  assign execute_SRC2_FORCE_ZERO = decode_to_execute_SRC2_FORCE_ZERO;
  assign execute_SRC_USE_SUB_LESS = decode_to_execute_SRC_USE_SUB_LESS;
  assign _zz_23 = decode_PC;
  assign _zz_24 = decode_RS2;
  assign decode_SRC2_CTRL = _zz_25;
  assign _zz_26 = decode_RS1;
  assign decode_SRC1_CTRL = _zz_27;
  assign decode_SRC_USE_SUB_LESS = _zz_226[0];
  assign decode_SRC_ADD_ZERO = _zz_227[0];
  assign execute_SRC_ADD_SUB = execute_SrcPlugin_addSub;
  assign execute_SRC_LESS = execute_SrcPlugin_less;
  assign execute_ALU_CTRL = _zz_28;
  assign execute_SRC2 = decode_to_execute_SRC2;
  assign execute_ALU_BITWISE_CTRL = _zz_29;
  assign _zz_30 = writeBack_INSTRUCTION;
  assign _zz_31 = writeBack_REGFILE_WRITE_VALID;
  always @ (*) begin
    _zz_32 = 1'b0;
    if(lastStageRegFileWrite_valid)begin
      _zz_32 = 1'b1;
    end
  end

  assign decode_INSTRUCTION_ANTICIPATED = (decode_arbitration_isStuck ? decode_INSTRUCTION : IBusSimplePlugin_decompressor_output_payload_rsp_inst);
  always @ (*) begin
    decode_REGFILE_WRITE_VALID = _zz_228[0];
    if((decode_INSTRUCTION[11 : 7] == 5'h0))begin
      decode_REGFILE_WRITE_VALID = 1'b0;
    end
  end

  always @ (*) begin
    _zz_40 = execute_REGFILE_WRITE_DATA;
    if(_zz_167)begin
      _zz_40 = execute_CsrPlugin_readData;
    end
    if(_zz_168)begin
      _zz_40 = _zz_126;
    end
  end

  assign execute_SRC1 = decode_to_execute_SRC1;
  assign execute_CSR_READ_OPCODE = decode_to_execute_CSR_READ_OPCODE;
  assign execute_CSR_WRITE_OPCODE = decode_to_execute_CSR_WRITE_OPCODE;
  assign execute_IS_CSR = decode_to_execute_IS_CSR;
  assign memory_ENV_CTRL = _zz_41;
  assign execute_ENV_CTRL = _zz_42;
  assign writeBack_ENV_CTRL = _zz_43;
  assign writeBack_MEMORY_STORE = memory_to_writeBack_MEMORY_STORE;
  always @ (*) begin
    _zz_44 = writeBack_REGFILE_WRITE_DATA;
    if((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE))begin
      _zz_44 = writeBack_DBusSimplePlugin_rspFormated;
    end
    if((writeBack_arbitration_isValid && writeBack_IS_MUL))begin
      case(_zz_201)
        2'b00 : begin
          _zz_44 = _zz_259;
        end
        default : begin
          _zz_44 = _zz_260;
        end
      endcase
    end
  end

  assign writeBack_MEMORY_ENABLE = memory_to_writeBack_MEMORY_ENABLE;
  assign writeBack_MEMORY_ADDRESS_LOW = memory_to_writeBack_MEMORY_ADDRESS_LOW;
  assign writeBack_MEMORY_READ_DATA = memory_to_writeBack_MEMORY_READ_DATA;
  assign memory_MEMORY_STORE = execute_to_memory_MEMORY_STORE;
  assign memory_MEMORY_ENABLE = execute_to_memory_MEMORY_ENABLE;
  assign execute_SRC_ADD = execute_SrcPlugin_addSub;
  assign execute_RS2 = decode_to_execute_RS2;
  assign execute_INSTRUCTION = decode_to_execute_INSTRUCTION;
  assign execute_MEMORY_STORE = decode_to_execute_MEMORY_STORE;
  assign execute_MEMORY_ENABLE = decode_to_execute_MEMORY_ENABLE;
  assign execute_ALIGNEMENT_FAULT = 1'b0;
  always @ (*) begin
    _zz_45 = memory_FORMAL_PC_NEXT;
    if(BranchPlugin_jumpInterface_valid)begin
      _zz_45 = BranchPlugin_jumpInterface_payload;
    end
  end

  assign decode_PC = IBusSimplePlugin_decodePc_pcReg;
  assign decode_INSTRUCTION = IBusSimplePlugin_injector_decodeInput_payload_rsp_inst;
  assign decode_IS_RVC = IBusSimplePlugin_injector_decodeInput_payload_isRvc;
  assign writeBack_PC = memory_to_writeBack_PC;
  assign writeBack_INSTRUCTION = memory_to_writeBack_INSTRUCTION;
  always @ (*) begin
    decode_arbitration_haltItself = 1'b0;
    case(_zz_143)
      3'b010 : begin
        decode_arbitration_haltItself = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    decode_arbitration_haltByOther = 1'b0;
    if(CsrPlugin_pipelineLiberator_active)begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if(({(writeBack_arbitration_isValid && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),{(memory_arbitration_isValid && (memory_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET)),(execute_arbitration_isValid && (execute_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_XRET))}} != 3'b000))begin
      decode_arbitration_haltByOther = 1'b1;
    end
    if((decode_arbitration_isValid && (_zz_127 || _zz_128)))begin
      decode_arbitration_haltByOther = 1'b1;
    end
  end

  always @ (*) begin
    decode_arbitration_removeIt = 1'b0;
    if(decode_arbitration_isFlushed)begin
      decode_arbitration_removeIt = 1'b1;
    end
  end

  assign decode_arbitration_flushIt = 1'b0;
  assign decode_arbitration_flushNext = 1'b0;
  always @ (*) begin
    execute_arbitration_haltItself = 1'b0;
    if(((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! dBus_cmd_ready)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_89)))begin
      execute_arbitration_haltItself = 1'b1;
    end
    if(_zz_169)begin
      if((! execute_CsrPlugin_wfiWake))begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_167)begin
      if(execute_CsrPlugin_blockedBySideEffects)begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
    if(_zz_168)begin
      if((! execute_LightShifterPlugin_done))begin
        execute_arbitration_haltItself = 1'b1;
      end
    end
  end

  always @ (*) begin
    execute_arbitration_haltByOther = 1'b0;
    if(_zz_170)begin
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
    if(_zz_170)begin
      if(_zz_171)begin
        execute_arbitration_flushIt = 1'b1;
      end
    end
  end

  always @ (*) begin
    execute_arbitration_flushNext = 1'b0;
    if(CsrPlugin_selfException_valid)begin
      execute_arbitration_flushNext = 1'b1;
    end
    if(_zz_170)begin
      if(_zz_171)begin
        execute_arbitration_flushNext = 1'b1;
      end
    end
    if(_zz_142)begin
      execute_arbitration_flushNext = 1'b1;
    end
  end

  always @ (*) begin
    memory_arbitration_haltItself = 1'b0;
    if((((memory_arbitration_isValid && memory_MEMORY_ENABLE) && (! memory_MEMORY_STORE)) && ((! dBus_rsp_ready) || 1'b0)))begin
      memory_arbitration_haltItself = 1'b1;
    end
    if(_zz_166)begin
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
    if(_zz_172)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
    if(_zz_173)begin
      writeBack_arbitration_flushNext = 1'b1;
    end
  end

  assign lastStageInstruction = writeBack_INSTRUCTION;
  assign lastStagePc = writeBack_PC;
  assign lastStageIsValid = writeBack_arbitration_isValid;
  assign lastStageIsFiring = writeBack_arbitration_isFiring;
  always @ (*) begin
    IBusSimplePlugin_fetcherHalt = 1'b0;
    if(({CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValids_memory,{CsrPlugin_exceptionPortCtrl_exceptionValids_execute,CsrPlugin_exceptionPortCtrl_exceptionValids_decode}}} != 4'b0000))begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_172)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_173)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_170)begin
      if(_zz_171)begin
        IBusSimplePlugin_fetcherHalt = 1'b1;
      end
    end
    if(DebugPlugin_haltIt)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
    if(_zz_174)begin
      IBusSimplePlugin_fetcherHalt = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_incomingInstruction = 1'b0;
    if((IBusSimplePlugin_iBusRsp_stages_1_input_valid || IBusSimplePlugin_iBusRsp_stages_2_input_valid))begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_incomingInstruction = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_inWfi = 1'b0;
    if(_zz_169)begin
      CsrPlugin_inWfi = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_thirdPartyWake = 1'b0;
    if(DebugPlugin_haltIt)begin
      CsrPlugin_thirdPartyWake = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_jumpInterface_valid = 1'b0;
    if(_zz_172)begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
    if(_zz_173)begin
      CsrPlugin_jumpInterface_valid = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_jumpInterface_payload = 32'h0;
    if(_zz_172)begin
      CsrPlugin_jumpInterface_payload = {CsrPlugin_xtvec_base,2'b00};
    end
    if(_zz_173)begin
      case(_zz_175)
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

  assign IBusSimplePlugin_externalFlush = ({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,{execute_arbitration_flushNext,decode_arbitration_flushNext}}} != 4'b0000);
  assign IBusSimplePlugin_jump_pcLoad_valid = ({BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid} != 2'b00);
  assign _zz_46 = {BranchPlugin_jumpInterface_valid,CsrPlugin_jumpInterface_valid};
  assign IBusSimplePlugin_jump_pcLoad_payload = (_zz_229[0] ? CsrPlugin_jumpInterface_payload : BranchPlugin_jumpInterface_payload);
  always @ (*) begin
    IBusSimplePlugin_fetchPc_correction = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_correction = 1'b1;
    end
  end

  assign IBusSimplePlugin_fetchPc_corrected = (IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_correctionReg);
  always @ (*) begin
    IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b0;
    if(IBusSimplePlugin_iBusRsp_stages_1_input_ready)begin
      IBusSimplePlugin_fetchPc_pcRegPropagate = 1'b1;
    end
  end

  always @ (*) begin
    IBusSimplePlugin_fetchPc_pc = (IBusSimplePlugin_fetchPc_pcReg + _zz_232);
    if(IBusSimplePlugin_fetchPc_inc)begin
      IBusSimplePlugin_fetchPc_pc[1] = 1'b0;
    end
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_pc = IBusSimplePlugin_jump_pcLoad_payload;
    end
    IBusSimplePlugin_fetchPc_pc[0] = 1'b0;
  end

  always @ (*) begin
    IBusSimplePlugin_fetchPc_flushed = 1'b0;
    if(IBusSimplePlugin_jump_pcLoad_valid)begin
      IBusSimplePlugin_fetchPc_flushed = 1'b1;
    end
  end

  assign IBusSimplePlugin_fetchPc_output_valid = ((! IBusSimplePlugin_fetcherHalt) && IBusSimplePlugin_fetchPc_booted);
  assign IBusSimplePlugin_fetchPc_output_payload = IBusSimplePlugin_fetchPc_pc;
  always @ (*) begin
    IBusSimplePlugin_decodePc_flushed = 1'b0;
    if(_zz_176)begin
      IBusSimplePlugin_decodePc_flushed = 1'b1;
    end
  end

  assign IBusSimplePlugin_decodePc_pcPlus = (IBusSimplePlugin_decodePc_pcReg + _zz_234);
  always @ (*) begin
    IBusSimplePlugin_decodePc_injectedDecode = 1'b0;
    if((_zz_143 != 3'b000))begin
      IBusSimplePlugin_decodePc_injectedDecode = 1'b1;
    end
  end

  assign IBusSimplePlugin_iBusRsp_redoFetch = 1'b0;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_valid = IBusSimplePlugin_fetchPc_output_valid;
  assign IBusSimplePlugin_fetchPc_output_ready = IBusSimplePlugin_iBusRsp_stages_0_input_ready;
  assign IBusSimplePlugin_iBusRsp_stages_0_input_payload = IBusSimplePlugin_fetchPc_output_payload;
  assign IBusSimplePlugin_iBusRsp_stages_0_halt = 1'b0;
  assign _zz_47 = (! IBusSimplePlugin_iBusRsp_stages_0_halt);
  assign IBusSimplePlugin_iBusRsp_stages_0_input_ready = (IBusSimplePlugin_iBusRsp_stages_0_output_ready && _zz_47);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_valid = (IBusSimplePlugin_iBusRsp_stages_0_input_valid && _zz_47);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_payload = IBusSimplePlugin_iBusRsp_stages_0_input_payload;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b0;
    if((IBusSimplePlugin_iBusRsp_stages_1_input_valid && ((! IBusSimplePlugin_cmdFork_canEmit) || (! IBusSimplePlugin_cmd_ready))))begin
      IBusSimplePlugin_iBusRsp_stages_1_halt = 1'b1;
    end
  end

  assign _zz_48 = (! IBusSimplePlugin_iBusRsp_stages_1_halt);
  assign IBusSimplePlugin_iBusRsp_stages_1_input_ready = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && _zz_48);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && _zz_48);
  assign IBusSimplePlugin_iBusRsp_stages_1_output_payload = IBusSimplePlugin_iBusRsp_stages_1_input_payload;
  assign IBusSimplePlugin_iBusRsp_stages_2_halt = 1'b0;
  assign _zz_49 = (! IBusSimplePlugin_iBusRsp_stages_2_halt);
  assign IBusSimplePlugin_iBusRsp_stages_2_input_ready = (IBusSimplePlugin_iBusRsp_stages_2_output_ready && _zz_49);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_valid = (IBusSimplePlugin_iBusRsp_stages_2_input_valid && _zz_49);
  assign IBusSimplePlugin_iBusRsp_stages_2_output_payload = IBusSimplePlugin_iBusRsp_stages_2_input_payload;
  assign IBusSimplePlugin_iBusRsp_flush = (IBusSimplePlugin_externalFlush || IBusSimplePlugin_iBusRsp_redoFetch);
  assign IBusSimplePlugin_iBusRsp_stages_0_output_ready = _zz_50;
  assign _zz_50 = ((1'b0 && (! _zz_51)) || IBusSimplePlugin_iBusRsp_stages_1_input_ready);
  assign _zz_51 = _zz_52;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_valid = _zz_51;
  assign IBusSimplePlugin_iBusRsp_stages_1_input_payload = IBusSimplePlugin_fetchPc_pcReg;
  assign IBusSimplePlugin_iBusRsp_stages_1_output_ready = ((1'b0 && (! _zz_53)) || IBusSimplePlugin_iBusRsp_stages_2_input_ready);
  assign _zz_53 = _zz_54;
  assign IBusSimplePlugin_iBusRsp_stages_2_input_valid = _zz_53;
  assign IBusSimplePlugin_iBusRsp_stages_2_input_payload = _zz_55;
  always @ (*) begin
    IBusSimplePlugin_iBusRsp_readyForError = 1'b1;
    if(IBusSimplePlugin_injector_decodeInput_valid)begin
      IBusSimplePlugin_iBusRsp_readyForError = 1'b0;
    end
  end

  assign IBusSimplePlugin_decompressor_input_valid = (IBusSimplePlugin_iBusRsp_output_valid && (! IBusSimplePlugin_iBusRsp_redoFetch));
  assign IBusSimplePlugin_decompressor_input_payload_pc = IBusSimplePlugin_iBusRsp_output_payload_pc;
  assign IBusSimplePlugin_decompressor_input_payload_rsp_error = IBusSimplePlugin_iBusRsp_output_payload_rsp_error;
  assign IBusSimplePlugin_decompressor_input_payload_rsp_inst = IBusSimplePlugin_iBusRsp_output_payload_rsp_inst;
  assign IBusSimplePlugin_decompressor_input_payload_isRvc = IBusSimplePlugin_iBusRsp_output_payload_isRvc;
  assign IBusSimplePlugin_iBusRsp_output_ready = IBusSimplePlugin_decompressor_input_ready;
  assign IBusSimplePlugin_decompressor_flushNext = 1'b0;
  assign IBusSimplePlugin_decompressor_consumeCurrent = 1'b0;
  assign IBusSimplePlugin_decompressor_isInputLowRvc = (IBusSimplePlugin_decompressor_input_payload_rsp_inst[1 : 0] != 2'b11);
  assign IBusSimplePlugin_decompressor_isInputHighRvc = (IBusSimplePlugin_decompressor_input_payload_rsp_inst[17 : 16] != 2'b11);
  assign IBusSimplePlugin_decompressor_throw2Bytes = (IBusSimplePlugin_decompressor_throw2BytesReg || IBusSimplePlugin_decompressor_input_payload_pc[1]);
  assign IBusSimplePlugin_decompressor_unaligned = (IBusSimplePlugin_decompressor_throw2Bytes || IBusSimplePlugin_decompressor_bufferValid);
  assign IBusSimplePlugin_decompressor_raw = (IBusSimplePlugin_decompressor_bufferValid ? {IBusSimplePlugin_decompressor_input_payload_rsp_inst[15 : 0],IBusSimplePlugin_decompressor_bufferData} : {IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16],(IBusSimplePlugin_decompressor_throw2Bytes ? IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16] : IBusSimplePlugin_decompressor_input_payload_rsp_inst[15 : 0])});
  assign IBusSimplePlugin_decompressor_isRvc = (IBusSimplePlugin_decompressor_raw[1 : 0] != 2'b11);
  assign _zz_56 = IBusSimplePlugin_decompressor_raw[15 : 0];
  always @ (*) begin
    IBusSimplePlugin_decompressor_decompressed = 32'h0;
    case(_zz_196)
      5'h0 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{{2'b00,_zz_56[10 : 7]},_zz_56[12 : 11]},_zz_56[5]},_zz_56[6]},2'b00},5'h02},3'b000},_zz_58},7'h13};
      end
      5'h02 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_59,_zz_57},3'b010},_zz_58},7'h03};
      end
      5'h06 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_59[11 : 5],_zz_58},_zz_57},3'b010},_zz_59[4 : 0]},7'h23};
      end
      5'h08 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_61,_zz_56[11 : 7]},3'b000},_zz_56[11 : 7]},7'h13};
      end
      5'h09 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_64[20],_zz_64[10 : 1]},_zz_64[11]},_zz_64[19 : 12]},_zz_76},7'h6f};
      end
      5'h0a : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{_zz_61,5'h0},3'b000},_zz_56[11 : 7]},7'h13};
      end
      5'h0b : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_56[11 : 7] == 5'h02) ? {{{{{{{{{_zz_68,_zz_56[4 : 3]},_zz_56[5]},_zz_56[2]},_zz_56[6]},4'b0000},_zz_56[11 : 7]},3'b000},_zz_56[11 : 7]},7'h13} : {{_zz_235[31 : 12],_zz_56[11 : 7]},7'h37});
      end
      5'h0c : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{((_zz_56[11 : 10] == 2'b10) ? _zz_82 : {{1'b0,(_zz_290 || _zz_291)},5'h0}),(((! _zz_56[11]) || _zz_78) ? _zz_56[6 : 2] : _zz_58)},_zz_57},_zz_80},_zz_57},(_zz_78 ? 7'h13 : 7'h33)};
      end
      5'h0d : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_71[20],_zz_71[10 : 1]},_zz_71[11]},_zz_71[19 : 12]},_zz_75},7'h6f};
      end
      5'h0e : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_74[12],_zz_74[10 : 5]},_zz_75},_zz_57},3'b000},_zz_74[4 : 1]},_zz_74[11]},7'h63};
      end
      5'h0f : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{_zz_74[12],_zz_74[10 : 5]},_zz_75},_zz_57},3'b001},_zz_74[4 : 1]},_zz_74[11]},7'h63};
      end
      5'h10 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{7'h0,_zz_56[6 : 2]},_zz_56[11 : 7]},3'b001},_zz_56[11 : 7]},7'h13};
      end
      5'h12 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{{{{4'b0000,_zz_56[3 : 2]},_zz_56[12]},_zz_56[6 : 4]},2'b00},_zz_77},3'b010},_zz_56[11 : 7]},7'h03};
      end
      5'h14 : begin
        IBusSimplePlugin_decompressor_decompressed = ((_zz_56[12 : 2] == 11'h400) ? 32'h00100073 : ((_zz_56[6 : 2] == 5'h0) ? {{{{12'h0,_zz_56[11 : 7]},3'b000},(_zz_56[12] ? _zz_76 : _zz_75)},7'h67} : {{{{{_zz_292,_zz_293},(_zz_294 ? _zz_295 : _zz_75)},3'b000},_zz_56[11 : 7]},7'h33}));
      end
      5'h16 : begin
        IBusSimplePlugin_decompressor_decompressed = {{{{{_zz_236[11 : 5],_zz_56[6 : 2]},_zz_77},3'b010},_zz_237[4 : 0]},7'h23};
      end
      default : begin
      end
    endcase
  end

  assign _zz_57 = {2'b01,_zz_56[9 : 7]};
  assign _zz_58 = {2'b01,_zz_56[4 : 2]};
  assign _zz_59 = {{{{5'h0,_zz_56[5]},_zz_56[12 : 10]},_zz_56[6]},2'b00};
  assign _zz_60 = _zz_56[12];
  always @ (*) begin
    _zz_61[11] = _zz_60;
    _zz_61[10] = _zz_60;
    _zz_61[9] = _zz_60;
    _zz_61[8] = _zz_60;
    _zz_61[7] = _zz_60;
    _zz_61[6] = _zz_60;
    _zz_61[5] = _zz_60;
    _zz_61[4 : 0] = _zz_56[6 : 2];
  end

  assign _zz_62 = _zz_56[12];
  always @ (*) begin
    _zz_63[9] = _zz_62;
    _zz_63[8] = _zz_62;
    _zz_63[7] = _zz_62;
    _zz_63[6] = _zz_62;
    _zz_63[5] = _zz_62;
    _zz_63[4] = _zz_62;
    _zz_63[3] = _zz_62;
    _zz_63[2] = _zz_62;
    _zz_63[1] = _zz_62;
    _zz_63[0] = _zz_62;
  end

  assign _zz_64 = {{{{{{{{_zz_63,_zz_56[8]},_zz_56[10 : 9]},_zz_56[6]},_zz_56[7]},_zz_56[2]},_zz_56[11]},_zz_56[5 : 3]},1'b0};
  assign _zz_65 = _zz_56[12];
  always @ (*) begin
    _zz_66[14] = _zz_65;
    _zz_66[13] = _zz_65;
    _zz_66[12] = _zz_65;
    _zz_66[11] = _zz_65;
    _zz_66[10] = _zz_65;
    _zz_66[9] = _zz_65;
    _zz_66[8] = _zz_65;
    _zz_66[7] = _zz_65;
    _zz_66[6] = _zz_65;
    _zz_66[5] = _zz_65;
    _zz_66[4] = _zz_65;
    _zz_66[3] = _zz_65;
    _zz_66[2] = _zz_65;
    _zz_66[1] = _zz_65;
    _zz_66[0] = _zz_65;
  end

  assign _zz_67 = _zz_56[12];
  always @ (*) begin
    _zz_68[2] = _zz_67;
    _zz_68[1] = _zz_67;
    _zz_68[0] = _zz_67;
  end

  assign _zz_69 = _zz_56[12];
  always @ (*) begin
    _zz_70[9] = _zz_69;
    _zz_70[8] = _zz_69;
    _zz_70[7] = _zz_69;
    _zz_70[6] = _zz_69;
    _zz_70[5] = _zz_69;
    _zz_70[4] = _zz_69;
    _zz_70[3] = _zz_69;
    _zz_70[2] = _zz_69;
    _zz_70[1] = _zz_69;
    _zz_70[0] = _zz_69;
  end

  assign _zz_71 = {{{{{{{{_zz_70,_zz_56[8]},_zz_56[10 : 9]},_zz_56[6]},_zz_56[7]},_zz_56[2]},_zz_56[11]},_zz_56[5 : 3]},1'b0};
  assign _zz_72 = _zz_56[12];
  always @ (*) begin
    _zz_73[4] = _zz_72;
    _zz_73[3] = _zz_72;
    _zz_73[2] = _zz_72;
    _zz_73[1] = _zz_72;
    _zz_73[0] = _zz_72;
  end

  assign _zz_74 = {{{{{_zz_73,_zz_56[6 : 5]},_zz_56[2]},_zz_56[11 : 10]},_zz_56[4 : 3]},1'b0};
  assign _zz_75 = 5'h0;
  assign _zz_76 = 5'h01;
  assign _zz_77 = 5'h02;
  assign _zz_78 = (_zz_56[11 : 10] != 2'b11);
  always @ (*) begin
    case(_zz_197)
      2'b00 : begin
        _zz_79 = 3'b000;
      end
      2'b01 : begin
        _zz_79 = 3'b100;
      end
      2'b10 : begin
        _zz_79 = 3'b110;
      end
      default : begin
        _zz_79 = 3'b111;
      end
    endcase
  end

  always @ (*) begin
    case(_zz_198)
      2'b00 : begin
        _zz_80 = 3'b101;
      end
      2'b01 : begin
        _zz_80 = 3'b101;
      end
      2'b10 : begin
        _zz_80 = 3'b111;
      end
      default : begin
        _zz_80 = _zz_79;
      end
    endcase
  end

  assign _zz_81 = _zz_56[12];
  always @ (*) begin
    _zz_82[6] = _zz_81;
    _zz_82[5] = _zz_81;
    _zz_82[4] = _zz_81;
    _zz_82[3] = _zz_81;
    _zz_82[2] = _zz_81;
    _zz_82[1] = _zz_81;
    _zz_82[0] = _zz_81;
  end

  assign IBusSimplePlugin_decompressor_output_valid = (IBusSimplePlugin_decompressor_input_valid && (! ((IBusSimplePlugin_decompressor_throw2Bytes && (! IBusSimplePlugin_decompressor_bufferValid)) && (! IBusSimplePlugin_decompressor_isInputHighRvc))));
  assign IBusSimplePlugin_decompressor_output_payload_pc = IBusSimplePlugin_decompressor_input_payload_pc;
  assign IBusSimplePlugin_decompressor_output_payload_isRvc = IBusSimplePlugin_decompressor_isRvc;
  assign IBusSimplePlugin_decompressor_output_payload_rsp_inst = (IBusSimplePlugin_decompressor_isRvc ? IBusSimplePlugin_decompressor_decompressed : IBusSimplePlugin_decompressor_raw);
  assign IBusSimplePlugin_decompressor_input_ready = (IBusSimplePlugin_decompressor_output_ready && (((! IBusSimplePlugin_iBusRsp_stages_2_input_valid) || IBusSimplePlugin_decompressor_flushNext) || ((! (IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isInputHighRvc)) && (! (((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && IBusSimplePlugin_decompressor_isInputHighRvc)))));
  assign IBusSimplePlugin_decompressor_bufferFill = (((((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && (! IBusSimplePlugin_decompressor_isInputHighRvc)) || (IBusSimplePlugin_decompressor_bufferValid && (! IBusSimplePlugin_decompressor_isInputHighRvc))) || ((IBusSimplePlugin_decompressor_throw2Bytes && (! IBusSimplePlugin_decompressor_isRvc)) && (! IBusSimplePlugin_decompressor_isInputHighRvc)));
  assign IBusSimplePlugin_decompressor_output_ready = ((1'b0 && (! IBusSimplePlugin_injector_decodeInput_valid)) || IBusSimplePlugin_injector_decodeInput_ready);
  assign IBusSimplePlugin_injector_decodeInput_valid = _zz_83;
  assign IBusSimplePlugin_injector_decodeInput_payload_pc = _zz_84;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_error = _zz_85;
  assign IBusSimplePlugin_injector_decodeInput_payload_rsp_inst = _zz_86;
  assign IBusSimplePlugin_injector_decodeInput_payload_isRvc = _zz_87;
  assign IBusSimplePlugin_pcValids_0 = IBusSimplePlugin_injector_nextPcCalc_valids_0;
  assign IBusSimplePlugin_pcValids_1 = IBusSimplePlugin_injector_nextPcCalc_valids_1;
  assign IBusSimplePlugin_pcValids_2 = IBusSimplePlugin_injector_nextPcCalc_valids_2;
  assign IBusSimplePlugin_pcValids_3 = IBusSimplePlugin_injector_nextPcCalc_valids_3;
  assign IBusSimplePlugin_injector_decodeInput_ready = (! decode_arbitration_isStuck);
  always @ (*) begin
    decode_arbitration_isValid = IBusSimplePlugin_injector_decodeInput_valid;
    case(_zz_143)
      3'b010 : begin
        decode_arbitration_isValid = 1'b1;
      end
      3'b011 : begin
        decode_arbitration_isValid = 1'b1;
      end
      default : begin
      end
    endcase
  end

  assign iBus_cmd_valid = IBusSimplePlugin_cmd_valid;
  assign IBusSimplePlugin_cmd_ready = iBus_cmd_ready;
  assign iBus_cmd_payload_pc = IBusSimplePlugin_cmd_payload_pc;
  assign IBusSimplePlugin_pending_next = (_zz_238 - _zz_242);
  assign IBusSimplePlugin_cmdFork_canEmit = (IBusSimplePlugin_iBusRsp_stages_1_output_ready && (IBusSimplePlugin_pending_value != 3'b111));
  assign IBusSimplePlugin_cmd_valid = (IBusSimplePlugin_iBusRsp_stages_1_input_valid && IBusSimplePlugin_cmdFork_canEmit);
  assign IBusSimplePlugin_pending_inc = (IBusSimplePlugin_cmd_valid && IBusSimplePlugin_cmd_ready);
  assign IBusSimplePlugin_cmd_payload_pc = {IBusSimplePlugin_iBusRsp_stages_1_input_payload[31 : 2],2'b00};
  assign IBusSimplePlugin_rspJoin_rspBuffer_flush = ((IBusSimplePlugin_rspJoin_rspBuffer_discardCounter != 3'b000) || IBusSimplePlugin_iBusRsp_flush);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_valid = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter == 3'b000));
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_error;
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst = IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_payload_inst;
  assign _zz_162 = (IBusSimplePlugin_rspJoin_rspBuffer_output_ready || IBusSimplePlugin_rspJoin_rspBuffer_flush);
  assign IBusSimplePlugin_pending_dec = (IBusSimplePlugin_rspJoin_rspBuffer_c_io_pop_valid && _zz_162);
  assign IBusSimplePlugin_rspJoin_fetchRsp_pc = IBusSimplePlugin_iBusRsp_stages_2_output_payload;
  always @ (*) begin
    IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_error;
    if((! IBusSimplePlugin_rspJoin_rspBuffer_output_valid))begin
      IBusSimplePlugin_rspJoin_fetchRsp_rsp_error = 1'b0;
    end
  end

  assign IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst = IBusSimplePlugin_rspJoin_rspBuffer_output_payload_inst;
  assign IBusSimplePlugin_rspJoin_exceptionDetected = 1'b0;
  assign IBusSimplePlugin_rspJoin_join_valid = (IBusSimplePlugin_iBusRsp_stages_2_output_valid && IBusSimplePlugin_rspJoin_rspBuffer_output_valid);
  assign IBusSimplePlugin_rspJoin_join_payload_pc = IBusSimplePlugin_rspJoin_fetchRsp_pc;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_error = IBusSimplePlugin_rspJoin_fetchRsp_rsp_error;
  assign IBusSimplePlugin_rspJoin_join_payload_rsp_inst = IBusSimplePlugin_rspJoin_fetchRsp_rsp_inst;
  assign IBusSimplePlugin_rspJoin_join_payload_isRvc = IBusSimplePlugin_rspJoin_fetchRsp_isRvc;
  assign IBusSimplePlugin_iBusRsp_stages_2_output_ready = (IBusSimplePlugin_iBusRsp_stages_2_output_valid ? (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready) : IBusSimplePlugin_rspJoin_join_ready);
  assign IBusSimplePlugin_rspJoin_rspBuffer_output_ready = (IBusSimplePlugin_rspJoin_join_valid && IBusSimplePlugin_rspJoin_join_ready);
  assign _zz_88 = (! IBusSimplePlugin_rspJoin_exceptionDetected);
  assign IBusSimplePlugin_rspJoin_join_ready = (IBusSimplePlugin_iBusRsp_output_ready && _zz_88);
  assign IBusSimplePlugin_iBusRsp_output_valid = (IBusSimplePlugin_rspJoin_join_valid && _zz_88);
  assign IBusSimplePlugin_iBusRsp_output_payload_pc = IBusSimplePlugin_rspJoin_join_payload_pc;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_error = IBusSimplePlugin_rspJoin_join_payload_rsp_error;
  assign IBusSimplePlugin_iBusRsp_output_payload_rsp_inst = IBusSimplePlugin_rspJoin_join_payload_rsp_inst;
  assign IBusSimplePlugin_iBusRsp_output_payload_isRvc = IBusSimplePlugin_rspJoin_join_payload_isRvc;
  assign _zz_89 = 1'b0;
  always @ (*) begin
    execute_DBusSimplePlugin_skipCmd = 1'b0;
    if(execute_ALIGNEMENT_FAULT)begin
      execute_DBusSimplePlugin_skipCmd = 1'b1;
    end
  end

  assign dBus_cmd_valid = (((((execute_arbitration_isValid && execute_MEMORY_ENABLE) && (! execute_arbitration_isStuckByOthers)) && (! execute_arbitration_isFlushed)) && (! execute_DBusSimplePlugin_skipCmd)) && (! _zz_89));
  assign dBus_cmd_payload_wr = execute_MEMORY_STORE;
  assign dBus_cmd_payload_size = execute_INSTRUCTION[13 : 12];
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_90 = {{{execute_RS2[7 : 0],execute_RS2[7 : 0]},execute_RS2[7 : 0]},execute_RS2[7 : 0]};
      end
      2'b01 : begin
        _zz_90 = {execute_RS2[15 : 0],execute_RS2[15 : 0]};
      end
      default : begin
        _zz_90 = execute_RS2[31 : 0];
      end
    endcase
  end

  assign dBus_cmd_payload_data = _zz_90;
  always @ (*) begin
    case(dBus_cmd_payload_size)
      2'b00 : begin
        _zz_91 = 4'b0001;
      end
      2'b01 : begin
        _zz_91 = 4'b0011;
      end
      default : begin
        _zz_91 = 4'b1111;
      end
    endcase
  end

  assign execute_DBusSimplePlugin_formalMask = (_zz_91 <<< dBus_cmd_payload_address[1 : 0]);
  assign dBus_cmd_payload_address = execute_SRC_ADD;
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

  assign _zz_92 = (writeBack_DBusSimplePlugin_rspShifted[7] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_93[31] = _zz_92;
    _zz_93[30] = _zz_92;
    _zz_93[29] = _zz_92;
    _zz_93[28] = _zz_92;
    _zz_93[27] = _zz_92;
    _zz_93[26] = _zz_92;
    _zz_93[25] = _zz_92;
    _zz_93[24] = _zz_92;
    _zz_93[23] = _zz_92;
    _zz_93[22] = _zz_92;
    _zz_93[21] = _zz_92;
    _zz_93[20] = _zz_92;
    _zz_93[19] = _zz_92;
    _zz_93[18] = _zz_92;
    _zz_93[17] = _zz_92;
    _zz_93[16] = _zz_92;
    _zz_93[15] = _zz_92;
    _zz_93[14] = _zz_92;
    _zz_93[13] = _zz_92;
    _zz_93[12] = _zz_92;
    _zz_93[11] = _zz_92;
    _zz_93[10] = _zz_92;
    _zz_93[9] = _zz_92;
    _zz_93[8] = _zz_92;
    _zz_93[7 : 0] = writeBack_DBusSimplePlugin_rspShifted[7 : 0];
  end

  assign _zz_94 = (writeBack_DBusSimplePlugin_rspShifted[15] && (! writeBack_INSTRUCTION[14]));
  always @ (*) begin
    _zz_95[31] = _zz_94;
    _zz_95[30] = _zz_94;
    _zz_95[29] = _zz_94;
    _zz_95[28] = _zz_94;
    _zz_95[27] = _zz_94;
    _zz_95[26] = _zz_94;
    _zz_95[25] = _zz_94;
    _zz_95[24] = _zz_94;
    _zz_95[23] = _zz_94;
    _zz_95[22] = _zz_94;
    _zz_95[21] = _zz_94;
    _zz_95[20] = _zz_94;
    _zz_95[19] = _zz_94;
    _zz_95[18] = _zz_94;
    _zz_95[17] = _zz_94;
    _zz_95[16] = _zz_94;
    _zz_95[15 : 0] = writeBack_DBusSimplePlugin_rspShifted[15 : 0];
  end

  always @ (*) begin
    case(_zz_199)
      2'b00 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_93;
      end
      2'b01 : begin
        writeBack_DBusSimplePlugin_rspFormated = _zz_95;
      end
      default : begin
        writeBack_DBusSimplePlugin_rspFormated = writeBack_DBusSimplePlugin_rspShifted;
      end
    endcase
  end

  always @ (*) begin
    CsrPlugin_privilege = 2'b11;
    if(CsrPlugin_forceMachineWire)begin
      CsrPlugin_privilege = 2'b11;
    end
  end

  assign _zz_96 = (CsrPlugin_mip_MTIP && CsrPlugin_mie_MTIE);
  assign _zz_97 = (CsrPlugin_mip_MSIP && CsrPlugin_mie_MSIE);
  assign _zz_98 = (CsrPlugin_mip_MEIP && CsrPlugin_mie_MEIE);
  assign CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_decode = 1'b0;
  assign CsrPlugin_exceptionPortCtrl_exceptionTargetPrivilegeUncapped = 2'b11;
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
  assign CsrPlugin_pipelineLiberator_active = ((CsrPlugin_interrupt_valid && CsrPlugin_allowInterrupts) && decode_arbitration_isValid);
  always @ (*) begin
    CsrPlugin_pipelineLiberator_done = CsrPlugin_pipelineLiberator_pcValids_2;
    if(({CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack,{CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory,CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute}} != 3'b000))begin
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
    CsrPlugin_xtvec_mode = 2'bxx;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_mode = CsrPlugin_mtvec_mode;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    CsrPlugin_xtvec_base = 30'h0;
    case(CsrPlugin_targetPrivilege)
      2'b11 : begin
        CsrPlugin_xtvec_base = CsrPlugin_mtvec_base;
      end
      default : begin
      end
    endcase
  end

  assign contextSwitching = CsrPlugin_jumpInterface_valid;
  assign execute_CsrPlugin_blockedBySideEffects = (({writeBack_arbitration_isValid,memory_arbitration_isValid} != 2'b00) || 1'b0);
  always @ (*) begin
    execute_CsrPlugin_illegalAccess = 1'b1;
    if(execute_CsrPlugin_csr_3857)begin
      if(execute_CSR_READ_OPCODE)begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3858)begin
      if(execute_CSR_READ_OPCODE)begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3859)begin
      if(execute_CSR_READ_OPCODE)begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3860)begin
      if(execute_CSR_READ_OPCODE)begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_769)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_768)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_836)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_772)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_773)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_833)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_832)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_834)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_835)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_2816)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_2944)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_2818)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_2946)begin
      execute_CsrPlugin_illegalAccess = 1'b0;
    end
    if(execute_CsrPlugin_csr_3072)begin
      if(execute_CSR_READ_OPCODE)begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(execute_CsrPlugin_csr_3200)begin
      if(execute_CSR_READ_OPCODE)begin
        execute_CsrPlugin_illegalAccess = 1'b0;
      end
    end
    if(_zz_177)begin
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
    if(_zz_178)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
    if(_zz_179)begin
      CsrPlugin_selfException_valid = 1'b1;
    end
  end

  always @ (*) begin
    CsrPlugin_selfException_payload_code = 4'bxxxx;
    if(_zz_178)begin
      CsrPlugin_selfException_payload_code = 4'b0010;
    end
    if(_zz_179)begin
      case(CsrPlugin_privilege)
        2'b00 : begin
          CsrPlugin_selfException_payload_code = 4'b1000;
        end
        default : begin
          CsrPlugin_selfException_payload_code = 4'b1011;
        end
      endcase
    end
  end

  assign CsrPlugin_selfException_payload_badAddr = execute_INSTRUCTION;
  always @ (*) begin
    execute_CsrPlugin_writeInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_WRITE_OPCODE);
    if(_zz_177)begin
      execute_CsrPlugin_writeInstruction = 1'b0;
    end
  end

  always @ (*) begin
    execute_CsrPlugin_readInstruction = ((execute_arbitration_isValid && execute_IS_CSR) && execute_CSR_READ_OPCODE);
    if(_zz_177)begin
      execute_CsrPlugin_readInstruction = 1'b0;
    end
  end

  assign execute_CsrPlugin_writeEnable = ((execute_CsrPlugin_writeInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readEnable = ((execute_CsrPlugin_readInstruction && (! execute_CsrPlugin_blockedBySideEffects)) && (! execute_arbitration_isStuckByOthers));
  assign execute_CsrPlugin_readToWriteData = execute_CsrPlugin_readData;
  always @ (*) begin
    case(_zz_200)
      1'b0 : begin
        execute_CsrPlugin_writeData = execute_SRC1;
      end
      default : begin
        execute_CsrPlugin_writeData = (execute_INSTRUCTION[12] ? (execute_CsrPlugin_readToWriteData & (~ execute_SRC1)) : (execute_CsrPlugin_readToWriteData | execute_SRC1));
      end
    endcase
  end

  assign execute_CsrPlugin_csrAddress = execute_INSTRUCTION[31 : 20];
  assign _zz_100 = ((decode_INSTRUCTION & 32'h00004050) == 32'h00004050);
  assign _zz_101 = ((decode_INSTRUCTION & 32'h00006004) == 32'h00002000);
  assign _zz_102 = ((decode_INSTRUCTION & 32'h00000004) == 32'h00000004);
  assign _zz_103 = ((decode_INSTRUCTION & 32'h00000048) == 32'h00000048);
  assign _zz_104 = ((decode_INSTRUCTION & 32'h00000030) == 32'h00000010);
  assign _zz_105 = ((decode_INSTRUCTION & 32'h00001000) == 32'h0);
  assign _zz_99 = {(((decode_INSTRUCTION & _zz_296) == 32'h00100050) != 1'b0),{({_zz_103,_zz_297} != 2'b00),{(_zz_298 != 1'b0),{(_zz_299 != _zz_300),{_zz_301,{_zz_302,_zz_303}}}}}};
  assign _zz_106 = _zz_99[1 : 0];
  assign _zz_39 = _zz_106;
  assign _zz_107 = _zz_99[6 : 5];
  assign _zz_38 = _zz_107;
  assign _zz_108 = _zz_99[15 : 14];
  assign _zz_37 = _zz_108;
  assign _zz_109 = _zz_99[17 : 16];
  assign _zz_36 = _zz_109;
  assign _zz_110 = _zz_99[20 : 19];
  assign _zz_35 = _zz_110;
  assign _zz_111 = _zz_99[27 : 26];
  assign _zz_34 = _zz_111;
  assign _zz_112 = _zz_99[29 : 28];
  assign _zz_33 = _zz_112;
  assign decode_RegFilePlugin_regFileReadAddress1 = decode_INSTRUCTION_ANTICIPATED[19 : 15];
  assign decode_RegFilePlugin_regFileReadAddress2 = decode_INSTRUCTION_ANTICIPATED[24 : 20];
  assign decode_RegFilePlugin_rs1Data = _zz_164;
  assign decode_RegFilePlugin_rs2Data = _zz_165;
  always @ (*) begin
    lastStageRegFileWrite_valid = (_zz_31 && writeBack_arbitration_isFiring);
    if(_zz_113)begin
      lastStageRegFileWrite_valid = 1'b1;
    end
  end

  assign lastStageRegFileWrite_payload_address = _zz_30[11 : 7];
  assign lastStageRegFileWrite_payload_data = _zz_44;
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
        _zz_114 = execute_IntAluPlugin_bitwise;
      end
      `AluCtrlEnum_defaultEncoding_SLT_SLTU : begin
        _zz_114 = {31'd0, _zz_245};
      end
      default : begin
        _zz_114 = execute_SRC_ADD_SUB;
      end
    endcase
  end

  always @ (*) begin
    case(decode_SRC1_CTRL)
      `Src1CtrlEnum_defaultEncoding_RS : begin
        _zz_115 = _zz_26;
      end
      `Src1CtrlEnum_defaultEncoding_PC_INCREMENT : begin
        _zz_115 = {29'd0, _zz_246};
      end
      `Src1CtrlEnum_defaultEncoding_IMU : begin
        _zz_115 = {decode_INSTRUCTION[31 : 12],12'h0};
      end
      default : begin
        _zz_115 = {27'd0, _zz_247};
      end
    endcase
  end

  assign _zz_116 = _zz_248[11];
  always @ (*) begin
    _zz_117[19] = _zz_116;
    _zz_117[18] = _zz_116;
    _zz_117[17] = _zz_116;
    _zz_117[16] = _zz_116;
    _zz_117[15] = _zz_116;
    _zz_117[14] = _zz_116;
    _zz_117[13] = _zz_116;
    _zz_117[12] = _zz_116;
    _zz_117[11] = _zz_116;
    _zz_117[10] = _zz_116;
    _zz_117[9] = _zz_116;
    _zz_117[8] = _zz_116;
    _zz_117[7] = _zz_116;
    _zz_117[6] = _zz_116;
    _zz_117[5] = _zz_116;
    _zz_117[4] = _zz_116;
    _zz_117[3] = _zz_116;
    _zz_117[2] = _zz_116;
    _zz_117[1] = _zz_116;
    _zz_117[0] = _zz_116;
  end

  assign _zz_118 = _zz_249[11];
  always @ (*) begin
    _zz_119[19] = _zz_118;
    _zz_119[18] = _zz_118;
    _zz_119[17] = _zz_118;
    _zz_119[16] = _zz_118;
    _zz_119[15] = _zz_118;
    _zz_119[14] = _zz_118;
    _zz_119[13] = _zz_118;
    _zz_119[12] = _zz_118;
    _zz_119[11] = _zz_118;
    _zz_119[10] = _zz_118;
    _zz_119[9] = _zz_118;
    _zz_119[8] = _zz_118;
    _zz_119[7] = _zz_118;
    _zz_119[6] = _zz_118;
    _zz_119[5] = _zz_118;
    _zz_119[4] = _zz_118;
    _zz_119[3] = _zz_118;
    _zz_119[2] = _zz_118;
    _zz_119[1] = _zz_118;
    _zz_119[0] = _zz_118;
  end

  always @ (*) begin
    case(decode_SRC2_CTRL)
      `Src2CtrlEnum_defaultEncoding_RS : begin
        _zz_120 = _zz_24;
      end
      `Src2CtrlEnum_defaultEncoding_IMI : begin
        _zz_120 = {_zz_117,decode_INSTRUCTION[31 : 20]};
      end
      `Src2CtrlEnum_defaultEncoding_IMS : begin
        _zz_120 = {_zz_119,{decode_INSTRUCTION[31 : 25],decode_INSTRUCTION[11 : 7]}};
      end
      default : begin
        _zz_120 = _zz_23;
      end
    endcase
  end

  always @ (*) begin
    execute_SrcPlugin_addSub = _zz_250;
    if(execute_SRC2_FORCE_ZERO)begin
      execute_SrcPlugin_addSub = execute_SRC1;
    end
  end

  assign execute_SrcPlugin_less = ((execute_SRC1[31] == execute_SRC2[31]) ? execute_SrcPlugin_addSub[31] : (execute_SRC_LESS_UNSIGNED ? execute_SRC2[31] : execute_SRC1[31]));
  assign execute_MulPlugin_a = execute_RS1;
  assign execute_MulPlugin_b = execute_RS2;
  always @ (*) begin
    case(_zz_180)
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
    case(_zz_180)
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
  assign writeBack_MulPlugin_result = ($signed(_zz_257) + $signed(_zz_258));
  assign memory_DivPlugin_frontendOk = 1'b1;
  always @ (*) begin
    memory_DivPlugin_div_counter_willIncrement = 1'b0;
    if(_zz_166)begin
      if(_zz_181)begin
        memory_DivPlugin_div_counter_willIncrement = 1'b1;
      end
    end
  end

  always @ (*) begin
    memory_DivPlugin_div_counter_willClear = 1'b0;
    if(_zz_182)begin
      memory_DivPlugin_div_counter_willClear = 1'b1;
    end
  end

  assign memory_DivPlugin_div_counter_willOverflowIfInc = (memory_DivPlugin_div_counter_value == 6'h21);
  assign memory_DivPlugin_div_counter_willOverflow = (memory_DivPlugin_div_counter_willOverflowIfInc && memory_DivPlugin_div_counter_willIncrement);
  always @ (*) begin
    if(memory_DivPlugin_div_counter_willOverflow)begin
      memory_DivPlugin_div_counter_valueNext = 6'h0;
    end else begin
      memory_DivPlugin_div_counter_valueNext = (memory_DivPlugin_div_counter_value + _zz_262);
    end
    if(memory_DivPlugin_div_counter_willClear)begin
      memory_DivPlugin_div_counter_valueNext = 6'h0;
    end
  end

  assign _zz_121 = memory_DivPlugin_rs1[31 : 0];
  assign memory_DivPlugin_div_stage_0_remainderShifted = {memory_DivPlugin_accumulator[31 : 0],_zz_121[31]};
  assign memory_DivPlugin_div_stage_0_remainderMinusDenominator = (memory_DivPlugin_div_stage_0_remainderShifted - _zz_263);
  assign memory_DivPlugin_div_stage_0_outRemainder = ((! memory_DivPlugin_div_stage_0_remainderMinusDenominator[32]) ? _zz_264 : _zz_265);
  assign memory_DivPlugin_div_stage_0_outNumerator = _zz_266[31:0];
  assign _zz_122 = (memory_INSTRUCTION[13] ? memory_DivPlugin_accumulator[31 : 0] : memory_DivPlugin_rs1[31 : 0]);
  assign _zz_123 = (execute_RS2[31] && execute_IS_RS2_SIGNED);
  assign _zz_124 = (1'b0 || ((execute_IS_DIV && execute_RS1[31]) && execute_IS_RS1_SIGNED));
  always @ (*) begin
    _zz_125[32] = (execute_IS_RS1_SIGNED && execute_RS1[31]);
    _zz_125[31 : 0] = execute_RS1;
  end

  assign execute_LightShifterPlugin_isShift = (execute_SHIFT_CTRL != `ShiftCtrlEnum_defaultEncoding_DISABLE_1);
  assign execute_LightShifterPlugin_amplitude = (execute_LightShifterPlugin_isActive ? execute_LightShifterPlugin_amplitudeReg : execute_SRC2[4 : 0]);
  assign execute_LightShifterPlugin_shiftInput = (execute_LightShifterPlugin_isActive ? memory_REGFILE_WRITE_DATA : execute_SRC1);
  assign execute_LightShifterPlugin_done = (execute_LightShifterPlugin_amplitude[4 : 1] == 4'b0000);
  always @ (*) begin
    case(execute_SHIFT_CTRL)
      `ShiftCtrlEnum_defaultEncoding_SLL_1 : begin
        _zz_126 = (execute_LightShifterPlugin_shiftInput <<< 1);
      end
      default : begin
        _zz_126 = _zz_276;
      end
    endcase
  end

  always @ (*) begin
    _zz_127 = 1'b0;
    if(_zz_129)begin
      if((_zz_130 == decode_INSTRUCTION[19 : 15]))begin
        _zz_127 = 1'b1;
      end
    end
    if(_zz_183)begin
      if(_zz_184)begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_127 = 1'b1;
        end
      end
    end
    if(_zz_185)begin
      if(_zz_186)begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_127 = 1'b1;
        end
      end
    end
    if(_zz_187)begin
      if(_zz_188)begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[19 : 15]))begin
          _zz_127 = 1'b1;
        end
      end
    end
    if((! decode_RS1_USE))begin
      _zz_127 = 1'b0;
    end
  end

  always @ (*) begin
    _zz_128 = 1'b0;
    if(_zz_129)begin
      if((_zz_130 == decode_INSTRUCTION[24 : 20]))begin
        _zz_128 = 1'b1;
      end
    end
    if(_zz_183)begin
      if(_zz_184)begin
        if((writeBack_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_128 = 1'b1;
        end
      end
    end
    if(_zz_185)begin
      if(_zz_186)begin
        if((memory_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_128 = 1'b1;
        end
      end
    end
    if(_zz_187)begin
      if(_zz_188)begin
        if((execute_INSTRUCTION[11 : 7] == decode_INSTRUCTION[24 : 20]))begin
          _zz_128 = 1'b1;
        end
      end
    end
    if((! decode_RS2_USE))begin
      _zz_128 = 1'b0;
    end
  end

  assign execute_BranchPlugin_eq = (execute_SRC1 == execute_SRC2);
  assign _zz_131 = execute_INSTRUCTION[14 : 12];
  always @ (*) begin
    if((_zz_131 == 3'b000)) begin
        _zz_132 = execute_BranchPlugin_eq;
    end else if((_zz_131 == 3'b001)) begin
        _zz_132 = (! execute_BranchPlugin_eq);
    end else if((((_zz_131 & 3'b101) == 3'b101))) begin
        _zz_132 = (! execute_SRC_LESS);
    end else begin
        _zz_132 = execute_SRC_LESS;
    end
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_INC : begin
        _zz_133 = 1'b0;
      end
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_133 = 1'b1;
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_133 = 1'b1;
      end
      default : begin
        _zz_133 = _zz_132;
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src1 = ((execute_BRANCH_CTRL == `BranchCtrlEnum_defaultEncoding_JALR) ? execute_RS1 : execute_PC);
  assign _zz_134 = _zz_278[19];
  always @ (*) begin
    _zz_135[10] = _zz_134;
    _zz_135[9] = _zz_134;
    _zz_135[8] = _zz_134;
    _zz_135[7] = _zz_134;
    _zz_135[6] = _zz_134;
    _zz_135[5] = _zz_134;
    _zz_135[4] = _zz_134;
    _zz_135[3] = _zz_134;
    _zz_135[2] = _zz_134;
    _zz_135[1] = _zz_134;
    _zz_135[0] = _zz_134;
  end

  assign _zz_136 = _zz_279[11];
  always @ (*) begin
    _zz_137[19] = _zz_136;
    _zz_137[18] = _zz_136;
    _zz_137[17] = _zz_136;
    _zz_137[16] = _zz_136;
    _zz_137[15] = _zz_136;
    _zz_137[14] = _zz_136;
    _zz_137[13] = _zz_136;
    _zz_137[12] = _zz_136;
    _zz_137[11] = _zz_136;
    _zz_137[10] = _zz_136;
    _zz_137[9] = _zz_136;
    _zz_137[8] = _zz_136;
    _zz_137[7] = _zz_136;
    _zz_137[6] = _zz_136;
    _zz_137[5] = _zz_136;
    _zz_137[4] = _zz_136;
    _zz_137[3] = _zz_136;
    _zz_137[2] = _zz_136;
    _zz_137[1] = _zz_136;
    _zz_137[0] = _zz_136;
  end

  assign _zz_138 = _zz_280[11];
  always @ (*) begin
    _zz_139[18] = _zz_138;
    _zz_139[17] = _zz_138;
    _zz_139[16] = _zz_138;
    _zz_139[15] = _zz_138;
    _zz_139[14] = _zz_138;
    _zz_139[13] = _zz_138;
    _zz_139[12] = _zz_138;
    _zz_139[11] = _zz_138;
    _zz_139[10] = _zz_138;
    _zz_139[9] = _zz_138;
    _zz_139[8] = _zz_138;
    _zz_139[7] = _zz_138;
    _zz_139[6] = _zz_138;
    _zz_139[5] = _zz_138;
    _zz_139[4] = _zz_138;
    _zz_139[3] = _zz_138;
    _zz_139[2] = _zz_138;
    _zz_139[1] = _zz_138;
    _zz_139[0] = _zz_138;
  end

  always @ (*) begin
    case(execute_BRANCH_CTRL)
      `BranchCtrlEnum_defaultEncoding_JAL : begin
        _zz_140 = {{_zz_135,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[19 : 12]},execute_INSTRUCTION[20]},execute_INSTRUCTION[30 : 21]}},1'b0};
      end
      `BranchCtrlEnum_defaultEncoding_JALR : begin
        _zz_140 = {_zz_137,execute_INSTRUCTION[31 : 20]};
      end
      default : begin
        _zz_140 = {{_zz_139,{{{execute_INSTRUCTION[31],execute_INSTRUCTION[7]},execute_INSTRUCTION[30 : 25]},execute_INSTRUCTION[11 : 8]}},1'b0};
      end
    endcase
  end

  assign execute_BranchPlugin_branch_src2 = _zz_140;
  assign execute_BranchPlugin_branchAdder = (execute_BranchPlugin_branch_src1 + execute_BranchPlugin_branch_src2);
  assign BranchPlugin_jumpInterface_valid = ((memory_arbitration_isValid && memory_BRANCH_DO) && (! 1'b0));
  assign BranchPlugin_jumpInterface_payload = memory_BRANCH_CALC;
  always @ (*) begin
    debug_bus_cmd_ready = 1'b1;
    if(debug_bus_cmd_valid)begin
      case(_zz_189)
        6'h01 : begin
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
    if((! _zz_141))begin
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
      case(_zz_189)
        6'h01 : begin
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
  assign DebugPlugin_allowEBreak = (CsrPlugin_privilege == 2'b11);
  assign debug_resetOut = DebugPlugin_resetIt_regNext;
  assign _zz_27 = _zz_39;
  assign _zz_25 = _zz_38;
  assign _zz_19 = decode_ENV_CTRL;
  assign _zz_16 = execute_ENV_CTRL;
  assign _zz_14 = memory_ENV_CTRL;
  assign _zz_17 = _zz_37;
  assign _zz_42 = decode_to_execute_ENV_CTRL;
  assign _zz_41 = execute_to_memory_ENV_CTRL;
  assign _zz_43 = memory_to_writeBack_ENV_CTRL;
  assign _zz_12 = decode_ALU_CTRL;
  assign _zz_10 = _zz_36;
  assign _zz_28 = decode_to_execute_ALU_CTRL;
  assign _zz_9 = decode_ALU_BITWISE_CTRL;
  assign _zz_7 = _zz_35;
  assign _zz_29 = decode_to_execute_ALU_BITWISE_CTRL;
  assign _zz_6 = decode_SHIFT_CTRL;
  assign _zz_4 = _zz_34;
  assign _zz_21 = decode_to_execute_SHIFT_CTRL;
  assign _zz_3 = decode_BRANCH_CTRL;
  assign _zz_1 = _zz_33;
  assign _zz_20 = decode_to_execute_BRANCH_CTRL;
  assign decode_arbitration_isFlushed = (({writeBack_arbitration_flushNext,{memory_arbitration_flushNext,execute_arbitration_flushNext}} != 3'b000) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,{execute_arbitration_flushIt,decode_arbitration_flushIt}}} != 4'b0000));
  assign execute_arbitration_isFlushed = (({writeBack_arbitration_flushNext,memory_arbitration_flushNext} != 2'b00) || ({writeBack_arbitration_flushIt,{memory_arbitration_flushIt,execute_arbitration_flushIt}} != 3'b000));
  assign memory_arbitration_isFlushed = ((writeBack_arbitration_flushNext != 1'b0) || ({writeBack_arbitration_flushIt,memory_arbitration_flushIt} != 2'b00));
  assign writeBack_arbitration_isFlushed = (1'b0 || (writeBack_arbitration_flushIt != 1'b0));
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
    case(_zz_143)
      3'b100 : begin
        IBusSimplePlugin_injectionPort_ready = 1'b1;
      end
      default : begin
      end
    endcase
  end

  always @ (*) begin
    _zz_144 = 32'h0;
    if(execute_CsrPlugin_csr_3857)begin
      _zz_144[3 : 0] = 4'b1011;
    end
  end

  always @ (*) begin
    _zz_145 = 32'h0;
    if(execute_CsrPlugin_csr_3858)begin
      _zz_145[4 : 0] = 5'h16;
    end
  end

  always @ (*) begin
    _zz_146 = 32'h0;
    if(execute_CsrPlugin_csr_3859)begin
      _zz_146[5 : 0] = 6'h21;
    end
  end

  always @ (*) begin
    _zz_147 = 32'h0;
    if(execute_CsrPlugin_csr_769)begin
      _zz_147[31 : 30] = CsrPlugin_misa_base;
      _zz_147[25 : 0] = CsrPlugin_misa_extensions;
    end
  end

  always @ (*) begin
    _zz_148 = 32'h0;
    if(execute_CsrPlugin_csr_768)begin
      _zz_148[12 : 11] = CsrPlugin_mstatus_MPP;
      _zz_148[7 : 7] = CsrPlugin_mstatus_MPIE;
      _zz_148[3 : 3] = CsrPlugin_mstatus_MIE;
    end
  end

  always @ (*) begin
    _zz_149 = 32'h0;
    if(execute_CsrPlugin_csr_836)begin
      _zz_149[11 : 11] = CsrPlugin_mip_MEIP;
      _zz_149[7 : 7] = CsrPlugin_mip_MTIP;
      _zz_149[3 : 3] = CsrPlugin_mip_MSIP;
    end
  end

  always @ (*) begin
    _zz_150 = 32'h0;
    if(execute_CsrPlugin_csr_772)begin
      _zz_150[11 : 11] = CsrPlugin_mie_MEIE;
      _zz_150[7 : 7] = CsrPlugin_mie_MTIE;
      _zz_150[3 : 3] = CsrPlugin_mie_MSIE;
    end
  end

  always @ (*) begin
    _zz_151 = 32'h0;
    if(execute_CsrPlugin_csr_773)begin
      _zz_151[31 : 2] = CsrPlugin_mtvec_base;
      _zz_151[1 : 0] = CsrPlugin_mtvec_mode;
    end
  end

  always @ (*) begin
    _zz_152 = 32'h0;
    if(execute_CsrPlugin_csr_833)begin
      _zz_152[31 : 0] = CsrPlugin_mepc;
    end
  end

  always @ (*) begin
    _zz_153 = 32'h0;
    if(execute_CsrPlugin_csr_832)begin
      _zz_153[31 : 0] = CsrPlugin_mscratch;
    end
  end

  always @ (*) begin
    _zz_154 = 32'h0;
    if(execute_CsrPlugin_csr_834)begin
      _zz_154[31 : 31] = CsrPlugin_mcause_interrupt;
      _zz_154[3 : 0] = CsrPlugin_mcause_exceptionCode;
    end
  end

  always @ (*) begin
    _zz_155 = 32'h0;
    if(execute_CsrPlugin_csr_835)begin
      _zz_155[31 : 0] = CsrPlugin_mtval;
    end
  end

  always @ (*) begin
    _zz_156 = 32'h0;
    if(execute_CsrPlugin_csr_2816)begin
      _zz_156[31 : 0] = CsrPlugin_mcycle[31 : 0];
    end
  end

  always @ (*) begin
    _zz_157 = 32'h0;
    if(execute_CsrPlugin_csr_2944)begin
      _zz_157[31 : 0] = CsrPlugin_mcycle[63 : 32];
    end
  end

  always @ (*) begin
    _zz_158 = 32'h0;
    if(execute_CsrPlugin_csr_2818)begin
      _zz_158[31 : 0] = CsrPlugin_minstret[31 : 0];
    end
  end

  always @ (*) begin
    _zz_159 = 32'h0;
    if(execute_CsrPlugin_csr_2946)begin
      _zz_159[31 : 0] = CsrPlugin_minstret[63 : 32];
    end
  end

  always @ (*) begin
    _zz_160 = 32'h0;
    if(execute_CsrPlugin_csr_3072)begin
      _zz_160[31 : 0] = CsrPlugin_mcycle[31 : 0];
    end
  end

  always @ (*) begin
    _zz_161 = 32'h0;
    if(execute_CsrPlugin_csr_3200)begin
      _zz_161[31 : 0] = CsrPlugin_mcycle[63 : 32];
    end
  end

  assign execute_CsrPlugin_readData = (((((_zz_144 | _zz_145) | (_zz_146 | _zz_445)) | ((_zz_147 | _zz_148) | (_zz_149 | _zz_150))) | (((_zz_151 | _zz_152) | (_zz_153 | _zz_154)) | ((_zz_155 | _zz_156) | (_zz_157 | _zz_158)))) | ((_zz_159 | _zz_160) | _zz_161));
  assign _zz_163 = 1'b0;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      IBusSimplePlugin_fetchPc_pcReg <= 32'h80000000;
      IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      IBusSimplePlugin_fetchPc_booted <= 1'b0;
      IBusSimplePlugin_fetchPc_inc <= 1'b0;
      IBusSimplePlugin_decodePc_pcReg <= 32'h80000000;
      _zz_52 <= 1'b0;
      _zz_54 <= 1'b0;
      IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      IBusSimplePlugin_decompressor_throw2BytesReg <= 1'b0;
      _zz_83 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      IBusSimplePlugin_pending_value <= 3'b000;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= 3'b000;
      CsrPlugin_misa_base <= 2'b01;
      CsrPlugin_misa_extensions <= 26'h0000042;
      CsrPlugin_mtvec_mode <= 2'b00;
      CsrPlugin_mtvec_base <= 30'h00000008;
      CsrPlugin_mstatus_MIE <= 1'b0;
      CsrPlugin_mstatus_MPIE <= 1'b0;
      CsrPlugin_mstatus_MPP <= 2'b11;
      CsrPlugin_mie_MEIE <= 1'b0;
      CsrPlugin_mie_MTIE <= 1'b0;
      CsrPlugin_mie_MSIE <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_execute <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_memory <= 1'b0;
      CsrPlugin_exceptionPortCtrl_exceptionValidsRegs_writeBack <= 1'b0;
      CsrPlugin_interrupt_valid <= 1'b0;
      CsrPlugin_lastStageWasWfi <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
      CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      CsrPlugin_hadException <= 1'b0;
      execute_CsrPlugin_wfiWake <= 1'b0;
      _zz_113 <= 1'b1;
      memory_DivPlugin_div_counter_value <= 6'h0;
      execute_LightShifterPlugin_isActive <= 1'b0;
      _zz_129 <= 1'b0;
      execute_arbitration_isValid <= 1'b0;
      memory_arbitration_isValid <= 1'b0;
      writeBack_arbitration_isValid <= 1'b0;
      _zz_143 <= 3'b000;
      memory_to_writeBack_REGFILE_WRITE_DATA <= 32'h0;
      memory_to_writeBack_INSTRUCTION <= 32'h0;
    end else begin
      if(IBusSimplePlugin_fetchPc_correction)begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b1;
      end
      if((IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_correctionReg <= 1'b0;
      end
      IBusSimplePlugin_fetchPc_booted <= 1'b1;
      if((IBusSimplePlugin_fetchPc_correction || IBusSimplePlugin_fetchPc_pcRegPropagate))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusSimplePlugin_fetchPc_output_valid && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b1;
      end
      if(((! IBusSimplePlugin_fetchPc_output_valid) && IBusSimplePlugin_fetchPc_output_ready))begin
        IBusSimplePlugin_fetchPc_inc <= 1'b0;
      end
      if((IBusSimplePlugin_fetchPc_booted && ((IBusSimplePlugin_fetchPc_output_ready || IBusSimplePlugin_fetchPc_correction) || IBusSimplePlugin_fetchPc_pcRegPropagate)))begin
        IBusSimplePlugin_fetchPc_pcReg <= IBusSimplePlugin_fetchPc_pc;
      end
      if((decode_arbitration_isFiring && (! IBusSimplePlugin_decodePc_injectedDecode)))begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_decodePc_pcPlus;
      end
      if(_zz_176)begin
        IBusSimplePlugin_decodePc_pcReg <= IBusSimplePlugin_jump_pcLoad_payload;
      end
      if(IBusSimplePlugin_iBusRsp_flush)begin
        _zz_52 <= 1'b0;
      end
      if(_zz_50)begin
        _zz_52 <= (IBusSimplePlugin_iBusRsp_stages_0_output_valid && (! 1'b0));
      end
      if(IBusSimplePlugin_iBusRsp_flush)begin
        _zz_54 <= 1'b0;
      end
      if(IBusSimplePlugin_iBusRsp_stages_1_output_ready)begin
        _zz_54 <= (IBusSimplePlugin_iBusRsp_stages_1_output_valid && (! IBusSimplePlugin_iBusRsp_flush));
      end
      if((IBusSimplePlugin_decompressor_output_valid && IBusSimplePlugin_decompressor_output_ready))begin
        IBusSimplePlugin_decompressor_throw2BytesReg <= ((((! IBusSimplePlugin_decompressor_unaligned) && IBusSimplePlugin_decompressor_isInputLowRvc) && IBusSimplePlugin_decompressor_isInputHighRvc) || (IBusSimplePlugin_decompressor_bufferValid && IBusSimplePlugin_decompressor_isInputHighRvc));
      end
      if((IBusSimplePlugin_decompressor_output_ready && IBusSimplePlugin_decompressor_input_valid))begin
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(_zz_190)begin
        if(IBusSimplePlugin_decompressor_bufferFill)begin
          IBusSimplePlugin_decompressor_bufferValid <= 1'b1;
        end
      end
      if((IBusSimplePlugin_externalFlush || IBusSimplePlugin_decompressor_consumeCurrent))begin
        IBusSimplePlugin_decompressor_throw2BytesReg <= 1'b0;
        IBusSimplePlugin_decompressor_bufferValid <= 1'b0;
      end
      if(decode_arbitration_removeIt)begin
        _zz_83 <= 1'b0;
      end
      if(IBusSimplePlugin_decompressor_output_ready)begin
        _zz_83 <= (IBusSimplePlugin_decompressor_output_valid && (! IBusSimplePlugin_externalFlush));
      end
      if((! 1'b0))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b1;
      end
      if(IBusSimplePlugin_decodePc_flushed)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_0 <= 1'b0;
      end
      if((! execute_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= IBusSimplePlugin_injector_nextPcCalc_valids_0;
      end
      if(IBusSimplePlugin_decodePc_flushed)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_1 <= 1'b0;
      end
      if((! memory_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= IBusSimplePlugin_injector_nextPcCalc_valids_1;
      end
      if(IBusSimplePlugin_decodePc_flushed)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_2 <= 1'b0;
      end
      if((! writeBack_arbitration_isStuck))begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= IBusSimplePlugin_injector_nextPcCalc_valids_2;
      end
      if(IBusSimplePlugin_decodePc_flushed)begin
        IBusSimplePlugin_injector_nextPcCalc_valids_3 <= 1'b0;
      end
      IBusSimplePlugin_pending_value <= IBusSimplePlugin_pending_next;
      IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= (IBusSimplePlugin_rspJoin_rspBuffer_discardCounter - _zz_244);
      if(IBusSimplePlugin_iBusRsp_flush)begin
        IBusSimplePlugin_rspJoin_rspBuffer_discardCounter <= IBusSimplePlugin_pending_next;
      end
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck)))
        `else
          if(!(! (((dBus_rsp_ready && memory_MEMORY_ENABLE) && memory_arbitration_isValid) && memory_arbitration_isStuck))) begin
            $display("FAILURE DBusSimplePlugin doesn't allow memory stage stall when read happend");
            $finish;
          end
        `endif
      `endif
      `ifndef SYNTHESIS
        `ifdef FORMAL
          assert((! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck)))
        `else
          if(!(! (((writeBack_arbitration_isValid && writeBack_MEMORY_ENABLE) && (! writeBack_MEMORY_STORE)) && writeBack_arbitration_isStuck))) begin
            $display("FAILURE DBusSimplePlugin doesn't allow writeback stage stall when read happend");
            $finish;
          end
        `endif
      `endif
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
      if(_zz_191)begin
        if(_zz_192)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_193)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
        if(_zz_194)begin
          CsrPlugin_interrupt_valid <= 1'b1;
        end
      end
      CsrPlugin_lastStageWasWfi <= (writeBack_arbitration_isFiring && (writeBack_ENV_CTRL == `EnvCtrlEnum_defaultEncoding_WFI));
      if(CsrPlugin_pipelineLiberator_active)begin
        if((! execute_arbitration_isStuck))begin
          CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b1;
        end
        if((! memory_arbitration_isStuck))begin
          CsrPlugin_pipelineLiberator_pcValids_1 <= CsrPlugin_pipelineLiberator_pcValids_0;
        end
        if((! writeBack_arbitration_isStuck))begin
          CsrPlugin_pipelineLiberator_pcValids_2 <= CsrPlugin_pipelineLiberator_pcValids_1;
        end
      end
      if(((! CsrPlugin_pipelineLiberator_active) || decode_arbitration_removeIt))begin
        CsrPlugin_pipelineLiberator_pcValids_0 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_1 <= 1'b0;
        CsrPlugin_pipelineLiberator_pcValids_2 <= 1'b0;
      end
      if(CsrPlugin_interruptJump)begin
        CsrPlugin_interrupt_valid <= 1'b0;
      end
      CsrPlugin_hadException <= CsrPlugin_exception;
      if(_zz_172)begin
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
      if(_zz_173)begin
        case(_zz_175)
          2'b11 : begin
            CsrPlugin_mstatus_MPP <= 2'b00;
            CsrPlugin_mstatus_MIE <= CsrPlugin_mstatus_MPIE;
            CsrPlugin_mstatus_MPIE <= 1'b1;
          end
          default : begin
          end
        endcase
      end
      execute_CsrPlugin_wfiWake <= (({_zz_98,{_zz_97,_zz_96}} != 3'b000) || CsrPlugin_thirdPartyWake);
      _zz_113 <= 1'b0;
      memory_DivPlugin_div_counter_value <= memory_DivPlugin_div_counter_valueNext;
      if(_zz_168)begin
        if(_zz_195)begin
          execute_LightShifterPlugin_isActive <= 1'b1;
          if(execute_LightShifterPlugin_done)begin
            execute_LightShifterPlugin_isActive <= 1'b0;
          end
        end
      end
      if(execute_arbitration_removeIt)begin
        execute_LightShifterPlugin_isActive <= 1'b0;
      end
      _zz_129 <= (_zz_31 && writeBack_arbitration_isFiring);
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_INSTRUCTION <= memory_INSTRUCTION;
      end
      if((! writeBack_arbitration_isStuck))begin
        memory_to_writeBack_REGFILE_WRITE_DATA <= _zz_22;
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
      case(_zz_143)
        3'b000 : begin
          if(IBusSimplePlugin_injectionPort_valid)begin
            _zz_143 <= 3'b001;
          end
        end
        3'b001 : begin
          _zz_143 <= 3'b010;
        end
        3'b010 : begin
          _zz_143 <= 3'b011;
        end
        3'b011 : begin
          if((! decode_arbitration_isStuck))begin
            _zz_143 <= 3'b100;
          end
        end
        3'b100 : begin
          _zz_143 <= 3'b000;
        end
        default : begin
        end
      endcase
      if(execute_CsrPlugin_csr_769)begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_misa_base <= execute_CsrPlugin_writeData[31 : 30];
          CsrPlugin_misa_extensions <= execute_CsrPlugin_writeData[25 : 0];
        end
      end
      if(execute_CsrPlugin_csr_768)begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mstatus_MPP <= execute_CsrPlugin_writeData[12 : 11];
          CsrPlugin_mstatus_MPIE <= _zz_281[0];
          CsrPlugin_mstatus_MIE <= _zz_282[0];
        end
      end
      if(execute_CsrPlugin_csr_772)begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mie_MEIE <= _zz_284[0];
          CsrPlugin_mie_MTIE <= _zz_285[0];
          CsrPlugin_mie_MSIE <= _zz_286[0];
        end
      end
      if(execute_CsrPlugin_csr_773)begin
        if(execute_CsrPlugin_writeEnable)begin
          CsrPlugin_mtvec_base <= execute_CsrPlugin_writeData[31 : 2];
          CsrPlugin_mtvec_mode <= execute_CsrPlugin_writeData[1 : 0];
        end
      end
    end
  end

  always @ (posedge io_mainClk) begin
    if(IBusSimplePlugin_iBusRsp_stages_1_output_ready)begin
      _zz_55 <= IBusSimplePlugin_iBusRsp_stages_1_output_payload;
    end
    if(_zz_190)begin
      IBusSimplePlugin_decompressor_bufferData <= IBusSimplePlugin_decompressor_input_payload_rsp_inst[31 : 16];
    end
    if(IBusSimplePlugin_decompressor_output_ready)begin
      _zz_84 <= IBusSimplePlugin_decompressor_output_payload_pc;
      _zz_85 <= IBusSimplePlugin_decompressor_output_payload_rsp_error;
      _zz_86 <= IBusSimplePlugin_decompressor_output_payload_rsp_inst;
      _zz_87 <= IBusSimplePlugin_decompressor_output_payload_isRvc;
    end
    if(IBusSimplePlugin_injector_decodeInput_ready)begin
      IBusSimplePlugin_injector_formal_rawInDecode <= IBusSimplePlugin_decompressor_raw;
    end
    CsrPlugin_mip_MEIP <= externalInterrupt;
    CsrPlugin_mip_MTIP <= timerInterrupt;
    CsrPlugin_mip_MSIP <= softwareInterrupt;
    CsrPlugin_mcycle <= (CsrPlugin_mcycle + 64'h0000000000000001);
    if(writeBack_arbitration_isFiring)begin
      CsrPlugin_minstret <= (CsrPlugin_minstret + 64'h0000000000000001);
    end
    if(CsrPlugin_selfException_valid)begin
      CsrPlugin_exceptionPortCtrl_exceptionContext_code <= CsrPlugin_selfException_payload_code;
      CsrPlugin_exceptionPortCtrl_exceptionContext_badAddr <= CsrPlugin_selfException_payload_badAddr;
    end
    if(_zz_191)begin
      if(_zz_192)begin
        CsrPlugin_interrupt_code <= 4'b0111;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(_zz_193)begin
        CsrPlugin_interrupt_code <= 4'b0011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
      if(_zz_194)begin
        CsrPlugin_interrupt_code <= 4'b1011;
        CsrPlugin_interrupt_targetPrivilege <= 2'b11;
      end
    end
    if(_zz_172)begin
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
    if((memory_DivPlugin_div_counter_value == 6'h20))begin
      memory_DivPlugin_div_done <= 1'b1;
    end
    if((! memory_arbitration_isStuck))begin
      memory_DivPlugin_div_done <= 1'b0;
    end
    if(_zz_166)begin
      if(_zz_181)begin
        memory_DivPlugin_rs1[31 : 0] <= memory_DivPlugin_div_stage_0_outNumerator;
        memory_DivPlugin_accumulator[31 : 0] <= memory_DivPlugin_div_stage_0_outRemainder;
        if((memory_DivPlugin_div_counter_value == 6'h20))begin
          memory_DivPlugin_div_result <= _zz_267[31:0];
        end
      end
    end
    if(_zz_182)begin
      memory_DivPlugin_accumulator <= 65'h0;
      memory_DivPlugin_rs1 <= ((_zz_124 ? (~ _zz_125) : _zz_125) + _zz_273);
      memory_DivPlugin_rs2 <= ((_zz_123 ? (~ execute_RS2) : execute_RS2) + _zz_275);
      memory_DivPlugin_div_needRevert <= ((_zz_124 ^ (_zz_123 && (! execute_INSTRUCTION[13]))) && (! (((execute_RS2 == 32'h0) && execute_IS_RS2_SIGNED) && (! execute_INSTRUCTION[13]))));
    end
    if(_zz_168)begin
      if(_zz_195)begin
        execute_LightShifterPlugin_amplitudeReg <= (execute_LightShifterPlugin_amplitude - 5'h01);
      end
    end
    _zz_130 <= _zz_30[11 : 7];
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_PC <= _zz_23;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_PC <= execute_PC;
    end
    if(((! writeBack_arbitration_isStuck) && (! CsrPlugin_exceptionPortCtrl_exceptionValids_writeBack)))begin
      memory_to_writeBack_PC <= memory_PC;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_INSTRUCTION <= decode_INSTRUCTION;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_INSTRUCTION <= execute_INSTRUCTION;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_FORMAL_PC_NEXT <= decode_FORMAL_PC_NEXT;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_FORMAL_PC_NEXT <= execute_FORMAL_PC_NEXT;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_FORMAL_PC_NEXT <= _zz_45;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_WRITE_OPCODE <= decode_CSR_WRITE_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_CSR_READ_OPCODE <= decode_CSR_READ_OPCODE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_USE_SUB_LESS <= decode_SRC_USE_SUB_LESS;
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
      decode_to_execute_REGFILE_WRITE_VALID <= decode_REGFILE_WRITE_VALID;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_REGFILE_WRITE_VALID <= execute_REGFILE_WRITE_VALID;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_REGFILE_WRITE_VALID <= memory_REGFILE_WRITE_VALID;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_EXECUTE_STAGE <= decode_BYPASSABLE_EXECUTE_STAGE;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BYPASSABLE_MEMORY_STAGE <= decode_BYPASSABLE_MEMORY_STAGE;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BYPASSABLE_MEMORY_STAGE <= execute_BYPASSABLE_MEMORY_STAGE;
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
      decode_to_execute_IS_CSR <= decode_IS_CSR;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ENV_CTRL <= _zz_18;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_ENV_CTRL <= _zz_15;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_ENV_CTRL <= _zz_13;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_CTRL <= _zz_11;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC_LESS_UNSIGNED <= decode_SRC_LESS_UNSIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_ALU_BITWISE_CTRL <= _zz_8;
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
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_DIV <= decode_IS_DIV;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_IS_DIV <= execute_IS_DIV;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS1_SIGNED <= decode_IS_RS1_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_IS_RS2_SIGNED <= decode_IS_RS2_SIGNED;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SHIFT_CTRL <= _zz_5;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_BRANCH_CTRL <= _zz_2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS1 <= _zz_26;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_RS2 <= _zz_24;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2_FORCE_ZERO <= decode_SRC2_FORCE_ZERO;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC1 <= decode_SRC1;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_SRC2 <= decode_SRC2;
    end
    if((! execute_arbitration_isStuck))begin
      decode_to_execute_DO_EBREAK <= decode_DO_EBREAK;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MEMORY_ADDRESS_LOW <= execute_MEMORY_ADDRESS_LOW;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_ADDRESS_LOW <= memory_MEMORY_ADDRESS_LOW;
    end
    if(((! memory_arbitration_isStuck) && (! execute_arbitration_isStuckByOthers)))begin
      execute_to_memory_REGFILE_WRITE_DATA <= _zz_40;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LL <= execute_MUL_LL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_LH <= execute_MUL_LH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HL <= execute_MUL_HL;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_MUL_HH <= execute_MUL_HH;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_HH <= memory_MUL_HH;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_DO <= execute_BRANCH_DO;
    end
    if((! memory_arbitration_isStuck))begin
      execute_to_memory_BRANCH_CALC <= execute_BRANCH_CALC;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MEMORY_READ_DATA <= memory_MEMORY_READ_DATA;
    end
    if((! writeBack_arbitration_isStuck))begin
      memory_to_writeBack_MUL_LOW <= memory_MUL_LOW;
    end
    if((_zz_143 != 3'b000))begin
      _zz_86 <= IBusSimplePlugin_injectionPort_payload;
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_3857 <= (decode_INSTRUCTION[31 : 20] == 12'hf11);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_3858 <= (decode_INSTRUCTION[31 : 20] == 12'hf12);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_3859 <= (decode_INSTRUCTION[31 : 20] == 12'hf13);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_3860 <= (decode_INSTRUCTION[31 : 20] == 12'hf14);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_769 <= (decode_INSTRUCTION[31 : 20] == 12'h301);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_768 <= (decode_INSTRUCTION[31 : 20] == 12'h300);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_836 <= (decode_INSTRUCTION[31 : 20] == 12'h344);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_772 <= (decode_INSTRUCTION[31 : 20] == 12'h304);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_773 <= (decode_INSTRUCTION[31 : 20] == 12'h305);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_833 <= (decode_INSTRUCTION[31 : 20] == 12'h341);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_832 <= (decode_INSTRUCTION[31 : 20] == 12'h340);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_834 <= (decode_INSTRUCTION[31 : 20] == 12'h342);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_835 <= (decode_INSTRUCTION[31 : 20] == 12'h343);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_2816 <= (decode_INSTRUCTION[31 : 20] == 12'hb00);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_2944 <= (decode_INSTRUCTION[31 : 20] == 12'hb80);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_2818 <= (decode_INSTRUCTION[31 : 20] == 12'hb02);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_2946 <= (decode_INSTRUCTION[31 : 20] == 12'hb82);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_3072 <= (decode_INSTRUCTION[31 : 20] == 12'hc00);
    end
    if((! execute_arbitration_isStuck))begin
      execute_CsrPlugin_csr_3200 <= (decode_INSTRUCTION[31 : 20] == 12'hc80);
    end
    if(execute_CsrPlugin_csr_836)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mip_MSIP <= _zz_283[0];
      end
    end
    if(execute_CsrPlugin_csr_833)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mepc <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_832)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mscratch <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_834)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mcause_interrupt <= _zz_287[0];
        CsrPlugin_mcause_exceptionCode <= execute_CsrPlugin_writeData[3 : 0];
      end
    end
    if(execute_CsrPlugin_csr_835)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mtval <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_2816)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mcycle[31 : 0] <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_2944)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_mcycle[63 : 32] <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_2818)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_minstret[31 : 0] <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
    if(execute_CsrPlugin_csr_2946)begin
      if(execute_CsrPlugin_writeEnable)begin
        CsrPlugin_minstret[63 : 32] <= execute_CsrPlugin_writeData[31 : 0];
      end
    end
  end

  always @ (posedge io_mainClk) begin
    DebugPlugin_firstCycle <= 1'b0;
    if(debug_bus_cmd_ready)begin
      DebugPlugin_firstCycle <= 1'b1;
    end
    DebugPlugin_secondCycle <= DebugPlugin_firstCycle;
    DebugPlugin_isPipBusy <= (({writeBack_arbitration_isValid,{memory_arbitration_isValid,{execute_arbitration_isValid,decode_arbitration_isValid}}} != 4'b0000) || IBusSimplePlugin_incomingInstruction);
    if(writeBack_arbitration_isValid)begin
      DebugPlugin_busReadDataReg <= _zz_44;
    end
    _zz_141 <= debug_bus_cmd_payload_address[2];
    if(_zz_170)begin
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
      _zz_142 <= 1'b0;
    end else begin
      if((DebugPlugin_haltIt && (! DebugPlugin_isPipBusy)))begin
        DebugPlugin_godmode <= 1'b1;
      end
      if(debug_bus_cmd_valid)begin
        case(_zz_189)
          6'h0 : begin
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
          default : begin
          end
        endcase
      end
      if(_zz_170)begin
        if(_zz_171)begin
          DebugPlugin_haltIt <= 1'b1;
          DebugPlugin_haltedByBreak <= 1'b1;
        end
      end
      if(_zz_174)begin
        if(decode_arbitration_isValid)begin
          DebugPlugin_haltIt <= 1'b1;
        end
      end
      _zz_142 <= (DebugPlugin_stepIt && decode_arbitration_isFiring);
    end
  end


endmodule

module MuraxMasterArbiter (
  input               io_iBus_cmd_valid,
  output reg          io_iBus_cmd_ready,
  input      [31:0]   io_iBus_cmd_payload_pc,
  output              io_iBus_rsp_valid,
  output              io_iBus_rsp_payload_error,
  output     [31:0]   io_iBus_rsp_payload_inst,
  input               io_dBus_cmd_valid,
  output reg          io_dBus_cmd_ready,
  input               io_dBus_cmd_payload_wr,
  input      [31:0]   io_dBus_cmd_payload_address,
  input      [31:0]   io_dBus_cmd_payload_data,
  input      [1:0]    io_dBus_cmd_payload_size,
  output              io_dBus_rsp_ready,
  output              io_dBus_rsp_error,
  output     [31:0]   io_dBus_rsp_data,
  output reg          io_masterBus_cmd_valid,
  input               io_masterBus_cmd_ready,
  output              io_masterBus_cmd_payload_write,
  output     [31:0]   io_masterBus_cmd_payload_address,
  output     [31:0]   io_masterBus_cmd_payload_data,
  output     [3:0]    io_masterBus_cmd_payload_mask,
  input               io_masterBus_rsp_valid,
  input      [31:0]   io_masterBus_rsp_payload_data,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_2;
  reg        [3:0]    _zz_1;
  reg                 rspPending;
  reg                 rspTarget;

  assign _zz_2 = (rspPending && (! io_masterBus_rsp_valid));
  always @ (*) begin
    io_masterBus_cmd_valid = (io_iBus_cmd_valid || io_dBus_cmd_valid);
    if(_zz_2)begin
      io_masterBus_cmd_valid = 1'b0;
    end
  end

  assign io_masterBus_cmd_payload_write = (io_dBus_cmd_valid && io_dBus_cmd_payload_wr);
  assign io_masterBus_cmd_payload_address = (io_dBus_cmd_valid ? io_dBus_cmd_payload_address : io_iBus_cmd_payload_pc);
  assign io_masterBus_cmd_payload_data = io_dBus_cmd_payload_data;
  always @ (*) begin
    case(io_dBus_cmd_payload_size)
      2'b00 : begin
        _zz_1 = 4'b0001;
      end
      2'b01 : begin
        _zz_1 = 4'b0011;
      end
      default : begin
        _zz_1 = 4'b1111;
      end
    endcase
  end

  assign io_masterBus_cmd_payload_mask = (_zz_1 <<< io_dBus_cmd_payload_address[1 : 0]);
  always @ (*) begin
    io_iBus_cmd_ready = (io_masterBus_cmd_ready && (! io_dBus_cmd_valid));
    if(_zz_2)begin
      io_iBus_cmd_ready = 1'b0;
    end
  end

  always @ (*) begin
    io_dBus_cmd_ready = io_masterBus_cmd_ready;
    if(_zz_2)begin
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

module BufferCC_3 (
  input               io_dataIn,
  output              io_dataOut,
  input               io_mainClk
);
  reg                 buffers_0;
  reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module InterruptCtrl (
  input      [1:0]    io_inputs,
  input      [1:0]    io_clears,
  input      [1:0]    io_masks,
  output     [1:0]    io_pendings,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  reg        [1:0]    pendings;

  assign io_pendings = (pendings & io_masks);
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      pendings <= 2'b00;
    end else begin
      pendings <= ((pendings & (~ io_clears)) | io_inputs);
    end
  end


endmodule

//Timer replaced by Timer

module Timer (
  input               io_tick,
  input               io_clear,
  input      [15:0]   io_limit,
  output              io_full,
  output     [15:0]   io_value,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire       [0:0]    _zz_1;
  wire       [15:0]   _zz_2;
  reg        [15:0]   counter;
  wire                limitHit;
  reg                 inhibitFull;

  assign _zz_1 = (! limitHit);
  assign _zz_2 = {15'd0, _zz_1};
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
      counter <= (counter + _zz_2);
    end
    if(io_clear)begin
      counter <= 16'h0;
    end
  end


endmodule

module Prescaler (
  input               io_clear,
  input      [15:0]   io_limit,
  output              io_overflow,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  reg        [15:0]   counter;

  assign io_overflow = (counter == io_limit);
  always @ (posedge io_mainClk) begin
    counter <= (counter + 16'h0001);
    if((io_clear || io_overflow))begin
      counter <= 16'h0;
    end
  end


endmodule

//StreamFifo replaced by StreamFifo

module StreamFifo (
  input               io_push_valid,
  output              io_push_ready,
  input      [7:0]    io_push_payload,
  output              io_pop_valid,
  input               io_pop_ready,
  output     [7:0]    io_pop_payload,
  input               io_flush,
  output     [4:0]    io_occupancy,
  output     [4:0]    io_availability,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  reg        [7:0]    _zz_3;
  wire       [0:0]    _zz_4;
  wire       [3:0]    _zz_5;
  wire       [0:0]    _zz_6;
  wire       [3:0]    _zz_7;
  wire       [3:0]    _zz_8;
  wire                _zz_9;
  reg                 _zz_1;
  reg                 logic_pushPtr_willIncrement;
  reg                 logic_pushPtr_willClear;
  reg        [3:0]    logic_pushPtr_valueNext;
  reg        [3:0]    logic_pushPtr_value;
  wire                logic_pushPtr_willOverflowIfInc;
  wire                logic_pushPtr_willOverflow;
  reg                 logic_popPtr_willIncrement;
  reg                 logic_popPtr_willClear;
  reg        [3:0]    logic_popPtr_valueNext;
  reg        [3:0]    logic_popPtr_value;
  wire                logic_popPtr_willOverflowIfInc;
  wire                logic_popPtr_willOverflow;
  wire                logic_ptrMatch;
  reg                 logic_risingOccupancy;
  wire                logic_pushing;
  wire                logic_popping;
  wire                logic_empty;
  wire                logic_full;
  reg                 _zz_2;
  wire       [3:0]    logic_ptrDif;
  reg [7:0] logic_ram [0:15];

  assign _zz_4 = logic_pushPtr_willIncrement;
  assign _zz_5 = {3'd0, _zz_4};
  assign _zz_6 = logic_popPtr_willIncrement;
  assign _zz_7 = {3'd0, _zz_6};
  assign _zz_8 = (logic_popPtr_value - logic_pushPtr_value);
  assign _zz_9 = 1'b1;
  always @ (posedge io_mainClk) begin
    if(_zz_9) begin
      _zz_3 <= logic_ram[logic_popPtr_valueNext];
    end
  end

  always @ (posedge io_mainClk) begin
    if(_zz_1) begin
      logic_ram[logic_pushPtr_value] <= io_push_payload;
    end
  end

  always @ (*) begin
    _zz_1 = 1'b0;
    if(logic_pushing)begin
      _zz_1 = 1'b1;
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

  assign logic_pushPtr_willOverflowIfInc = (logic_pushPtr_value == 4'b1111);
  assign logic_pushPtr_willOverflow = (logic_pushPtr_willOverflowIfInc && logic_pushPtr_willIncrement);
  always @ (*) begin
    logic_pushPtr_valueNext = (logic_pushPtr_value + _zz_5);
    if(logic_pushPtr_willClear)begin
      logic_pushPtr_valueNext = 4'b0000;
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

  assign logic_popPtr_willOverflowIfInc = (logic_popPtr_value == 4'b1111);
  assign logic_popPtr_willOverflow = (logic_popPtr_willOverflowIfInc && logic_popPtr_willIncrement);
  always @ (*) begin
    logic_popPtr_valueNext = (logic_popPtr_value + _zz_7);
    if(logic_popPtr_willClear)begin
      logic_popPtr_valueNext = 4'b0000;
    end
  end

  assign logic_ptrMatch = (logic_pushPtr_value == logic_popPtr_value);
  assign logic_pushing = (io_push_valid && io_push_ready);
  assign logic_popping = (io_pop_valid && io_pop_ready);
  assign logic_empty = (logic_ptrMatch && (! logic_risingOccupancy));
  assign logic_full = (logic_ptrMatch && logic_risingOccupancy);
  assign io_push_ready = (! logic_full);
  assign io_pop_valid = ((! logic_empty) && (! (_zz_2 && (! logic_full))));
  assign io_pop_payload = _zz_3;
  assign logic_ptrDif = (logic_pushPtr_value - logic_popPtr_value);
  assign io_occupancy = {(logic_risingOccupancy && logic_ptrMatch),logic_ptrDif};
  assign io_availability = {((! logic_risingOccupancy) && logic_ptrMatch),_zz_8};
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      logic_pushPtr_value <= 4'b0000;
      logic_popPtr_value <= 4'b0000;
      logic_risingOccupancy <= 1'b0;
      _zz_2 <= 1'b0;
    end else begin
      logic_pushPtr_value <= logic_pushPtr_valueNext;
      logic_popPtr_value <= logic_popPtr_valueNext;
      _zz_2 <= (logic_popPtr_valueNext == logic_pushPtr_value);
      if((logic_pushing != logic_popping))begin
        logic_risingOccupancy <= logic_pushing;
      end
      if(io_flush)begin
        logic_risingOccupancy <= 1'b0;
      end
    end
  end


endmodule

module UartCtrl (
  input      [2:0]    io_config_frame_dataLength,
  input      `UartStopType_defaultEncoding_type io_config_frame_stop,
  input      `UartParityType_defaultEncoding_type io_config_frame_parity,
  input      [19:0]   io_config_clockDivider,
  input               io_write_valid,
  output reg          io_write_ready,
  input      [7:0]    io_write_payload,
  output              io_read_valid,
  input               io_read_ready,
  output     [7:0]    io_read_payload,
  output              io_uart_txd,
  input               io_uart_rxd,
  output              io_readError,
  input               io_writeBreak,
  output              io_readBreak,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_1;
  wire                tx_io_write_ready;
  wire                tx_io_txd;
  wire                rx_io_read_valid;
  wire       [7:0]    rx_io_read_payload;
  wire                rx_io_rts;
  wire                rx_io_error;
  wire                rx_io_break;
  reg        [19:0]   clockDivider_counter;
  wire                clockDivider_tick;
  reg                 io_write_thrown_valid;
  wire                io_write_thrown_ready;
  wire       [7:0]    io_write_thrown_payload;
  `ifndef SYNTHESIS
  reg [23:0] io_config_frame_stop_string;
  reg [31:0] io_config_frame_parity_string;
  `endif


  UartCtrlTx tx (
    .io_configFrame_dataLength    (io_config_frame_dataLength[2:0]  ), //i
    .io_configFrame_stop          (io_config_frame_stop             ), //i
    .io_configFrame_parity        (io_config_frame_parity[1:0]      ), //i
    .io_samplingTick              (clockDivider_tick                ), //i
    .io_write_valid               (io_write_thrown_valid            ), //i
    .io_write_ready               (tx_io_write_ready                ), //o
    .io_write_payload             (io_write_thrown_payload[7:0]     ), //i
    .io_cts                       (_zz_1                            ), //i
    .io_txd                       (tx_io_txd                        ), //o
    .io_break                     (io_writeBreak                    ), //i
    .io_mainClk                   (io_mainClk                       ), //i
    .resetCtrl_systemReset        (resetCtrl_systemReset            )  //i
  );
  UartCtrlRx rx (
    .io_configFrame_dataLength    (io_config_frame_dataLength[2:0]  ), //i
    .io_configFrame_stop          (io_config_frame_stop             ), //i
    .io_configFrame_parity        (io_config_frame_parity[1:0]      ), //i
    .io_samplingTick              (clockDivider_tick                ), //i
    .io_read_valid                (rx_io_read_valid                 ), //o
    .io_read_ready                (io_read_ready                    ), //i
    .io_read_payload              (rx_io_read_payload[7:0]          ), //o
    .io_rxd                       (io_uart_rxd                      ), //i
    .io_rts                       (rx_io_rts                        ), //o
    .io_error                     (rx_io_error                      ), //o
    .io_break                     (rx_io_break                      ), //o
    .io_mainClk                   (io_mainClk                       ), //i
    .resetCtrl_systemReset        (resetCtrl_systemReset            )  //i
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

  assign clockDivider_tick = (clockDivider_counter == 20'h0);
  always @ (*) begin
    io_write_thrown_valid = io_write_valid;
    if(rx_io_break)begin
      io_write_thrown_valid = 1'b0;
    end
  end

  always @ (*) begin
    io_write_ready = io_write_thrown_ready;
    if(rx_io_break)begin
      io_write_ready = 1'b1;
    end
  end

  assign io_write_thrown_payload = io_write_payload;
  assign io_write_thrown_ready = tx_io_write_ready;
  assign io_read_valid = rx_io_read_valid;
  assign io_read_payload = rx_io_read_payload;
  assign io_uart_txd = tx_io_txd;
  assign io_readError = rx_io_error;
  assign _zz_1 = 1'b0;
  assign io_readBreak = rx_io_break;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      clockDivider_counter <= 20'h0;
    end else begin
      clockDivider_counter <= (clockDivider_counter - 20'h00001);
      if(clockDivider_tick)begin
        clockDivider_counter <= io_config_clockDivider;
      end
    end
  end


endmodule

module BufferCC_2 (
  input               io_mainClk,
  input               resetCtrl_systemReset
);


endmodule

module FlowCCByToggle (
  input               io_input_valid,
  input               io_input_payload_last,
  input      [0:0]    io_input_payload_fragment,
  output              io_output_valid,
  output              io_output_payload_last,
  output     [0:0]    io_output_payload_fragment,
  input               tck,
  input               io_mainClk,
  input               resetCtrl_mainClkReset
);
  wire                inputArea_target_buffercc_io_dataOut;
  wire                outHitSignal;
  reg                 inputArea_target = 0;
  reg                 inputArea_data_last;
  reg        [0:0]    inputArea_data_fragment;
  wire                outputArea_target;
  reg                 outputArea_hit;
  wire                outputArea_flow_valid;
  wire                outputArea_flow_payload_last;
  wire       [0:0]    outputArea_flow_payload_fragment;
  reg                 outputArea_flow_regNext_valid;
  reg                 outputArea_flow_regNext_payload_last;
  reg        [0:0]    outputArea_flow_regNext_payload_fragment;

  BufferCC_1 inputArea_target_buffercc (
    .io_dataIn                 (inputArea_target                      ), //i
    .io_dataOut                (inputArea_target_buffercc_io_dataOut  ), //o
    .io_mainClk                (io_mainClk                            ), //i
    .resetCtrl_mainClkReset    (resetCtrl_mainClkReset                )  //i
  );
  assign outputArea_target = inputArea_target_buffercc_io_dataOut;
  assign outputArea_flow_valid = (outputArea_target != outputArea_hit);
  assign outputArea_flow_payload_last = inputArea_data_last;
  assign outputArea_flow_payload_fragment = inputArea_data_fragment;
  assign io_output_valid = outputArea_flow_regNext_valid;
  assign io_output_payload_last = outputArea_flow_regNext_payload_last;
  assign io_output_payload_fragment = outputArea_flow_regNext_payload_fragment;
  always @ (posedge tck) begin
    if(io_input_valid)begin
      inputArea_target <= (! inputArea_target);
      inputArea_data_last <= io_input_payload_last;
      inputArea_data_fragment <= io_input_payload_fragment;
    end
  end

  always @ (posedge io_mainClk) begin
    outputArea_hit <= outputArea_target;
    outputArea_flow_regNext_payload_last <= outputArea_flow_payload_last;
    outputArea_flow_regNext_payload_fragment <= outputArea_flow_payload_fragment;
  end

  always @ (posedge io_mainClk or posedge resetCtrl_mainClkReset) begin
    if (resetCtrl_mainClkReset) begin
      outputArea_flow_regNext_valid <= 1'b0;
    end else begin
      outputArea_flow_regNext_valid <= outputArea_flow_valid;
    end
  end


endmodule

module StreamFifoLowLatency (
  input               io_push_valid,
  output              io_push_ready,
  input               io_push_payload_error,
  input      [31:0]   io_push_payload_inst,
  output reg          io_pop_valid,
  input               io_pop_ready,
  output reg          io_pop_payload_error,
  output reg [31:0]   io_pop_payload_inst,
  input               io_flush,
  output     [0:0]    io_occupancy,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_4;
  wire       [0:0]    _zz_5;
  reg                 _zz_1;
  reg                 pushPtr_willIncrement;
  reg                 pushPtr_willClear;
  wire                pushPtr_willOverflowIfInc;
  wire                pushPtr_willOverflow;
  reg                 popPtr_willIncrement;
  reg                 popPtr_willClear;
  wire                popPtr_willOverflowIfInc;
  wire                popPtr_willOverflow;
  wire                ptrMatch;
  reg                 risingOccupancy;
  wire                empty;
  wire                full;
  wire                pushing;
  wire                popping;
  wire       [32:0]   _zz_2;
  reg        [32:0]   _zz_3;

  assign _zz_4 = (! empty);
  assign _zz_5 = _zz_2[0 : 0];
  always @ (*) begin
    _zz_1 = 1'b0;
    if(pushing)begin
      _zz_1 = 1'b1;
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
    if(_zz_4)begin
      io_pop_valid = 1'b1;
    end else begin
      io_pop_valid = io_push_valid;
    end
  end

  assign _zz_2 = _zz_3;
  always @ (*) begin
    if(_zz_4)begin
      io_pop_payload_error = _zz_5[0];
    end else begin
      io_pop_payload_error = io_push_payload_error;
    end
  end

  always @ (*) begin
    if(_zz_4)begin
      io_pop_payload_inst = _zz_2[32 : 1];
    end else begin
      io_pop_payload_inst = io_push_payload_inst;
    end
  end

  assign io_occupancy = (risingOccupancy && ptrMatch);
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
    if(_zz_1)begin
      _zz_3 <= {io_push_payload_inst,io_push_payload_error};
    end
  end


endmodule

module UartCtrlRx (
  input      [2:0]    io_configFrame_dataLength,
  input      `UartStopType_defaultEncoding_type io_configFrame_stop,
  input      `UartParityType_defaultEncoding_type io_configFrame_parity,
  input               io_samplingTick,
  output              io_read_valid,
  input               io_read_ready,
  output     [7:0]    io_read_payload,
  input               io_rxd,
  output              io_rts,
  output reg          io_error,
  output              io_break,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                io_rxd_buffercc_io_dataOut;
  wire                _zz_2;
  wire                _zz_3;
  wire                _zz_4;
  wire                _zz_5;
  wire                _zz_6;
  wire       [0:0]    _zz_7;
  wire       [2:0]    _zz_8;
  reg                 _zz_1;
  wire                sampler_synchroniser;
  wire                sampler_samples_0;
  reg                 sampler_samples_1;
  reg                 sampler_samples_2;
  reg                 sampler_value;
  reg                 sampler_tick;
  reg        [2:0]    bitTimer_counter;
  reg                 bitTimer_tick;
  reg        [2:0]    bitCounter_value;
  reg        [6:0]    break_counter;
  wire                break_valid;
  reg        `UartCtrlRxState_defaultEncoding_type stateMachine_state;
  reg                 stateMachine_parity;
  reg        [7:0]    stateMachine_shifter;
  reg                 stateMachine_validReg;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_2 = (stateMachine_parity == sampler_value);
  assign _zz_3 = (! sampler_value);
  assign _zz_4 = (bitTimer_counter == 3'b000);
  assign _zz_5 = ((sampler_tick && (! sampler_value)) && (! break_valid));
  assign _zz_6 = (bitCounter_value == io_configFrame_dataLength);
  assign _zz_7 = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? 1'b0 : 1'b1);
  assign _zz_8 = {2'd0, _zz_7};
  BufferCC io_rxd_buffercc (
    .io_dataIn                (io_rxd                      ), //i
    .io_dataOut               (io_rxd_buffercc_io_dataOut  ), //o
    .io_mainClk               (io_mainClk                  ), //i
    .resetCtrl_systemReset    (resetCtrl_systemReset       )  //i
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

  always @ (*) begin
    io_error = 1'b0;
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlRxState_defaultEncoding_START : begin
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          if(! _zz_2) begin
            io_error = 1'b1;
          end
        end
      end
      default : begin
        if(bitTimer_tick)begin
          if(_zz_3)begin
            io_error = 1'b1;
          end
        end
      end
    endcase
  end

  assign io_rts = _zz_1;
  assign sampler_synchroniser = io_rxd_buffercc_io_dataOut;
  assign sampler_samples_0 = sampler_synchroniser;
  always @ (*) begin
    bitTimer_tick = 1'b0;
    if(sampler_tick)begin
      if(_zz_4)begin
        bitTimer_tick = 1'b1;
      end
    end
  end

  assign break_valid = (break_counter == 7'h41);
  assign io_break = break_valid;
  assign io_read_valid = stateMachine_validReg;
  assign io_read_payload = stateMachine_shifter;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      _zz_1 <= 1'b0;
      sampler_samples_1 <= 1'b1;
      sampler_samples_2 <= 1'b1;
      sampler_value <= 1'b1;
      sampler_tick <= 1'b0;
      break_counter <= 7'h0;
      stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
      stateMachine_validReg <= 1'b0;
    end else begin
      _zz_1 <= (! io_read_ready);
      if(io_samplingTick)begin
        sampler_samples_1 <= sampler_samples_0;
      end
      if(io_samplingTick)begin
        sampler_samples_2 <= sampler_samples_1;
      end
      sampler_value <= (((1'b0 || ((1'b1 && sampler_samples_0) && sampler_samples_1)) || ((1'b1 && sampler_samples_0) && sampler_samples_2)) || ((1'b1 && sampler_samples_1) && sampler_samples_2));
      sampler_tick <= io_samplingTick;
      if(sampler_value)begin
        break_counter <= 7'h0;
      end else begin
        if((io_samplingTick && (! break_valid)))begin
          break_counter <= (break_counter + 7'h01);
        end
      end
      stateMachine_validReg <= 1'b0;
      case(stateMachine_state)
        `UartCtrlRxState_defaultEncoding_IDLE : begin
          if(_zz_5)begin
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
            if(_zz_6)begin
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
            if(_zz_2)begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_STOP;
              stateMachine_validReg <= 1'b1;
            end else begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end
          end
        end
        default : begin
          if(bitTimer_tick)begin
            if(_zz_3)begin
              stateMachine_state <= `UartCtrlRxState_defaultEncoding_IDLE;
            end else begin
              if((bitCounter_value == _zz_8))begin
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
      bitTimer_counter <= (bitTimer_counter - 3'b001);
      if(_zz_4)begin
        bitTimer_counter <= 3'b100;
      end
    end
    if(bitTimer_tick)begin
      bitCounter_value <= (bitCounter_value + 3'b001);
    end
    if(bitTimer_tick)begin
      stateMachine_parity <= (stateMachine_parity ^ sampler_value);
    end
    case(stateMachine_state)
      `UartCtrlRxState_defaultEncoding_IDLE : begin
        if(_zz_5)begin
          bitTimer_counter <= 3'b001;
        end
      end
      `UartCtrlRxState_defaultEncoding_START : begin
        if(bitTimer_tick)begin
          bitCounter_value <= 3'b000;
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
        end
      end
      `UartCtrlRxState_defaultEncoding_DATA : begin
        if(bitTimer_tick)begin
          stateMachine_shifter[bitCounter_value] <= sampler_value;
          if(_zz_6)begin
            bitCounter_value <= 3'b000;
          end
        end
      end
      `UartCtrlRxState_defaultEncoding_PARITY : begin
        if(bitTimer_tick)begin
          bitCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module UartCtrlTx (
  input      [2:0]    io_configFrame_dataLength,
  input      `UartStopType_defaultEncoding_type io_configFrame_stop,
  input      `UartParityType_defaultEncoding_type io_configFrame_parity,
  input               io_samplingTick,
  input               io_write_valid,
  output reg          io_write_ready,
  input      [7:0]    io_write_payload,
  input               io_cts,
  output              io_txd,
  input               io_break,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  wire                _zz_2;
  wire       [0:0]    _zz_3;
  wire       [2:0]    _zz_4;
  wire       [0:0]    _zz_5;
  wire       [2:0]    _zz_6;
  reg                 clockDivider_counter_willIncrement;
  wire                clockDivider_counter_willClear;
  reg        [2:0]    clockDivider_counter_valueNext;
  reg        [2:0]    clockDivider_counter_value;
  wire                clockDivider_counter_willOverflowIfInc;
  wire                clockDivider_counter_willOverflow;
  reg        [2:0]    tickCounter_value;
  reg        `UartCtrlTxState_defaultEncoding_type stateMachine_state;
  reg                 stateMachine_parity;
  reg                 stateMachine_txd;
  reg                 _zz_1;
  `ifndef SYNTHESIS
  reg [23:0] io_configFrame_stop_string;
  reg [31:0] io_configFrame_parity_string;
  reg [47:0] stateMachine_state_string;
  `endif


  assign _zz_2 = (tickCounter_value == io_configFrame_dataLength);
  assign _zz_3 = clockDivider_counter_willIncrement;
  assign _zz_4 = {2'd0, _zz_3};
  assign _zz_5 = ((io_configFrame_stop == `UartStopType_defaultEncoding_ONE) ? 1'b0 : 1'b1);
  assign _zz_6 = {2'd0, _zz_5};
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
  assign clockDivider_counter_willOverflowIfInc = (clockDivider_counter_value == 3'b100);
  assign clockDivider_counter_willOverflow = (clockDivider_counter_willOverflowIfInc && clockDivider_counter_willIncrement);
  always @ (*) begin
    if(clockDivider_counter_willOverflow)begin
      clockDivider_counter_valueNext = 3'b000;
    end else begin
      clockDivider_counter_valueNext = (clockDivider_counter_value + _zz_4);
    end
    if(clockDivider_counter_willClear)begin
      clockDivider_counter_valueNext = 3'b000;
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
    io_write_ready = io_break;
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_counter_willOverflow)begin
          if(_zz_2)begin
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

  assign io_txd = _zz_1;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      clockDivider_counter_value <= 3'b000;
      stateMachine_state <= `UartCtrlTxState_defaultEncoding_IDLE;
      _zz_1 <= 1'b1;
    end else begin
      clockDivider_counter_value <= clockDivider_counter_valueNext;
      case(stateMachine_state)
        `UartCtrlTxState_defaultEncoding_IDLE : begin
          if(((io_write_valid && (! io_cts)) && clockDivider_counter_willOverflow))begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_START;
          end
        end
        `UartCtrlTxState_defaultEncoding_START : begin
          if(clockDivider_counter_willOverflow)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_DATA;
          end
        end
        `UartCtrlTxState_defaultEncoding_DATA : begin
          if(clockDivider_counter_willOverflow)begin
            if(_zz_2)begin
              if((io_configFrame_parity == `UartParityType_defaultEncoding_NONE))begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
              end else begin
                stateMachine_state <= `UartCtrlTxState_defaultEncoding_PARITY;
              end
            end
          end
        end
        `UartCtrlTxState_defaultEncoding_PARITY : begin
          if(clockDivider_counter_willOverflow)begin
            stateMachine_state <= `UartCtrlTxState_defaultEncoding_STOP;
          end
        end
        default : begin
          if(clockDivider_counter_willOverflow)begin
            if((tickCounter_value == _zz_6))begin
              stateMachine_state <= (io_write_valid ? `UartCtrlTxState_defaultEncoding_START : `UartCtrlTxState_defaultEncoding_IDLE);
            end
          end
        end
      endcase
      _zz_1 <= (stateMachine_txd && (! io_break));
    end
  end

  always @ (posedge io_mainClk) begin
    if(clockDivider_counter_willOverflow)begin
      tickCounter_value <= (tickCounter_value + 3'b001);
    end
    if(clockDivider_counter_willOverflow)begin
      stateMachine_parity <= (stateMachine_parity ^ stateMachine_txd);
    end
    case(stateMachine_state)
      `UartCtrlTxState_defaultEncoding_IDLE : begin
      end
      `UartCtrlTxState_defaultEncoding_START : begin
        if(clockDivider_counter_willOverflow)begin
          stateMachine_parity <= (io_configFrame_parity == `UartParityType_defaultEncoding_ODD);
          tickCounter_value <= 3'b000;
        end
      end
      `UartCtrlTxState_defaultEncoding_DATA : begin
        if(clockDivider_counter_willOverflow)begin
          if(_zz_2)begin
            tickCounter_value <= 3'b000;
          end
        end
      end
      `UartCtrlTxState_defaultEncoding_PARITY : begin
        if(clockDivider_counter_willOverflow)begin
          tickCounter_value <= 3'b000;
        end
      end
      default : begin
      end
    endcase
  end


endmodule

module BufferCC_1 (
  input               io_dataIn,
  output              io_dataOut,
  input               io_mainClk,
  input               resetCtrl_mainClkReset
);
  reg                 buffers_0;
  reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk) begin
    buffers_0 <= io_dataIn;
    buffers_1 <= buffers_0;
  end


endmodule

module BufferCC (
  input               io_dataIn,
  output              io_dataOut,
  input               io_mainClk,
  input               resetCtrl_systemReset
);
  reg                 buffers_0;
  reg                 buffers_1;

  assign io_dataOut = buffers_1;
  always @ (posedge io_mainClk or posedge resetCtrl_systemReset) begin
    if (resetCtrl_systemReset) begin
      buffers_0 <= 1'b0;
      buffers_1 <= 1'b0;
    end else begin
      buffers_0 <= io_dataIn;
      buffers_1 <= buffers_0;
    end
  end


endmodule
