`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 16:39:55
// Design Name: 
// Module Name: tb_state_machine_receiver
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


module tb_state_machine_receiver();

reg clk = 0;
reg rst = 0;
wire [7:0]in_data;
wire send;
wire [7:0]out_data;
wire txd;

reg [7:0]cnt = 0;
initial
begin
    while(1)
    begin
        if (cnt == 196) $finish;
        #1; clk = 1; 
        #1; clk = 0;
        cnt = cnt + 1;
    end
end

state_machine_receiver receiver (
    .clk(clk),
    .rst(rst),
    .rxd(txd),
    .data(out_data),
    .received(received)
);

state_machine transmitter (
    .clk(clk),
    .rst(rst),
    .send(send),
    .data(in_data),
    .txd(txd)
);

input_data sim_in (
    .data(in_data),
    .send(send)
);

char_output sim_out (
    .received(received),
    .data(out_data)
);

endmodule
