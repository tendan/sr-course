`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 10:56:31 AM
// Design Name: 
// Module Name: preprocess
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


module preprocess(
    input [23:0]video_in,
    output [23:0]video_out
    );
    
assign video_out = {video_in[15:8], video_in[7:0], video_in[23:16]};

endmodule
