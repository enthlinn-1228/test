`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 16:35:00
// Design Name: 
// Module Name: signal_edge
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


module signal_edge(clk, button, button_redge);
    input clk;
    input button;
    output button_redge;
    reg button_r1,button_r2;
    
    always @(posedge clk)
        button_r1 <= button;
        
    always @(posedge clk)
        button_r2 <= button_r1;
        
    assign button_redge = button_r1 & (~button_r2);
endmodule
