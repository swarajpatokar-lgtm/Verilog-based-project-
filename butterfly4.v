`timescale 1ns/1ps
module butterfly4(
    input  signed [15:0] x0_real, x0_imag,
    input  signed [15:0] x1_real, x1_imag,
    input  signed [15:0] x2_real, x2_imag,
    input  signed [15:0] x3_real, x3_imag,
    output signed [15:0] y0_real, y0_imag,
    output signed [15:0] y1_real, y1_imag,
    output signed [15:0] y2_real, y2_imag,
    output signed [15:0] y3_real, y3_imag
);

    // Temporary sums and differences
    wire signed [16:0] t0r = x0_real + x2_real;
    wire signed [16:0] t0i = x0_imag + x2_imag;
    wire signed [16:0] t1r = x0_real - x2_real;
    wire signed [16:0] t1i = x0_imag - x2_imag;
    wire signed [16:0] t2r = x1_real + x3_real;
    wire signed [16:0] t2i = x1_imag + x3_imag;
    wire signed [16:0] t3r = x1_imag - x3_imag; // B-D imaginary swapped for j multiply
    wire signed [16:0] t3i = x3_real - x1_real; // B-D real swapped for j multiply

    // Outputs (shift right 1 to avoid overflow, Q1.15 format)
    assign y0_real = (t0r + t2r) >>> 1;
    assign y0_imag = (t0i + t2i) >>> 1;

    assign y1_real = (t1r + t3r) >>> 1;
    assign y1_imag = (t1i + t3i) >>> 1;

    assign y2_real = (t0r - t2r) >>> 1;
    assign y2_imag = (t0i - t2i) >>> 1;

    assign y3_real = (t1r - t3r) >>> 1;
    assign y3_imag = (t1i - t3i) >>> 1;

endmodule