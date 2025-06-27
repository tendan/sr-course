`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2025 11:09:02 AM
// Design Name: 
// Module Name: postprocess
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


module postprocess(
    input [23:0]video_in,
    output [35:0]video_out
    );

assign video_out = {video_in[7:0], 4'b0000, video_in[23:16], 4'b0000, video_in[15:8], 4'b0000};
endmodule
