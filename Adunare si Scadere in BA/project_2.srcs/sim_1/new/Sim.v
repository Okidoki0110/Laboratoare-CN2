`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2019 11:40:39 PM
// Design Name: 
// Module Name: Sim
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


module Sim(

    );
    
    reg clear;
	reg load;
	reg clk;
	reg [31:0] A = 0;
	reg [31:0] B = 0;
	reg eScadere;
	
	wire [31:0] Rez;

    Pipeline pipe(clear, load, clk, A, B, eScadere, Rez);

	initial
	begin
		
		clear = 0;
		load = 0;
		clk = 0;
		eScadere = 0;
		
		#100
		load = 1;
		A = 32'b00111110100010100011110101110001; // 0.27
		B = 32'b00111111000000000000000000000000; // 0.5
		
		#100
		A = 32'b00111111000110011001100110011010; //0.6
		B = 32'b10111101110011001100110011001101; //-0.1
		
		#100
		A = 32'b10111111011001100110011001100110; //-0.9
		B = 32'b10111101110011001100110011001101; //-0.1
		
		#100
		A = 32'b00111111100110011001100110011010; //32
		B = 32'b00111110100110011001100110011010; //8
	
	    #100
	    eScadere = 1;
	    A = 32'b00111111100110011001100110011010; //1.2
		B = 32'b00111111100110011001100110011010; //1.2
		
		#100
		eScadere = 0;
		A = 32'b01111111011111111111111111111111;
		B = 32'b01111111011111111111111111111111;
		
		
	end
	always 
		 #50 clk = ~clk;
	  
endmodule
