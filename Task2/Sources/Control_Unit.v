module Control_Unit(
  input [6:0] Opcode,
  output reg [1:0] ALUOp = 2'b00,
  output reg Branch = 1'b0, 
  output reg MemRead = 1'b0,
  output reg MemtoReg = 1'b0, 
  output reg MemWrite = 1'b0,
  output reg ALUSrc = 1'b0,
  output reg RegWrite = 1'b0
);
  
  always @*
    begin
      case (Opcode)
        7'b0110011: //R-type
          begin 
            ALUOp = 2'b10;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b1;
          end
        7'b0000011: //I-type (ld)
          begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b1;
            MemtoReg = 1'b1;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
          end
        7'b0100011: //sd
          begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'bx;
            MemWrite = 1'b1;
            ALUSrc = 1'b1;
            RegWrite = 1'b0;
          end
        7'b1100011: //SB-type(beq)
          begin
            ALUOp = 2'b01;
            Branch = 1'b1;
            MemRead = 1'b0;
            MemtoReg = 1'bx;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
          end  
        7'b0010011: //I-type(addi)
          begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b1;
            RegWrite = 1'b1;
          end
        default:
          begin
            ALUOp = 2'b00;
            Branch = 1'b0;
            MemRead = 1'b0;
            MemtoReg = 1'b0;
            MemWrite = 1'b0;
            ALUSrc = 1'b0;
            RegWrite = 1'b0;
          end
      endcase
    end
  
endmodule
