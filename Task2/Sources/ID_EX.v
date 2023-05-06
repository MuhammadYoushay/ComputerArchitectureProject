module ID_EX(input clk, reset,
  input [3:0] IF_ID_Instruction,
  input [4:0] rs1,
  input [4:0] rs2,
  input [4:0] rd,
  input [63:0] imm_data,
  input [63:0] ReadData1,
  input [63:0] ReadData2,
  input [63:0] PC,
  input [1:0] ALUOp,
  input Branch,
  input MemRead,
  input MemtoReg,
  input MemWrite,
  input ALUSrc,
  input RegWrite,
  output reg [3:0] ID_EX_Instruction,
  output reg [4:0] ID_EX_rs1,
  output reg [4:0] ID_EX_rs2,
  output reg [4:0] ID_EX_rd,
  output reg [63:0] ID_EX_imm_data,
  output reg [63:0] ID_EX_ReadData1,
  output reg [63:0] ID_EX_ReadData2,
  output reg [63:0] ID_EX_PC, 
  output reg [1:0] ID_EX_ALUOp,
  output reg ID_EX_ALUSrc,
  output reg ID_EX_Branch,
  output reg ID_EX_MemRead,
  output reg ID_EX_MemtoReg,
  output reg ID_EX_MemWrite,
  output reg ID_EX_RegWrite  
);
  
  always @(posedge clk or posedge reset)
    if(reset) begin
      ID_EX_Instruction <= 4'b0;
      ID_EX_rs1 <= 5'b0;
      ID_EX_rs2	<= 5'b0;
      ID_EX_rd 	<= 5'b0;
      ID_EX_imm_data <= 64'b0;
      ID_EX_ReadData1 <= 64'b0;
      ID_EX_ReadData2 <= 64'b0;
      ID_EX_PC <= 64'b0;
      ID_EX_ALUOp <= 2'b0;
      ID_EX_Branch	<= 1'b0;
      ID_EX_MemRead <= 1'b0;
      ID_EX_MemtoReg <= 1'b0;
      ID_EX_MemWrite <= 1'b0;
      ID_EX_ALUSrc	 <= 1'b0;
      ID_EX_RegWrite <= 1'b0;
    end else begin 
      ID_EX_Instruction	<= IF_ID_Instruction;
      ID_EX_rs1 <= rs1;
      ID_EX_rs2	<= rs2;
      ID_EX_rd 	<= rd;
      ID_EX_imm_data <= imm_data;
      ID_EX_ReadData1 <= ReadData1;
      ID_EX_ReadData2 <= ReadData2;
      ID_EX_PC <= PC;
      ID_EX_ALUOp <= ALUOp;
      ID_EX_Branch	<= Branch;
      ID_EX_MemRead <= MemRead;
      ID_EX_MemtoReg <= MemtoReg;
      ID_EX_MemWrite <= MemWrite;
      ID_EX_ALUSrc	<= ALUSrc;
      ID_EX_RegWrite <= RegWrite;
    end
endmodule
