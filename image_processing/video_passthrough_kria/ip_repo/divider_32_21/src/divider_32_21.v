`timescale 1ns / 1ps
//-----------------------------------------------
// Company: agh
// Engineer: komorkiewicz
// Create Date: 04/18/2012 
// Description: divider core using successive approximation method
//-----------------------------------------------
module divider_32_21 #
(
  parameter LATENCY=4,
  parameter DIVIDEND_W=32,
  parameter DIVISOR_W=21,
  parameter QUOTIENT_W=32
)
(
  input clk,
  input start,
  input [DIVIDEND_W-1:0]dividend,
  input [DIVISOR_W-1:0]divisor,
  output [QUOTIENT_W-1:0]quotient,
  output qv
);
//-----------------------------------------------
reg [DIVIDEND_W-1:0] dividend_reg = 0;
reg [DIVISOR_W-1:0] divisor_reg = 0;

reg [QUOTIENT_W-1:0]sar=0;
wire [DIVISOR_W+QUOTIENT_W-1:0]mul_res;
reg [7:0]i;
reg [7:0]lat_cnt;
reg rv_reg=1'b0;
reg [QUOTIENT_W-1:0]result_reg;
//-----------------------------------------------
mult_32_21_lm instance_name 
(
  .clk(clk), 
  .a(sar), 
  .b(divisor_reg), 
  .p(mul_res)
);
//-----------------------------------------------
localparam IDLE=2'b00;
localparam DIV=2'b01;
localparam NOP=2'b10;
localparam END=2'b11;
reg [1:0]state=IDLE;
//-----------------------------------------------
always @(posedge clk)
begin
  rv_reg<=1'b0;
  
  case(state)
    IDLE:
	 begin
      i<=QUOTIENT_W-1;
	   sar<=0;
	   if(start)
		begin		
			state<=DIV;
			dividend_reg <= dividend;
			divisor_reg <= divisor;
		end
	 end
    DIV:
	 begin
      sar[i]<=1;
		lat_cnt<=LATENCY;
		state<=NOP;
	 end
    NOP:
	 begin
      lat_cnt<=lat_cnt-1;
		if(lat_cnt==0)
		begin
		  if(mul_res>dividend_reg) sar[i]<=0;
        i<=i-1;
		  if(i==0) state<=END;
		  else state<=DIV;
		end
	 end
	 END:
	 begin
      rv_reg<=1'b1;
		result_reg<=sar;
		state<=IDLE;
	 end
  endcase
end
//-----------------------------------------------
assign quotient=result_reg;
assign qv=rv_reg;
//-----------------------------------------------
endmodule
//-----------------------------------------------
