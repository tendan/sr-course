`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/24/2025 10:48:21 AM
// Design Name: 
// Module Name: tb_operation
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


module tb_operation();

reg clk = 0;
reg ce = 0;
reg signed [15:0]A = 'b0101001011001110; // 0.32345
//reg signed [2:0]B = 0'b001; // 0.5
reg signed [15:0]B = 'b1001101100110101; // -0.78743
reg signed [15:0]C = 'b0100100001011100; // 0.56532
wire signed [33:0]out;

initial
begin
    ce = 1;
    while (1)
    begin
        #1; clk = 1;
        #1; clk = 0;
    end
end

initial
begin
    #6;
    //if (out != 0'b1000) $display("Error occured with operation %b, %b, %b", A, B, C);
    //#3;
    $finish;
end

operation dut
(
    .clk(clk),
    .ce(ce),
    .A(A),
    .B(B),
    .C(C),
    .out(out)
);

endmodule
