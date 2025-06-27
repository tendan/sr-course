`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/10/2025 11:05:42 AM
// Design Name: 
// Module Name: delay_line
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


module delay_line
#(
    parameter DELAY = 0,
    parameter N = 1
)
(
    input clk,
    input [N-1:0]idata,
    output [N-1:0]odata
);

wire [N-1:0] tdata [DELAY:0];

genvar i;
generate
    for (i=0;i<DELAY;i=i+1)
    begin
        single_delay 
        #(
            .N(N)
        )
        dl_i
        (
            .clk(clk),
            .d(tdata[i]),
            .q(tdata[i+1])
        );
    end
endgenerate

assign tdata[0] = idata;
assign odata = tdata[DELAY];

endmodule
