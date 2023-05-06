module Data_Memory
(
  input clk,
  input [63:0] Mem_Addr,
  input [63:0] Write_Data,
  input MemWrite,
  input MemRead,
  output reg [63:0] Read_Data  
);
 
  reg [7:0] Data_Memory [63:0];
  integer i;
  initial
    begin
      for (i=0; i<64; i=i+1)
        begin
          Data_Memory [i] = 8'd0;
        end
    end
always @(*)
    begin
      if(MemRead == 1)
        begin Read_Data = {
          Data_Memory[Mem_Addr+7], Data_Memory[Mem_Addr+6],
          Data_Memory[Mem_Addr+5], Data_Memory[Mem_Addr+4],
          Data_Memory[Mem_Addr+3], Data_Memory[Mem_Addr+2],
          Data_Memory[Mem_Addr+1], Data_Memory[Mem_Addr+0] 
        };
        end
    end
always @(posedge clk)
    begin
      if (MemWrite == 1)
        begin
          Data_Memory[Mem_Addr+7] = Write_Data[63:56];
          Data_Memory[Mem_Addr+6] = Write_Data[55:48];
          Data_Memory[Mem_Addr+5] = Write_Data[47:40];
          Data_Memory[Mem_Addr+4] = Write_Data[39:32];
          Data_Memory[Mem_Addr+3] = Write_Data[31:24];
          Data_Memory[Mem_Addr+2] = Write_Data[23:16];
          Data_Memory[Mem_Addr+1] = Write_Data[15:8];
          Data_Memory[Mem_Addr+0] = Write_Data[7:0];
        end
    end
endmodule
