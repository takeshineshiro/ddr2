library verilog;
use verilog.vl_types.all;
entity ddr2_phy_dm_iob is
    port(
        clk90           : in     vl_logic;
        dm_ce           : in     vl_logic;
        mask_data_rise  : in     vl_logic;
        mask_data_fall  : in     vl_logic;
        ddr_dm          : out    vl_logic
    );
end ddr2_phy_dm_iob;
