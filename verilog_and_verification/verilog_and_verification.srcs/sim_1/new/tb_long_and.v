`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2025 10:21:11 AM
// Design Name: 
// Module Name: tb_long_and
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


module tb_long_and
#(
    parameter LENGTH=8
)
();

wire [LENGTH-1:0]x;
wire y;

//reg [LENGTH-1:0]r_x = 8'b11001100;

reg clk=1'b0;
reg [7:0]cnt=8'b00000000;

initial
begin
    while(1)
    begin
        #1 clk=1'b0;
        #1 clk=1'b1;
        if (cnt == 255) $finish;
    end
end

always @(posedge clk)
    begin
        cnt<=cnt+1;
    end
    
assign x = cnt;

long_and dut
(
    .x(x),
    .y(y)
);

endmodule
