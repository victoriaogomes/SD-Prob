
module arqt (
	buttons_export,
	clk_clk,
	reset_reset_n,
	vga_b_writeresponsevalid_n,
	vga_g_writeresponsevalid_n,
	vga_r_writeresponsevalid_n,
	vga_vs_writeresponsevalid_n,
	vga_hs_writeresponsevalid_n,
	display_readdata,
	en_writeresponsevalid_n,
	rs_writeresponsevalid_n,
	rw_writeresponsevalid_n);	

	input	[3:0]	buttons_export;
	input		clk_clk;
	input		reset_reset_n;
	output		vga_b_writeresponsevalid_n;
	output		vga_g_writeresponsevalid_n;
	output		vga_r_writeresponsevalid_n;
	output		vga_vs_writeresponsevalid_n;
	output		vga_hs_writeresponsevalid_n;
	output	[7:0]	display_readdata;
	output		en_writeresponsevalid_n;
	output		rs_writeresponsevalid_n;
	output		rw_writeresponsevalid_n;
endmodule
