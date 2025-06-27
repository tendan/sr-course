`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2025 08:33:18 PM
// Design Name: 
// Module Name: register
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


module register(
    input clk,
    input ce,
    input [7:0]in,
    output [7:0]out
);

reg [7:0]tmp = 0;

always @(posedge clk)
begin
    if (ce) tmp <= in;
    else tmp <= tmp;
end

assign out = tmp;

endmodule
