module top2(
    input wire CLK,               // Clock da placa
    input wire CLK_EN,            // Clock para habilitar a instrução customizada
    input wire [31:0] dataa,      // Entrada para envio de coordenadas de y da barra 1 e 2
    input wire [31:0] datab,      // Entrada para ser utilizada pelo LCD
    input  wire resentinho,       // Botão de reset
    output wire [31:0] result,    // Output que irá fornecer a pontuação do jogador
    output wire VGA_HS_O,         // Output do sinal horizontal
    output wire VGA_VS_O,         // Output do sinal vertical
    output reg VGA_R,             // Output red da VGA de 1-bit
    output reg VGA_G,             // Output green da VGA de 1-bit
    output reg VGA_B,             // Output blue da VGA de 1-bit
    output wire [23:0] placar,     // Placar a ser escrito na LCD
    output wire enablePlacar       // Informa se o placar deve ser escrito ou não
    );

    wire [9:0] x;                 // Posição x atual do pixel: 10-bit value: 0-1023
    wire RST_BTN;
    wire [8:0] y;                 // Posição x atual do pixel:  9-bit value: 0-511
    wire activeArea;              // Armazena se um pixel está sendo desenhado (área ativa)
    wire [3:0] selectColors;      // Fios para informar se a cor do desenho da barra 1/2, da bolinha ou do menu será azul ou roxo
    reg refreshBar1;              // Informa se a barra 1 será atualizada ou não
    reg refreshBar2;              // Informa se a barra 2 será atualizada ou não
    wire [8:0] barra1Atual;       // Informa a posição atual da barra 1 no eixo y
    wire [8:0] barra2Atual;       // Informa a posição atual da barra 2 no eixo y
    reg enableGame = 0;           // Indica se o jogo está rolando ou não
    assign RST_BTN = ~resentinho;

    reg [8:0] yBar1;              // Registrador para armazenar o novo valor da posição y da barra 1
    reg [8:0] yBar2;              // Registrador para armazenar o novo valor da posição y da barra 2

    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK)
        // Colocando a frequência para 50MHz: (2^16)/2 = 0x8000
        {pix_stb, cnt} <= cnt + 16'h8000;

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(RST_BTN),
        .o_hs(VGA_HS_O),
        .o_vs(VGA_VS_O),
        .o_active(activeArea),
        .o_x(x),
        .o_y(y)
    );

    printMenu startGame (
        .clk_in(pix_stb),         // Clock base (vindo da placa)
        .clk_en(CLK_EN),          // Clock para habilitar a instrução customizada
        .i_rst(RST_BTN),          // Reset: recomeça a imprimir o quadro
        .o_active(activeArea),    // Alto quando um pixel está sendo desenhado
        .o_x(x),                  // Posição x atual do pixel
        .o_y(y),                  // Posição y atual do pixel
        .enablePong(enableGame),  // Indica se o jogo está rodando ou não
        .color(selectColors[0])   // Indica se está imprimindo ou não (1 imprimindo, 0 não)
    );


    printBar printBar_1 (
      .clk_in(pix_stb),           // Clock da FPGA
      .clk_en(CLK_EN),            // Clock Enable
      .i_rst(RST_BTN),            // Botão de reset
      .o_active(activeArea),      // Indicador de área ativa
      .o_x(x),                    // Posição x atual do pixel
      .o_y(y),                    // Posição y atual do pixel
      .coordY(yBar1),             // Nova posição y da barra 1
      .refreshBar(refreshBar1),   // Indica se a posição da barra deve ser atualizada ou não
      .enablePong(enableGame),
      .y_Atual(barra1Atual),      // Indica a posição atual da barra 1 no eixo y
      .color(selectColors[1])     // Saída para indicar a cor do que deve ser escrito
    );

    printBar #(.x_barra(620)) printBar_2 (
      .clk_in(pix_stb),           // Clock da FPGA
      .clk_en(CLK_EN),            // Clock Enable
      .i_rst(RST_BTN),            // Botão de reset
      .o_active(activeArea),      // Indicador de área ativa
      .o_x(x),                    // Posição x atual do pixel
      .o_y(y),                    // Posição y atual do pixel
      .coordY(yBar2),             // Nova posição do y da barra 2
      .refreshBar(refreshBar2),   // Indica se a posição da barra deve ser atualizada ou não
      .enablePong(enableGame),
      .y_Atual(barra2Atual),      // Indica a posição atual da barra 2 no eixo y
      .color(selectColors[2])     // Saída para indicar a cor do que deve ser escrito
    );

    printBall ball (
        .clk_in(pix_stb),         // Clock da FPGA
        .i_rst(RST_BTN),          // Botão de reset
        .o_active(activeArea),    // Indicador de área ativa
        .o_x(x),                  // Posição x atual do pixel
        .o_y(y),                  // Posição y atual do pixel
        .placarWrite(placar),     // Placar a ser escrito na LCD
        .enPlacar(enablePlacar),  // Informa se o placar deve ser printado ou não
        .pos_yBarra1(barra1Atual),// Posição y atual da barra 1
        .pos_yBarra2(barra2Atual),// Posição y atual da barra 2
        .enablePong(enableGame),  // Indica se o jogo está habilitado ou não
        .pointPlayers(result),    // Pontuação do jogador 1 e 2
        .color(selectColors[3])   // Saída para indicar a cor do que deve ser escrito
    );

    always @ (posedge CLK) begin
      if (RST_BTN)
        enableGame <= 1;
      if(result[1:0] == 3 || result[3:2] == 3)
        enableGame <= 0;
    end

    always @(posedge CLK_EN) begin
      if(enableGame == 1) begin
        if(dataa[9] == 0) begin
          yBar1 <= dataa[8:0];
          refreshBar1 <= 1;
          refreshBar2 <= 0;
        end
        else begin
          yBar2 <= dataa[8:0];
          refreshBar1 <= 0;
          refreshBar2 <= 1;
        end
      end
    end


    always @(posedge pix_stb) begin
      if(activeArea == 1) begin
        if(selectColors[0] == 1 || selectColors[1] == 1 || selectColors[2] == 1 || selectColors[3] == 1) begin
          VGA_R <= 1;
          VGA_G <= 0;
          VGA_B <= 1;
        end
        else begin
          VGA_R <= 0;
          VGA_G <= 0;
          VGA_B <= 1;
        end
      end
      else begin
        VGA_R <= 0;
        VGA_G <= 0;
        VGA_B <= 0;
      end
    end
endmodule
