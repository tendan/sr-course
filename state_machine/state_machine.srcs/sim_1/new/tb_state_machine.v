`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 10:45:46 AM
// Design Name: 
// Module Name: tb_state_machine
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


module tb_state_machine();

reg clk = 0;
reg rst = 0;
wire send;
wire [7:0]data;
wire txd;

reg [7:0]cnt = 0;
initial
begin
    while(1)
    begin
        if (cnt == 195) $finish;
        #1; clk = 1;
        #1; clk = 0;
        cnt = cnt + 1;
    end
end

state_machine dut (
    .clk(clk),
    .rst(rst),
    .send(send),
    .data(data),
    .txd(txd)
);

input_data idata (
    .data(data),
    .send(send)
);

output_data odata (
    .txd(txd)
);

endmodule
