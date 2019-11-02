`timescale 1ns / 1ps

module Normalizare(
    input [25:0] mant_in,
    output reg [8:0] valoare2,
    output reg [23:0] mant_out
    );
    
    integer i;
    reg [24:0] mant_cu_1;
    reg semn;
    
    always @(mant_in)
    begin
    
        valoare2 = 0;
        mant_cu_1 = mant_in[24:0];
        semn = mant_in[25];
        
        //mantisa nu e 0
        if (mant_in[24:0] != 0)
        begin
            if (mant_cu_1[24] == 1)
            begin
                mant_cu_1 = mant_cu_1 >> 1;
                valoare2 = 1;
                valoare2[8] = 1;
            end
            else
            begin
                for (i = 0; i < 23; i = i + 1)
                begin
                    if (mant_cu_1[23] == 0)
                    begin
                        mant_cu_1 = mant_cu_1 << 1;
                        valoare2 = valoare2 + 1;
                    end
                end
            end
        end
        
        else
        begin
            valoare2[8] = 0;
            valoare2[7:0] = 255;
        end
        
        mant_out[23] = semn;
        mant_out[22:0] = mant_cu_1[22:0];
    end
    
endmodule
