module Instruction_Memory(
  input [63:0] Inst_Address,
  output reg [31:0] Instruction

);
  
  reg [7:0] Instruction_Memory [7:0];
  
  initial
    begin 
//    //TESTCASE 1
//        //Addi x1,x0,8
//    Instruction_Memory[3] = 8'b00000000;
//    Instruction_Memory[2] = 8'b10000000;
//    Instruction_Memory[1] = 8'b00000000;
//    Instruction_Memory[0] = 8'b10010011;
    
//       //Addi x4,x0, x1
//    Instruction_Memory[7] = 8'b00000000;
//    Instruction_Memory[6] = 8'b00010000;
//    Instruction_Memory[5] = 8'b00000010;
//    Instruction_Memory[4] = 8'b00110011;
//TESTCASE 2
     //00800093 //Addi x1,x0,8
    Instruction_Memory[3] = 8'b00000000;
    Instruction_Memory[2] = 8'b10000000;
    Instruction_Memory[1] = 8'b00000000;
    Instruction_Memory[0] = 8'b10010011;
    
    //00008213 //Addi x4,x1,2
    Instruction_Memory[7] = 8'b00000000;
    Instruction_Memory[6] = 8'b00000000;
    Instruction_Memory[5] = 8'b10000010;
    Instruction_Memory[4] = 8'b00010011;
      
      
    end
  
  always @ (Inst_Address)
    begin
      Instruction = {Instruction_Memory[Inst_Address+3], Instruction_Memory[Inst_Address+2], Instruction_Memory[Inst_Address+1], Instruction_Memory[Inst_Address+0]};
    end
  
endmodule

