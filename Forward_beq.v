`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/10 12:38:43
// Design Name: 
// Module Name: Forward_beq
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


module Forward_beq(
    input [4:0] id_rs,
    input [4:0] id_rt,
    input [4:0] ex_rd,
    input [4:0] mem_rd,
    input [4:0] wb_rd,
    input [4:0] ex_we,
    input [4:0] mem_we,
    input [4:0] wb_we,
    output reg [1:0] BEQSrc1,
    output reg [1:0] BEQSrc2
    );
    
    always @(*)
    begin
        if(id_rs && ex_we && id_rs == ex_rd) BEQSrc1 = 1;
        else if(id_rs && mem_we && id_rs == mem_rd) BEQSrc1 = 2;
        else if(id_rs && wb_we && id_rs == wb_rd) BEQSrc1 = 3;
        else BEQSrc1 = 0;
    end
    
    always @(*)
    begin
        if(id_rt && ex_we && id_rt == ex_rd) BEQSrc2 = 1;
        else if(id_rt && mem_we && id_rt == mem_rd) BEQSrc2 = 2;
        else if(id_rt && wb_we && id_rt == wb_rd) BEQSrc2 = 3;
        else BEQSrc2 = 0;
    end    
endmodule
