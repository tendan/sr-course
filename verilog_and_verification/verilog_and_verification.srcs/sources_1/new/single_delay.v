`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2025 11:03:44 AM
// Design Name: 
// Module Name: single_delay
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


module single_delay
#(
    parameter N = 1
)
(
    input clk,
    //input ce,
    input [N-1:0]d,
    output [N-1:0]q
);

reg [N-1:0]val = 0;

always @(posedge clk)
begin
    if(clk) val <= d;
    else val <= val;
end

assign q = val;

endmodule
