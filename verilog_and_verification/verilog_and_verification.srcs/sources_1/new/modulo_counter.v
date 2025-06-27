`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 20:21:49
// Design Name: 
// Module Name: modulo_counter
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


module modulo_counter
#(
    parameter N = 4,
    parameter WIDTH = $clog2(N)
)
(
    input clk,
    input ce,
    input rst,
    output [WIDTH-1:0]y
);
reg [WIDTH-1:0]val = 0; // init
always @(posedge clk)
    begin
    if(rst) val<=4'b0000;
    else
        if(ce) val<=val+1;
        else val<=val;
    end
assign y=val;
endmodule
