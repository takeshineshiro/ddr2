library verilog;
use verilog.vl_types.all;
entity fifo_0 is
    port(
        rst             : in     vl_logic;
        wr_clk          : in     vl_logic;
        rd_clk          : in     vl_logic;
        din             : in     vl_logic_vector(63 downto 0);
        wr_en           : in     vl_logic;
        rd_en           : in     vl_logic;
        dout            : out    vl_logic_vector(63 downto 0);
        full            : out    vl_logic;
        almost_full     : out    vl_logic;
        empty           : out    vl_logic;
        almost_empty    : out    vl_logic;
        valid           : out    vl_logic;
        rd_data_count   : out    vl_logic_vector(9 downto 0);
        wr_data_count   : out    vl_logic_vector(9 downto 0);
        prog_full       : out    vl_logic;
        prog_empty      : out    vl_logic
    );
end fifo_0;
