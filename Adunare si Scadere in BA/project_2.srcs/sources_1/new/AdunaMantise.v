`timescale 1ns / 1ps

module AdunaMantise(
    input [47:0] mant_in,
    input op,
    input semn,
    output reg [25:0] mant_out
    );
    
    always @(mant_in)
    begin
        if (op == 1)
            mant_out[24:0] = mant_in[47:24] - mant_in[23:0];
        else
            mant_out[24:0] = mant_in[47:24] + mant_in[23:0];
    
        mant_out[25] = semn;
    end
endmodule
