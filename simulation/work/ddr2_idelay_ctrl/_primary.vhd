library verilog;
use verilog.vl_types.all;
entity ddr2_idelay_ctrl is
    generic(
        IODELAY_GRP     : string  := "IODELAY_MIG"
    );
    port(
        clk200          : in     vl_logic;
        rst200          : in     vl_logic;
        idelay_ctrl_rdy : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IODELAY_GRP : constant is 1;
end ddr2_idelay_ctrl;
