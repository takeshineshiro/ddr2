library verilog;
use verilog.vl_types.all;
entity clk_gen is
    port(
        CLKIN1_IN       : in     vl_logic;
        RST_IN          : in     vl_logic;
        CLKOUT0_OUT     : out    vl_logic;
        CLKOUT1_OUT     : out    vl_logic;
        LOCKED_OUT      : out    vl_logic
    );
end clk_gen;
