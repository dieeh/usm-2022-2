module ALU(input logic [7:0] a,b,
           input logic [1:0] ctrl,
           output logic [7:0] out,
           output logic cout);
  always @(*) begin
    case(ctrl)
      2'b00: out = a & b;
      2'b01: out = a | b;
      2'b10: {cout,out} = a + b;
      2'b11: {cout,out} = a - b;
     default: out = 8'b0000_0000;
   endcase
  end
endmodule


module test();
 
  logic [7:0] a,b,out;
  logic [1:0] ctrl;
  logic cout;
 
  ALU alu(a,b,ctrl,out,cout); //Instancia
 
  initial begin
    a = 8'b1000_0011; b = 8'b1000_0001; ctrl = 2'b10; #10;
    $display("SUMA: %b cout:%b",out,cout);
  end
 
endmodule

