module contador3(input logic clk,
                input logic reset,
                 output logic [1:0] y,
                output logic s);
 
  typedef enum logic [1:0] {S0,S1,S2,S3} statetype; //Creamos un tipo de dato llamado statetype
 
  statetype state,nextstate; //Instanciamos dos variables como state
 
  always_ff @(posedge clk, posedge reset)
    if(reset) state <= S0; // <= es para non-blocking
      else state <= nextstate;
 
  always_comb //Se ejecuta siempre, es similar al always @(*)
    case(state)
      S0: nextstate = S1;
      S1: nextstate = S2;
      S2: nextstate = S3;
      S3: nextstate = S0;
      default: nextstate = S0;
    endcase
    
 
      
  assign y = state;
  assign s = (state == S3);
 
 
endmodule



module test();
 
  logic clk,reset,s;
  logic [1:0] y;
 
  contador3 cont(clk,reset,y,s);
 
  initial begin
    reset = 1; #10;
    reset = 0; #10;
    display;
    clk = 0; #10;
    clk = 1; #10;
    display;
    clk = 0; #10;
    clk = 1; #10;
    display;
    clk = 0; #10;
    clk = 1; #10;
    display;
    clk = 0; #10;
    clk = 1; #10;
    display;
  end
 
  task display;
    $display("Y:%b S:%b",y,s);
  endtask
 
 
 
endmodule

