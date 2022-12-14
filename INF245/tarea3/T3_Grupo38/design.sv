module alu(
        input logic [2:0] opcode,
        input logic [7:0] A_in, B_in,
        output logic [7:0] salida, flags
    );
    reg [7:0] resultado, A_comp, B_comp, temporal;
    logic temp_carry = 0;
    always @(*)
    begin
        case(opcode)
        3'b000: //Suma 2-complemento
            begin
                temp_carry = 0;
                A_comp = ~A_in + 8'h01;
                B_comp = ~B_in + 8'h01;
                {temp_carry,resultado} = ~(A_comp + B_comp) + 8'h01;
            end
        3'b001: //Resta 2-complemento
            begin
                temp_carry = 0;
                A_comp = ~A_in + 8'h01;
                B_comp = ~B_in + 8'h01;
                {temp_carry,resultado} = ~(A_comp - B_comp) + 8'h01;
            end
        3'b010: //Suma magnitud
            begin
                temp_carry = 0;
                {temp_carry,resultado} = A_in + B_in;
            end
        3'b011: //Resta magnitud
            begin
                temp_carry = 1;
                {temp_carry,resultado} = A_in - B_in;
            end
        3'b100: //Rotación izquierda
            begin
                temp_carry = 0;
                temporal = A_in;
                repeat(B_in) begin
                    temporal = {temporal[6:0],temporal[7]};
                end
                resultado = temporal;
            end
        3'b101: //Rotación derecha
            begin
                temp_carry = 0;
                temporal = A_in;
                repeat(B_in) begin
                    temporal = {temporal[0],temporal[7:1]};
                end
                resultado = temporal;
            end
        3'b110: //Duplicación
            begin
                temp_carry = 0;
                {temp_carry,resultado} = (A_in << B_in)|(A_in >> (8 - B_in));
            end
        3'b111: //División binaria
            begin
                temp_carry = 0;
                resultado = A_in >> B_in;  
            end
        default: resultado = 8'b0;
        endcase
    end
    assign salida = resultado;
    integer sum;
    byte tempbit1, tempbit2;
    always @(*)
    begin
        flags = 8'h00;

        case (opcode)
            3'b010:
                flags[7] = 0;
            3'b011:
                flags[7] = 0;
            3'b110:
                flags[7] = 0;
            3'b111:
                flags[7] = 0;
            default: begin
                if (resultado[7]) begin  //N, el valor de salida es negativo
                    flags[7] = 1;
                end else begin
                    flags[7] = 0;
                end
            end
        endcase

        if (resultado == 0) begin //Z, el valor de salida es cero
            flags[6] = 1;
        end else begin
            flags[6] = 0;
        end

        if (temp_carry) begin //C, la operación produce un carry de salida
            flags[5] = 1;
        end else if ((opcode == 3'b011) & (temp_carry == 0)) begin
            flags[5] = 1;
        end else begin
            flags[5] = 0;
        end

        case (opcode)
            3'b000: //Suma 2-Complemento
                begin
                    if ((A_in[7] & B_in[7]) & (resultado[7] == 0)) begin
                        flags[4] = 1;
                    end else if (((A_in[7] == 0) & (B_in[7] == 0)) & resultado[7]) begin
                        flags[4] = 1;
                    end else begin
                        flags[4] = 0;
                    end
                end
            3'b001: //Resta 2-Complemento
                begin
                    if ((A_in[7] & (B_in[7] == 0)) & (resultado[7] == 0)) begin
                        flags[4] = 1;
                    end else if (((A_in[7] == 0) & B_in[7]) & resultado[7]) begin
                        flags[4] = 1;
                    end else begin
                        flags[4] = 0;
                    end
                end
            3'b010: //Suma magnitud
                begin
                    if (flags[5])
                        flags[4] = 1; 
                end
            3'b110:
                begin
                    if (flags[5])
                        flags[4] = 1; 
                end
            default: flags[4] = 0;
        endcase
        
        case (opcode)
            3'b000:
                begin
                    if (A_in[7] & (B_in[7] == 0)) begin
                        
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if (A_in[7] & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                end
            3'b001:
                begin
                    if (A_in[7] & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if (A_in[7] & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                end
            3'b010:
                if (A_in > B_in) begin
                    flags[3] = 1;
                end
            3'b011:
                if (A_in > B_in) begin
                    flags[3] = 1;
                end
            3'b100:
                begin
                    if (A_in[7] & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if (A_in[7] & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                end
            3'b101:
                begin
                    if (A_in[7] & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if (A_in[7] & B_in[7]) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                    if ((A_in[7] == 0) & (B_in[7] == 0)) begin
                        tempbit1 = A_in;
                        tempbit2 = B_in;
                        if (tempbit1 > tempbit2) begin
                            flags[3] = 1;
                        end
                    end
                end
            3'b110:
                if (A_in > B_in) begin
                    flags[3] = 1;
                end
            3'b111:
                if (A_in > B_in) begin
                    flags[3] = 1;
                end
            default: flags[3] = 0;
        endcase

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

        sum = resultado[7] + resultado[6] + resultado[5] + resultado[4] + resultado[3] + resultado[2] + resultado[1] + resultado[0];
        if (sum == 4) begin //P, el valor de salida tiene la misma cantidad de 0's y 1's
            flags[0] = 1;            
        end else begin
            flags[0] = 0;
        end
    end
endmodule
