	component arqt is
		port (
			clk_clk                      : in  std_logic := 'X'; -- clk
			reset_reset_n                : in  std_logic := 'X'; -- reset_n
			resetfpga_beginbursttransfer : in  std_logic := 'X'; -- beginbursttransfer
			rs232_RXD                    : in  std_logic := 'X'; -- RXD
			rs232_TXD                    : out std_logic;        -- TXD
			rs232_1_RXD                  : in  std_logic := 'X'; -- RXD
			rs232_1_TXD                  : out std_logic;        -- TXD
			rs232_2_RXD                  : in  std_logic := 'X'; -- RXD
			rs232_2_TXD                  : out std_logic;        -- TXD
			vga_b_writeresponsevalid_n   : out std_logic;        -- writeresponsevalid_n
			vga_g_writeresponsevalid_n   : out std_logic;        -- writeresponsevalid_n
			vga_hs_writeresponsevalid_n  : out std_logic;        -- writeresponsevalid_n
			vga_r_writeresponsevalid_n   : out std_logic;        -- writeresponsevalid_n
			vga_vs_writeresponsevalid_n  : out std_logic         -- writeresponsevalid_n
		);
	end component arqt;

	u0 : component arqt
		port map (
			clk_clk                      => CONNECTED_TO_clk_clk,                      --       clk.clk
			reset_reset_n                => CONNECTED_TO_reset_reset_n,                --     reset.reset_n
			resetfpga_beginbursttransfer => CONNECTED_TO_resetfpga_beginbursttransfer, -- resetfpga.beginbursttransfer
			rs232_RXD                    => CONNECTED_TO_rs232_RXD,                    --     rs232.RXD
			rs232_TXD                    => CONNECTED_TO_rs232_TXD,                    --          .TXD
			rs232_1_RXD                  => CONNECTED_TO_rs232_1_RXD,                  --   rs232_1.RXD
			rs232_1_TXD                  => CONNECTED_TO_rs232_1_TXD,                  --          .TXD
			rs232_2_RXD                  => CONNECTED_TO_rs232_2_RXD,                  --   rs232_2.RXD
			rs232_2_TXD                  => CONNECTED_TO_rs232_2_TXD,                  --          .TXD
			vga_b_writeresponsevalid_n   => CONNECTED_TO_vga_b_writeresponsevalid_n,   --     vga_b.writeresponsevalid_n
			vga_g_writeresponsevalid_n   => CONNECTED_TO_vga_g_writeresponsevalid_n,   --     vga_g.writeresponsevalid_n
			vga_hs_writeresponsevalid_n  => CONNECTED_TO_vga_hs_writeresponsevalid_n,  --    vga_hs.writeresponsevalid_n
			vga_r_writeresponsevalid_n   => CONNECTED_TO_vga_r_writeresponsevalid_n,   --     vga_r.writeresponsevalid_n
			vga_vs_writeresponsevalid_n  => CONNECTED_TO_vga_vs_writeresponsevalid_n   --    vga_vs.writeresponsevalid_n
		);

