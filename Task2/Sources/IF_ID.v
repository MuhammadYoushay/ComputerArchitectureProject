module IF_ID(
  input clk, reset,
  input [31:0] Instruction,
  input [63:0] PC,
  output reg [31:0] IF_ID_Ins = 0,
  output reg [63:0] IF_ID_PC = 0
);

  always @(posedge clk or reset) begin
    if (reset) begin 
      IF_ID_Ins <= 0;
      IF_ID_PC <= 0;
    end else begin 
      IF_ID_Ins <= Instruction;
      IF_ID_PC <= PC;
    end
  end
endmodule

