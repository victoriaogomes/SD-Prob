	arqt u0 (
		.buttons_export                       (<connected-to-buttons_export>),                       //         buttons.export
		.clk_clk                              (<connected-to-clk_clk>),                              //             clk.clk
		.lcd_display_readdata                 (<connected-to-lcd_display_readdata>),                 //     lcd_display.readdata
		.lcd_enable_writeresponsevalid_n      (<connected-to-lcd_enable_writeresponsevalid_n>),      //      lcd_enable.writeresponsevalid_n
		.lcd_rs_writeresponsevalid_n          (<connected-to-lcd_rs_writeresponsevalid_n>),          //          lcd_rs.writeresponsevalid_n
		.lcd_rw_writeresponsevalid_n          (<connected-to-lcd_rw_writeresponsevalid_n>),          //          lcd_rw.writeresponsevalid_n
		.leds_export                          (<connected-to-leds_export>),                          //            leds.export
		.reset_reset_n                        (<connected-to-reset_reset_n>),                        //           reset.reset_n
		.vga_o_y_readdata                     (<connected-to-vga_o_y_readdata>),                     //         vga_o_y.readdata
		.vga_o_x_readdata                     (<connected-to-vga_o_x_readdata>),                     //         vga_o_x.readdata
		.vga_o_animate_writeresponsevalid_n   (<connected-to-vga_o_animate_writeresponsevalid_n>),   //   vga_o_animate.writeresponsevalid_n
		.vga_o_screenend_writeresponsevalid_n (<connected-to-vga_o_screenend_writeresponsevalid_n>), // vga_o_screenend.writeresponsevalid_n
		.vga_o_active_writeresponsevalid_n    (<connected-to-vga_o_active_writeresponsevalid_n>),    //    vga_o_active.writeresponsevalid_n
		.vga_o_vs_writeresponsevalid_n        (<connected-to-vga_o_vs_writeresponsevalid_n>),        //        vga_o_vs.writeresponsevalid_n
		.vga_o_hs_writeresponsevalid_n        (<connected-to-vga_o_hs_writeresponsevalid_n>),        //        vga_o_hs.writeresponsevalid_n
		.vga_o_blanking_writeresponsevalid_n  (<connected-to-vga_o_blanking_writeresponsevalid_n>)   //  vga_o_blanking.writeresponsevalid_n
	);

