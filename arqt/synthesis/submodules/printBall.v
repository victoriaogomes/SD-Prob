module printBall(
    input wire clk_in,                                 // Clock base (vindo da placa)
    input wire i_rst,                                  // Reset: recomeça a imprimir o quadro
    input wire o_active,                               // Alto quando um pixel está sendo desenhado
    input wire [9:0] o_x,                              // Posição x atual do pixel
    input wire [8:0] o_y,                              // Posição y atual do pixel
    input wire [8:0] pos_yBarra1,                      // Indica a posição atual da barra 1 no eixo y
    input wire [8:0] pos_yBarra2,                      // Indica a posição atual da barra 2 no eixo y
    output reg pointPlayer1,                           // Indica se o player 1 pontuou (1) ou não (0)
    output reg pointPlayer2,                           // Indica se o player 2 pontuou (1) ou não (0)
    output reg color                                   // Indica se está imprimindo ou não (1 imprimindo, 0 não)
);

// Bolinha: 8x8
// Barra: 10x90
// Meio da tela pra bola = 236
reg [8:0] y_bola = 200;                                // Posição inicial da bola em y
reg [9:0] x_bola = 316;                                // Posição inicial da bola em x
reg [15:0] delay = 0;                                  // Tempo que deve ser esperado até atualizar as coordenadas
reg startDelay = 1;                                    // Sinal que indica se o delay deve ser iniciado
reg direcao = 0;                                       // Indica a direção do movimento da bola: 0 (direita) e 1 (esquerda)
reg aleatory = 0;                                      // Indica se a bola deve retornar aleatoriamente (1) ou não (0)
reg upDown = 0;                                        // Indica se a bola deve subir ou descer
localparam tamBolaX = 8,                               // Tamanho da bola no eixo x
           tamBolaY = 8,                               // Tamanho da bola no eixo y
           pos_xBarra1 = 10,
           pos_xBarra2 = 620;
reg cor;                                               // Fio auxiliar para manipular o valor do registrador color
wire [1:0] random_Y;
wire [9:0] random_Pos;

rand_YandPos rand (
    .VGA_clk(clk_in),
    .rand_Y(random_Y),
    .rand_Pos(random_Pos)
);

always @(posedge clk_in) begin                         // A cada pulso de clock
  if(startDelay) begin
    if(delay == 16'hFFFF) begin                       // Verifica se o delay já chegou ao final
        startDelay <= 0;                               // Seta variável para finalizar delay
        delay <= 0;
    end
    else delay <= delay + 1'b1;
  end
  if(o_x == (638) && o_y == (479) && startDelay == 0) begin
    if(x_bola >= pos_xBarra1 && x_bola <= (pos_xBarra1+10) && y_bola >= pos_yBarra1 && y_bola <= (pos_yBarra1 + 90) ) begin
      direcao = 0;
      upDown = random_Pos[2];
      // Parte 1 ou 3 da barra
      if(y_bola >= pos_yBarra1 && y_bola <= (pos_yBarra1 + 30) || y_bola >= (pos_yBarra1 + 60) && y_bola <= (pos_yBarra1 + 90))
        aleatory = 1;
      // Parte 2 da barra
      if(y_bola >= (pos_yBarra1 + 30) && y_bola <= (pos_yBarra1 + 60))
        aleatory = 0;
    end
    if(x_bola >= (pos_xBarra2-10) && x_bola <= (pos_xBarra2) && y_bola >= pos_yBarra2 && y_bola <= (pos_yBarra2 + 90) ) begin
      direcao = 1;
      // Parte 1 ou 3 da barra
      if(y_bola >= pos_yBarra2 && y_bola <= (pos_yBarra2 + 30) || y_bola >= (pos_yBarra2 + 60) && y_bola <= (pos_yBarra2 + 90))
        aleatory = 1;
      // Parte 2 da barra
      if(y_bola >= (pos_yBarra2 + 30) && y_bola <= (pos_yBarra2 + 60))
        aleatory = 0;
    end
    if(direcao == 1) x_bola <= x_bola - 2;
    else x_bola <= x_bola + 2;
    if(aleatory == 1) begin
      if(upDown == 0) y_bola = y_bola + random_Y;
      else y_bola = y_bola - random_Y;
    end
    startDelay <=1;
  end
end


always @(posedge clk_in) begin                         // A cada pulso de clock
    color <= cor;                                      // O valor do fio 'cor' é armazenado no registrador 'color'
end

always @(*) begin
    if(o_active) begin                                 // Caso esteja na área ativa
        if(o_x >= x_bola && o_x <= (x_bola+tamBolaX)) begin        // Verifica se está na posição x da bola para desenhá-la
            if(o_y >= y_bola && o_y <= (y_bola+tamBolaY)) begin         // Verifica se está na posição y da bola para desenhá-la
                cor = 1;
            end
            else cor = 0;
        end
        else cor = 0;
    end
end
endmodule
