library verilog;
use verilog.vl_types.all;
entity data_format_out is
    generic(
        DI_WIDTH        : integer := 64;
        DO_WIDTH        : integer := 32
    );
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        data_in         : in     vl_logic_vector;
        din_vd          : in     vl_logic;
        data_out        : out    vl_logic_vector;
        dout_vd         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DI_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DO_WIDTH : constant is 1;
end data_format_out;
