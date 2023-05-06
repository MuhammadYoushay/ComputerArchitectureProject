module ALU_64_bit (
  input [63:0]a, b,
  input [3:0] ALUOp,
  output reg [63:0]  Result, 
  output Zero
);
  
  always @ (a or b or ALUOp)
    begin
      if (ALUOp == 4'b0000)
        Result = a & b;
      else if (ALUOp == 4'b0001)
        Result = a | b;
      else if (ALUOp == 4'b0010)
        Result = a + b;
      else if (ALUOp == 4'b0110)
        Result = a - b;
      else if (ALUOp == 4'b1100)
        Result = ~(a | b);
    end
  
  assign Zero = (Result == 0) ? 1'b1 : 1'b0;
  
endmodule
