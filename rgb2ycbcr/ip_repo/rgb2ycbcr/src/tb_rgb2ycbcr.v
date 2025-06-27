`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2025 20:23:21
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


module tb_rgb2ycbcr(

    );
reg clk;

reg rx_de=1'b0;
wire tx_de;
reg rx_vsync=1'b0;
wire tx_vsync;
reg rx_hsync=1'b0;
wire tx_hsync;

reg [7:0]rx_red;
reg [7:0]rx_green;
reg [7:0]rx_blue;

wire [8:0]tx_y;
wire [8:0]tx_cb;
wire [8:0]tx_cr;

initial
begin
  while(1)
  begin
    #1 clk=1'b0;
	#1 clk=1'b1;
  end
end

initial
begin
    while (1)
    begin
        #2 rx_de = 'b0; rx_vsync=1'b0; rx_hsync=1'b0;
        #2 rx_de = 'b1; rx_vsync=1'b1; rx_hsync=1'b1;
    end
end

initial
begin
    #2
    //rx_red = 8'b00000011; //3
    //rx_green = 8'b00010010; //18
    //rx_blue = 8'b10000001; //129
    rx_red = 8'd122;
    rx_green = 8'd88;
    rx_blue = 8'd169;
    $finish;
end

wire [26:0]ycbcr;

rgb2ycbcr conv (
    .clk(clk),
    .de_in(rx_de),
    .hsync_in(rx_hsync),
    .vsync_in(rx_vsync),
    .de_out(tx_de),
    .hsync_out(tx_hsync),
    .vsync_out(tx_vsync),
    .pixel_in({rx_red, rx_green, rx_blue}),
    .pixel_out(ycbcr)
);

assign tx_y = ycbcr[26:18];
assign tx_cb = ycbcr[17:9];
assign tx_cr = ycbcr[8:0];

endmodule
