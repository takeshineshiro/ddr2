library verilog;
use verilog.vl_types.all;
entity ddr2_phy_dqs_iob is
    generic(
        DDR_TYPE        : integer := 1;
        HIGH_PERFORMANCE_MODE: string  := "TRUE";
        IODELAY_GRP     : string  := "IODELAY_MIG"
    );
    port(
        clk0            : in     vl_logic;
        clkdiv0         : in     vl_logic;
        rst0            : in     vl_logic;
        dlyinc_dqs      : in     vl_logic;
        dlyce_dqs       : in     vl_logic;
        dlyrst_dqs      : in     vl_logic;
        dlyinc_gate     : in     vl_logic;
        dlyce_gate      : in     vl_logic;
        dlyrst_gate     : in     vl_logic;
        dqs_oe_n        : in     vl_logic;
        dqs_rst_n       : in     vl_logic;
        en_dqs          : in     vl_logic;
        ddr_dqs         : inout  vl_logic;
        ddr_dqs_n       : inout  vl_logic;
        dq_ce           : out    vl_logic;
        delayed_dqs     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DDR_TYPE : constant is 1;
    attribute mti_svvh_generic_type of HIGH_PERFORMANCE_MODE : constant is 1;
    attribute mti_svvh_generic_type of IODELAY_GRP : constant is 1;
end ddr2_phy_dqs_iob;
