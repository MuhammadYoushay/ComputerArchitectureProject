module Pipelined_Processor(input clk, reset);

//IF/ID 
wire [31:0] IF_ID_Ins;
wire [63:0] IF_ID_PC;
//ID/EX
wire [3:0] ID_EX_Instruction;
wire [4:0] ID_EX_rs1;
wire [4:0] ID_EX_rs2;
wire [4:0] ID_EX_rd;
wire [63:0] ID_EX_imm_data;
wire [63:0] ID_EX_ReadData1;
wire [63:0] ID_EX_ReadData2;
wire [63:0] ID_EX_PC;
wire [1:0] ID_EX_ALUOp;
wire ID_EX_ALUSrc; 
wire ID_EX_Branch;
wire ID_EX_MemRead; 
wire ID_EX_MemtoReg; 
wire ID_EX_MemWrite; 
wire ID_EX_RegWrite;
//EX/MEM
wire [4:0] EX_Mem_rd;
wire [63:0] EX_Mem_Adder, EX_Mem_ALU_Result, EX_Mem_ForwardB_MUX;
wire EX_Mem_Branch, EX_Mem_MemRead, EX_Mem_MemtoReg, EX_Mem_MemWrite, EX_Mem_RegWrite;
wire[63:0] EX_Mem_Zero;
//MEM/WB
wire [63:0] Mem_WB_Read_Data;
wire [63:0] Mem_WB_ALU_Result;
wire[4:0] Mem_WB_rd;
wire Mem_WB_MemtoReg;
wire Mem_WB_RegWrite;
//Others
wire [1:0] Fwd_A, Fwd_B;
wire [63:0] MuxA_Out, MuxB_Out;
wire [63:0] mux_out_1;
wire [63:0] mux_out_2;
wire [63:0] mux_out_3;
wire [63:0] PC_out;
wire [63:0] out_1;
wire [63:0] out_2;
wire [31:0] Instruction; 
wire [6:0] opcode;
wire [4:0] rd;
wire [2:0] funct3;
wire [4:0] rs1;
wire [4:0] rs2;
wire [6:0] funct7;
wire [63:0] ReadData1;
wire [63:0] ReadData2;
wire [1:0] ALUOp;
wire [63:0] immediate;
wire [3:0] Operation;
wire [63:0] Result;
wire [63:0] Read_Data;  
wire branch;
wire MemRead; 
wire MemtoReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire Zero;

    
Program_Counter pc (.clk(clk), .reset(reset), .PC_In(mux_out_1), .PC_Out(PC_out));
  
