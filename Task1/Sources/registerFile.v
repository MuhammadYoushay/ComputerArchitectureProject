module registerFile(
	input [63:0] WriteData,
	input [4:0] rs1,
	input [4:0] rs2,
	input [4:0] rd,
	output reg [63:0] readData1,
	output reg [63:0] readData2,
	input clk, reset, RegWrite
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
          readData1 = 64'b0;
          readData2 = 64'b0;
        end
      else
        begin
          readData1 = Registers[rs1];
          readData2 = Registers[rs2];
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


