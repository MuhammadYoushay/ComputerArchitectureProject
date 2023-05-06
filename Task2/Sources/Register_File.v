module Register_File(
  input [63:0] WriteData,
  input [4:0] rs1, rs2, rd,
  input RegWrite,
  input clk, reset,
  
  output reg [63:0] ReadData1, ReadData2

);
reg [63:0] Registers [31:0];
integer i;
initial begin
for (i=0; i<64; i=i+1)
begin
Registers [i] = 8'h0;
end
Registers [11] = 8'h8;
end
always @(*)
    begin
      if (reset == 1)
        begin
          ReadData1 = 64'b0;
          ReadData2 = 64'b0;
        end
      else
        begin
          ReadData1 = Registers[rs1];
          ReadData2 = Registers[rs2];
        end 
    end
  
always @ (posedge clk)
    begin
      if (RegWrite == 1)
        begin
          Registers[rd] = WriteData;
        end  
     end
  
endmodule