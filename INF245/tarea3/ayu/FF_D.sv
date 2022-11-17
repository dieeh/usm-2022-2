module flipflop(input logic clk,
               input logic d,
                output logic q);
 
  always_ff @(posedge clk)
    q <=d;
 
endmodule

module test();
 
  logic clk,d,q;
 
  flipflop ff(clk,d,q);
 
  initial begin
 
    clk = 0; d = 0;#10;
    display;
    clk = 1; d = 0;#10;
    display;
    clk = 0; d = 1;#10;
    display;
    clk = 1; d = 1;#10;
    display;
  end
 
 
  task display;
    $display("Q:%b",q);
  endtask
 
endmodule

