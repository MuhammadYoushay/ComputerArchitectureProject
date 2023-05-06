module Mux(
  input [63:0] a, b,
  input SEL,
  output [63:0] data_out
);
  
  assign data_out = SEL ? b : a;
  
endmodule