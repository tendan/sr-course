`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/26/2025 10:12:01 AM
// Design Name: 
// Module Name: processor
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


module processor(
    input clk
    );

wire [7:0]alu_res;
wire [31:0]instr;
wire [7:0]data_mem;

i_mem instructions (
    .address(registers[7]),
    .data(instr)
);

d_mem data (
    .address(alu_res),
    .data(data_mem)
);

wire [7:0]registers[7:0];
wire [7:0]rd_mux_out;

wire [1:0]pc_op = instr[25:24];
wire [1:0]alu_op = instr[21:20];
wire [2:0]rx_op = instr[18:16];
wire imm_op = instr[15];
wire [2:0]ry_op = instr[14:12];
wire rd_op = instr[11];
wire [2:0]d_op = instr[10:8];
wire [7:0]imm = instr[7:0];

// Mux-es
wire [7:0]pc_mux[1:0];
wire [7:0]rx_mux[7:0];
wire [7:0]ry_mux[7:0];
wire [7:0]imm_mux[1:0];
wire [7:0]alu_mux[3:0];
wire [7:0]rd_mux[1:0];

assign pc_mux[0] = registers[7] + 1;
assign pc_mux[1] = alu_res;
reg [1:0]op_select = 0;
wire [7:0]pc_out = pc_mux[op_select];

register R0(
    .clk(clk),
    .ce(d_op == 0),
    .in(rd_mux_out),
    .out(registers[0])
    );
register R1(
    .clk(clk),
    .ce(d_op == 1),
    .in(rd_mux_out),
    .out(registers[1])
    );
register R2(
    .clk(clk),
    .ce(d_op == 2),
    .in(rd_mux_out),
    .out(registers[2])
    );
register R3(
    .clk(clk),
    .ce(d_op == 3),
    .in(rd_mux_out),
    .out(registers[3])
    );
register R4(
    .clk(clk),
    .ce(d_op == 4),
    .in(rd_mux_out),
    .out(registers[4])
    );
register R5(
    .clk(clk),
    .ce(d_op == 5),
    .in(rd_mux_out),
    .out(registers[5])
    );
register R6(
    .clk(clk),
    .ce(d_op == 6),
    .in(0),
    .out(registers[6])
    );    
register R7(
    .clk(clk),
    .ce(1),
    .in(pc_out),
    .out(registers[7])
    );

assign {
    rx_mux[7], rx_mux[6], rx_mux[5], rx_mux[4],
    rx_mux[3], rx_mux[2], rx_mux[1], rx_mux[0]
} = {
    registers[7], registers[6], registers[5], registers[4],
    registers[3], registers[2], registers[1], registers[0]
};
wire [7:0]rx_out = rx_mux[rx_op];

assign {
    ry_mux[7], ry_mux[6], ry_mux[5], ry_mux[4],
    ry_mux[3], ry_mux[2], ry_mux[1], ry_mux[0]
} = {
    registers[7], registers[6], registers[5], registers[4],
    registers[3], registers[2], registers[1], registers[0]
};
wire [7:0]ry_out = ry_mux[ry_op];

assign imm_mux[0] = ry_out;
assign imm_mux[1] = imm;
wire [7:0]imm_out = imm_mux[imm_op];

ALU alu_1 (
    .rx(rx_out),
    .imm(imm_out),
    .and_result(alu_mux[0]),
    .add_result(alu_mux[1]),
    .zero_comp_result(alu_mux[2]),
    .imm_mux(alu_mux[3])
);
wire [7:0]cmp_res = alu_mux[2];
assign alu_res = alu_mux[alu_op];

reg is_zero;

always @*
begin
    is_zero = cmp_res[0];
    if (pc_op == 1) op_select = 1; // jump
    else if (pc_op == 2) // jnz
    begin
        if (~is_zero) op_select = 1;
        else op_select = 0;
    end
    else if (pc_op == 3) // jz
    begin
        if (is_zero) op_select = 1;
        else op_select = 0;
    end
    else op_select = 0; // nieobsłużony operator, zrób mov/movi
end

assign rd_mux[0] = alu_res;
assign rd_mux[1] = data_mem;
assign rd_mux_out = rd_mux[rd_op];

endmodule
