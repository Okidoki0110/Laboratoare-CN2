`timescale 1ns / 1ps

module RegExp8(
    input clear,
    input load,
    input clk,
    input [7:0] exp_in,
    output reg [7:0] exp_out
    );
    
    always @(posedge clk)
    begin
        if (clear)
            exp_out <= 0;
        if (load)
            exp_out <= exp_in;
    end    
    
endmodule
