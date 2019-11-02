`timescale 1ns / 1ps

module AliniereMantise(
    input [56:0] mant_in,
    output reg [47:0] mant_out,
    output reg semn,
    output reg op
    );
    
    reg [8:0] valoare1;
    reg [23:0] mant1, mant2;
    reg semn1, semn2;
    
    always @(*)
    begin
        valoare1 = mant_in[56:48];
        semn1 = mant_in[47];
        mant1 = {1'b1, mant_in[46:24]};
        semn2 = mant_in[23];
        mant2 = {1'b1, mant_in[22:0]};
        
        op = semn1 ^ semn2;
        
        //exp1 > exp2
        if (valoare1[8] == 1)
        begin
            mant2 = mant2 >> valoare1[7:0];
            mant_out = {mant1, mant2};
            semn = semn1;
        end
        
        //exp2 >= exp1
        else
        begin
            if (valoare1[7:0] == 0 && mant1 > mant2)
            begin
                mant2 = mant2 >> valoare1[7:0];
                mant_out = {mant1, mant2};
                semn = semn1;
            end
            else
            begin
                mant1 = mant1 >> valoare1[7:0];
                mant_out = {mant2, mant1};
                semn = semn2;
            end
        end
    end
    
endmodule
