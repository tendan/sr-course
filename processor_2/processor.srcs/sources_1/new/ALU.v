`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2025 08:02:51 PM
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [7:0]rx,
    input [7:0]imm,
    output [7:0]and_result,
    output [7:0]add_result,
    output [7:0]zero_comp_result,
    output [7:0]imm_mux
    );
    
assign and_result = rx & imm;
assign add_result = rx + imm;
assign zero_comp_result = rx == 0;
assign imm_mux = imm;

endmodule
