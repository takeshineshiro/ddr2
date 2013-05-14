library verilog;
use verilog.vl_types.all;
entity ddr2_usr_top is
    generic(
        BANK_WIDTH      : integer := 2;
        CS_BITS         : integer := 0;
        COL_WIDTH       : integer := 10;
        DQ_WIDTH        : integer := 72;
        DQ_PER_DQS      : integer := 8;
        APPDATA_WIDTH   : integer := 144;
        ECC_ENABLE      : integer := 0;
        DQS_WIDTH       : integer := 9;
        ROW_WIDTH       : integer := 14
    );
    port(
        clk0            : in     vl_logic;
        clk90           : in     vl_logic;
        rst0            : in     vl_logic;
        rd_data_in_rise : in     vl_logic_vector;
        rd_data_in_fall : in     vl_logic_vector;
        phy_calib_rden  : in     vl_logic_vector;
        phy_calib_rden_sel: in     vl_logic_vector;
        rd_data_valid   : out    vl_logic;
        rd_data_fifo_out: out    vl_logic_vector;
        app_af_cmd      : in     vl_logic_vector(2 downto 0);
        app_af_addr     : in     vl_logic_vector(30 downto 0);
        app_af_wren     : in     vl_logic;
        ctrl_af_rden    : in     vl_logic;
        af_cmd          : out    vl_logic_vector(2 downto 0);
        af_addr         : out    vl_logic_vector(30 downto 0);
        af_empty        : out    vl_logic;
        app_af_afull    : out    vl_logic;
        rd_ecc_error    : out    vl_logic_vector(1 downto 0);
        app_wdf_wren    : in     vl_logic;
        app_wdf_data    : in     vl_logic_vector;
        app_wdf_mask_data: in     vl_logic_vector;
        wdf_rden        : in     vl_logic;
        app_wdf_afull   : out    vl_logic;
        wdf_data        : out    vl_logic_vector;
        wdf_mask_data   : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BANK_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CS_BITS : constant is 1;
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DQ_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DQ_PER_DQS : constant is 1;
    attribute mti_svvh_generic_type of APPDATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ECC_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of DQS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
end ddr2_usr_top;
