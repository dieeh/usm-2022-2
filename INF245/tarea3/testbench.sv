`timescale 1ns/1ns

module testb_alu;
    reg[7:0] testA,testB;
    reg[2:0] Sel_ALU;

  	wire[7:0] Out_ALU, flaps;

    alu test_unit(
        Sel_ALU,
        testA,testB,
        Out_ALU, flaps
    );
    initial begin
        testA = 8'h23; testB = 8'h56; Sel_ALU = 3'b000; #10;
        $display("Esta wea dio: %h y debia ser 79 en Suma 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 02", flaps);
        testA = 8'h56; testB = 8'h79; Sel_ALU = 3'b000; #10;
        $display("Esta wea dio: %h y debia ser CF en Suma 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 92", flaps);
        testA = 8'hCF; testB = 8'h23; Sel_ALU = 3'b000; #10;
        $display("Esta wea dio: %h y debia ser F2 en Suma 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 80", flaps);
        testA = 8'hCF; testB = 8'h6D; Sel_ALU = 3'b000; #10;
        $display("Esta wea dio: %h y debia ser 3C en Suma 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 01", flaps);
        testA = 8'hFA; testB = 8'hFD; Sel_ALU = 3'b000; #10;
        $display("Esta wea dio: %h y debia ser F7 en Suma 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser AA", flaps);
        testA = 8'hFA; testB = 8'h23; Sel_ALU = 3'b000; #10;
        $display("Esta wea dio: %h y debia ser 1D en Suma 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 32", flaps);
        testA = 8'h69; testB = 8'h42; Sel_ALU = 3'b001; #10;
        $display("Esta wea dio: %h y debia ser 27 en Resta 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 0B", flaps);
        testA = 8'h69; testB = 8'h82; Sel_ALU = 3'b001; #10;
        $display("Esta wea dio: %h y debia ser E7 en Resta 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 8A", flaps);
        testA = 8'hA3; testB = 8'hA4; Sel_ALU = 3'b001; #10;
        $display("Esta wea dio: %h y debia ser FF en Resta 2-complemento", Out_ALU);
        $display("Con flags: %h que debian ser 82", flaps);
        testA = 8'hF0; testB = 8'h0F; Sel_ALU = 3'b010; #10;
        $display("Esta wea dio: %h y debia ser FF en Suma magnitud", Out_ALU);
        $display("Con flags: %h que debian ser 0A", flaps);
        testA = 8'hF0; testB = 8'h10; Sel_ALU = 3'b010; #10;
        $display("Esta wea dio: %h y debia ser 00 en Suma magnitud", Out_ALU);
        $display("Con flags: %h que debian ser 78", flaps);
        testA = 8'hFF; testB = 8'h0F; Sel_ALU = 3'b011; #10;
        $display("Esta wea dio: %h y debia ser F0 en Resta magnitud", Out_ALU);
        $display("Con flags: %h que debian ser 29", flaps);
        testA = 8'h0F; testB = 8'hFF; Sel_ALU = 3'b011; #10;
        $display("Esta wea dio: %h y debia ser 10 en Resta magnitud", Out_ALU);
        $display("Con flags: %h que debian ser 30", flaps);
        testA = 8'h0F; testB = 8'h04; Sel_ALU = 3'b100; #10;
        $display("Esta wea dio: %h y debia ser F0 en Rotación izquierda", Out_ALU);
        $display("Con flags: %h que debian ser 89", flaps);
        testA = 8'h0F; testB = 8'h06; Sel_ALU = 3'b101; #10;
        $display("Esta wea dio: %h y debia ser 3C en Rotación derecha", Out_ALU);
        $display("Con flags: %h que debian ser 09", flaps);
        testA = 8'h01; testB = 8'h05; Sel_ALU = 3'b110; #10;
        $display("Esta wea dio: %h y debia ser 20 en Duplicación", Out_ALU);
        $display("Con flags: %h que debian ser 00", flaps);
        testA = 8'h01; testB = 8'hFF; Sel_ALU = 3'b110; #10;
        $display("Esta wea dio: %h y debia ser 00 en Duplicación", Out_ALU);
        $display("Con flags: %h que debian ser 70", flaps);
        testA = 8'hFF; testB = 8'h02; Sel_ALU = 3'b111; #10;
        $display("Esta wea dio: %h y debia ser 3C en División binaria", Out_ALU);
        $display("Con flags: %h que debian ser 09", flaps);
        testA = 8'hFF; testB = 8'hFF; Sel_ALU = 3'b111; #10;
        $display("Esta wea dio: %h y debia ser 00 en División binaria", Out_ALU);
        $display("Con flags: %h que debian ser 44", flaps);

    end
endmodule