Adder add1(.a(PC_out), .b(64'd4), .out(out_1));
  
Adder add2(.a(ID_EX_PC), .b(ID_EX_imm_data << 1), .out(out_2));
  
Mux a(.a(out_1), .b(EX_Mem_Adder), .SEL(EX_Mem_Branch & EX_Mem_Zero), .data_out(mux_out_1));

Mux b(.a(MuxB_Out), .b(ID_EX_imm_data), .SEL(ID_EX_ALUSrc), .data_out(mux_out_2));

Mux c(.a(Mem_WB_ALU_Result), .b(Mem_WB_Read_Data), .SEL(Mem_WB_MemtoReg), .data_out(mux_out_3));

mux3by1 muxA(.data_out(MuxA_Out),.S(Fwd_A),.A(ID_EX_ReadData1),.B(mux_out_3),.C(EX_Mem_ALU_Result));
  
mux3by1 muxB(.data_out(MuxB_Out),.S(Fwd_B),.A(ID_EX_ReadData2),.B(mux_out_3),.C(EX_Mem_ALU_Result));
    
Instruction_Memory im(.Inst_Address(PC_out), .Instruction(Instruction));
  
Instruction_Parser IP(.instruction(IF_ID_Ins), .opcode(opcode), .rd(rd), .funct3(funct3), .rs1(rs1), .rs2(rs2), .funct7(funct7) );
  
Control_Unit CU(.Opcode(opcode), .ALUOp(ALUOp), .Branch(branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc), .RegWrite(RegWrite));
  
Register_File rf(.WriteData(mux_out_3),.rs1(rs1), .rs2(rs2), .rd(Mem_WB_rd),.RegWrite(RegWrite),.clk(clk),.reset(reset), .ReadData1(ReadData1), .ReadData2(ReadData2));
  
Immediate_Data_Generator ig(.instruction(IF_ID_Ins), .immediate(immediate));
  
ALU_Control alu_c(.ALUOp(ID_EX_ALUOp), .Funct(ID_EX_Instruction), .Operation(Operation));
  
ALU_64_bit alu (.a(MuxA_Out), .b(mux_out_2),.ALUOp(Operation), .Result(Result), .Zero(Zero));
  
Data_Memory dm(.clk(clk),.Mem_Addr(EX_Mem_ALU_Result), .Write_Data(EX_Mem_ForwardB_MUX), .MemWrite(EX_Mem_MemWrite), .MemRead(EX_Mem_MemRead),.Read_Data(Read_Data));


IF_ID ifid(.clk(clk), .reset(reset), .Instruction(Instruction),.PC(PC_out), .IF_ID_Ins(IF_ID_Ins), .IF_ID_PC(IF_ID_PC));
  
ID_EX ID_EX(
    .clk(clk), .reset(reset), .IF_ID_Instruction({IF_ID_Ins[30],IF_ID_Ins[14:12]}),.rs1(rs1),.rs2(rs2),.rd(rd),.imm_data(immediate),.ReadData1(ReadData1),.ReadData2(ReadData2),.PC(IF_ID_PC),.ALUOp(ALUOp),.Branch(branch), .MemRead(MemRead), .MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc),.RegWrite(RegWrite),.ID_EX_Instruction(ID_EX_Instruction),.ID_EX_rs1(ID_EX_rs1),.ID_EX_rs2(ID_EX_rs2),.ID_EX_rd(ID_EX_rd),.ID_EX_imm_data(ID_EX_imm_data),.ID_EX_ReadData1(ID_EX_ReadData1),.ID_EX_ReadData2(ID_EX_ReadData2),.ID_EX_PC(ID_EX_PC),.ID_EX_ALUOp(ID_EX_ALUOp),.ID_EX_ALUSrc(ID_EX_ALUSrc),.ID_EX_Branch(ID_EX_Branch),.ID_EX_MemRead(ID_EX_MemRead),.ID_EX_MemtoReg(ID_EX_MemtoReg),.ID_EX_MemWrite(ID_EX_MemWrite),.ID_EX_RegWrite(ID_EX_RegWrite));
  
Forwarding_Unit FU(.ID_EX_rs1(ID_EX_rs1),.ID_EX_rs2(ID_EX_rs2),.EX_Mem_rd(EX_Mem_rd),.EX_Mem_RegWrite(EX_Mem_RegWrite),.Mem_WB_rd(Mem_WB_rd),.Mem_WB_RegWrite(Mem_WB_RegWrite),.Forward_A(Fwd_A),.Forward_B(Fwd_B)  );

EX_Mem EXMem(.clk(clk), .reset(reset),.ID_EX_Branch(ID_EX_Branch), .ID_EX_MemRead(ID_EX_MemRead),.ID_EX_MemtoReg(ID_EX_MemtoReg), .ID_EX_MemWrite(ID_EX_MemWrite), .ID_EX_RegWrite(ID_EX_RegWrite), .Adder(out_2),.Zero(Zero),.ALU_Rslt(Result),.ForwardB_MUX(MuxB_Out),.ID_EX_rd(ID_EX_rd),.EX_Mem_Branch(EX_Mem_Branch),.EX_Mem_MemRead(EX_Mem_MemRead),.EX_Mem_MemtoReg(EX_Mem_MemtoReg), .EX_Mem_MemWrite(EX_Mem_MemWrite),.EX_Mem_RegWrite(EX_Mem_RegWrite),.EX_Mem_Adder(EX_Mem_Adder),.EX_Mem_Zero(EX_Mem_Zero), .EX_Mem_ALU_Result(EX_Mem_ALU_Result),.EX_Mem_ForwardB_MUX(EX_Mem_ForwardB_MUX),.EX_Mem_rd(EX_Mem_rd));

Mem_WB MemWB(.clk(clk), .reset(reset),.EX_Mem_MemtoReg(EX_Mem_MemtoReg),.EX_Mem_RegWrite(EX_Mem_RegWrite),.Read_Data(Read_Data), .EX_Mem_ALU_Result(EX_Mem_ALU_Result),.EX_Mem_rd(EX_Mem_RD),.Mem_WB_MemtoReg(Mem_WB_MemtoReg),.Mem_WB_RegWrite(Mem_WB_RegWrite),.Mem_WB_Read_Data(Mem_WB_Read_Data),.Mem_WB_ALU_Result(Mem_WB_ALU_Result),.Mem_WB_rd(Mem_WB_rd));



always @(posedge clk)
    begin
    $monitor(
        "Instruction =%b",Instruction,
        " RS1 =%d",rs1,  
        " RS2 =%d",rs2,
        " RD =%d",rd, 
        " Result =%d", Result,
        " ForwardA =%d",Fwd_A,
        " ForwardB =%d",Fwd_B 
        );
     end 
 
   
endmodule