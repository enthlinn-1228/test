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
    #(parameter N = 32) 	     //���ݿ��
    (output reg [N-1:0] out,    //���
    input en,                   //ʹ���ź�
    input rst,                  //��λ�ź�
    input clk,                  //ʱ���ź�
    input [N-1:0] in            //����
    );
    
    always @(posedge clk, posedge rst)
        if(rst) out <= 0;
        else if(en) out <= in;
        else out <= out;
endmodule
