`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2025 11:08:34 AM
// Design Name: 
// Module Name: tb_rgb2ycbcr
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


module tb_rgb2ycbcr();

wire clk;
wire rx_de, rx_hsync, rx_vsync;

wire [7:0] rx_red;
wire [7:0] rx_green;
wire [7:0] rx_blue;

wire tx_de, tx_hsync, tx_vsync;

wire [7:0] tx_red;
wire [7:0] tx_green;
wire [7:0] tx_blue;

rgb2ycbcr conv (
    .clk(clk),
    .de_in(rx_de),
    .hsync_in(rx_hsync),
    .vsync_in(rx_vsync),
    .de_out(tx_de),
    .hsync_out(tx_hsync),
    .vsync_out(tx_vsync),
    .pixel_in({rx_red, rx_green, rx_blue}),
    .pixel_out({tx_red, tx_green, tx_blue})
);

// --------------------------------------
// HDMI input
// --------------------------------------
hdmi_in file_input (
    .hdmi_clk(clk), 
    .hdmi_de(rx_de), 
    .hdmi_hs(rx_hsync), 
    .hdmi_vs(rx_vsync), 
    .hdmi_r(rx_red), 
    .hdmi_g(rx_green), 
    .hdmi_b(rx_blue)
    );
 
// --------------------------------------
// Output assigment
// --------------------------------------
assign tx_red = rx_red;
assign tx_green = rx_green;
assign tx_blue = rx_blue;

// --------------------------------------
// HDMI output
// --------------------------------------
hdmi_out file_output (
    .hdmi_clk(clk), 
    .hdmi_vs(tx_vsync), 
    .hdmi_de(tx_de), 
    .hdmi_data({8'b0,tx_red,tx_green,tx_blue})
    );

endmodule
