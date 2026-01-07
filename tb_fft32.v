`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2025 12:50:04
// Design Name: 
// Module Name: tb_fft32
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


`timescale 1ns/1ps
module tb_fft32;
    reg clk, rst;
    reg signed [15:0] xr, xi;
    reg valid_in;
    wire signed [15:0] yr, yi;
    wire valid_out;

    fft32_radix4 dut (
        .clk(clk), .rst(rst),
        .xr(xr), .xi(xi),
        .valid_in(valid_in),
        .yr(yr), .yi(yi),
        .valid_out(valid_out)
    );

    integer i;
    reg signed [15:0] x_real[0:31];
    reg signed [15:0] x_imag[0:31];

    // Clock
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz

    // Input data
    initial begin
        rst = 1; valid_in = 0;
        #20 rst = 0;

        // Example: impulse at first sample
        for(i=0;i<32;i=i+1) begin
            if(i==0) begin
                xr = 16'sh7FFF; xi = 16'sh0000;
            end else begin
                xr = 16'sh0000; xi = 16'sh0000;
            end
            valid_in = 1;
            #10;
        end
        valid_in = 0;
    end

    // Monitor output
    initial begin
        $monitor("Time=%0t: yr=%h, yi=%h, valid_out=%b",$time, yr, yi, valid_out);
    end
endmodule