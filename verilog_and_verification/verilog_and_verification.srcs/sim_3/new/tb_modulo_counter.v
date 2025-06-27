`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 20:30:35
// Design Name: 
// Module Name: tb_modulo_counter
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


module tb_modulo_counter
#(
    parameter N = 16,
    parameter WIDTH = $clog2(N)
)();

reg clk=1'b0;
//reg ce;
//reg rst;
wire [WIDTH-1:0]out;

initial
begin
    while(1)
    begin
        #1 clk=1'b0;
        #1 clk=1'b1;
        if (out == (N-1)) $finish;
    end
end

modulo_counter
#(
    .N(N)
)
dut (
    .clk(clk),
    .ce(1),
    .rst(0),
    .y(out)
);

endmodule
