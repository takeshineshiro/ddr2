library verilog;
use verilog.vl_types.all;
entity ddr2_phy_ctl_io is
    generic(
        BANK_WIDTH      : integer := 2;
        CKE_WIDTH       : integer := 1;
        COL_WIDTH       : integer := 10;
        CS_NUM          : integer := 1;
        TWO_T_TIME_EN   : integer := 0;
        CS_WIDTH        : integer := 1;
        ODT_WIDTH       : integer := 1;
        ROW_WIDTH       : integer := 14;
        DDR_TYPE        : integer := 1
    );
    port(
        clk0            : in     vl_logic;
        clk90           : in     vl_logic;
        rst0            : in     vl_logic;
        rst90           : in     vl_logic;
        ctrl_addr       : in     vl_logic_vector;
        ctrl_ba         : in     vl_logic_vector;
        ctrl_ras_n      : in     vl_logic;
        ctrl_cas_n      : in     vl_logic;
        ctrl_we_n       : in     vl_logic;
        ctrl_cs_n       : in     vl_logic_vector;
        phy_init_addr   : in     vl_logic_vector;
        phy_init_ba     : in     vl_logic_vector;
        phy_init_ras_n  : in     vl_logic;
        phy_init_cas_n  : in     vl_logic;
        phy_init_we_n   : in     vl_logic;
        phy_init_cs_n   : in     vl_logic_vector;
        phy_init_cke    : in     vl_logic_vector;
        phy_init_data_sel: in     vl_logic;
        odt             : in     vl_logic_vector;
        ddr_addr        : out    vl_logic_vector;
        ddr_ba          : out    vl_logic_vector;
        ddr_ras_n       : out    vl_logic;
        ddr_cas_n       : out    vl_logic;
        ddr_we_n        : out    vl_logic;
        ddr_cke         : out    vl_logic_vector;
        ddr_cs_n        : out    vl_logic_vector;
        ddr_odt         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BANK_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CKE_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CS_NUM : constant is 1;
    attribute mti_svvh_generic_type of TWO_T_TIME_EN : constant is 1;
    attribute mti_svvh_generic_type of CS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ODT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DDR_TYPE : constant is 1;
end ddr2_phy_ctl_io;
