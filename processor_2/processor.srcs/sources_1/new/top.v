`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 08:01:27 PM
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
    input clk100,
    input [3:0]sw,
    output [3:0]led
    );
    
reg clk = 0;

integer counter = 0;
always @(posedge clk100)
begin
    if (counter >= 50_000_000)
    begin
        clk = ~clk;
        counter = 0;
    end else counter = counter + 1;
end

processor proc (
    .clk(clk),
    .gpi({4'b0, sw}),
    .gpo({4'b0, led})
);

endmodule
