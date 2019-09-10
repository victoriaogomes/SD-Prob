// **** Este módulo usa o Linear Feedback Shift Register para gerar *****/
// ** um número pseudo-aleatório para a volta da barra nas extremidades */

module LFSR(
  input clock,
  input reset,
  output reg [4:0] rnd_Y,
  output reg rnd
);

reg [4:0] data_next;                        // Registro do próximo valor a ser calculado

always @* begin                             // A cada pulso de clock, dá shift para gerar outro número
  data_next[4] = rnd_Y[4]^rnd_Y[1];         // Faz um XOR com os bits 4 e 1 do vetor buscado
  data_next[3] = rnd_Y[3]^rnd_Y[0];         // Faz um XOR com os bits 3 e 0 do vetor buscado
  data_next[2] = rnd_Y[2]^data_next[4];     // Faz um XOR com os bits 2 e 4 do vetor buscado
  data_next[1] = rnd_Y[1]^data_next[3];     // Faz um XOR com os bits 1 e 3 do vetor buscado
  data_next[0] = rnd_Y[0]^data_next[2];     // Faz um XOR com os bits 0 e 2 do vetor buscado
end

always @(posedge clock or negedge reset)
  if(!reset) begin                          // Se o botão for pressionado, reinicia
    rnd_Y <= 5'h1f;                         // O Y aleatório recebe o valor inicial 1
    rnd <= rnd_Y[3];                        // O registro aleatório recebe um dos bits do vetor
  end
  else begin
    rnd_Y <= data_next;                     // Y recebe o vetor de XORs calculado anteriormente
    rnd <= data_next[2];                    // Random recebe um dos bits do vetor de XORs
  end
endmodule
