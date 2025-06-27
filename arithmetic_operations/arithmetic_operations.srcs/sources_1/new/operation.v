`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2025 10:08:50 AM
// Design Name: 
// Module Name: operation
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


module operation(
    input clk,
    input ce,
    input signed [15:0]A,
    input signed [15:0]B,
    input signed [15:0]C,
    output signed [33:0]out
    );
    
wire signed [17:0]x;
wire [16:0]w_B;
wire [15:0]w_C;

assign w_B = {B, 1'b0};

// Latency - 2
c_addsub_5 adder
(
    .CLK(clk),
    .CE(ce),
    .A(A),
    .B(w_B),
    .S(x)
);

mult_gen_3 mult
(
    .CLK(clk),
    .CE(ce),
    .A(x),
    .B(w_C),
    .P(out)
);

delay_line
#(
    .DELAY(2),
    .N(16)
)
delay
(
    .clk(clk),
    .idata(C),
    .odata(w_C)
);

endmodule
