`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2025 17:12:27
// Design Name: 
// Module Name: char_output
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


module char_output(
    input received,
    input [7:0]data
    );

integer file;
reg [7:0]i;

initial
begin
    #3; file = $fopen("dane_wyjsciowe_tekst.txt","w");
    for (i=0;i<16*(12+1);i=i+1)
    begin
        if (received) $fwrite(file, "%c", data);
        #2;
    end
    $fclose(file);
    $stop;
end

endmodule
