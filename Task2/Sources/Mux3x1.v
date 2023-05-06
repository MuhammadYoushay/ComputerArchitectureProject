module mux3by1(
  output [63:0] data_out,
  input [1:0] S,
  input [63:0] A,
  input [63:0] B,
  input [63:0] C
);

  assign data_out = (S == 2'b00) ? A : (S == 2'b01) ? B : C;
endmodule
