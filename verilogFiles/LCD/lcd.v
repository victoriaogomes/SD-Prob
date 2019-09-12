module lcd(

	input [31:0] dataa, // Dados de instru��o ou a��o
	input [31:0] datab, // Dados para escrever no LCDs
	input clk,
	input clk_en,
	input [23:0] placar,					// Dados para escrever no LCD
	input enablePlacar,      			// Indica se deve atualizar o placar ou não
	output     rw,
	output reg rs,
	output reg en,
	output reg [7:0] display // Sa�da de dados para o LCD
);

	reg startWrite = 0;
	assign rw    = 1'b0;         // Atribuindo o pino rw, sempre escrita
	reg    state = 1'b0;
	always @(posedge clk) begin
		 if(clk_en || enablePlacar) begin
		 	 if(enablePlacar) startWrite <= 1;
			 en    <= 1'b0;
			 state <= 1'b1;
		 end
		 else if(state) begin
		 	 en    <= 1'b1;
			 state <= 1'b0;
		 	 if(startWrite) begin
				rs <= 1;
				display[7:0] <= placar[7:0];
				startWrite <= 0;
			 end
			 else begin
			 	rs    <= dataa[0];
			 	display[7:0] <= datab[7:0];
			 end
		 end
	end
endmodule
