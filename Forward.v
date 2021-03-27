`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 23:11:34
// Design Name: 
// Module Name: Forward
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


module Forward(
    input [4:0] ex_rs,
    input [4:0] ex_rt,
    input [4:0] mem_rd,
    input [4:0] wb_rd,
    input mem_we,
    input wb_we,
    output reg [1:0] ALUSrc1,
    output reg [1:0] ALUSrc2
    );
    
    always @(*)
    begin
        if(ex_rs && mem_we && ex_rs == mem_rd) ALUSrc1 = 1;
        else if(ex_rs && wb_we && ex_rs == wb_rd) ALUSrc1 = 2;
        else ALUSrc1 = 0;
    end
    
    always @(*)
    begin
        if(ex_rt && mem_we && ex_rt == mem_rd) ALUSrc2 = 1;
        else if(ex_rt && wb_we && ex_rt == wb_rd) ALUSrc2 = 2;
        else ALUSrc2 = 0;
    end    
endmodule
