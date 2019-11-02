`timescale 1ns / 1ps

module ParsareNumere(
    input [31:0] A,
    input [31:0] B,
    input eScadere,
    output reg [15:0] exp,
    output reg [47:0] mant
    );
    
    reg B31;
    
    always @(*)
    begin
        exp = {A[30:23], B[30:23]};
        if (eScadere == 1)
            B31 = !B[31];
        else
            B31 = B[31];
        mant = {A[31], A[22:0], B31, B[22:0]};
    end
    
endmodule
