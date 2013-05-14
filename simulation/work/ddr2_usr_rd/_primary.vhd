library verilog;
use verilog.vl_types.all;
entity ddr2_usr_rd is
    generic(
        DQ_PER_DQS      : integer := 8;
        DQS_WIDTH       : integer := 9;
        APPDATA_WIDTH   : integer := 144;
        ECC_WIDTH       : integer := 72;
        ECC_ENABLE      : integer := 0
    );
    port(
        clk0            : in     vl_logic;
        rst0            : in     vl_logic;
        rd_data_in_rise : in     vl_logic_vector;
        rd_data_in_fall : in     vl_logic_vector;
        ctrl_rden       : in     vl_logic_vector;
        ctrl_rden_sel   : in     vl_logic_vector;
        rd_ecc_error    : out    vl_logic_vector(1 downto 0);
        rd_data_valid   : out    vl_logic;
        rd_data_out_rise: out    vl_logic_vector;
        rd_data_out_fall: out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DQ_PER_DQS : constant is 1;
    attribute mti_svvh_generic_type of DQS_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of APPDATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ECC_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ECC_ENABLE : constant is 1;
end ddr2_usr_rd;
