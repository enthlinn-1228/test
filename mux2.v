`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:30:48
// Design Name: 
// Module Name: mux2
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


module mux2
    #(parameter N = 32) 	    //���ݿ��
    (output [N-1:0] out,        //���
    input m,                    //ѡ���ź�                     
    input [N-1:0] a, b          //����
    );
    
    assign out = m? b : a;
endmodule

