//////////////////////////////////////////////////////////////////////////////////
// Engineer: 
// 
// Create Date: 11/15/2024 03:28:08 PM
// Design Name: 
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
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
    output [2:0]led,
    output [3:0]JA,
    output [3:0]an // common anodes of 4 digit display, Active low (to turn glowing display off)
    );
    wire locked;
    wire CLK_OUT;
    wire COUNT;    
    
  assign led = { COUNT, locked, btnC };
  assign JA  = { COUNT, CLK_OUT, locked, btnC };

  // tie 4-digit 7-segment display anodes to 1 (PNP transistor off) to stop glowing display
  genvar ii;
  for(ii=0 ; ii<4 ;ii = ii+1) begin: gen_anx_obuf
    OBUF anx_obuf ( .I(1'b1), .O(an[ii]) );
  end
    
  clk_wiz_0_exdes exdes_inst1 (// Clock in ports
    // Reset for logic in example design
    .COUNTER_RESET      (btnC),
    .CLK_OUT            (CLK_OUT), // must be always FPGA Output, because it uses ODDR
    // High bits of the counters
    .COUNT              (COUNT),
    // Status and control signals
    .reset              (btnC),
    .locked             (locked),
    .clk_in1            (clk)
);

       
    
endmodule
