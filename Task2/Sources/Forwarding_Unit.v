module Forwarding_Unit(
  input [4:0] ID_EX_rs1,
  input [4:0] ID_EX_rs2,
  input [4:0] EX_Mem_rd,//
  input EX_Mem_RegWrite,
  input [4:0] Mem_WB_rd,
  input Mem_WB_RegWrite,
  output reg [1:0] Forward_A,
  output reg [1:0] Forward_B
);

  always @(*) begin
    // Check for hazard on rs1/Forward_A from EX stage
    Forward_A = (EX_Mem_RegWrite && EX_Mem_rd != 0 && (EX_Mem_rd == ID_EX_rs1)) ? 2'b10 :
                // Check for hazard on rs1/Forward_A from MEM stage
                (Mem_WB_RegWrite && Mem_WB_rd != 0 && (Mem_WB_rd == ID_EX_rs1) &&
                 !(EX_Mem_RegWrite && EX_Mem_rd != 0 && EX_Mem_rd == ID_EX_rs1)) ? 2'b01 :
                // No hazard on rs1/Forward_A
                2'b00;

    // Check for hazard on rs2/Forward_B from EX stage
    Forward_B = (EX_Mem_RegWrite && EX_Mem_rd != 0 && (EX_Mem_rd == ID_EX_rs2)) ? 2'b10 :
                // Check for hazard on rs2/Forward_B from MEM stage
                (Mem_WB_RegWrite && Mem_WB_rd != 0 && (Mem_WB_rd == ID_EX_rs2) &&
                 !(EX_Mem_RegWrite && EX_Mem_rd != 0 && EX_Mem_rd == ID_EX_rs2)) ? 2'b01 :
                // No hazard on rs2/Forward_B
                2'b00;
  end
endmodule
