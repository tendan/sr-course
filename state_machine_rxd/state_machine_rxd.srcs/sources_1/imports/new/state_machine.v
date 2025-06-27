`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 10:05:21 AM
// Design Name: 
// Module Name: state_machine
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


module state_machine(
    input clk,
    input rst,
    input send,
    input [7:0]data,
    output txd
    );

localparam STATE0 = 0;
localparam STATE1 = 1;
localparam STATE2 = 2;
localparam STATE3 = 3;

reg [1:0]state = STATE0;
reg r_txd = 0;
reg r_send = 0;

reg [7:0]r_data;
reg [2:0]counter = 0;

always @(posedge clk)
begin
    if (rst) state <= STATE0;
    else
    begin
        case (state)
            STATE0: begin
                if (send && ~r_send)
                begin
                    state = STATE1;
                    r_data = data;
                end
                r_send = send;
            end
            STATE1: begin
                r_txd = 1;
                state = STATE2;
                r_send = send;
            end
            STATE2: begin
                r_txd = r_data[counter];
                counter = counter + 1;
                if (counter == 0) state = STATE3;
                r_send = send;
            end
            STATE3: begin
                r_txd = 0;
                state = STATE0;
                r_send = send;
            end
        endcase
    end
end

assign txd = r_txd;

endmodule
