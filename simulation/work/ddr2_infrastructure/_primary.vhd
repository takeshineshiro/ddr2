library verilog;
use verilog.vl_types.all;
entity ddr2_infrastructure is
    generic(
        CLK_PERIOD      : integer := 3000;
        CLK_TYPE        : string  := "DIFFERENTIAL";
        DLL_FREQ_MODE   : string  := "HIGH";
        NOCLK200        : integer := 0;
        RST_ACT_LOW     : integer := 1
    );
    port(
        sys_clk_p       : in     vl_logic;
        sys_clk_n       : in     vl_logic;
        sys_clk         : in     vl_logic;
        clk200_p        : in     vl_logic;
        clk200_n        : in     vl_logic;
        idly_clk_200    : in     vl_logic;
        clk0            : out    vl_logic;
        clk90           : out    vl_logic;
        clk200          : out    vl_logic;
        clkdiv0         : out    vl_logic;
        sys_rst_n       : in     vl_logic;
        idelay_ctrl_rdy : in     vl_logic;
        rst0            : out    vl_logic;
        rst90           : out    vl_logic;
        rst200          : out    vl_logic;
        rstdiv0         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of CLK_TYPE : constant is 1;
    attribute mti_svvh_generic_type of DLL_FREQ_MODE : constant is 1;
    attribute mti_svvh_generic_type of NOCLK200 : constant is 1;
    attribute mti_svvh_generic_type of RST_ACT_LOW : constant is 1;
end ddr2_infrastructure;
