library verilog;
use verilog.vl_types.all;
entity ddr2_phy_write is
    generic(
        DQ_WIDTH        : integer := 72;
        CS_NUM          : integer := 1;
        ADDITIVE_LAT    : integer := 0;
        CAS_LAT         : integer := 5;
        ECC_ENABLE      : integer := 0;
        ODT_TYPE        : integer := 1;
        REG_ENABLE      : integer := 1;
        DDR_TYPE        : integer := 1
    );
    port(
        clk0            : in     vl_logic;
        clk90           : in     vl_logic;
        rst90           : in     vl_logic;
        wdf_data        : in     vl_logic_vector;
        wdf_mask_data   : in     vl_logic_vector;
        ctrl_wren       : in     vl_logic;
        phy_init_wren   : in     vl_logic;
        phy_init_data_sel: in     vl_logic;
        dm_ce           : out    vl_logic;
        dq_oe_n         : out    vl_logic_vector(1 downto 0);
        dqs_oe_n        : out    vl_logic;
        dqs_rst_n       : out    vl_logic;
        wdf_rden        : out    vl_logic;
        odt             : out    vl_logic_vector;
        wr_data_rise    : out    vl_logic_vector;
        wr_data_fall    : out    vl_logic_vector;
        mask_data_rise  : out    vl_logic_vector;
        mask_data_fall  : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DQ_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CS_NUM : constant is 1;
    attribute mti_svvh_generic_type of ADDITIVE_LAT : constant is 1;
    attribute mti_svvh_generic_type of CAS_LAT : constant is 1;
    attribute mti_svvh_generic_type of ECC_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of ODT_TYPE : constant is 1;
    attribute mti_svvh_generic_type of REG_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of DDR_TYPE : constant is 1;
end ddr2_phy_write;
