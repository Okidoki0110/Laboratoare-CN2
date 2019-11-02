`timescale 1ns / 1ps

module AlegeExponent(
    input [15:0] exp_in,
    output reg [7:0] exp_out
    );
    
    always @(*)
    begin
        exp_out = exp_in[15:8];
    end
    
endmodule
