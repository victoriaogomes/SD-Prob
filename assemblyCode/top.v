module top(
    input wire CLK,             // Clock da placa.
    input wire RST_BTN,         // Botão de reset
    output wire VGA_HS_O,       // Output do sinal horizontal
    output wire VGA_VS_O,       // Output do sinal vertical
    output wire [3:0] VGA_R,    // Output red da VGA de 4-bit
    output wire [3:0] VGA_G,    // Output green da VGA de 4-bit
    output wire [3:0] VGA_B     // Output blue da VGA de 4-bit
    );

    wire rst = ~RST_BTN;    // Assumindo que o reset esteja ativo em sinal baixo
    wire [9:0] x;  // Posição x atual do pixel: 10-bit value: 0-1023
    wire [8:0] y;  // Posição x atual do pixel:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_rst(rst),
        .o_hs(VGA_HS_O),
        .o_vs(VGA_VS_O),
        .o_x(x),
        .o_y(y)
    );

    // Escrevendo quadrados na VGA
    wire sq_a, sq_b, sq_c, sq_d;
    assign sq_a = ((x > 120) & (y >  40) & (x < 280) & (y < 200)) ? 1 : 0;
    assign sq_b = ((x > 200) & (y > 120) & (x < 360) & (y < 280)) ? 1 : 0;
    assign sq_c = ((x > 280) & (y > 200) & (x < 440) & (y < 360)) ? 1 : 0;
    assign sq_d = ((x > 360) & (y > 280) & (x < 520) & (y < 440)) ? 1 : 0;

    assign VGA_R[3] = sq_b;         // Este quadrado (B) é vermelho
    assign VGA_G[3] = sq_a | sq_d;  // Os quadrados A e D são verdes
    assign VGA_B[3] = sq_c;         // O quadrado C é azul
endmodule
