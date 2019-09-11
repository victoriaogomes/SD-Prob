`timescale 1ns / 100ps
module lcd(
	input [31:0] dado, 			 // Dados para escrever no LCDs
	input clk,
	input clk_en,
	input [31:0] placarToWrite,    // Placar a ser escrito para o jogador 1 e 2
	input writePlacar,      // Indica se deve atualizar o placar ou não
	output     rw,
	output reg rs,
	output reg en,
	output reg [7:0] display 	// Saída de dados para o LCD
);

	assign rw    = 1'b0;     	// Atribuindo o pino rw, sempre escrita
	reg    state = 1'b0;
	always @(posedge clk)
		 if((clk_en == 1 && dado != 0) || (writePlacar == 1)) begin
			 en    <= 1'b0;
			 state <= 1'b1;
		 end else if(state) begin
			 en    <= 1'b1;
			 if(writePlacar == 1) begin
			 		rs <= placarToWrite [24];
					display[7:0] <= placarToWrite[7:0];
					#53
					display[7:0] <= placarWrite[15:8];
					#53
					display[7:0] <= placarToWrite[23:16];
			 end
			 else begin
			 		rs    <= dado[8];
			 		display[7:0] <= dado[7:0];
			 end
			 state <= 1'b0;
		 end
endmodule
