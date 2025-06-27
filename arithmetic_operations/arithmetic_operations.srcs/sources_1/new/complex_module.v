`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 19:58:11
// Design Name: 
// Module Name: complex_module
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


module complex_module(
    input clk, ce,
    input signed [17:0]A,
    input signed [7:0]B,
    input signed [11:0]C,
    input signed [7:0]D,
    input signed [13:0]E,
    input signed [18:0]F,
    output signed [36:0]Y // powinno by� 36
);

wire signed [11:0]del_c;
wire signed [12:0]b_long;
wire signed [10:0]d_long;
wire signed [17:0]e_long;
wire signed [18:0]X1;
wire signed [14:0]X2;
//wire signed [14:0]del_X2;
wire signed [19:0]X3;
//wire signed [19:0]del_X3;
wire signed [30:0]X4;
//wire signed [30:0]del_X4;
wire signed [34:0]X5;
//wire signed [34:0]del_X5;
wire signed [35:0]x5_long;

assign b_long = {B, 5'b0};
assign d_long = {D, 3'b0};
assign e_long = {E, 4'b0};
assign x5_long = {X5, 1'b0};

delay_line #(
    .DELAY(1),
    .N(18)
) delay_1 (
    .clk(clk),
    .idata(C),
    .odata(del_c)
);

//delay_line #(
//    .DELAY(0),
//    .N(15)
//) delay_2 (
//    .clk(clk),
//    .idata(X2),
//    .odata(del_X2)
//);

//delay_line #(
//    .DELAY(0),
//    .N(20)
//) delay_3 (
//    .clk(clk),
//    .idata(X3),
//    .odata(del_X3)
//);

//delay_line #(
//    .DELAY(1),
//    .N(31)
//) delay_4 (
//    .clk(clk),
//    .idata(X4),
//    .odata(del_X4)
//);

//delay_line #(
//    .DELAY(1),
//    .N(35)
//) delay_5 (
//    .clk(clk),
//    .idata(X5),
//    .odata(del_X5)
//);

// A: z9c8u + B: z4c3u
// S: z10c8u
// latencja: 1
c_addsub_1 adder_1 (
    .CLK(clk),
    .CE(ce),
    .A(A),
    .B(b_long),
    .S(X1)
);

mult_gen_1 mult_1 (
    .CLK(clk),
    .CE(ce),
    .A(X1),
    .B(del_c),
    .P(X4)
);

// A: z5c2u + B: z8c5u
// S: z9c5u
// latencja: 1
c_addsub_2 adder_2 (
    .CLK(clk),
    .CE(ce),
    .A(d_long),
    .B(E),
    .S(X2)
);

// A: z8c5u + B: z9c9u
// S: z10c9u
// latencja: 1
c_addsub_3 adder_3 (
    .CLK(clk),
    .CE(ce),
    .A(e_long),
    .B(F),
    .S(X3)
);

mult_gen_2 mult_2 (
    .CLK(clk),
    .CE(ce),
    //.A(del_X2),
    .A(X2),
    //.B(del_X3),
    .B(X3),
    .P(X5)
);

c_addsub_4 adder_4 (
    .CLK(clk),
    .CE(ce),
    //.A(del_X4),
    .A(X4),
    //.B(del_X5),
    .B(x5_long),
    .S(Y)
);

//assign Y = X;

endmodule
