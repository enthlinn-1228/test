`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 20:02:22
// Design Name: 
// Module Name: control
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


module control(
    input [5:0] ins,
    output Jump,
    output Branch,
    output Reg_Dst,
    output RegWrite,
    output MemRead,
    output MemtoReg,
    output MemWrite,
    output [2:0] ALUOp,
    output ALUSrc
    );
    
    assign Reg_Dst  = (ins == 6'b000000)? 1 : 0;
    assign ALUSrc   = (ins == 6'b000000 || ins == 6'b000100)? 0 : 1;
    assign MemtoReg = (ins == 6'b100011)? 1 : 0;
    assign RegWrite = (ins == 6'b000000 || ins == 6'b001000 || ins == 6'b100011)? 1 : 0;
    assign MemWrite = (ins == 6'b101011)? 1 : 0;
    assign MemRead  = (ins == 6'b100011)? 1 : 0;
    assign Branch   = (ins == 6'b000100)? 1 : 0;
    assign Jump     = (ins == 6'b000010)? 1 : 0;
    assign ALUOp    = (ins == 6'b000100)? 3'b001 : 3'b000;
    
endmodule
