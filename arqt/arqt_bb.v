
module arqt (
	buttons_export,
	clk_clk,
	lcd_display_readdata,
	lcd_enable_writeresponsevalid_n,
	lcd_rs_writeresponsevalid_n,
	lcd_rw_writeresponsevalid_n,
	leds_export,
	reset_reset_n,
	vga_o_y_readdata,
	vga_o_x_readdata,
	vga_o_animate_writeresponsevalid_n,
	vga_o_screenend_writeresponsevalid_n,
	vga_o_active_writeresponsevalid_n,
	vga_o_vs_writeresponsevalid_n,
	vga_o_hs_writeresponsevalid_n,
	vga_o_blanking_writeresponsevalid_n);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	output	[7:0]	lcd_display_readdata;
	output		lcd_enable_writeresponsevalid_n;
	output		lcd_rs_writeresponsevalid_n;
	output		lcd_rw_writeresponsevalid_n;
	output	[3:0]	leds_export;
	input		reset_reset_n;
	output	[9:0]	vga_o_y_readdata;
	output	[10:0]	vga_o_x_readdata;
	output		vga_o_animate_writeresponsevalid_n;
	output		vga_o_screenend_writeresponsevalid_n;
	output		vga_o_active_writeresponsevalid_n;
	output		vga_o_vs_writeresponsevalid_n;
	output		vga_o_hs_writeresponsevalid_n;
	output		vga_o_blanking_writeresponsevalid_n;
endmodule
