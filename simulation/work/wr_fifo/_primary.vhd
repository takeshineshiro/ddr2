library verilog;
use verilog.vl_types.all;
entity wr_fifo is
    generic(
        DATA_WIDTH      : integer := 64;
        WRITE_BURST     : integer := 8
    );
    port(
        wr_clk          : in     vl_logic;
        rd_clk          : in     vl_logic;
        reset           : in     vl_logic;
        data_in         : in     vl_logic_vector;
        wr_fifo         : in     vl_logic;
        rd_fifo         : in     vl_logic;
        rd_data_count   : out    vl_logic_vector(9 downto 0);
        wr_data_count   : out    vl_logic_vector(9 downto 0);
        almost_full     : out    vl_logic;
        almost_empty    : out    vl_logic;
        prog_full       : out    vl_logic;
        prog_empty      : out    vl_logic;
        data_out        : out    vl_logic_vector;
        dout_vd         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of WRITE_BURST : constant is 1;
end wr_fifo;
