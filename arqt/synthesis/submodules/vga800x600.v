// Driver VGA 800x600 50Hz
module vga800x600(
    input wire i_clk,           // Clock base (vindo da placa)
    input wire i_rst,           // Reset: recomeça a imprimir o quadro
    output wire o_hs,           // Sincronização horizontal
    output wire o_vs,           // Sincronização vertical
    output wire o_blanking,     // Alto no período de piscar
    output wire o_active,       // Alto quando um pixel está sendo desenhado
    output wire o_screenend,    // Alto quando falta um pixel para o fim da tela
    output wire o_animate,      // Alto no penúltimo pixel na zona ativa
    output wire [10:0] o_x,     // Posição x atual do pixel
    output wire  [9:0] o_y      // Posição y atual do pixel
    );

    // Tempos de escrita na VGA
    localparam HS_STA = 56;            // Início do sinal de HSync horizontal
    localparam HS_END = 56 + 120;      // Espero terminar o sinal de HSync
    localparam HA_STA = 56 + 120 + 64; // Começo dos pixeis ativos horizontalmente
    localparam VS_STA = 600 + 37;      // Início do sinal vertical
    localparam VS_END = 600 + 37 + 6;  // Final do sinal vertical
    localparam VA_END = 600;           // Final dos pixeis ativos verticalmente
    localparam LINE   = 1040;          // Linha completa (soma tudo)
    localparam SCREEN = 666;           // O número oficial do PBL

    reg [10:0] h_count; // Posição da linha
    reg  [9:0] v_count; // Posição da tela

    // Gero os sinais sync (Alto na zona ativa: 800x600)
    assign o_hs = ((h_count >= HS_STA) & (h_count < HS_END));
    assign o_vs = ((v_count >= VS_STA) & (v_count < VS_END));

    // Mantenho x e y travados dentro dos pixeis ativos
    assign o_x = (h_count < HA_STA) ? {11{1'b0}} : (h_count - HA_STA);
    assign o_y = (v_count >= VA_END) ? (VA_END - 1'd1) : (v_count);

    // Blanking: alto no período de piscar
    assign o_blanking = ((h_count < HA_STA) | (v_count > VA_END - 1));

    // Active: alto se algum pixel estiver sendo desenhado
    assign o_active = ~((h_count < HA_STA) | (v_count > VA_END - 1));

    // Screenend: alto quando falta um pixel para o fim da tela
    assign o_screenend = ((v_count == SCREEN - 1) & (h_count == LINE));

    // Animate: alto quando falta um pixel para o fim da linha de pixeis ativos
    assign o_animate = ((v_count == VA_END - 1) & (h_count == LINE));

    always @ (posedge i_clk)
    begin
        if (i_rst)  // Se o reset for acionado, recomeça a impressão
        begin
            h_count <= 0;
            v_count <= 0;
        end
        else //Senão, continuo normalmente
        begin
            if (h_count == LINE)  // Se for o final da linha
            begin
                h_count <= 0;//Zero meu contador
                v_count <= v_count + 1'b1;//Vou para a outra linha
            end
            else
                h_count <= h_count + 1'b1;//Senão, continuo nessa linha

            if (v_count == SCREEN)  // Se for o final da tela
            begin
                v_count <= 0; //Zero meu contador
            end
            else
              begin
              //Completando if e else para evitar erro.
              end
        end
    end
endmodule
