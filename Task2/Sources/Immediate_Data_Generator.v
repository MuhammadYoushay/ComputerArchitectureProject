module Immediate_Data_Generator(
  input [31:0] instruction,
  output reg [63:0] immediate
);
  
  wire [6:5] field;
  assign field = instruction[6:5];

    always @ (*)
    begin
      case (field)
        
        2'b00: immediate[11:0] = {instruction[31:20]}; // load instructions 
        2'b01: immediate[11:0] = {instruction[31:25], instruction[11:7] };   // store instructions   
        2'b11: immediate[11:0] = {instruction[31], instruction[7], instruction[30:25], instruction[11:8]}; // branch instructions
                                                                                              
        default: immediate[11:0] = 12'b0;
      endcase
      
     immediate = { {52  {immediate[11]}}, immediate[11:0] } ;
    end  
endmodule