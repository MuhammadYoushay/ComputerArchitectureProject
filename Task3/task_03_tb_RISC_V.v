module tb_task3
();

reg clk, reset;
wire [63:0] index1,index2,index3,index4;
Pipelined_Processor_Task_3 tsk3
(
    .clk(clk),
    .reset(reset),
    .element1(index1),
    .element2(index2),
    .element3(index3),
    .element4(index4)  
);
initial 
 begin 
  clk = 1'b0; 
  reset = 1'b1;  
  #10 reset = 1'b0; 
 end   
always  
#5 clk = ~clk; 
endmodule 