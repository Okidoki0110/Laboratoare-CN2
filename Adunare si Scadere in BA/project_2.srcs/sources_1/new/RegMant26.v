`timescale 1ns / 1ps

module RegMant26(
    input clear,
    input load,
    input clk,
    input [25:0] mant_in,
    output reg [25:0] mant_out
    );
    
    always @(posedge clk)
    begin
        if (clear)
            mant_out <= 0;
        if (load)
            mant_out <= mant_in;
    end    
    
endmodule
