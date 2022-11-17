// Code your design here
module basico(input logic a,b,
              input logic [7:0] c,
              output logic x,y,z,u,s,
              output logic [7:0] d,e);
  
  assign x = ~a; //NOT
  assign y = a | b; //OR
  assign z = a & b; //AND
  assign u = a ^ b; //XOR
  assign s = a + b; //SUM
  assign d = c << a; //Shift logico izquierda
  assign e = c >> a; //Shift logico derecha
endmodule


// Code your testbench here
// or browse Examples
module test();
 
  logic a,b,x,y,z,u,s; //Variables que ocuparemos
  logic [7:0] c,e,d;	
  
  basico basic(a,b,c,x,y,z,u,s,d,e); //Instancia del módulo
 
  initial begin
    a = 0; b = 0;c=8'b0011_0011; #10;
    display;
    b = 1; #10;
    display;
    a = 1; b = 0; #10;
    display;
    b = 1; #10;
    display;
  end
  
  
  task display;
      begin
        $display("INPUT: %b",{a,b});
        $display("Shift: %b",e);
      end
  endtask
endmodule

