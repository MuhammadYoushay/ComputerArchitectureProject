module Program_Counter
(
	input clk, reset,
	input [63:0] PC_In,
	output reg [63:0] PC_Out
);

initial
	PC_Out = 0;
	
	
always @ (posedge clk)
begin
	if (reset == 0)
		PC_Out = PC_In;
	else
		PC_Out = 0;
end
endmodule