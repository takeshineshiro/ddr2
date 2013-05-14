library verilog;
use verilog.vl_types.all;
entity vio_sync_out32 is
    port(
        control         : in     vl_logic_vector(35 downto 0);
        clk             : in     vl_logic;
        sync_out        : out    vl_logic_vector(31 downto 0)
    );
end vio_sync_out32;
