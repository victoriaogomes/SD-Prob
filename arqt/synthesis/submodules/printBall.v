module printBall(
    input wire clk_in,                                                    // Clock base (vindo da placa)
    input wire i_rst,                                                     // Reset: recomeça a imprimir o quadro
    input wire o_active,                                                  // Alto quando um pixel está sendo desenhado
    input wire [9:0] o_x,                                                 // Posição x atual do pixel
    input wire [8:0] o_y,                                                 // Posição y atual do pixel
    input wire [8:0] pos_yBarra1,                                         // Indica a posição atual da barra 1 no eixo y
    input wire [8:0] pos_yBarra2,                                         // Indica a posição atual da barra 2 no eixo y
    input wire enablePong,
    output reg [3:0] pointPlayers,                                        // Indica se o player 1 pontuou (1) ou não (0)
    output reg color                                                      // Indica se está imprimindo ou não (1 imprimindo, 0 não)
);

// Bolinha: 8x8
// Barra: 10x90
// Meio da tela pra bola = 236
reg [8:0] y_bola = 188;                                                   // Posição inicial da bola em y
reg [9:0] x_bola = 316;                                                   // Posição inicial da bola em x
reg [15:0] delay = 0;                                                     // Tempo que deve ser esperado até atualizar as coordenadas
reg startDelay = 1;                                                       // Sinal que indica se o delay deve ser iniciado
reg direcao = 0;                                                          // Indica a direção do movimento da bola: 0 (direita) e 1 (esquerda)
reg aleatory = 0;                                                         // Indica se a bola deve retornar aleatoriamente (1) ou não (0)
reg upDown = 1;                                                           // Indica se a bola deve subir ou descer
localparam tamBolaX = 8,                                                  // Tamanho da bola no eixo x
           tamBolaY = 8,                                                  // Tamanho da bola no eixo y
           pos_xBarra1 = 10,                                              // Posição inicial fixa da barra 1 no eixo x
           pos_xBarra2 = 620;                                             // Posição inicial fixa da barra 1 no eixo y
reg cor;                                                                  // Fio auxiliar para manipular o valor do registrador color
reg [1:0] pontuacaoJogador1 = 0;
reg [1:0] pontuacaoJogador2 = 0;
wire [1:0] random_Y;
wire [12:0] random_Pos;

 LFSR randValue (
    .clock(clk_in),
    .reset(i_rst),
    .rnd(random_Pos),
    .rnd_Y(random_Y)
);

