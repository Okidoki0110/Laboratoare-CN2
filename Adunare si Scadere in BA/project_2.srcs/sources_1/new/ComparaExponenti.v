`timescale 1ns / 1ps

module ComparaExponenti(
    input [15:0] exp_in,
    output reg [8:0] valoare1,
    output reg [15:0] exp_out
    );
    
    reg [7:0] exp1, exp2;
    
    always @(exp_in)
    begin
        exp1 = exp_in[15:8];
        exp2 = exp_in[7:0];
        
        //mantisa 2 se deplaseaza la dreapta
        if (exp1 > exp2)
        begin
            valoare1[7:0] = exp1 - exp2;
            valoare1[8] = 1;
            exp_out = {exp1, exp2};
        end
        
        //mantisa 1 se deplaseaza la dreapta
        else
        begin
            valoare1[7:0] = exp2 - exp1;
            valoare1[8] = 0;
            exp_out = {exp2, exp1};
        end  
    end
    
endmodule
