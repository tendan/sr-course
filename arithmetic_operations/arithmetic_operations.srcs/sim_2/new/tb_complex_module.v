`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2025 20:19:11
// Design Name: 
// Module Name: tb_complex_module
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


module tb_complex_module();

reg clk = 0;
reg ce = 1;
reg signed [17:0]A = 0'b111001101110101001; //z9c8u
reg signed [7:0]B = 0'b00111011; //z4c3u
reg signed [11:0]C = 0'b110110001010; //z4c7u
reg signed [7:0]D = 0'b00100100; //z5c2u
reg signed [13:0]E = 0'b11001110000000; //z8c5u
reg signed [18:0]F = 0'b0010000110100011111; //z9c9u
wire signed [36:0]Y;

initial
begin
    while(1)
    begin
        #1; clk = 1;
        #1; clk = 0;
    end
end

complex_module comp_mod (
    .clk(clk), .ce(ce),
    .A(A),
    .B(B),
    .C(C),
    //input signed [7:0]D,
    .D(D),
    //input signed [13:0]E,
    .E(E),
    //input signed [18:0]F,
    .F(F),
    .Y(Y)
);
endmodule
