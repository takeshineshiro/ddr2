library verilog;
use verilog.vl_types.all;
entity addr_gen is
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
        wr_addr_en      : in     vl_logic;
        rd_addr_en      : in     vl_logic;
        rd_en           : in     vl_logic;
        wr_addr         : out    vl_logic_vector(30 downto 0);
        cmd             : out    vl_logic_vector(2 downto 0);
        rd_addr         : out    vl_logic_vector(30 downto 0);
        af_addr         : out    vl_logic_vector(30 downto 0);
        af_vd           : out    vl_logic;
        addr_confilct   : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of WRITE_BURST : constant is 1;
    attribute mti_svvh_generic_type of COL_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ROW_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of BANK_WIDTH : constant is 1;
end addr_gen;
