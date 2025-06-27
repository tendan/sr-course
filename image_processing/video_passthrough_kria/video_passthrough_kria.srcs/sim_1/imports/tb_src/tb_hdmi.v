`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: AGH
// Engineer: Tomasz Kryjak
// 
// Create Date:    11:29:28 10/28/2013 
// Design Name: 
// Module Name:    tb_filter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module tb_hdmi(
    );
	 

wire rx_pclk;

wire [3:0]sw;

wire rx_de;
wire rx_hsync;
wire rx_vsync;

wire [7:0] rx_red;
wire [7:0] rx_green;
wire [7:0] rx_blue;
wire [23:0] rx_pixel_out;

//wire tx_de;
//wire tx_hsync;
//wire tx_vsync;

//wire [7:0] tx_red;
//wire [7:0] tx_green;
//wire [7:0] tx_blue;
//wire [23:0] tx_pixel_out;

wire vs_rx_de;
wire vs_rx_hsync;
wire vs_rx_vsync;


// --------------------------------------
// HDMI input
// --------------------------------------
hdmi_in file_input (
    .hdmi_clk(rx_pclk), 
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
//assign tx_de = rx_de;
//assign tx_hsync = rx_hsync;
//assign tx_vsync = rx_vsync;
//assign tx_red = rx_red;
//assign tx_green = rx_green;
//assign tx_blue = rx_blue;
//assign tx_pixel_out = rx_pixel_out;

// --------------------------------------
// HDMI output
// --------------------------------------
hdmi_out file_output (
    .hdmi_clk(rx_pclk), 
    .hdmi_vs(vs_rx_vsync), 
    .hdmi_de(vs_rx_de), 
    .hdmi_data({8'b0, rx_pixel_out})
    );
    
// --------------------------------------
// Vision system
// --------------------------------------
vision_system vs (
    .clk(rx_pclk),
    .sw(sw),
    .de_in(rx_de),
    .hsync_in(rx_hsync),
    .vsync_in(rx_vsync),
    .pixel_in({rx_red,rx_green,rx_blue}),
    .de_out(vs_rx_de),
    .hsync_out(vs_rx_hsync),
    .vsync_out(vs_rx_vsync),
    .pixel_out(rx_pixel_out)
);

endmodule