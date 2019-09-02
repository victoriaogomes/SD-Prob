	arqt u0 (
		.buttons_export                  (<connected-to-buttons_export>),                  //     buttons.export
		.clk_clk                         (<connected-to-clk_clk>),                         //         clk.clk
		.lcd_display_readdata            (<connected-to-lcd_display_readdata>),            // lcd_display.readdata
		.lcd_enable_writeresponsevalid_n (<connected-to-lcd_enable_writeresponsevalid_n>), //  lcd_enable.writeresponsevalid_n
		.lcd_rs_writeresponsevalid_n     (<connected-to-lcd_rs_writeresponsevalid_n>),     //      lcd_rs.writeresponsevalid_n
		.lcd_rw_writeresponsevalid_n     (<connected-to-lcd_rw_writeresponsevalid_n>),     //      lcd_rw.writeresponsevalid_n
		.reset_reset_n                   (<connected-to-reset_reset_n>),                   //       reset.reset_n
		.vga_b_readdata                  (<connected-to-vga_b_readdata>),                  //       vga_b.readdata
		.vga_g_readdata                  (<connected-to-vga_g_readdata>),                  //       vga_g.readdata
		.vga_hs_o_writeresponsevalid_n   (<connected-to-vga_hs_o_writeresponsevalid_n>),   //    vga_hs_o.writeresponsevalid_n
		.vga_r_readdata                  (<connected-to-vga_r_readdata>),                  //       vga_r.readdata
		.vga_vs_o_writeresponsevalid_n   (<connected-to-vga_vs_o_writeresponsevalid_n>)    //    vga_vs_o.writeresponsevalid_n
	);

