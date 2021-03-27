`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/09 17:00:30
// Design Name: 
// Module Name: CPU
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


module CPU(
    input clk,
    input rst,
    input [2:0] sel0,
    input [1:0] sel1,
    input [31:0] m_rf_addr,
    output reg [15:0] control_sign,
    output reg [31:0] status,
    output [31:0] m_data,
    output [31:0] r_data
    );
    
    wire [31:0] i_addr, ins_in, ins, data_1, data_2, data_a, data_b, data_b2, data_b_ex, result, y;
    wire [31:0] d_addr, d_mem_in, d_mem, wd_reg, extend_in, extend, alu_data1, alu_data2;
    wire [31:0] pc_in, pc_next, pc_beq, pc_jump, beq_left, beq, npc, beq_1, beq_2, mem_for;
    wire Jump, Branch, Reg_Dst, Reg_Dst1, RegWrite, RegWrite1, RegWrite2, RegWrite3, MemRead, MemtoReg, MemtoReg1, MemtoReg2, MemtoReg3;
    wire MemWrite, MemWrite1, MemWrite2, MuxBeq, zero, flush, bubble, pc_en, ALUSrc, ALUSrc_ex;
    wire [1:0] ALUSrc1, ALUSrc2, BEQSrc1, BEQSrc2, tag, flag;
    wire [2:0] ALUOp, ALUOp1;
    wire [4:0] write_reg, rs, rt, rd, wa, wa_reg, r_addr;
    wire [31:0] m_addr;
    reg  Sel;
    
    register    PC(.rst(rst), .clk(clk), .in(pc_in), .out(i_addr), .en(pc_en)),
                IR(.rst(rst), .clk(clk), .in(ins_in), .out(ins), .en(flush)),
                NPC(.rst(rst), .clk(clk), .in(pc_next), .out(npc), .en(flush)),
                A(.rst(rst), .clk(clk), .in(data_1), .out(data_a), .en(1)),
                B(.rst(rst), .clk(clk), .in(data_2), .out(data_b), .en(1)),
                IMM(.rst(rst), .clk(clk), .in(extend_in), .out(extend), .en(1));
    register    #(5) RS(.rst(rst), .clk(clk), .in(ins[25:21]), .out(rs), .en(1));
    register    #(5) RT(.rst(rst), .clk(clk), .in(ins[20:16]), .out(rt), .en(1));
    register    #(5) RD(.rst(rst), .clk(clk), .in(ins[15:11]), .out(rd), .en(1));
    register    #(1) ALU(.rst(rst), .clk(clk), .in(ALUSrc & bubble), .out(ALUSrc_ex), .en(1));
    register    RES(.rst(rst), .clk(clk), .in(result), .out(d_addr), .en(1));
    register    #(5) WA1(.rst(rst), .clk(clk), .in(write_reg), .out(wa), .en(1));
    register    B2(.rst(rst), .clk(clk), .in(data_b_ex), .out(data_b2), .en(1));
    register    MDR(.rst(rst), .clk(clk), .in(d_mem_in), .out(d_mem), .en(1));
    register    Y(.rst(rst), .clk(clk), .in(d_addr), .out(y), .en(1));
    register    #(5) WA2(.rst(rst), .clk(clk), .in(wa), .out(wa_reg), .en(1));
    register    #(1) REG_DST(.rst(rst), .clk(clk), .in(Reg_Dst & bubble), .out(Reg_Dst1), .en(1));
    register    #(3) ALUOP(.rst(rst), .clk(clk), .in(ALUOp & {3{bubble}}), .out(ALUOp1), .en(1));
    register    #(1) MW1(.rst(rst), .clk(clk), .in(MemWrite & bubble), .out(MemWrite1), .en(1));
    register    #(1) MW2(.rst(rst), .clk(clk), .in(MemWrite1), .out(MemWrite2), .en(1));
    register    #(1) MR1(.rst(rst), .clk(clk), .in(MemtoReg & bubble), .out(MemtoReg1), .en(1));
    register    #(1) MR2(.rst(rst), .clk(clk), .in(MemtoReg1), .out(MemtoReg2), .en(1));
    register    #(1) MR3(.rst(rst), .clk(clk), .in(MemtoReg2), .out(MemtoReg3), .en(1));
    register    #(1) RW1(.rst(rst), .clk(clk), .in(RegWrite & bubble), .out(RegWrite1), .en(1));
    register    #(1) RW2(.rst(rst), .clk(clk), .in(RegWrite1), .out(RegWrite2), .en(1));
    register    #(1) RW3(.rst(rst), .clk(clk), .in(RegWrite2), .out(RegWrite3), .en(1));
    register    #(2) TAG(.rst(rst), .clk(clk), .in(tag & {2{bubble}}), .out(flag), .en(1));
    MEM_ins     I_MEM(.a(i_addr[9:2]), .spo(ins_in));
    control     Control(ins[31:26], Jump, Branch, Reg_Dst, RegWrite, MemRead, MemtoReg, MemWrite, ALUOp, ALUSrc);
    mux4        mux_alu1(alu_data1, ALUSrc1, data_a, d_addr, wd_reg);
    mux4        mux_data_b(data_b_ex, ALUSrc2, data_b, d_addr, wd_reg);
    mux4        mux_beq1(beq_1, BEQSrc1, data_1, result, mem_for, wd_reg);
    mux4        mux_beq2(beq_2, BEQSrc2, data_2, result, mem_for, wd_reg);
    mux2        mux_alu2(alu_data2, ALUSrc_ex, data_b_ex, extend);
    mux2        mux_mem(wd_reg, MemtoReg3, y, d_mem);
    mux2        #(5) mux_reg(write_reg, Reg_Dst1, rt, rd);
    mux2        mux_beq(beq, (MuxBeq & !flag[1]), pc_next, pc_beq);
    mux2        mux_jump(pc_in, (Jump & !flag[1]), beq, pc_jump);
    mux2        #(5) mux_r_data(r_addr, Sel, ins[25:21], m_rf_addr[7:2]);
    mux2        mux_m_data(m_addr, Sel, d_addr, m_rf_addr);
    mux2        mux_mem_for(mem_for, MemtoReg2, d_addr, d_mem_in);
    registers   registers(clk, r_addr, data_1, ins[20:16], data_2, wa_reg, RegWrite3, wd_reg);
    sign_extend sign_extend(ins[15:0], extend_in);
    alu         alu_reg(.a(alu_data1), .b(alu_data2), .m(ALUOp1), .y(result)),
                alu_next(.a(i_addr), .b(4), .m(3'b000), .y(pc_next)),
                alu_beq(.a(npc), .b(beq_left), .m(3'b000), .y(pc_beq)),
                alu_equal(.a(beq_1), .b(beq_2), .m(3'b001), .zf(zero));
    MEM_data    D_MEM(.a(m_addr[9:2]), .d(data_b2), .clk(clk), .we(MemWrite2), .spo(d_mem_in));
    Forward     Forward(rs, rt, wa, wa_reg, RegWrite2, RegWrite3, ALUSrc1, ALUSrc2);
    Forward_beq Forward2(ins[25:21], ins[20:16], write_reg, wa, wa_reg, RegWrite1, RegWrite2, RegWrite3, BEQSrc1, BEQSrc2);
    Hazard      Hazard(ins, rt, flag, zero, flush, bubble, pc_en, tag);
    
    assign beq_left = extend_in << 2;
    assign MuxBeq = Branch & zero;
    assign pc_jump = {npc[31:28], ins[25:0], 2'b00};
    //assign control_sign = {Jump, Branch, Reg_Dst, RegWrite, MemRead, MemtoReg, MemWrite, ALUOp, ALUSrc1, ALUSrc2, zero};
    assign r_data = data_1;
    assign m_data = d_mem;
    
    always @(*)
    case(sel0)
        3'b001: 
            if(sel1 == 0) status = i_addr;
            else if(sel1 == 1) status = pc_in;
            else status = ins_in;
        3'b010: 
            if(sel1 == 0) status = pc_next;
            else if(sel1 == 1) status = ins;
            else if(sel1 == 2) status = beq_1;
            else status = beq_2;
        3'b011: 
            if(sel1 == 0) status = alu_data1;
            else if(sel1 == 1) status = alu_data2;
            else status = result;
        3'b100: 
            if(sel1 == 0) status = d_addr;
            else if(sel1 == 1) status = d_mem_in;
            else status = mem_for;
        3'b101: 
            if(sel1 == 0) status = y;
            else if(sel1 == 1) status = d_mem;
            else status = wd_reg;
        default: status = 0;
    endcase
    
    always @(*)
    case(sel0)
        3'b001: 
            control_sign = {14'b0, pc_en, flush};
        3'b010: 
            control_sign = {6'b0, Jump, Branch, BEQSrc1, BEQSrc2, zero, bubble, tag};
        3'b011: 
            control_sign = {7'b0, ALUSrc1, ALUSrc2, ALUSrc_ex, ALUOp, Reg_Dst};
        3'b100: 
            control_sign = {14'b0, MemWrite2, MemtoReg2};
        3'b101: 
            control_sign = {14'b0, RegWrite3, MemtoReg3};
        default: control_sign = 0;
    endcase
    
    always @(*)
        if(sel0 == 0) Sel = 1;
        else Sel = 0;
endmodule
