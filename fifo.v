`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2019 07:55:14 PM
// Design Name: 
// Module Name: fifo
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


module fifo #(parameter NUM_BITS = 8, depth = 8)(
    input rst, clk, ren, wen,
    input [(NUM_BITS - 1):0] data_in,
    output reg [(NUM_BITS - 1):0] data_out,
    output empty,full,
    output reg [3:0] fifo_counter
);
 
    //clog2(depth)=3;
    reg [2:0] rptr,wptr;
 
    //declaratie memorie fifo
    reg [(NUM_BITS - 1):0] fifo_mem[(depth - 1):0];
   
    //parte combinationala care determina empty/full
    assign empty = (fifo_counter == 0);
    assign full = (fifo_counter == depth);
 
    //circuit secvential care va gestiona fifo_counter
    always @(posedge clk or negedge rst)
    begin
        if(~rst)
            fifo_counter = 0;
        else if( (!full && wen) && (!empty && ren))
            fifo_counter = fifo_counter; //citire si scriere simultana nu se intampla
        else if( !full && wen)
            fifo_counter = fifo_counter + 1; //scrierea incrementeaza
        else if( !empty && ren)
            fifo_counter = fifo_counter - 1; //citirea decrementeaza
    end
   
    //circuit secvential pentru gestionarea citirii din fifo
    always @(posedge clk or negedge rst)
    begin
        if(~rst)
            data_out <= 0;
        else
        begin
            if(!empty && ren)
            begin
                data_out <= fifo_mem[rptr];
                $display ("POP genereaza valoarea: %d la momentul %t", fifo_mem[rptr], $time);
            end
        end
    end
 
    //circuit secvential pentru gestionarea scrierii in FIFO
    always @(posedge clk or negedge rst)
    begin
        if(!full && wen)
        begin
            fifo_mem[wptr] <= data_in;
            $display ("PUSH valoarea: %d la momentul %t", data_in, $time);
        end
    end
 
    //circuit secvential pentru gestionarea pointerilor READ/WRITE
    always @(posedge clk or negedge rst)
    begin
        if(~rst)
        begin
            rptr <= 0;
            wptr <= 0;
        end
        else
        begin
            if(!full && wen)
                wptr <= wptr + 1;
            if(!empty && ren)
                rptr <= rptr + 1;
        end
    end
 
    function integer clog2;
    input [31:0] depth;
    begin
        depth=depth-1;
        for (clog2 = 0; depth > 0; clog2 = clog2+1)
            depth = depth >> 1;
    end
    endfunction
   
   
endmodule
