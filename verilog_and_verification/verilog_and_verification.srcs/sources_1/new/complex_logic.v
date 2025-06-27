`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2025 20:52:19
// Design Name: 
// Module Name: complex_logic
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


module complex_logic
#(
    parameter N = 16
)
(
    input [N-1:0]x,
    input [N-1:0]y,
    output z
);

//wire [N-1:0]first_row;
//wire [N/2-1:0]second_row;
//wire [N/4-1:0]third_row;
localparam row_count = $clog2(N);
wire [N-1:0]rows[row_count:0];

genvar i, j;
generate
    for (i = 0; i < N; i = i + 1)
    //begin
    //    assign first_row[i] = x[i] & y[i];
    //    if (i < N / 2) assign second_row[i] = first_row[2*i] | first_row[2*i+1];
    //    if (i < N / 4) assign third_row[i] = second_row[2*i] & second_row[2*i+1];
    //end
    begin
        assign rows[0][i] = x[i] & y[i]; // Wype³niamy pierwszy wiersz AND-ami
        for (j = 1; j <= row_count; j = j + 1) // Idziemy po kolejnych wierszach, których jest log2(N)
        begin
            assign rows[j][i] = j % 2 == 0 
                ? rows[j-1][2*i] & rows[j-1][2*i+1] 
                : rows[j-1][2*i] | rows[j-1][2*i+1];
        end
    end
    //if (row_count % 2 == 0)
    //    assign z = rows[row_count-1][0] & rows[row_count-1][1];
    //else
    //    assign z = rows[row_count-1][0] | rows[row_count-1][1];
endgenerate

assign z = rows[row_count][0]; // Ostatnia zwrócona wartoœæ logiczna - jednoelementowy wiersz

endmodule
