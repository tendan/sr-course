`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2025 17:13:34
// Design Name: 
// Module Name: median5x5
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


module median5x5 #(
//    parameter H_SIZE = 83
    parameter H_SIZE = 2200
) (
    input clk,
    input de,
    input vsync,
    input hsync,
    input mask,
    //input [7:0]in,
    output [7:0]out,
    output de_out, vsync_out, hsync_out
    );
    
reg [15:0]pixel_in;
wire [15:0]pixel_out;
//assign pixel_in = {mask, de, hsync, vsync};

reg [3:0]d12; reg [3:0]d13; reg [3:0]d14; reg [3:0]d15;
reg [3:0]d22; reg [3:0]d23; reg [3:0]d24; reg [3:0]d25;
reg [3:0]d32; reg [3:0]d33; reg [3:0]d34; reg [3:0]d35;
reg [3:0]d42; reg [3:0]d43; reg [3:0]d44; reg [3:0]d45;
reg [3:0]d52; reg [3:0]d53; reg [3:0]d54; reg [3:0]d55;

delayLineBRAM_WP long_delay (
    .clk(clk),
    .rst(0),
    .ce(1),
    .din(pixel_in),
    .dout(pixel_out),
    .h_size(H_SIZE - 5)
);

reg [2:0]D1 = 0;
reg [2:0]D2 = 0;
reg [2:0]D3 = 0;
reg [2:0]D4 = 0;
reg [2:0]D5 = 0;

reg [4:0]sum = 0;

reg context_valid;
reg context_1 = 0;
reg context_2 = 0;
reg context_3 = 0;
reg context_4 = 0;
reg context_5 = 0;

wire [3:0]central_in;
assign central_in = d33;
wire [3:0]central_out;

delay_line #(
    .N(4),
    .DELAY(2)
) sync_delay (
    .clk(clk),
    .idata(central_in),
    .odata(central_out)
);

assign de_out = central_out[2];
assign hsync_out = central_out[1];
assign vsync_out = central_out[0];

//genvar i;
//generate
always @(posedge clk)
begin
    pixel_in <= {d15, 
        d25,
        d35,
        d45
       };
    // pierwszy rz�d
    d12 <= {mask, de, hsync, vsync};
    //for (i = 0; i < 25; i = i + 1)
    //begin
    //    short_delays[i+1] <= (i+1) % 5 == 0 ? pixel_out : short_delays[i];
    //end
    //d12 <= d11;
    d13 <= d12;
    d14 <= d13;
    d15 <= d14;
    
    //pixel_in = short_delays[4];
    //short_delays[5] = pixel_out;
    //d21 <= pixel_out[15:12];
    d22 <= pixel_out[15:12];
    
    // drugi rz�d
    //d22 <= d21;
    d23 <= d22;
    d24 <= d23;
    d25 <= d24;
    
    //pixel_in = short_delays[9];
    //short_delays[10] = pixel_out;
    //d31 <= pixel_out[11:8];
    d32 <= pixel_out[11:8];
    
    // trzeci rz�d
    //d32 <= d31;
    d33 <= d32;
    d34 <= d33;
    d35 <= d34;
    
    //pixel_in = short_delays[14];
    //short_delays[15] = pixel_out;
    //d41 <= pixel_out[7:4];
    d42 <= pixel_out[7:4];
    
    // czwarty rz�d
    //d42 <= d41;
    d43 <= d42;
    d44 <= d43;
    d45 <= d44;
    
    //pixel_in = short_delays[19];
    //short_delays[20] = pixel_out;
    //d51 <= pixel_out[3:0];
    d52 <= pixel_out[3:0];
    
    // pi�ty rz�d
    //d52 <= d51;
    d53 <= d52;
    d54 <= d53;
    d55 <= d54;
    
    //pixel_in = short_delays[24];
    
    D1 <= mask + d12[3]
        + d13[3] + d14[3]
        + d15[3];
    D2 <= pixel_out[15] + d22[3]
        + d23[3] + d24[3]
        + d25[3];
    D3 <= pixel_out[11] + d32[3]
        + d33[3] + d34[3]
        + d35[3];
    D4 <= pixel_out[7] + d42[3]
        + d43[3] + d44[3]
        + d45[3];
    D5 <= pixel_out[3] + d52[3]
        + d53[3] + d54[3]
        + d55[3];
    sum <= D1 + D2 + D3 + D4 + D5;
    
    context_1 <= de & d12[2] & d13[2] & d14[2] & d15[2];
    context_2 <= pixel_out[14] & d22[2] & d23[2] & d24[2] & d25[2];
    context_3 <= pixel_out[10] & d32[2] & d33[2] & d34[2] & d35[2];    
    context_4 <= pixel_out[6] & d42[2] & d43[2] & d44[2] & d45[2];    
    context_5 <= pixel_out[2] & d52[2] & d53[2] & d54[2] & d55[2];
    context_valid <= context_1 & context_2 & context_3 & context_4 & context_5;
end
//endgenerate

wire [7:0]mask_out;
assign mask_out = sum > 5'd12 ? 255 : 0;
assign out = context_valid == 1 ? mask_out : 0;

endmodule
