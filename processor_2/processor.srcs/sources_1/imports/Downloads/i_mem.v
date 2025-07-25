`timescale 1ns / 1ps
//-----------------------------------------------
// Company: agh
//-----------------------------------------------
module i_mem
(
  input [7:0]address,
  output [31:0]data
);
//-----------------------------------------------
//instruction memory
wire [31:0]program[255:0];
// ......_{pc_op:2}_.._{alu_op:2}_._{rx_op:3}_{imm_op:1}_{ry_op:3}_{rd_op:1}_{d_op:3}_{imm:8}
//assign program[0]=32'b00000000000000000000000000000000;
//assign program[0] = 32'b000000_00_00_01_0_110_1_000_0_000_00110100; // movi R0, 0x34
//assign program[1] = 32'b000000_00_00_01_0_000_0_110_0_001_00000000; // mov R1, R0
//assign program[2] = 32'b000000_00_00_01_0_001_0_110_0_010_00000000; // mov R2, R1
//assign program[3] = 32'b000000_01_00_11_0_110_1_110_0_110_00000101; // jumpi 0x5
//assign program[4] = 32'b000000_00_00_01_0_110_1_000_0_001_00000000; // movi R1, 0x0
//assign program[5] = 32'b000000_11_00_11_0_001_1_110_0_110_00000111; // jz R1, 0x7
//assign program[6] = 32'b000000_10_00_11_0_001_1_110_0_110_00000100; // jnz R1, 0x4
//assign program[7] = 32'b0; // nop
//assign program[8] = 32'b0; // nop
//assign program[9] = 32'b0; // nop
//assign program[10] = 32'b000000_00_00_01_0_001_1_000_0_001_00000101; // addi R1, 0x5
//assign program[11] = 32'b000000_00_00_01_0_001_0_010_0_011_00000000; // add R3, R1, R2
//assign program[12] = 32'b000000_00_00_00_0_011_0_011_0_100_00000000; // and R4, R3, R3
//assign program[13] = 32'b000000_00_00_00_0_010_1_110_0_101_00110100; // andi R5, R2, 0x34
//assign program[14] = 32'b000000_00_00_01_0_110_1_000_0_100_00000001; // movi R4, 0x1
//assign program[15] = 32'b000000_00_00_11_0_110_0_100_1_010_00000000; // load R2, R4
//assign program[16] = 32'b000000_00_00_11_0_110_1_110_1_001_00000000; // loadi R1, 0x0
//assign program[17] = 32'b000000_01_00_11_0_110_0_110_0_110_00000000; // jump R1

// LEDs
assign program[0] = 32'b000000_00_00_01_0_110_1_110_0_100_00000001; // movi R4, 0x01
assign program[1] = 32'b000000_00_00_01_0_110_1_110_0_100_00000000; // movi R4, 0x00
assign program[2] = 32'b000000_00_00_01_0_110_1_110_0_100_00000010; // movi R4, 0x02
assign program[3] = 32'b000000_00_00_00_0_101_1_110_0_000_00000001; // andi R0, R5, 0x01
assign program[4] = 32'b000000_11_00_11_0_000_1_110_0_110_00000011; // jz R0, 0x3
assign program[5] = 32'b000000_00_00_01_0_110_1_110_0_100_00000100; // movi R4, 0x04
assign program[6] = 32'b000000_00_00_01_0_110_1_110_0_100_00000000; // movi R4, 0x00
assign program[7] = 32'b000000_00_00_01_0_110_1_110_0_100_00001000; // movi R4, 0x08
assign program[8] = 32'b000000_00_00_00_0_101_1_110_0_000_00000010; // andi R0, R5, 0x02
assign program[9] = 32'b000000_11_00_11_0_000_1_110_0_110_00001000; // jz R0, 0x8
assign program[10] = 32'b000000_01_00_11_0_110_1_110_0_110_00000000; // jumpi 0x0


//-----------------------------------------------
assign data=program[address];
//-----------------------------------------------
endmodule
//-----------------------------------------------
