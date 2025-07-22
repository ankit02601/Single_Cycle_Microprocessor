
module Single_Cycle_Top(clk,rst );
input clk,rst;
 wire [31:0]PC_Top,RD_Instr,ALUResult, ReadData,PCPlus4,RD1_Top,RD2_Top,Imm_Ext_Top,SrcB,Mux_out_Result;
 wire [2:0] ALUControl_Top;
 wire [1:0]ImmSrc;
 wire Mem_Write,RegWrite,ALUSrc,ResultSrc;
 
P_C P_C( .PC_NEXT(PCPlus4),
          .PC(PC_Top),
          .rst(rst),
          .clk(clk)
);

PC_adder PC_adder(.a(PC_Top),
                  .b(32'd4), 
                  .c(PCPlus4)
);

Instr_Mem Instr_Mem(.A(PC_Top),
           .rst(rst),
           .RD(RD_Instr)
);

Reg_file Reg_file(.A1(RD_Instr[19:15]),
          .A2(RD_Instr[24:20]),
           .A3(RD_Instr[11:7]),
           .WD3(Mux_out_Result),
           .WE3(RegWrite),
           .clk(clk),
           .rst(rst),
           .RD1(RD1_Top),
           .RD2(RD2_Top)
);

Sign_Extend Sign_Extend(
                       .In(RD_Instr),
                       .ImmSrc(ImmSrc[0]),
                       .Imm_Ext(Imm_Ext_Top)
);

Mux Mux_Register_to_ALU(
        .a(RD2_Top),
        .b(Imm_Ext_Top),
        .s(ALUSrc),
        .c(SrcB)
);

ALU ALU(.A(RD1_Top),
        .B(SrcB),
        .ALUControl(ALUControl_Top),
        .Result(ALUResult),
        .Z(),
        .N(),
        .C(),
        .V()
);
Control_Unit_Top Control_Unit_Top(.Op(RD_Instr[6:0]),
                                  .RegWrite(RegWrite),
                                  .ImmSrc(ImmSrc),
                                  .ALUSrc(ALUSrc),
                                  .MemWrite(MemWrite),
                                  .ResultSrc(ResultSrc),
                                  .Branch(),
                                  .funct3(RD_Instr[14:12]),
                                  .funct7(RD_Instr[6:0]),
                                  .ALUControl(ALUControl_Top)
);

Data_Memory Data_Memory(.A(ALUResult),
                        .WD(RD2_Top),
                        .clk(clk),
                        .WE(MemWrite),
                        .RD(ReadData)
);
Mux Mux_DataMemory_to_Register(
        .a(ALUResult),
        .b(ReadData),
        .s(ResultSrc),
        .c(Mux_out_Result)
);


   
endmodule

