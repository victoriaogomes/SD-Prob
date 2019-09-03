module top2(
    input wire CLK,             // Clock da placa.
    input wire CLK_EN,          // Clock para habilitar a instrução customizada
    input wire [31:0] dataa,    // Entrada para envio de coordenadas de y da barra 1 e 2
    input  wire RST_BTN,        // Botão de reset
    output wire [31:0] result,  // Output que irá fornecer a pontuação do jogador
    output wire VGA_HS_O,       // Output do sinal horizontal
    output wire VGA_VS_O,       // Output do sinal vertical
    output reg VGA_R,           // Output red da VGA de 1-bit
    output reg VGA_G,           // Output green da VGA de 1-bit
    output reg VGA_B            // Output blue da VGA de 1-bit
    );

    wire [9:0] x;               // Posição x atual do pixel: 10-bit value: 0-1023
    wire [8:0] y;               // Posição x atual do pixel:  9-bit value: 0-511
    wire activeArea;            // Armazena se um pixel está sendo desenhado (área ativa)
    wire selectColor1;          // Fio para informar se a cor do desenho da barra 1 será azul ou roxo
    wire selectColor2;          // Fio para informar se a cor do desenho da barra 2 será azul ou roxo
    wire selectColor3;          // Fio para informar se a cor do desenho da bolinha será azul ou roxo
    reg refreshBar1;
    reg refreshBar2;
    reg [9:0] yBar1;            // Registrador para armazenar o valor da posição y da barra 1
    reg [9:0] yBar2;            // Registrador para armazenar o valor da posição y da barra 2

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

    printBar printBar_1 (
      .clk_in(pix_stb),         // Clock da FPGA
      .clk_en(CLK_EN),          // Clock Enable
      .i_rst(RST_BTN),          // Botão de reset
      .o_active(activeArea),    // Indicador de área ativa
      .o_x(x),                  // Posição x atual do pixel
      .o_y(y),                  // Posição y atual do pixel
      .coordY(yBar1),           // Nova posição y da barra 1
      .refreshBar(refreshBar1),
      .color(selectColor1)      // Saída para indicar a cor do que deve ser escrito
    );

    printBar #(.x_barra(620)) printBar_2 (
      .clk_in(pix_stb),         // Clock da FPGA
      .clk_en(CLK_EN),          // Clock Enable
      .i_rst(RST_BTN),          // Botão de reset
      .o_active(activeArea),    // Indicador de área ativa
      .o_x(x),                  // Posição x atual do pixel
      .o_y(y),                  // Posição y atual do pixel
      .coordY(yBar2),           // Nova posição do y da barra 2
      .refreshBar(refreshBar2),
      .color(selectColor2)      // Saída para indicar a cor do que deve ser escrito
    );

    printBallv2 sq_a_anim (
        .clk_in(pix_stb),         // Clock da FPGA
        .i_rst(RST_BTN),          // Botão de reset
        .o_active(activeArea),    // Indicador de área ativa
        .o_x(x),                  // Posição x atual do pixel
        .o_y(y),                  // Posição y atual do pixel
        .color(selectColor3)      // Saída para indicar a cor do que deve ser escrito
    );

    always @(posedge CLK_EN) begin
      if(dataa[10] == 0) begin
        yBar1 <= dataa[9:0];
        refreshBar1 <=1;
        refreshBar2 <=0;
      end
      else begin
        yBar2 <= dataa[9:0];
        refreshBar1 <=0;
        refreshBar2 <=1;
      end
    end


    always @(posedge pix_stb) begin
      if(activeArea == 1) begin
        if(selectColor2 == 1 || selectColor1 == 1 || selectColor3 == 1) begin
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