module alu(
        input logic [2:0] opcode,
        input logic [7:0] A_in, B_in,
        output logic [7:0] salida, flags
    );
    reg [7:0] resultado;
    reg [7:0] A_comp, B_comp;
    //assign salida = resultado; // ALU output
    //assign tmp = {1'b0,A} + {1'b0,B};
    logic temp_carry;
    always @(*)
    begin
        case(opcode)
        3'b000: //Suma 2-complemento
            begin
                A_comp = ~A_in + 8'h01;
                B_comp = ~B_in + 8'h01;
                {temp_carry,resultado} = ~(A_comp + B_comp) + 8'h01;
            end
        3'b001: //Resta 2-complemento
            begin
                A_comp = ~A_in + 8'h01;
                B_comp = ~B_in + 8'h01;
                {temp_carry,resultado} = ~(A_comp - B_comp) + 8'h01;
            end
        3'b010: //Suma magnitud
            {temp_carry,resultado} = A_in + B_in;
        3'b011: //Resta magnitud
            {temp_carry,resultado} = A_in - B_in;
        3'b100: //Rotación izquierda
            resultado = A_in<<B_in;
        3'b101: //Rotación derecha
            resultado = A_in>>B_in;
        3'b110: //Duplicación
          resultado = A_in * ((2'b10)**B_in);
        3'b111: //División binaria
          resultado = A_in / ((2'b10)**B_in);

        default: resultado = 8'b0;
        endcase
    end
    assign salida = resultado;
    integer sum;
    always @(*)
    begin
      flags = 8'h00;
      if (resultado[7]) begin  //N, el valor de salida es negativo
            flags[7] = 1;
        end else begin
            flags[7] = 0;
        end

        if (resultado == 0) begin //Z, el valor de salida es cero
            flags[6] = 1;
        end else begin
            flags[6] = 0;
        end

        if (temp_carry) begin //C, la operación produce un carry de salida
            flags[5] = 1;
        end else begin
            flags[5] = 0;
        end

        //if (conditions) begin //V, la operacion produce un overflow
        //    flags[4] = 1;
        //end else begin
        //    flags[4] = 0;
        //end

        if (A_in > B_in) begin //G, el valor de A es mayor que el valor de B
            flags[3] = 1;
        end else begin
            flags[3] = 0;
        end

        if (A_in == B_in) begin //Q, el valor de A es igual al de B
            flags[2] = 1;
        end else begin
            flags[2] = 0;
        end

        if (resultado[0]) begin //O, el valor de salida es impar
            flags[1] = 1;
        end else begin
            flags[1] = 0;
        end

        sum = 0;
        for (int i = 0;i<8 ;i++ ) begin
          	if (resultado[i] == 1) begin
                sum++;
            end
        end

        if (sum == 4) begin //P, el valor de salida tiene la misma cantidad de 0's y 1's
            flags[0] = 1;            
        end else begin
            flags[0] = 0;
        end
    end
endmodule
