`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.05.2025 19:20:51
// Design Name: 
// Module Name: centroid
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


module centroid #(
    parameter IMG_H = 1080,
    parameter IMG_W = 1920
)(
    input clk,
    input ce,
    input rst,
    input de,
    input hsync,
    input vsync,
    input mask,
    output [10:0]x, //1920
    output [10:0]y //1080
    );

reg [10:0]x_pos = 0;
reg [10:0]y_pos = 0;

reg prev_vsync = 0;
wire eof;

always @(posedge clk)
begin
    prev_vsync <= vsync;
    
    if (vsync) begin
        x_pos <= 0;
        y_pos <= 0;
    end
    
    if (de) begin
        x_pos <= x_pos + 1;
        if (x_pos == IMG_W - 1) begin
            x_pos <= 0;
            y_pos <= y_pos + 1;
            if (y_pos == IMG_H - 1) begin
                y_pos <= 0;
            end
        end
    end
    
    if (eof) m00 <= 0;
    else if (mask) m00 <= m00 + 1;
    
    if(qv_x) x_reg <= quotient_2[10:0];
    if(qv_y) y_reg <= quotient_1[10:0];
end

assign eof = (prev_vsync == 1'b0 & vsync == 1'b1) ? 1'b1 : 1'b0;

reg [20:0]m00 = 0;
reg [31:0]m01 = 0;
reg [31:0]m10 = 0;

wire [32:0]m01_reg;
wire [32:0]m10_reg;

//always @(posedge clk)
//begin
//    if (eof) m00 <= 0;
//    else if (mask) m00 <= m00 + 1;
//end

zero_lat_adder zl1 (
    //.ce(mask & de),
    .A(y_pos),
    .B(m01),
    .S(m01_reg)
);

always @(posedge clk)
begin
    if (eof) m01 <= 0;
    else if (mask & de) m01 <= m01_reg[31:0];
end

zero_lat_adder zl2 (
    //.ce(mask & de),
    .A(x_pos),
    //.B({1'd0, m10}),
    .B(m10),
    //.S({1'd0, m10_reg})
    .S(m10_reg)
);

always @(posedge clk)
begin
    if (eof) m10 <= 0;
    else if (mask & de) m10 <= m10_reg[31:0];
end

wire qv_x, qv_y;
wire [31:0]quotient_1;
wire [31:0]quotient_2;

divider_32_21_0 divider1 (
    .clk(clk),
    .start(eof),
    .dividend(m01),
    .divisor(m00),
    .quotient(quotient_1),
    .qv(qv_y)
);

divider_32_21_0 divider2 (
    .clk(clk),
    .start(eof),
    //.dividend({1'd0, m10_reg}),
    .dividend(m10),
    .divisor(m00),
    .quotient(quotient_2),
    .qv(qv_x)
);

reg [10:0]x_reg = 0;
reg [10:0]y_reg = 0;

//always @(posedge clk)
//begin
//    if(qv_x) x_reg <= quotient_2[10:0];
//end

//always @(posedge clk)
//begin
//    if(qv_y) y_reg <= quotient_1[10:0];
//end

assign x = x_reg;
assign y = y_reg;

endmodule
