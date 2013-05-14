library verilog;
use verilog.vl_types.all;
entity data_gen is
    generic(
        DATA_WIDTH      : integer := 64;
        WRITE_BURST     : integer := 8
    );
    port(
        sys_clk         : in     vl_logic;
        reset           : in     vl_logic;
        data_in         : in     vl_logic_vector;
        din_vd          : in     vl_logic;
        data_out        : out    vl_logic_vector;
        dout_vd         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of WRITE_BURST : constant is 1;
end data_gen;
