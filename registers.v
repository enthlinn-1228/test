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


module registers    				//32 x WIDTH�Ĵ�����
    #(parameter WIDTH = 32) 	    //���ݿ��
    (input clk,						//ʱ�ӣ���������Ч��
    input [4:0] ra0,				//���˿�0��ַ
    output [WIDTH-1:0] rd0, 	    //���˿�0����
    input [4:0] ra1, 				//���˿�1��ַ
    output [WIDTH-1:0] rd1, 	    //���˿�1����
    input [4:0] wa, 				//д�˿ڵ�ַ
    input we,					    //дʹ�ܣ��ߵ�ƽ��Ч
    input [WIDTH-1:0] wd 		    //д�˿�����
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
