library verilog;
use verilog.vl_types.all;
entity WireDelay is
    generic(
        Delay_g         : integer := 0;
        Delay_rd        : integer := 0
    );
    port(
        A               : inout  vl_logic;
        B               : inout  vl_logic;
        reset           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of Delay_g : constant is 1;
    attribute mti_svvh_generic_type of Delay_rd : constant is 1;
end WireDelay;
