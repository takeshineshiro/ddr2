library verilog;
use verilog.vl_types.all;
entity rd_fifo is
    generic(
        DATA_WIDTH      : integer := 128;
        WRITE_BURST     : integer := 8
    );
    port(
        wr_clk          : in     vl_logic;
        rd_clk          : in     vl_logic;
        reset           : in     vl_logic;
        rd_fifo_in      : in     vl_logic_vector;
        rd_fifo_vd      : in     vl_logic;
        rd_en           : in     vl_logic;
        full            : out    vl_logic;
        almost_full     : out    vl_logic;
        empty           : out    vl_logic;
        almost_empty    : out    vl_logic;
        rd_fifo_out     : out    vl_logic_vector;
        fifo_out_vd     : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of WRITE_BURST : constant is 1;
end rd_fifo;
