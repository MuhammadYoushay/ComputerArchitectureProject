module EX_Mem (
  input clk, reset,
  input [4:0] ID_EX_rd,
  input [63:0] Adder, ALU_Rslt, ForwardB_MUX,
  input Zero,
  input ID_EX_Branch, ID_EX_MemRead, ID_EX_MemtoReg, ID_EX_MemWrite, ID_EX_RegWrite,
  output reg [4:0] EX_Mem_rd,
  output reg [63:0] EX_Mem_Adder, EX_Mem_ALU_Result, EX_Mem_ForwardB_MUX,
  output reg EX_Mem_Branch, EX_Mem_MemRead, EX_Mem_MemtoReg, EX_Mem_MemWrite, EX_Mem_RegWrite,
  output reg [63:0] EX_Mem_Zero
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      EX_Mem_Branch <= 0;
      EX_Mem_MemRead <= 0;
      EX_Mem_MemtoReg <= 0;
      EX_Mem_MemWrite <= 0;
      EX_Mem_RegWrite <= 0;
      EX_Mem_Adder <= 0;
      EX_Mem_ALU_Result <= 0;
      EX_Mem_ForwardB_MUX <= 0;
      EX_Mem_rd <= 0;
      EX_Mem_Zero <= 0;
    end else begin
      EX_Mem_Branch <= ID_EX_Branch;
      EX_Mem_MemRead <= ID_EX_MemRead;
      EX_Mem_MemtoReg <= ID_EX_MemtoReg;
      EX_Mem_MemWrite <= ID_EX_MemWrite;
      EX_Mem_RegWrite <= ID_EX_RegWrite;
      EX_Mem_Adder <= Adder;
      EX_Mem_ALU_Result <= ALU_Rslt;
      EX_Mem_ForwardB_MUX <= ForwardB_MUX;
      EX_Mem_rd <= ID_EX_rd;
      EX_Mem_Zero <= Zero;
    end
  end
  
endmodule
