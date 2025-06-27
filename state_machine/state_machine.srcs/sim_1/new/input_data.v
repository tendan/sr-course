`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/17/2025 11:07:06 AM
// Design Name: 
// Module Name: input_data
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


module input_data(
    output [7:0]data,
    output send
    );


integer file;
reg [7:0]t_data;
reg [4:0]i;
reg t_send = 0;

initial
begin
    //file = $fopen("../imports/Downloads/dane_testowe.txt", "rb");
    file = $fopen("dane_testowe.txt", "rb");
    for (i = 0; i < 16; i = i + 1)
    begin
        t_data = $fgetc(file); #24;
    end
    $fclose(file);
end

always
begin
    #2; t_send = 1;
    #2; t_send = 0;
    #20;
end

assign data = t_data;
assign send = t_send;

endmodule
