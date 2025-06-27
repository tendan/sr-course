`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2025 10:08:10 AM
// Design Name: 
// Module Name: vision_system
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


module vision_system(
    input clk,
    input [3:0]sw,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [23:0]pixel_out
    );

wire [7:0]red;
wire [7:0]green;
wire [7:0]blue;

wire [23:0]rgb_mux[15:0];
wire de_mux[15:0];
wire hsync_mux[15:0];
wire vsync_mux[15:0];

LUT red_lut (
    .a(pixel_in[23:16]),
    .clk(clk),
    .qspo(red)
);

LUT green_lut (
    .a(pixel_in[15:8]),
    .clk(clk),
    .qspo(green)
);

LUT blue_lut (
    .a(pixel_in[7:0]),
    .clk(clk),
    .qspo(blue)
);

wire [8:0]y;
wire [8:0]cb;
wire [8:0]cr;

wire de_conv;
wire hsync_conv;
wire vsync_conv;

assign de_mux[0] = de_in;
assign de_mux[1] = de_mux[0];
assign hsync_mux[0] = hsync_in;
assign hsync_mux[1] = hsync_mux[0];
assign vsync_mux[0] = vsync_in;
assign vsync_mux[1] = vsync_mux[0];

rgb2ycbcr_0 conv (
    .clk(clk),
    .de_in(de_mux[0]),
    .hsync_in(hsync_mux[0]),
    .vsync_in(vsync_mux[0]),
    .pixel_in(pixel_in),
    .de_out(de_mux[2]),
    .hsync_out(hsync_mux[2]),
    .vsync_out(vsync_mux[2]),
    .pixel_out({y, cb, cr})
);

assign de_mux[3] = de_mux[2];
assign de_mux[4] = de_mux[2];
assign hsync_mux[3] = hsync_mux[2];
assign hsync_mux[4] = hsync_mux[2];
assign vsync_mux[3] = vsync_mux[2];
assign vsync_mux[4] = vsync_mux[2];

wire [7:0]monochrome = red & green & blue;

localparam Ta = 85;
localparam Tb = 135;
localparam Tc = 135;
localparam Td = 180;

wire [7:0]bin;

assign bin = (cb > Ta && cb < Tb && cr > Tc && cr < Td) ? 8'd255 : 0;

wire de_median;
wire hsync_median;
wire vsync_median;

wire [7:0]filtered_bin;

median5x5 #(
    .H_SIZE(83)
) median (
    .clk(clk),
    .de(de_mux[2]),
    .vsync(vsync_mux[2]),
    .hsync(hsync_mux[2]),
    .mask(bin[0]),
    //input [7:0]in,
    .out(filtered_bin),
    .de_out(de_mux[7]),
    .vsync_out(vsync_mux[7]),
    .hsync_out(hsync_mux[7])
);

wire [10:0]c_x;
wire [10:0]c_y;

//localparam IMG_W = 64;
localparam IMG_W = 1920;
//localparam IMG_H = 64;
localparam IMG_H = 1080;

centroid #(
    .IMG_H(IMG_H),
    .IMG_W(IMG_W)
) cent (
    .clk(clk),
    .ce(1),
    .rst(1),
    .de(de_mux[7]),
//    .de(de_conv),
    .hsync(hsync_mux[7]),
//    .hsync(hsync_conv),
    .vsync(vsync_mux[7]),
//    .vsync(vsync_conv),
    .mask(filtered_bin[0]),
    .x(c_x), //1920
    .y(c_y) //1080
);

wire [23:0]monochrome_red;

vis_centroid #(
    .IMG_H(IMG_H),
    .IMG_W(IMG_W)
) vis_cent (
    .clk(clk),
    .x(c_x),
    .y(c_y),
    .de(de_mux[7]),
//    .de(de_conv),
    .vsync(vsync_mux[7]),
//    .vsync(vsync_conv),
    .hsync(hsync_mux[7]),
    .i_pixel({filtered_bin, filtered_bin, filtered_bin}),
    .o_pixel(monochrome_red),
    .de_out(de_mux[6]),
    .vsync_out(vsync_mux[6]),
    .hsync_out(hsync_mux[6])
);

// orygina�
assign rgb_mux[0] = pixel_in;
// LUT
assign rgb_mux[1] = {red, green, blue};
// binaryzacja
assign rgb_mux[2] = {monochrome, monochrome, monochrome};
// ycbcr
assign rgb_mux[3] = {y[7:0], cb[7:0], cr[7:0]};
// progowanie
assign rgb_mux[4] = {bin, bin, bin};
// centroid
assign rgb_mux[5] = {c_x | c_y, c_x | c_y, c_x | c_y};
// vis_centroid
//assign rgb_mux[6] = {monochrome_red, bin, bin};
assign rgb_mux[6] = monochrome_red;
// median
assign rgb_mux[7] = {filtered_bin, filtered_bin, filtered_bin};

//assign pixel_out = {red, green, blue} > 'b1000_0000_1000_0000_1000_0000 ? {8'd255, 8'd255, 8'd255} : {8'b0, 8'b0, 8'b0};
assign pixel_out = rgb_mux[sw];

//assign de_out = de_median;
assign de_out = de_mux[sw];
//assign hsync_out = hsync_median;
assign hsync_out = hsync_mux[sw];
//assign vsync_out = vsync_median;
assign vsync_out = vsync_mux[sw];

endmodule
