
module arqt (
	buttons_export,
	clk_clk,
	lcd_display_readdata,
	lcd_enable_writeresponsevalid_n,
	lcd_rs_writeresponsevalid_n,
	lcd_rw_writeresponsevalid_n,
	leds_export,
	reset_reset_n,
	vga_b_readdata,
	vga_g_readdata,
	vga_r_readdata,
	vga_vs_o_writeresponsevalid_n,
	vga_hs_o_writeresponsevalid_n);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[7:0]	lcd_display_readdata;
	output		lcd_enable_writeresponsevalid_n;
	output		lcd_rs_writeresponsevalid_n;
	output		lcd_rw_writeresponsevalid_n;
	output	[3:0]	leds_export;
	input		reset_reset_n;
	output	[3:0]	vga_b_readdata;
	output	[3:0]	vga_g_readdata;
	output	[3:0]	vga_r_readdata;
	output		vga_vs_o_writeresponsevalid_n;
	output		vga_hs_o_writeresponsevalid_n;
endmodule
