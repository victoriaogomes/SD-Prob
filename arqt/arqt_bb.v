
module arqt (
	clk_clk,
	reset_reset_n,
	resetfpga_beginbursttransfer,
	rs232_RXD,
	rs232_TXD,
	rs232_1_RXD,
	rs232_1_TXD,
	rs232_2_RXD,
	rs232_2_TXD,
	vga_b_writeresponsevalid_n,
	vga_g_writeresponsevalid_n,
	vga_hs_writeresponsevalid_n,
	vga_r_writeresponsevalid_n,
	vga_vs_writeresponsevalid_n);	

	input		clk_clk;
	input		reset_reset_n;
	input		resetfpga_beginbursttransfer;
	input		rs232_RXD;
	output		rs232_TXD;
	input		rs232_1_RXD;
	output		rs232_1_TXD;
	input		rs232_2_RXD;
	output		rs232_2_TXD;
	output		vga_b_writeresponsevalid_n;
	output		vga_g_writeresponsevalid_n;
	output		vga_hs_writeresponsevalid_n;
	output		vga_r_writeresponsevalid_n;
	output		vga_vs_writeresponsevalid_n;
endmodule
