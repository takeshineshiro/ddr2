library verilog;
use verilog.vl_types.all;
entity cmd_gen is
    generic(
        DATA_WIDTH      : integer := 64;
        WRITE_BURST     : integer := 8
    );
    port(
        sys_clk         : in     vl_logic;
        reset           : in     vl_logic;
        din_vd          : in     vl_logic;
        rd_data_count   : in     vl_logic_vector(9 downto 0);
        wr_data_count   : in     vl_logic_vector(9 downto 0);
        almost_full     : in     vl_logic;
        almost_empty    : in     vl_logic;
        prog_full       : in     vl_logic;
        prog_empty      : in     vl_logic;
        phy_init_done   : in     vl_logic;
        app_wdf_afull   : in     vl_logic;
        app_af_afull    : in     vl_logic;
        rd_en           : in     vl_logic;
        addr_confilct   : in     vl_logic;
        wr_fifo_rd      : out    vl_logic;
        wr_addr_en      : out    vl_logic;
        rd_addr_en      : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of WRITE_BURST : constant is 1;
end cmd_gen;
