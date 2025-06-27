`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2025 00:13:21
// Design Name: 
// Module Name: vis_centroid
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


module vis_centroid #(
    parameter IMG_W = 1080,
    parameter IMG_H = 1920
)(
    input clk,
    input [10:0]x,
    input [10:0]y,
    input de,
    input vsync,
    input hsync,
    input [23:0]i_pixel,
    output [23:0]o_pixel,
    output de_out,
    output vsync_out,
    output hsync_out
    );
    
reg [10:0]x_pos;
reg [10:0]y_pos;

reg prev_vsync = 0;
    
always @(posedge clk)
begin
    prev_vsync <= vsync;
    if (vsync) begin
        x_pos <= 0;
        y_pos <= 0;
    end else if (de) begin
        x_pos <= x_pos + 1;
        if (x_pos == IMG_W - 1) begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
            if (y_pos == IMG_H - 1) begin
                y_pos <= 0;
            end
        end
    end
end

assign {de_out, vsync_out, hsync_out} = {de, vsync, hsync};

assign o_pixel = ((x_pos == x || y_pos == y) ? 24'hff0000 : i_pixel);
endmodule
