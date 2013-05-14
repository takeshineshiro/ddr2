library verilog;
use verilog.vl_types.all;
entity fifo_control is
    generic(
        DATA_WIDTH      : integer := 64;
        WRITE_BURST     : integer := 8;
        COL_WIDTH       : integer := 10;
        ROW_WIDTH       : integer := 14;
        BANK_WIDTH      : integer := 2
    );
    port(
        sys_clk         : in     vl_logic;
        reset           : in     vl_logic;
        data_in_vd      : in     vl_logic;
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
        wr_fifo_in      : in     vl_logic_vector;
        wr_fifo_vd      : in     vl_logic;
        wr_fifo_rd      : out    vl_logic;
        app_af_wren     : out    vl_logic;
        app_af_addr     : out    vl_logic_vector(30 downto 0);
        app_af_cmd      : out    vl_logic_vector(2 downto 0);
        app_wdf_data    : out    vl_logic_vector;
        app_wdf_wren    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of WRITE_BURST : constant is 1;
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BANK_WIDTH : constant is 1;
end fifo_control;
