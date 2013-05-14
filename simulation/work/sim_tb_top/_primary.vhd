library verilog;
use verilog.vl_types.all;
entity sim_tb_top is
    generic(
        CLK_PERIOD      : integer := 3750;
        WR_PERIOD       : integer := 20;
        RD_PERIOD       : integer := 10
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of WR_PERIOD : constant is 1;
    attribute mti_svvh_generic_type of RD_PERIOD : constant is 1;
end sim_tb_top;
