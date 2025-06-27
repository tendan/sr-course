`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2025 22:59:34
// Design Name: 
// Module Name: tb_or_gate
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


module tb_or_gate(

    );
reg [9:0]i = 0;
integer file;
wire o;

initial
begin
    file = $fopen("log", "w");
    #1; if (o != 0) $fwrite(file, "Incorrect logic for %d\n", i);
    for (i=1; i < 1024; i = i + 1)
    begin
        #1; if (o != 1) $fwrite(file, "Incorrect logic for %d\n", i);
    end
    $fclose(file);
    $stop; $finish;
end

or_gate dut (
    .i(i),
    .o(o)
);

endmodule
