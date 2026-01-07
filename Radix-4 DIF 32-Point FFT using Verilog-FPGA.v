`timescale 1ns/1ps
module fft32_radix4(
    input clk,
    input rst,
    input signed [15:0] xr, xi,
    input valid_in,
    output reg signed [15:0] yr, yi,
    output reg valid_out
);

    // Simple 32-point input buffer
    reg signed [15:0] x_r[0:31];
    reg signed [15:0] x_i[0:31];
    integer count;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            count <= 0;
            valid_out <= 0;
        end else if(valid_in) begin
            x_r[count] <= xr;
            x_i[count] <= xi;
            count <= count + 1;
        end
    end

    // For simplicity, after 32 samples, feed first 4 to butterfly
    wire signed [15:0] y0r, y0i, y1r, y1i, y2r, y2i, y3r, y3i;
    butterfly4 u0 (
        .x0_real(x_r[0]), .x0_imag(x_i[0]),
        .x1_real(x_r[1]), .x1_imag(x_i[1]),
        .x2_real(x_r[2]), .x2_imag(x_i[2]),
        .x3_real(x_r[3]), .x3_imag(x_i[3]),
        .y0_real(y0r), .y0_imag(y0i),
        .y1_real(y1r), .y1_imag(y1i),
        .y2_real(y2r), .y2_imag(y2i),
        .y3_real(y3r), .y3_imag(y3i)
    );

    // Output first butterfly after 32 samples (simulation only)
    always @(posedge clk) begin
        if(count == 32) begin
            yr <= y0r;
            yi <= y0i;
            valid_out <= 1;
        end else valid_out <= 0;
    end

endmodule