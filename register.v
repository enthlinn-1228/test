`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:30:02
// Design Name: 
// Module Name: register
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


module register
    #(parameter N = 32) 	     //数据宽度
    (output reg [N-1:0] out,    //输出
    input en,                   //使能信号
    input rst,                  //复位信号
    input clk,                  //时钟信号
    input [N-1:0] in            //输入
    );
    
    always @(posedge clk, posedge rst)
        if(rst) out <= 0;
        else if(en) out <= in;
        else out <= out;
endmodule
