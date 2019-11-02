`timescale 1ns / 1ps

module AjustareExponent(
    input [7:0] exp_in,
    input [8:0] valoare1,
    input [8:0] valoare2,
    output reg [7:0] exp_out
    );
    
    always @(*)
    begin
        if (valoare2[7:0] == 255)
            exp_out = 0;
        else
        begin
            if (valoare2[8] == 0)
                exp_out = exp_in - valoare2[7:0];
            else
                exp_out = exp_in + valoare2[7:0];
        end
    end
    
endmodule
