`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:39:24
// Design Name: 
// Module Name: registers
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


module registers    				//32 x WIDTH寄存器堆
    #(parameter WIDTH = 32) 	    //数据宽度
    (input clk,						//时钟（上升沿有效）
    input [4:0] ra0,				//读端口0地址
    output [WIDTH-1:0] rd0, 	    //读端口0数据
    input [4:0] ra1, 				//读端口1地址
    output [WIDTH-1:0] rd1, 	    //读端口1数据
    input [4:0] wa, 				//写端口地址
    input we,					    //写使能，高电平有效
    input [WIDTH-1:0] wd 		    //写端口数据
);

    reg [WIDTH-1:0] register [0:31];
    
    assign rd0 = register[ra0];
    assign rd1 = register[ra1];
    
    always @(negedge clk)
    begin
        register[0] <= 0;
        if(we)
            if(wa != 0)
                register[wa] <= wd;
    end
    
endmodule
