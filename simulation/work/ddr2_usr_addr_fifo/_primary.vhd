library verilog;
use verilog.vl_types.all;
entity ddr2_usr_addr_fifo is
    generic(
        BANK_WIDTH      : integer := 2;
        COL_WIDTH       : integer := 10;
        CS_BITS         : integer := 0;
        ROW_WIDTH       : integer := 14
    );
    port(
        clk0            : in     vl_logic;
        rst0            : in     vl_logic;
        app_af_cmd      : in     vl_logic_vector(2 downto 0);
        app_af_addr     : in     vl_logic_vector(30 downto 0);
        app_af_wren     : in     vl_logic;
        ctrl_af_rden    : in     vl_logic;
        af_cmd          : out    vl_logic_vector(2 downto 0);
        af_addr         : out    vl_logic_vector(30 downto 0);
        af_empty        : out    vl_logic;
        app_af_afull    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of BANK_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of CS_BITS : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
end ddr2_usr_addr_fifo;
