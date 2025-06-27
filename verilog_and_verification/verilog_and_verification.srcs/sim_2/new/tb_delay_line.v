`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 18:33:10
// Design Name: 
// Module Name: tb_delay_line
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


module tb_delay_line
#(
    N = 8,
    DELAY = 3
)
();
    
reg clk = 1'b0;
reg [N-1:0]idata = 8'b11010010;
wire [N-1:0]odata;

initial
begin
    while(1)
    begin
        #1 clk=1'b0;
        #1 clk=1'b1;
        if (idata == odata) $finish;
    end
end


delay_line
#(
    .N(N),
    .DELAY(DELAY)
) dut
(
    .clk(clk),
    .idata(idata),
    .odata(odata)
);

endmodule
