`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2019 10:51:46 PM
// Design Name: 
// Module Name: Pipeline
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Pipeline(
    input clear,
    input load,
    input clk,
    input [31:0] A,
    input [31:0] B,
    input eScadere,
    output [31:0] Res
    );
    
    //Segment 0
    
    wire [15:0] exp_in0, exp_out0;
    wire [47:0] mant_in0, mant_out0;
    
    //parsare si punere in reg
    ParsareNumere parsare(A, B, eScadere, exp_in0, mant_in0);
    RegExp16 regE0(clear, load, clk, exp_in0, exp_out0);
    RegMant48 regM0(clear, load, clk, mant_in0, mant_out0);
    
    //Segment 1
    
    wire [15:0] exp_in1, exp_out1;
    wire [56:0] mant_in1, mant_out1;
    wire [8:0] valoare1, valoare1_1;
    
    ComparaExponenti comp(exp_out0, valoare1, exp_in1);
    Concatenare conc(mant_out0, valoare1, mant_in1);
    RegExp16 regE1(clear, load, clk, exp_in1, exp_out1);
    RegMant57 regM1(clear, load, clk, mant_in1, mant_out1);
    RegVal9 regV1(clear, load, clk, valoare1, valoare1_1);
    
//    always @(*) begin 	
//		$display ("1 exp: %b", exp_in1);
//		$display ("1 mant: %b", mant_in1);
//		$display ("1 val1: %b", valoare1);
//	end
    
    //Segment 2
    
    wire [7:0] exp_in2, exp_out2;
    wire [47:0] mant_in2, mant_out2;
    wire semn, op;
    wire [8:0] valoare1_2;
    
    AlegeExponent alege(exp_out1, exp_in2);
    AliniereMantise alin(mant_out1, mant_in2, semn, op);
    RegExp8 regE2(clear, load, clk, exp_in2, exp_out2);
    RegMant48 regM2(clear, load, clk, mant_in2, mant_out2);
    RegVal9 regV2(clear, load, clk, valoare1_1, valoare1_2);
    
//    always @(*) begin 	
//		$display ("2 exp: %b", exp_in2);
//		$display ("2 mant: %b", mant_in2);
//		$display ("2 semn: %b", semn);
//		$display ("2 op: %b", op);
//	end
    
    //Segment 3
    
    wire [7:0] exp_out3;
    wire [25:0] mant_in3, mant_out3;
    wire [8:0] valoare1_3;
    
    AdunaMantise aduna(mant_out2, op, semn, mant_in3);
    RegExp8 regE3(clear, load, clk, exp_out2, exp_out3);
    RegMant26 regM3(clear, load, clk, mant_in3, mant_out3);
    RegVal9 regV3(clear, load, clk, valoare1_2, valoare1_3);
    
//    always @(*) begin 	
//		$display ("3 exp: %b", exp_out2);
//		$display ("3 mant: %b", mant_in3);
//	end
    
    //Segment 4
    
    wire [7:0] exp_in4, exp_out4;
    wire [23:0] mant_in4, mant_out4;
    wire [8:0] valoare2;
    
    Normalizare norm(mant_out3, valoare2, mant_in4);
    AjustareExponent ajust(exp_out3, valoare1_3, valoare2, exp_in4);
    RegExp8 regE4(clear, load, clk, exp_in4, exp_out4);
    RegMant24 regM4(clear, load, clk, mant_in4, mant_out4);
    
    assign Res = {mant_out4[23], exp_out4, mant_out4[22:0]};
    
endmodule
