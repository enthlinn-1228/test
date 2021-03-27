`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:31:11
// Design Name: 
// Module Name: mux4
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


module mux4
    #(parameter N = 32) 	    //���ݿ��
    (output [N-1:0] out,        //���
    input [1:0] m,              //ѡ���ź�                     
    input [N-1:0] a, b, c, d    //����
    );
    
    assign out = m[1]? (m[0]? d : c) : (m[0]? b : a);
endmodule
