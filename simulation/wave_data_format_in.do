 
if { [info exists PathSeparator] } { set ps $PathSeparator } else { set ps "/" }

if { ![info exists ddr2_fifo_top] } { set  ddr2_fifo_top "../src/ddr2_fifo_top" } 
 
set binopt {-logic}
set hexopt {-literal -hex}
set ascopt {-literal -ascii}
 
 eval add wave -noupdate -divider {"data_format_in"}
 eval add wave -noupdate $binopt $ddr2_fifo_top${ps}data_format_in${ps}clk 
 eval add wave -noupdate $binopt $ddr2_fifo_top${ps}data_format_in${ps}reset 
 eval add wave -noupdate $binopt $ddr2_fifo_top${ps}data_format_in${ps}data_in
 eval add wave -noupdate $binopt $ddr2_fifo_top${ps}data_format_in${ps}din_valid 
 eval add wave -noupdate $binopt $ddr2_fifo_top${ps}data_format_in${ps}dout 
 eval add wave -noupdate $binopt $ddr2_fifo_top${ps}data_format_in${ps}dout_vd
 
 
 
 
 
 
 
 
 
 
 
 