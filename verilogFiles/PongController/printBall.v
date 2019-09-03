// Animação com a bola

module printBall #(
    H_SIZE=20,                                  // Metade da largura da bola
    IX=320,                                     // Posição inicial horizontal do centro da bola
    IY=240,                                     // Posição inicial vertical do centro da bola
    IX_DIR=1,                                   // Direção horizontal inicial: 1 é direita, 0 é esquerda
    IY_DIR=1,                                   // Direção vertical inicial: 1 é baixo, 0 é cima
    D_WIDTH=640,                                // Largura da tela
    D_HEIGHT=480                                // Altura da tela
  )

    (
    input wire i_clk,                           // Clock base
    input wire i_ani_stb,                       // Clock da animação: o clock do pixel é 1 pixel/frame
    input wire i_rst,                           // Reset: retorna a animação para o início
    input wire i_animate,                       // Anima quando está alto
    output wire [11:0] o_x1,                    // Borda esquerda do quadrado: valor de 12 bits: 0-4095
    output wire [11:0] o_x2,                    // Borda direita do quadrado
    output wire [11:0] o_y1,                    // Borda do topo do quadrado
    output wire [11:0] o_y2                     // Borda do fundo do quadrado
    );

    reg [11:0] x = IX;                          // Posição horizontal do centro do quadrado
    reg [11:0] y = IY;                          // Posição horizontal do centro do quadrado
    reg x_dir = IX_DIR;                         // Direção horizontal da animação
    reg y_dir = IY_DIR;                         // Direção vertical da animação

    assign o_x1 = x - H_SIZE;                   // Esquerda: centro menos a metade do tamanho horizontal
    assign o_x2 = x + H_SIZE;                   // Direita
    assign o_y1 = y - H_SIZE;                   // Topo
    assign o_y2 = y + H_SIZE;                   // Fundo

    always @ (posedge i_clk)
    begin
        if (i_rst)                              // Quando reseta, reinicia a posição
        begin
            x <= IX;
            y <= IY;
            x_dir <= IX_DIR;
            y_dir <= IY_DIR;
        end
        if (i_animate && i_ani_stb)             //Se o pixel de animar e o clock está correto,
        begin
            x <= (x_dir) ? x + 1 : x - 1;       // Mova para esquerda se a posição é positiva
            y <= (y_dir) ? y + 1 : y - 1;       // Mova para baixo se a direção é positiva

            if (x <= H_SIZE + 1)                // Borda do quadrado bate na borda esquerda da tela
                x_dir <= 1;                     // Vá para a direita
            if (x >= (D_WIDTH - H_SIZE - 1))    // Borda do quadrado bate na borda direita da tela
                x_dir <= 0;                     // Vá para a esquerda
            if (y <= H_SIZE + 1)                // Borda do quadrado bate no topo da tela
                y_dir <= 1;                     // Vá para baixo
            if (y >= (D_HEIGHT - H_SIZE - 1))   // Borda do quadrado bate no fundo da tela
                y_dir <= 0;                     // Vá para cima
        end
    end
endmodule
