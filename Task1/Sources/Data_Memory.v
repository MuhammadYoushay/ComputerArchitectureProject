module Data_Memory(
	input [63:0] Mem_Addr, Write_Data,
	input clk, MemWrite, MemRead,
	output reg [63:0] Read_Data,
	output [63:0] element1,
    output [63:0] element2,
    output [63:0] element3,
    output [63:0] element4
);

 reg [7:0] DataMemory [63:0]; 
  integer i;
  integer x;
  
   initial  
    begin 
      for (i = 0; i < 64; i = i + 1)
      begin 
        DataMemory[i] = 0;
      end

     
 
      
    end 
  assign element1 ={DataMemory[7],DataMemory[6],  DataMemory[5] , DataMemory[4] , DataMemory[3] , DataMemory[2] , DataMemory[1] , DataMemory[0]}; 
  assign element2 = {DataMemory[15], DataMemory[14], DataMemory[13] , DataMemory[12] , DataMemory[11], DataMemory[10] , DataMemory[9] , DataMemory[8]}; 
assign element3 = {DataMemory[23],DataMemory[22],DataMemory[21],DataMemory[20],DataMemory[19],DataMemory[18],DataMemory[17],DataMemory[16]} ; 
 assign element4= {DataMemory[31] ,DataMemory[30], DataMemory [29], DataMemory[28], DataMemory[27] , DataMemory[26] ,DataMemory[25] ,DataMemory[24]};
   

  
  
  always @( posedge clk)
    begin
    if (MemWrite == 1'b1)
    begin
      DataMemory[Mem_Addr] = Write_Data[7:0];
      DataMemory[Mem_Addr + 1] = Write_Data[15:8];
      DataMemory[Mem_Addr + 2] = Write_Data[23:16];
      DataMemory[Mem_Addr + 3] = Write_Data[31:24];
      DataMemory[Mem_Addr + 4] = Write_Data[39:32];
      DataMemory[Mem_Addr + 5] = Write_Data[47:40];
      DataMemory[Mem_Addr + 6] = Write_Data[55:48];
      DataMemory[Mem_Addr + 7] = Write_Data[63:56];
    end
    end
  always @(*)
    begin
      if (MemRead == 1'b1)
        begin
      Read_Data = {DataMemory[Mem_Addr + 7], DataMemory[Mem_Addr + 6],DataMemory[Mem_Addr + 5], DataMemory[Mem_Addr + 4], DataMemory[Mem_Addr + 3], DataMemory[Mem_Addr + 2],DataMemory[Mem_Addr + 1], DataMemory[Mem_Addr]};
        end
      
    end
endmodule

