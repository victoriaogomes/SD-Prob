	component arqt is
		port (
			buttons_export                           : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			clk_clk                                  : in  std_logic                     := 'X';             -- clk
			enableplacar_receiver_beginbursttransfer : in  std_logic                     := 'X';             -- beginbursttransfer
			lcd_display_readdata                     : out std_logic_vector(7 downto 0);                     -- readdata
			lcd_enable_writeresponsevalid_n          : out std_logic;                                        -- writeresponsevalid_n
			lcd_rs_writeresponsevalid_n              : out std_logic;                                        -- writeresponsevalid_n
			lcd_rw_writeresponsevalid_n              : out std_logic;                                        -- writeresponsevalid_n
			placar_receiver_writebyteenable_n        : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writebyteenable_n
			reset_reset_n                            : in  std_logic                     := 'X';             -- reset_n
			resetfpga_beginbursttransfer             : in  std_logic                     := 'X';             -- beginbursttransfer
			rs232_RXD                                : in  std_logic                     := 'X';             -- RXD
			rs232_TXD                                : out std_logic;                                        -- TXD
			rs232_1_RXD                              : in  std_logic                     := 'X';             -- RXD
			rs232_1_TXD                              : out std_logic;                                        -- TXD
			vga_b_writeresponsevalid_n               : out std_logic;                                        -- writeresponsevalid_n
			vga_g_writeresponsevalid_n               : out std_logic;                                        -- writeresponsevalid_n
			vga_hs_writeresponsevalid_n              : out std_logic;                                        -- writeresponsevalid_n
			vga_r_writeresponsevalid_n               : out std_logic;                                        -- writeresponsevalid_n
			vga_vs_writeresponsevalid_n              : out std_logic;                                        -- writeresponsevalid_n
			placar_sender_readdata                   : out std_logic_vector(31 downto 0);                    -- readdata
			enableplacar_sender_writeresponsevalid_n : out std_logic                                         -- writeresponsevalid_n
		);
	end component arqt;

	u0 : component arqt
		port map (
			buttons_export                           => CONNECTED_TO_buttons_export,                           --               buttons.export
			clk_clk                                  => CONNECTED_TO_clk_clk,                                  --                   clk.clk
			enableplacar_receiver_beginbursttransfer => CONNECTED_TO_enableplacar_receiver_beginbursttransfer, -- enableplacar_receiver.beginbursttransfer
			lcd_display_readdata                     => CONNECTED_TO_lcd_display_readdata,                     --           lcd_display.readdata
			lcd_enable_writeresponsevalid_n          => CONNECTED_TO_lcd_enable_writeresponsevalid_n,          --            lcd_enable.writeresponsevalid_n
			lcd_rs_writeresponsevalid_n              => CONNECTED_TO_lcd_rs_writeresponsevalid_n,              --                lcd_rs.writeresponsevalid_n
			lcd_rw_writeresponsevalid_n              => CONNECTED_TO_lcd_rw_writeresponsevalid_n,              --                lcd_rw.writeresponsevalid_n
			placar_receiver_writebyteenable_n        => CONNECTED_TO_placar_receiver_writebyteenable_n,        --       placar_receiver.writebyteenable_n
			reset_reset_n                            => CONNECTED_TO_reset_reset_n,                            --                 reset.reset_n
			resetfpga_beginbursttransfer             => CONNECTED_TO_resetfpga_beginbursttransfer,             --             resetfpga.beginbursttransfer
			rs232_RXD                                => CONNECTED_TO_rs232_RXD,                                --                 rs232.RXD
			rs232_TXD                                => CONNECTED_TO_rs232_TXD,                                --                      .TXD
			rs232_1_RXD                              => CONNECTED_TO_rs232_1_RXD,                              --               rs232_1.RXD
			rs232_1_TXD                              => CONNECTED_TO_rs232_1_TXD,                              --                      .TXD
			vga_b_writeresponsevalid_n               => CONNECTED_TO_vga_b_writeresponsevalid_n,               --                 vga_b.writeresponsevalid_n
			vga_g_writeresponsevalid_n               => CONNECTED_TO_vga_g_writeresponsevalid_n,               --                 vga_g.writeresponsevalid_n
			vga_hs_writeresponsevalid_n              => CONNECTED_TO_vga_hs_writeresponsevalid_n,              --                vga_hs.writeresponsevalid_n
			vga_r_writeresponsevalid_n               => CONNECTED_TO_vga_r_writeresponsevalid_n,               --                 vga_r.writeresponsevalid_n
			vga_vs_writeresponsevalid_n              => CONNECTED_TO_vga_vs_writeresponsevalid_n,              --                vga_vs.writeresponsevalid_n
			placar_sender_readdata                   => CONNECTED_TO_placar_sender_readdata,                   --         placar_sender.readdata
			enableplacar_sender_writeresponsevalid_n => CONNECTED_TO_enableplacar_sender_writeresponsevalid_n  --   enableplacar_sender.writeresponsevalid_n
		);

