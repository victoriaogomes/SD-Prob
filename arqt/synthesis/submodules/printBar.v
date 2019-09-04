module printBar #(parameter y_barraInicial = 240, x_barra = 10)(
    input wire clk_in,                                             // Clock base (vindo da placa)
    input wire clk_en,                                             // Clock para habilitar a instrução customizada
    input wire i_rst,                                              // Reset: recomeça a imprimir o quadro
    input wire o_active,                                           // Alto quando um pixel está sendo desenhado
    input wire [9:0] o_x,                                          // Posição x atual do pixel
    input wire [8:0] o_y,                                          // Posição y atual do pixel
    input wire [8:0] coordY,                                       // Coordenada para impressão em y
    input wire refreshBar,                                         // Indica se deve atualizar a barra ou não
    output reg color                                               // Indica se está imprimindo ou não (1 imprimindo, 0 não)
);

// Barra: 10x60
// Bolinha: 40x40
reg [8:0] y_barra = y_barraInicial;                                // Tamanho da barra
reg [8:0] y_barraAux;                                              // Auxiliar para armazenar novo valor de Y até fim do delay
reg [19:0] delay = 0;                                              // Tempo que deve ser esperado até atualizar as coordenadas
reg startDelay = 0;                                                // Sinal que indica se o delay deve ser iniciado
localparam tamBarraX = 10,                                         // Tamanho da barra no eixo x
           tamBarraY = 60;                                         // Tamanho da barra no eixo y
reg cor;                                                           // Fio auxiliar para manipular o valor do registrador color

always @(posedge clk_in) begin                                     // A cada pulso de clock
    if (clk_en) begin
      if(refreshBar) begin
          startDelay <= 1;                                         // Seta variável para iniciar delay
          y_barraAux <= coordY;                                    // Armazena o novo Y para ser usado depois
      end
    end
    else begin
        if(startDelay) begin
            if(delay == 20'hFFFFF) begin                           // Verifica se o delay já chegou ao final
                if(!cor) begin                                     // Caso não esteja escrevendo na tela
                    startDelay <= 0;                               // Seta variável para finalizar delay
                    delay <= 0;
                    y_barra <= y_barraAux;                         // Atualiza valor de Y
                end
            end
            else delay <= delay + 1'b1;
        end
    end
end


always @(posedge clk_in) begin                                     // A cada pulso de clock
    color <= cor;                                                  // O valor do fio 'cor' é armazenado no registrador 'color'
end

always @(*) begin
    if(o_active) begin                                             // Caso esteja na área ativa
        if(o_x >= x_barra && o_x <= (x_barra+tamBarraX)) begin     // Verifica se está na posição x da barra para desenhá-la
            if(o_y >= y_barra && o_y <= (y_barra+tamBarraY))       // Verifica se está na posição y da barra para desenhá-la
                cor = 1;
            else cor = 0;
        end
        else cor = 0;
    end
end
endmodule
