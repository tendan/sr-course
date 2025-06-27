`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2025 23:21:14
// Design Name: 
// Module Name: state_machine_receiver
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


module state_machine_receiver(
    input clk,
    input rst,
    input rxd,
    output [7:0]data,
    output received
    );

localparam STATE0 = 0;
localparam STATE1 = 1;
localparam STATE2 = 2;
localparam STATE3 = 3;

reg [1:0]state = STATE0;
//reg r_rxd = 0;
//reg r_send = 0;
reg r_received = 0;

reg [7:0]r_data = 0;
reg [2:0]counter = 0;

always @(posedge clk)
begin
    if (rst) state = STATE0;
    else
    begin
        case (state)
            STATE0: begin
                if (rxd)
                begin
                    state = STATE1;
                end
            end
            STATE1: begin
                r_data[counter] = rxd;
                counter = counter + 1;
                if (counter == 0) state = STATE2;
            end
            STATE2: begin
                if (~rxd) r_received = 1;
                state = STATE3;
            end
            STATE3: begin
                r_received = 0;
                r_data = 0;
                state = STATE0;
            end
        endcase
    end
end

assign data = r_data; 
assign received = r_received;

endmodule
