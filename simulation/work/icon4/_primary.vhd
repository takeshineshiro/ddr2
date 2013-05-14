library verilog;
use verilog.vl_types.all;
entity icon4 is
    port(
        control0        : out    vl_logic_vector(35 downto 0);
        control1        : out    vl_logic_vector(35 downto 0);
        control2        : out    vl_logic_vector(35 downto 0);
        control3        : out    vl_logic_vector(35 downto 0)
    );
end icon4;
