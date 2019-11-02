`timescale 1ns / 1ps

module RegVal9(
    input clear,
    input load,
    input clk,
    input [8:0] valoare1,
    output reg [8:0] valoare1_out
    );
    
    always @(posedge clk)
    begin
        if (clear)
            valoare1_out <= 0;
        if (load)
            valoare1_out <= valoare1;
    end    
    
endmodule
