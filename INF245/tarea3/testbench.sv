`timescale 1ns/1ns

module testb_alu;
    reg[7:0] A,B;
    reg[2:0] Sel_ALU;

  	wire[7:0] Out_ALU, flaps;

    integer i;
    alu test_unit(
        A,B,
        Sel_ALU,
        Out_ALU, flaps
    );
    initial begin
        A = 8'hF0;
        B = 8'h0F;
        Sel_ALU = 3'b010;
        $display("Esta wea dio: %h", Out_ALU);
        $display("Con flags: %h", flaps)
    end
endmodule