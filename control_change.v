`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/18 21:14:58
// Design Name: 
// Module Name: control_change
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


module control_change(
    input [5:0] ins,
    input [5:0] funct,
    input zero,
    output Jump,
    output reg Branch,
    output Reg_Dst,
    output RegWrite,
    output MemRead,
    output MemtoReg,
    output MemWrite,
    output reg [2:0] ALUOp,
    output ALUSrc,
    output JALSrc
    );
    
    assign Reg_Dst  = (ins == 6'b000000)? 1 : 0;
    assign ALUSrc   = (ins == 6'b000000 || ins == 6'b000100 || ins == 6'b000101)? 0 : 1;
    assign MemtoReg = (ins == 6'b100011)? 1 : 0;
    assign RegWrite = (ins == 6'b000000 || ins == 6'b001000 || ins == 6'b001101 || ins == 6'b100011 || ins == 6'b000011)? 1 : 0;
    assign MemWrite = (ins == 6'b101011)? 1 : 0;
    assign MemRead  = (ins == 6'b100011)? 1 : 0;
    //assign Branch   = ((ins[31:26] == 6'b000100 && zero) || (ins[31:26] == 6'b000101 && !zero))? 1 : 0;
    assign Jump     = (ins == 6'b000010 || ins == 6'b000011)? 1 : 0;
    assign JALSrc   = (ins == 6'b000011)? 1 : 0;
    always @(*)
    begin
        if(ins == 6'b000100 || ins == 6'b000101 || (ins == 6'b000000 && funct == 6'b100010)) ALUOp = 3'b001;
        else if(ins == 6'b001101) ALUOp = 3'b011;
        else ALUOp = 3'b000;
    end
    
    always @(*)
    begin
        if((ins[31:26] == 6'b000100 && zero) || (ins[31:26] == 6'b000101 && !zero)) Branch = 1;
        else Branch = 0;
    end
    
endmodule
