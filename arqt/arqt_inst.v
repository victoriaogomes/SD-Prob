	arqt u0 (
		.buttons_export              (<connected-to-buttons_export>),              // buttons.export
		.clk_clk                     (<connected-to-clk_clk>),                     //     clk.clk
		.reset_reset_n               (<connected-to-reset_reset_n>),               //   reset.reset_n
		.vga_b_writeresponsevalid_n  (<connected-to-vga_b_writeresponsevalid_n>),  //   vga_b.writeresponsevalid_n
		.vga_g_writeresponsevalid_n  (<connected-to-vga_g_writeresponsevalid_n>),  //   vga_g.writeresponsevalid_n
		.vga_r_writeresponsevalid_n  (<connected-to-vga_r_writeresponsevalid_n>),  //   vga_r.writeresponsevalid_n
		.vga_vs_writeresponsevalid_n (<connected-to-vga_vs_writeresponsevalid_n>), //  vga_vs.writeresponsevalid_n
		.vga_hs_writeresponsevalid_n (<connected-to-vga_hs_writeresponsevalid_n>), //  vga_hs.writeresponsevalid_n
		.display_readdata            (<connected-to-display_readdata>),            // display.readdata
		.en_writeresponsevalid_n     (<connected-to-en_writeresponsevalid_n>),     //      en.writeresponsevalid_n
		.rs_writeresponsevalid_n     (<connected-to-rs_writeresponsevalid_n>),     //      rs.writeresponsevalid_n
		.rw_writeresponsevalid_n     (<connected-to-rw_writeresponsevalid_n>)      //      rw.writeresponsevalid_n
	);

