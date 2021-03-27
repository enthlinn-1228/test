`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/18 21:37:56
// Design Name: 
// Module Name: Hazard_change
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


module Hazard_change(
    input [31:0] ins,
    input [4:0] rd,
    input [1:0] flag,
    input zero,
    output reg flush,
    output reg bubble,
    output reg pc_en,
    output reg [1:0] tag
    );
    
    always @(*)
        if(ins[31:26] == 6'b100011) tag = 1;
        else if((ins[31:26] == 6'b000100 && zero) || (ins[31:26] == 6'b000101 && !zero)) tag = 2;
        else if(ins[31:26] == 6'b000010 || ins[31:26] == 6'b000011) tag = 3;
        else tag = 0;
    
    always @(*)
        if(!flag && (ins[31:26] == 6'b000010 || ins == 6'b000011)) flush = 0;
        else if(!flag && ((ins[31:26] == 6'b000100 && zero) || (ins[31:26] == 6'b000101 && !zero))) flush = 0;
        else if(flag == 1)
        begin
            if((rd == ins[25:21] || rd == ins[20:16]) &&
                (ins[31:26] == 6'b000000 || ins[31:26] == 6'b101011 || ins[31:26] == 6'b000100)) flush = 0;
            else if(rd == ins[25:21] && (ins[31:26] == 6'b001000 || ins[31:26] == 6'b100011)) flush = 0;
            else flush = 1;
        end
        else flush = 1;
        
    always @(*)
        if(flag == 2 || flag == 3) bubble = 0;
        else if(flag == 1)
        begin
            if((rd == ins[25:21] || rd == ins[20:16]) &&
                (ins[31:26] == 6'b000000 || ins[31:26] == 6'b101011 || ins[31:26] == 6'b000100)) bubble = 0;
            else if(rd == ins[25:21] && (ins[31:26] == 6'b001000 || ins[31:26] == 6'b100011)) bubble = 0;
            else bubble = 1;
        end
        else bubble = 1;
        
    always @(*)
        if(flag == 1)
        begin
            if((rd == ins[25:21] || rd == ins[20:16]) &&
                (ins[31:26] == 6'b000000 || ins[31:26] == 6'b101011 || ins[31:26] == 6'b000100)) pc_en = 0;
            else if(rd == ins[25:21] && (ins[31:26] == 6'b001000 || ins[31:26] == 6'b100011)) pc_en = 0;
            else pc_en = 1;
        end
        else pc_en = 1;
endmodule
