
module arqt (
	buttons_export,
	clk_clk,
	enableplacar_receiver_beginbursttransfer,
	lcd_display_readdata,
	lcd_enable_writeresponsevalid_n,
	lcd_rs_writeresponsevalid_n,
	lcd_rw_writeresponsevalid_n,
	placar_receiver_writebyteenable_n,
	reset_reset_n,
	resetfpga_beginbursttransfer,
	rs232_RXD,
	rs232_TXD,
	rs232_1_RXD,
	rs232_1_TXD,
	vga_b_writeresponsevalid_n,
	vga_g_writeresponsevalid_n,
	vga_hs_writeresponsevalid_n,
	vga_r_writeresponsevalid_n,
	vga_vs_writeresponsevalid_n,
	placar_sender_readdata,
	enableplacar_sender_writeresponsevalid_n);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	input		enableplacar_receiver_beginbursttransfer;
	output	[7:0]	lcd_display_readdata;
	output		lcd_enable_writeresponsevalid_n;
	output		lcd_rs_writeresponsevalid_n;
	output		lcd_rw_writeresponsevalid_n;
	input	[31:0]	placar_receiver_writebyteenable_n;
	input		reset_reset_n;
	input		resetfpga_beginbursttransfer;
	input		rs232_RXD;
	output		rs232_TXD;
	input		rs232_1_RXD;
	output		rs232_1_TXD;
	output		vga_b_writeresponsevalid_n;
	output		vga_g_writeresponsevalid_n;
	output		vga_hs_writeresponsevalid_n;
	output		vga_r_writeresponsevalid_n;
	output		vga_vs_writeresponsevalid_n;
	output	[31:0]	placar_sender_readdata;
	output		enableplacar_sender_writeresponsevalid_n;
endmodule
