module top (clk, a, b, z1, z2);
  input clk, a, b;
  output z1, z2;
  XOR2 u_skew (.A(a), .B(b), .Z(z1));
  XOR2_BAL u_bal (.A(a), .B(b), .Z(z2));
endmodule
