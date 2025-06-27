`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/28/2025 10:06:05 AM
// Design Name: 
// Module Name: rgb2ycbcr
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


module rgb2ycbcr (
    input clk,
    input de_in,
    input hsync_in,
    input vsync_in,
    input [23:0]pixel_in,
    output de_out,
    output hsync_out,
    output vsync_out,
    output [26:0]pixel_out
    );

//localparam X = 'b010000010;
    
wire signed [17:0]R; 
wire signed [17:0]G;
wire signed [17:0]B;

assign R = {10'd0, pixel_in[23:16]};
assign G = {10'd0, pixel_in[15:8]};
assign B = {10'd0, pixel_in[7:0]};

wire [35:0]R_Y;
wire [35:0]G_Y;
wire [35:0]B_Y;
 
mult_gen_0 mult_1 (
    .clk(clk),
    .A(R),
    .B(18'b001001100100010111),
    .P(R_Y)
);

mult_gen_0 mult_2 (
    .clk(clk),
    .A(G),
    .B(18'b010010110010001011),
    .P(G_Y)
);

mult_gen_0 mult_3 (
    .clk(clk),
    .A(B),
    .B(18'b000011101001011110),
    .P(B_Y)
);

wire [35:0]R_Cb;
wire [35:0]G_Cb;
wire [35:0]B_Cb;


mult_gen_0 mult_4 (
    .clk(clk),
    .A(R),
    .B(18'b111010100110011011),
    .P(R_Cb)
);

mult_gen_0 mult_5 (
    .clk(clk),
    .A(G),
    .B(18'b110101011001100101),
    .P(G_Cb)
);

mult_gen_0 mult_6 (
    .clk(clk),
    .A(B),
    .B(18'b010000000000000000),
    .P(B_Cb)
);

wire [35:0]R_Cr;
wire [35:0]G_Cr;
wire [35:0]B_Cr;

mult_gen_0 mult_7 (
    .clk(clk),
    .A(R),
    .B(18'b010000000000000000),
    .P(R_Cr)
);

mult_gen_0 mult_8 (
    .clk(clk),
    .A(G),
    .B(18'b110010100110100010),
    .P(G_Cr)
);

mult_gen_0 mult_9 (
    .clk(clk),
    .A(B),
    .B(18'b111101011001011110),
    .P(B_Cr)
);

wire [8:0]RG_Y;
wire [8:0]RGB_Y;
wire [8:0]del_B_Y;

// Y
c_addsub_0 add_1 (
    .ce(1),
    .clk(clk),
    .A({R_Y[35], R_Y[24:17]}),
    .B({G_Y[35], G_Y[24:17]}),
    .S(RG_Y)
);

c_addsub_0 add_2 (
    .ce(1),
    .clk(clk),
    .A(RG_Y),
    .B(del_B_Y),
    .S(RGB_Y)
);

delay_line #(
    .N(9),
    .DELAY(1)
) delay (
    .clk(clk),
    .idata({B_Y[35], B_Y[24:17]}),
    .odata(del_B_Y)
);

wire [8:0]RG_Cb;
wire [8:0]Bc_Cb;
wire [8:0]RGB_Cb;

// Cb
c_addsub_0 add_3 (
    .ce(1),
    .clk(clk),
    .A({R_Cb[35], R_Cb[24:17]}),
    .B({G_Cb[35], G_Cb[24:17]}),
    .S(RG_Cb)
);

c_addsub_0 add_4 (
    .ce(1),
    .clk(clk),
    .A({B_Cb[35], B_Cb[24:17]}),
    .B(9'b010000000),
    .S(Bc_Cb)
);

c_addsub_0 add_5 (
    .ce(1),
    .clk(clk),
    .A(RG_Cb),
    .B(Bc_Cb),
    .S(RGB_Cb)
);

wire [8:0]RG_Cr;
wire [8:0]Bc_Cr;
wire [8:0]RGB_Cr;

// Cr
c_addsub_0 add_6 (
    .ce(1),
    .clk(clk),
    .A({R_Cr[35], R_Cr[24:17]}),
    .B({G_Cr[35], G_Cr[24:17]}),
    .S(RG_Cr)
);

c_addsub_0 add_7 (
    .ce(1),
    .clk(clk),
    .A({B_Cr[35], B_Cr[24:17]}),
    .B(9'b010000000),
    .S(Bc_Cr)
);

c_addsub_0 add_8 (
    .ce(1),
    .clk(clk),
    .A(RG_Cr),
    .B(Bc_Cr),
    .S(RGB_Cr)
);

assign pixel_out = {RGB_Y, RGB_Cb, RGB_Cr};

wire [3:0]sync_delayed;

delay_line #(
    .N(3),
    .DELAY(5)
) del_sync (
    .clk(clk),
    .idata({de_in, hsync_in, vsync_in}),
    .odata(sync_delayed)
);

assign de_out = sync_delayed[2];
assign hsync_out = sync_delayed[1];
assign vsync_out = sync_delayed[0];

endmodule
