library verilog;
use verilog.vl_types.all;
entity ddr2_phy_dq_iob is
    generic(
        HIGH_PERFORMANCE_MODE: string  := "TRUE";
        IODELAY_GRP     : string  := "IODELAY_MIG";
        FPGA_SPEED_GRADE: integer := 2
    );
    port(
        clk0            : in     vl_logic;
        clk90           : in     vl_logic;
        clkdiv0         : in     vl_logic;
        rst90           : in     vl_logic;
        dlyinc          : in     vl_logic;
        dlyce           : in     vl_logic;
        dlyrst          : in     vl_logic;
        dq_oe_n         : in     vl_logic_vector(1 downto 0);
        dqs             : in     vl_logic;
        ce              : in     vl_logic;
        rd_data_sel     : in     vl_logic;
        wr_data_rise    : in     vl_logic;
        wr_data_fall    : in     vl_logic;
        rd_data_rise    : out    vl_logic;
        rd_data_fall    : out    vl_logic;
        ddr_dq          : inout  vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of HIGH_PERFORMANCE_MODE : constant is 1;
    attribute mti_svvh_generic_type of IODELAY_GRP : constant is 1;
    attribute mti_svvh_generic_type of FPGA_SPEED_GRADE : constant is 1;
end ddr2_phy_dq_iob;
