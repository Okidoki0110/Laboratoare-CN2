`timescale 1ns / 1ps

module Concatenare(
    input [47:0] mant_in,
    input [8:0] valoare1,
    output reg [56:0] mant_out
    );
    
    always @(*)
    begin
        mant_out = {valoare1, mant_in};
    end
    
endmodule
