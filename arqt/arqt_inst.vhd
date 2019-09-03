	component arqt is
		port (
			buttons_export              : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			clk_clk                     : in  std_logic                    := 'X';             -- clk
			reset_reset_n               : in  std_logic                    := 'X';             -- reset_n
			vga_b_writeresponsevalid_n  : out std_logic;                                       -- writeresponsevalid_n
			vga_g_writeresponsevalid_n  : out std_logic;                                       -- writeresponsevalid_n
			vga_r_writeresponsevalid_n  : out std_logic;                                       -- writeresponsevalid_n
			vga_vs_writeresponsevalid_n : out std_logic;                                       -- writeresponsevalid_n
			vga_hs_writeresponsevalid_n : out std_logic;                                       -- writeresponsevalid_n
			display_readdata            : out std_logic_vector(7 downto 0);                    -- readdata
			en_writeresponsevalid_n     : out std_logic;                                       -- writeresponsevalid_n
			rs_writeresponsevalid_n     : out std_logic;                                       -- writeresponsevalid_n
			rw_writeresponsevalid_n     : out std_logic                                        -- writeresponsevalid_n
		);
	end component arqt;

	u0 : component arqt
		port map (
			buttons_export              => CONNECTED_TO_buttons_export,              -- buttons.export
			clk_clk                     => CONNECTED_TO_clk_clk,                     --     clk.clk
			reset_reset_n               => CONNECTED_TO_reset_reset_n,               --   reset.reset_n
			vga_b_writeresponsevalid_n  => CONNECTED_TO_vga_b_writeresponsevalid_n,  --   vga_b.writeresponsevalid_n
			vga_g_writeresponsevalid_n  => CONNECTED_TO_vga_g_writeresponsevalid_n,  --   vga_g.writeresponsevalid_n
			vga_r_writeresponsevalid_n  => CONNECTED_TO_vga_r_writeresponsevalid_n,  --   vga_r.writeresponsevalid_n
			vga_vs_writeresponsevalid_n => CONNECTED_TO_vga_vs_writeresponsevalid_n, --  vga_vs.writeresponsevalid_n
			vga_hs_writeresponsevalid_n => CONNECTED_TO_vga_hs_writeresponsevalid_n, --  vga_hs.writeresponsevalid_n
			display_readdata            => CONNECTED_TO_display_readdata,            -- display.readdata
			en_writeresponsevalid_n     => CONNECTED_TO_en_writeresponsevalid_n,     --      en.writeresponsevalid_n
			rs_writeresponsevalid_n     => CONNECTED_TO_rs_writeresponsevalid_n,     --      rs.writeresponsevalid_n
			rw_writeresponsevalid_n     => CONNECTED_TO_rw_writeresponsevalid_n      --      rw.writeresponsevalid_n
		);

