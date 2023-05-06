module Program_Counter(
  input clk, reset,
  input [63:0] PC_In,
  output reg [63:0] PC_Out
); 
  always @(posedge clk or posedge reset)
    begin
      if (reset == 1)
        begin
          PC_Out = 0;
        end   
      else
        begin
          PC_Out = PC_In;
        end     
    end
endmodule