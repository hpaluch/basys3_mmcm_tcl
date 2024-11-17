//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Henryk Paluch, https://github.com/hpaluch
// 
// Create Date:    11/15/2024 03:28:08 PM
// Design Name:    Basys 3 MMCM TCL
// Module Name:    top
// Project Name:   https://github.com/hpaluch/basys3_mmcm_tcl
// Target Devices: xc7a35tcpg236-1
// Tool Versions:  Vivado 2024.1
// Description: 
//      Example how to use MMCM clock module via "Clock Wizard" to create 8 MHz clock from 100 MHz input clock
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module top(
    input clk,
    input btnC,
    output [4:0]led,
    output [4:0]JA,
    output [3:0]an // common anodes of 4 digit display, Active low - used here to stop glowing
    );

  wire locked;
  wire CLK_OUT;
  wire COUNT;
  wire safe_clk; // use safe_clk (before ODDR) to internal safe clocking with synchronous safe_reset
  wire safe_reset;
  wire ex_count_out;
    
  assign led = { ex_count_out, COUNT, locked, safe_reset, btnC };
  assign JA  = { COUNT, CLK_OUT, locked, safe_reset, btnC };

  // tie 4-digit 7-segment display anodes to 1 (PNP transistor off) to stop glowing display
  genvar ii;
  for(ii=0 ; ii<4 ;ii = ii+1) begin: gen_anx_obuf
    OBUF anx_obuf ( .I(1'b1), .O(an[ii]) );
  end
    
  clk_wiz_0_exdes exdes_inst1 (// Clock in ports
    // Reset for logic in example design
    .COUNTER_RESET      (btnC),
    .CLK_OUT            (CLK_OUT), // must be always FPGA Output Pin, because it uses ODDR
    // High bits of the counters
    .COUNT              (COUNT),
    // Status and control signals
    .reset              (btnC),
    .locked             (locked),
    .clk_in1            (clk),
    .safe_reset( safe_reset ), .safe_clk( safe_clk ) );

  // example counter using 8 Mhz MMCM clock (safe_clock) and synchronous reset (safe_reset):
  // NOTE: We can't use CLK_OUT because it is Output buffer (usable for Output Pin on FPGA only)
  ex_count ex_count_inst1 (
    .safe_reset( safe_reset ), .safe_clk( safe_clk ),
    .ex_count_out( ex_count_out) );
    
endmodule
