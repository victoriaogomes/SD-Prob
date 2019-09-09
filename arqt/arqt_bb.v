
module arqt (
	buttons_export,
	clk_clk,
	lcd_display_readdata,
	lcd_enable_writeresponsevalid_n,
	lcd_rs_writeresponsevalid_n,
	lcd_rw_writeresponsevalid_n,
	reset_reset_n,
	vga_b_writeresponsevalid_n,
	vga_g_writeresponsevalid_n,
	vga_hs_writeresponsevalid_n,
	vga_r_writeresponsevalid_n,
	vga_vs_writeresponsevalid_n,
	rs232_RXD,
	rs232_TXD);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[7:0]	lcd_display_readdata;
	output		lcd_enable_writeresponsevalid_n;
	output		lcd_rs_writeresponsevalid_n;
	output		lcd_rw_writeresponsevalid_n;
	input		reset_reset_n;
	output		vga_b_writeresponsevalid_n;
	output		vga_g_writeresponsevalid_n;
	output		vga_hs_writeresponsevalid_n;
	output		vga_r_writeresponsevalid_n;
	output		vga_vs_writeresponsevalid_n;
	input		rs232_RXD;
	output		rs232_TXD;
endmodule
