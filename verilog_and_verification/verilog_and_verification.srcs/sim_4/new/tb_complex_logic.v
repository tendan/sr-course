`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 22:57:23
// Design Name: 
// Module Name: tb_complex_logic
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


module tb_complex_logic
#(
    parameter N = 8
)
();

reg [N-1:0]x;
reg [N-1:0]y;
wire z;

//reg clk=1'b0;

initial
begin
    begin
        #10
        x = 8'b10010001;
        y = 8'b11010100;
        #10
        x = 8'b01111101;
        y = 8'b10110100;
        #10
        x = 8'b10010101;
        y = 8'b11010111;
        #10
        x = 8'b10110011;
        y = 8'b11011100;
        #10
        x = 8'b10010111;
        y = 8'b11000100;
        #10
        x = 8'b10110101;
        y = 8'b01000000;
        #10
        x = 8'b10110111;
        y = 8'b11010110;
        #10
        x = 8'b10110011;
        y = 8'b11010100;
        $stop;
    end
end

complex_logic
#(
    .N(N)
)
dut
(
    .x(x),
    .y(y),
    .z(z)
);

endmodule
