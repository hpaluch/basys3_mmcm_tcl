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
    output [3:0]JA
    );
    wire locked;
    wire CLK_OUT;
    wire COUNT;    
    
  assign led = { COUNT, locked, btnC };
  assign JA  = { COUNT, CLK_OUT, locked, btnC };
    
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
