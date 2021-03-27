`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/11 10:30:49
// Design Name: 
// Module Name: DBU
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


module DBU(
    input clk,
    input rst,
    input succ,
    input step,
    input [2:0] sel0,
    input [1:0] sel1,
    input m_rf,
    input inc,
    input dec,
    output [15:0] LED,
    output reg [7:0] SSEG_AN,
    output [7:0] SSEG_CA
    //output reg [31:0] m_rf_addr,
    //output [31:0] status, m_data, r_data
    );
    
    reg [31:0] m_rf_addr;
    reg [3:0] sseg_in;
    reg [2:0] count;
    wire pulse_clk, cpu_clk;
    wire step_edge, inc_edge, dec_edge;
    wire [15:0] control_sign;
    wire [31:0] status, m_data, r_data;
    wire [31:0] sseg_data;
    
    CPU CPU(cpu_clk, rst, sel0, sel1, m_rf_addr, control_sign, status, m_data, r_data);
    signal_edge step_(clk, step, step_edge),
                inc_(clk, inc, inc_edge),
                dec_(clk, dec, dec_edge);
    mux2 cpu_(cpu_clk, succ, step_edge, clk);
    SSEG_2to7 SSEG_2to7(.a(sseg_in), .spo(SSEG_CA));
    clk_k k1(.clk(clk), .rst(rst), .k(200000), .clk_out(pulse_clk));
    
    assign LED = (sel0 == 0)? m_rf_addr[17:2] : control_sign;
    assign sseg_data = (sel0 == 0)? (m_rf? m_data : r_data) : status;
    
    always @(posedge clk or posedge rst)
        if(rst) m_rf_addr <= 0;
        else if(inc_edge) m_rf_addr <= m_rf_addr + 4;
        else if(dec_edge) m_rf_addr <= m_rf_addr - 4;
        else m_rf_addr <= m_rf_addr;
    
    always @(posedge clk)
    begin
        if (pulse_clk)
            if (count >= 7) count <= 0;
            else count <= count + 1;
    end
    
    always @(posedge clk)
    begin
        if (pulse_clk)
            if (rst)
            begin
                SSEG_AN <= 8'b11111111;
                sseg_in <= 0;
            end
            else if(count == 0)
            begin
                SSEG_AN <= 8'b11111110;
                sseg_in <= sseg_data[3:0];
            end
            else if(count == 1)
            begin
                SSEG_AN <= 8'b11111101;
                sseg_in <= sseg_data[7:4];
            end
            else if(count == 2)
            begin
                SSEG_AN <= 8'b11111011;
                sseg_in <= sseg_data[11:8];
            end
            else if(count == 3)
            begin
                SSEG_AN <= 8'b11110111;
                sseg_in <= sseg_data[15:12];
            end
            else if(count == 4)
            begin
                SSEG_AN <= 8'b11101111;
                sseg_in <= sseg_data[19:16];
            end
            else if(count == 5)
            begin
                SSEG_AN <= 8'b11011111;
                sseg_in <= sseg_data[23:20];
            end
            else if(count == 6)
            begin
                SSEG_AN <= 8'b10111111;
                sseg_in <= sseg_data[27:24];
            end
            else if(count == 7)
            begin
                SSEG_AN <= 8'b01111111;
                sseg_in <= sseg_data[31:28];
            end
    end
endmodule