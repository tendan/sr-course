`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2025 20:36:42
// Design Name: 
// Module Name: output_data
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

module output_data(
    input txd
);

integer file;
reg [7:0]i;

initial
begin
    #3; file = $fopen("dane_wyjsciowe.txt","wb");
    for (i=0;i<16*12;i=i+1)
    begin
        $fwrite(file, "%d", txd);
        #2;
    end
    $fclose(file);
    $stop;
end
    
    
endmodule

