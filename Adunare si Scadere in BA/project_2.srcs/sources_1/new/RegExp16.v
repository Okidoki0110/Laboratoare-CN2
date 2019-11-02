`timescale 1ns / 1ps

module RegExp16(
    input clear,
    input load,
    input clk,
    input [15:0] exp_in,
    output reg [15:0] exp_out
    );
    
    always @(posedge clk)
    begin
        if (clear)
            exp_out <= 0;
        if (load)
            exp_out <= exp_in;
    end    
    
endmodule
