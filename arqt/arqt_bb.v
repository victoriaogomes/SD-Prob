
module arqt (
	buttons_export,
	clk_clk,
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
	rw_writeresponsevalid_n,
	rs_writeresponsevalid_n,
	enablelcd_writeresponsevalid_n,
	display_readdata);	

	input	[3:0]	buttons_export;
	input		clk_clk;
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
	output		rw_writeresponsevalid_n;
	output		rs_writeresponsevalid_n;
	output		enablelcd_writeresponsevalid_n;
	output	[7:0]	display_readdata;
endmodule
