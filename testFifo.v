`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2019 08:33:27 PM
// Design Name: 
// Module Name: testFifo
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


module testFifo();
    parameter NUM_BITS = 32;
    parameter DEPTH = 8;
    
    //Inputs
    reg rst;
    reg clk;
    reg rd, wr;
    reg [(NUM_BITS - 1):0] data_in;
    
    //Outputs
    wire [(NUM_BITS - 1):0] data_out;
    wire empty, full;
    wire [3:0] fifo_counter;
    
    reg [(NUM_BITS - 1):0] tempdata;
    
    //Instantiate FIFO
    fifo #(NUM_BITS, DEPTH) fif(rst, clk, rd, wr, data_in, data_out, empty, full, fifo_counter);
    
    initial begin
        clk = 0;
        rst = 1;
        rd = 0;
        wr = 0;
        tempdata = 0;
        data_in = {NUM_BITS{1'bx}};
        #1 rst = 0;
        #1 rst = 1;
    end
    
    always
        #5 clk = ~clk;
        
    initial begin
        $display("Start test:1 at: %t", $time);
        push(1);
        push(2);
        push(3);
        push(4);
        push(5);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        push(6);
        push(7);
        push(8);
        push(9);
        push(10);
        push(11);
        push(12);
        push(13);
        push(14);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        pop(tempdata);
        
        @(negedge clk);
        @(negedge clk);
        $display("Start test:2 at: %t", $time);
        push(20);
        fork
            push(1);
            pop(tempdata);
        join
        fork
            push(2);
            pop(tempdata);
        join
        fork
            push(3);
            pop(tempdata);
        join
        fork
            push(4);
            pop(tempdata);
        join
        fork
            push(5);
            pop(tempdata);
        join
        fork
            push(6);
            pop(tempdata);
        join
        @(negedge clk);
        @(negedge clk);
        $stop;
    end
    
    task push;
    input [(NUM_BITS - 1):0] data;
    if(full)
        $display("PUSH %d not made, buffer is full at moment: %t", data, $time);
    else
    begin
        data_in = data;
        wr = 1;
        @(posedge clk);
        #1 wr = 0;
    end 
    endtask
    
    task pop;
    output [(NUM_BITS - 1):0] data;
    if(empty)
        $display("POP not made, buffer is empty at moment: %t", $time);
    else
    begin
        rd = 1;
        @(posedge clk);
        #1 rd = 0;
        data = data_out;
    end 
    endtask
endmodule
