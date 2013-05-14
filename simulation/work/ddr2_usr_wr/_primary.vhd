library verilog;
use verilog.vl_types.all;
entity ddr2_usr_wr is
    generic(
        BANK_WIDTH      : integer := 2;
        COL_WIDTH       : integer := 10;
        CS_BITS         : integer := 0;
        DQ_WIDTH        : integer := 72;
        APPDATA_WIDTH   : integer := 144;
        ECC_ENABLE      : integer := 0;
        ROW_WIDTH       : integer := 14
    );
    port(
        clk0            : in     vl_logic;
        clk90           : in     vl_logic;
        rst0            : in     vl_logic;
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
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CS_BITS : constant is 1;
    attribute mti_svvh_generic_type of DQ_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of APPDATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ECC_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
end ddr2_usr_wr;