always @(posedge clk_in) begin                                            // A cada pulso de clock
  if(i_rst || pontuacaoJogador1 == 3 || pontuacaoJogador2 == 3) begin
    pontuacaoJogador1 <= 0;
    pontuacaoJogador2 <= 0;
    y_bola = 188;
    x_bola = 316;
  end
  if(enablePong == 1) begin
    if(startDelay) begin                                                  // Verifica se o controlador do delay está ativado
      if(delay == 16'hFFFF) begin                                         // Verifica se o delay já chegou ao final
          startDelay <= 0;                                                // Seta variável para finalizar delay
          delay <= 0;                                                     // Zera contador do delay
      end
      else delay <= delay + 1'b1;                                         // Incrementa contador do delay
    end

    if(o_x == (639) && o_y == (479) && startDelay == 0) begin             // Caso a posição atual do x e do y = fim da tela e o delay = desativado

      if(x_bola >= 631) begin                                             // Verifica se bateu no fim da tela no eixo x
        direcao = ~direcao;                                               // Inverte a direção da bola para esquerda
        pontuacaoJogador1 <= pontuacaoJogador1 + 1;                        // Ativa bit indicador de pontuação de player 1
      end
      else if(x_bola <= 1) begin                                          // Verifica se bateu no início da tela no eixo x
        direcao = ~direcao;                                               // Inverte a direção da bola para direita
        pontuacaoJogador2 <= pontuacaoJogador2 + 1;                        // Ativa bit indicador de pontuação de player 2
      end

      if(y_bola <= 2) upDown = 0;                                         // Caso esteja no início da tela no eixo y, muda direção para baixo
      else if (y_bola >=471) upDown = 1;                                  // Caso esteja no início da tela no eixo y, muda direção para cima

      // Verifica se o eixo x e y da bola se encontra na barra 1
      if(x_bola >= pos_xBarra1 && x_bola <= (pos_xBarra1+10) && (y_bola + 8) >= pos_yBarra1 && (y_bola) <= (pos_yBarra1 + 90) ) begin
        direcao = 0;                                                      // Direção = direita
        upDown = random_Pos[2];                                           // Caso seja 0, bola vai para baixo. Caso 1, bola vai p cima
        // Caso bola colida com a parte 1 ou 3 da barra
        if((y_bola + 8) >= pos_yBarra1 && (y_bola) <= (pos_yBarra1 + 30) || (y_bola + 8) >= (pos_yBarra1 + 60) && (y_bola) <= (pos_yBarra1 + 90))
          aleatory = 1;                                                   // Indica que a bola deve retornar aleatoriamente
        if((y_bola + 8) >= (pos_yBarra1 + 30) && (y_bola) <= (pos_yBarra1 + 60))  // Caso bola colida com a parte 2 da barra
          aleatory = 0;                                                   // Indica que a bola não deve retornar aleatoriamente
      end

      // Verifica se o eixo x e y da bola se encontra na barra 2
      if(x_bola >= (pos_xBarra2-10) && x_bola <= (pos_xBarra2) && (y_bola + 8) >= pos_yBarra2 && (y_bola) <= (pos_yBarra2 + 90) ) begin
        direcao = 1;                                                      // Direção = esquerda
        upDown = random_Pos[4];                                           // Caso seja 0, bola vai para baixo. Caso 1, bola vai p cima
        // Caso bola colida com a parte 1 ou 3 da barra
        if((y_bola + 8) >= pos_yBarra2 && (y_bola) <= (pos_yBarra2 + 30) || (y_bola + 8) >= (pos_yBarra2 + 60) && (y_bola) <= (pos_yBarra2 + 90))
          aleatory = 1;                                                   // Indica que a bola deve retornar aleatoriamente
        if((y_bola + 8) >= (pos_yBarra2 + 30) && (y_bola + 8) <= (pos_yBarra2 + 60))  // Caso bola colida com a parte 2 da barra
          aleatory = 0;                                                   // Indica que a bola não deve retornar aleatoriamente
      end

      if(direcao == 1) x_bola <= x_bola - 2;                              // Caso direção = esquerda, diminui valor da pos da bola no eixo x
      else x_bola <= x_bola + 2;                                          // Caso direção = esquerda, incrementa valor da pos da bola no eixo x

      if(aleatory == 1) begin                                             // Caso aleatório esteja ligado
        if(upDown == 0) y_bola = y_bola + random_Y;                       // Deve ir para baixo, e por isso incrementa y
        else y_bola = y_bola - random_Y;                                  // Deve ir para cima, e por isso decrementa y
      end
      startDelay <= 1;                                                    // Indica que o delay deve começar a rodar novamente
    end
  end
end


always @(posedge clk_in) begin                                            // A cada pulso de clock
    color <= cor;                                                         // O valor do fio 'cor' é armazenado no registrador 'color'
    pointPlayers <= {pontuacaoJogador1, pontuacaoJogador2};
end

always @(*) begin
    if((o_active == 1) && (enablePong == 1)) begin                        // Caso esteja na área ativa
        if(o_x >= x_bola && o_x <= (x_bola+tamBolaX)) begin               // Verifica se está na posição x da bola para desenhá-la
            if(o_y >= y_bola && o_y <= (y_bola+tamBolaY)) begin           // Verifica se está na posição y da bola para desenhá-la
                cor = 1;                                                  // Indica que deve imprimir na cor roxa
            end
            else cor = 0;                                                 // Indica que deve imprimir na cor azul
        end
        else cor = 0;                                                     // Indica que deve imprimir na cor azul
    end
end
endmodule
