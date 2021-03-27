`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:35:34
// Design Name: 
// Module Name: clk_k
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


module clk_k(
    input clk,
    input rst,
	input [31:0] k,
    output clk_out
);
    reg [31:0]counter;
    
    always @(posedge clk or posedge rst)
    begin
	   if (rst) counter <= 0;
	   else if (counter >= k-1)
	       counter <= 0;
	   else
	       counter <= counter + 1;
    end

    assign clk_out = (counter == 1);
endmodule