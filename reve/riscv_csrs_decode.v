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

//a Module riscv_csrs_decode
    //   
    //   This module performs combinatorial decode of CSR accesses.
    //   
    //   
module riscv_csrs_decode
(

    csr_access__mode,
    csr_access__access_cancelled,
    csr_access__access,
    csr_access__custom__mhartid,
    csr_access__custom__misa,
    csr_access__custom__mvendorid,
    csr_access__custom__marchid,
    csr_access__custom__mimpid,
    csr_access__address,
    csr_access__select,
    csr_access__write_data,

    csr_decode__illegal_access,
    csr_decode__csr_select
);

    //b Clocks

    //b Inputs
        //   RISC-V CSR access, combinatorially decoded
    input [2:0]csr_access__mode;
    input csr_access__access_cancelled;
    input [2:0]csr_access__access;
    input [31:0]csr_access__custom__mhartid;
    input [31:0]csr_access__custom__misa;
    input [31:0]csr_access__custom__mvendorid;
    input [31:0]csr_access__custom__marchid;
    input [31:0]csr_access__custom__mimpid;
    input [11:0]csr_access__address;
    input [11:0]csr_access__select;
    input [31:0]csr_access__write_data;

    //b Outputs
        //   CSR response (including read data), from the current @a csr_access
    output csr_decode__illegal_access;
    output [11:0]csr_decode__csr_select;

// output components here

    //b Output combinatorials
        //   CSR response (including read data), from the current @a csr_access
    reg csr_decode__illegal_access;
    reg [11:0]csr_decode__csr_select;

    //b Output nets

    //b Internal and output registers

    //b Internal combinatorials

    //b Internal nets

    //b Clock gating module instances
    //b Module instances
    //b csr_read_write combinatorial process
        //   
        //       CSR_ADDR_MSTATUS
        //       CSR_ADDR_MISA
        //       CSR_ADDR_MVENDORID
        //       CSR_ADDR_MARCHID
        //       CSR_ADDR_MIMPID
        //       CSR_ADDR_MHARTID
        //   
        //       User mode interrupts requires uscratch, uepc, ucause, utval, uip; ustatus, uie, utvec
        //       
    always @ ( * )//csr_read_write
    begin: csr_read_write__comb_code
    reg csr_decode__illegal_access__var;
    reg [11:0]csr_decode__csr_select__var;
        csr_decode__illegal_access__var = 1'h0;
        csr_decode__csr_select__var = 12'h0;
        csr_decode__illegal_access__var = 1'h1;
        case (csr_access__address) //synopsys parallel_case
        12'hc00: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h12;
            end
        12'hc80: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h13;
            end
        12'hc02: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h14;
            end
        12'hc82: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h15;
            end
        12'hc01: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h10;
            end
        12'hc81: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h11;
            end
        12'h0: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h40;
            end
        12'h4: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h42;
            end
        12'h5: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h44;
            end
        12'h40: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h41;
            end
        12'h41: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h46;
            end
        12'h42: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h47;
            end
        12'h43: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h45;
            end
        12'h44: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h43;
            end
        12'hb00: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h12;
            end
        12'hb80: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h13;
            end
        12'hb02: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h14;
            end
        12'hb82: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h15;
            end
        12'hf13: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h23;
            end
        12'hf14: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h24;
            end
        12'h301: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h20;
            end
        12'hf12: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h22;
            end
        12'hf11: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h21;
            end
        12'h300: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h80;
            end
        12'h304: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h82;
            end
        12'h305: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h84;
            end
        12'h340: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h81;
            end
        12'h341: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h86;
            end
        12'h342: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h87;
            end
        12'h343: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h85;
            end
        12'h344: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h83;
            end
        12'h302: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h100;
            end
        12'h303: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            csr_decode__csr_select__var = 12'h101;
            end
        12'h7b1: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h800;
            end
        12'h7b0: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h801;
            end
        12'h7b2: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h802;
            end
        12'h7b3: // req 1
            begin
            csr_decode__illegal_access__var = 1'h1;
            csr_decode__csr_select__var = 12'h803;
            end
        //synopsys  translate_off
        //pragma coverage off
        //synopsys  translate_on
        default:
            begin
            //Need a default case to make Cadence Lint happy, even though this is not a full case
            end
        //synopsys  translate_off
        //pragma coverage on
        //synopsys  translate_on
        endcase
        if (((1'h0!=64'h0)&&(csr_access__mode==3'h0)))
        begin
            if ((csr_access__address[9:8]!=2'h0))
            begin
                csr_decode__illegal_access__var = 1'h1;
            end //if
        end //if
        case (csr_access__access) //synopsys parallel_case
        3'h0: // req 1
            begin
            csr_decode__illegal_access__var = 1'h0;
            end
        3'h1: // req 1
            begin
            if ((csr_access__address[11:10]==2'h3))
            begin
                csr_decode__illegal_access__var = 1'h1;
            end //if
            end
        3'h3: // req 1
            begin
            if ((csr_access__address[11:10]==2'h3))
            begin
                csr_decode__illegal_access__var = 1'h1;
            end //if
            end
        3'h6: // req 1
            begin
            if ((csr_access__address[11:10]==2'h3))
            begin
                csr_decode__illegal_access__var = 1'h1;
            end //if
            end
        3'h7: // req 1
            begin
            if ((csr_access__address[11:10]==2'h3))
            begin
                csr_decode__illegal_access__var = 1'h1;
            end //if
            end
        //synopsys  translate_off
        //pragma coverage off
        //synopsys  translate_on
        default:
            begin
            //Need a default case to make Cadence Lint happy, even though this is not a full case
            end
        //synopsys  translate_off
        //pragma coverage on
        //synopsys  translate_on
        endcase
        csr_decode__illegal_access = csr_decode__illegal_access__var;
        csr_decode__csr_select = csr_decode__csr_select__var;
    end //always

endmodule // riscv_csrs_decode
