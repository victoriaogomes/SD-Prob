	arqt u0 (
		.clk_clk                      (<connected-to-clk_clk>),                      //       clk.clk
		.reset_reset_n                (<connected-to-reset_reset_n>),                //     reset.reset_n
		.resetfpga_beginbursttransfer (<connected-to-resetfpga_beginbursttransfer>), // resetfpga.beginbursttransfer
		.rs232_RXD                    (<connected-to-rs232_RXD>),                    //     rs232.RXD
		.rs232_TXD                    (<connected-to-rs232_TXD>),                    //          .TXD
		.rs232_1_RXD                  (<connected-to-rs232_1_RXD>),                  //   rs232_1.RXD
		.rs232_1_TXD                  (<connected-to-rs232_1_TXD>),                  //          .TXD
		.rs232_2_RXD                  (<connected-to-rs232_2_RXD>),                  //   rs232_2.RXD
		.rs232_2_TXD                  (<connected-to-rs232_2_TXD>),                  //          .TXD
		.vga_b_writeresponsevalid_n   (<connected-to-vga_b_writeresponsevalid_n>),   //     vga_b.writeresponsevalid_n
		.vga_g_writeresponsevalid_n   (<connected-to-vga_g_writeresponsevalid_n>),   //     vga_g.writeresponsevalid_n
		.vga_hs_writeresponsevalid_n  (<connected-to-vga_hs_writeresponsevalid_n>),  //    vga_hs.writeresponsevalid_n
		.vga_r_writeresponsevalid_n   (<connected-to-vga_r_writeresponsevalid_n>),   //     vga_r.writeresponsevalid_n
		.vga_vs_writeresponsevalid_n  (<connected-to-vga_vs_writeresponsevalid_n>)   //    vga_vs.writeresponsevalid_n
	);

