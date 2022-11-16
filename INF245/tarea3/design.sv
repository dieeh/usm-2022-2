module alu(
        input logic [2:0] opcode,
        input logic [7:0] A_in, B_in,
        output logic [7:0] salida, flags
    );
    reg [7:0] resultado;
    //wire [8:0] tmp;
    //assign salida = resultado; // ALU output
    //assign tmp = {1'b0,A} + {1'b0,B};
    always @(*)
    begin
        case(opcode)
        3'b000: //Suma 2-complemento
            resultado = (~A_in + 1) + (~B_in + 1);
        3'b001: //Resta 2-complemento
            resultado = (~A_in + 1) - (~B_in + 1);
        3'b010: //Suma magnitud
            resultado = A_in + B_in;
        3'b011: //Resta magnitud
            resultado = A_in - B_in;
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

    always @(*)
    begin
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

        //if (conditions) begin //C, la operación produce un carry de salida
        //    
        //end

        //if (conditions) begin //V, la operacion produce un overflow
        //    
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

        //if (conditions) begin //P, el valor de salida tiene la misma cantidad de 0's y 1's
        //    
        //end
    end
endmodule
