`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:29:23
// Design Name: 
// Module Name: alu
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


module alu
    #(parameter WIDTH = 32) 	//���ݿ��
    (output [WIDTH-1:0] y, 		//������
    output zf, 					//���־
    output cf, 					//��λ/��λ��־
    output sf,                  //���ű�־
    output of, 					//�����־
    input [WIDTH-1:0] a, b,		//��������
    input [2:0] m				//��������
    );
    
    reg rcf, rof, rzf;
    reg [WIDTH-1:0] ry;
    
    assign zf = rzf;
    assign cf = rcf;
    assign of = rof;
    assign sf = ry[WIDTH-1];
    assign y = ry;
    
    always @(*)
	    case(m)
		    3'b000:begin 
			    {rcf,ry} = a + b;
			    rof = a[WIDTH-1]^b[WIDTH-1]^y[WIDTH-1]^cf;
				rzf = ~|y;
				end
			3'b001:begin
			    {rcf,ry} = a - b;
				rof = a[WIDTH-1]^b[WIDTH-1]^y[WIDTH-1]^cf;
				rzf = ~|y;
				end
			3'b010:begin
			    ry = a & b;
				rzf = ~|y;
			    end
			3'b011:begin
			    ry = a | b;
				rzf = ~|y;
				end
			3'b100:begin
			    ry = a^b;
				rzf = ~|y;
				end
		    3'b101:begin
			    ry = a;
				rzf = ~|y;
				end
			default;
		endcase
endmodule
