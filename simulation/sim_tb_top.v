`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:40:04 05/08/2013
// Design Name:   sim_fifo_top
// Module Name:   D:/ddr2_fifo_module/sim_tb_top.v
// Project Name:  ddr2_fifo_module
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: sim_fifo_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sim_tb_top;


	// Inputs
	reg [31:0] data_in;
	reg wr_clk;
	reg ref_clk;
	reg sys_clk;
	reg clk_200;
	reg rd_clk;
	reg reset_n;
	reg wr_en;
	reg rd_en;

	// Outputs
	wire full;
	wire almost_full;
	wire empty;
	wire almost_empty;
	wire phy_init_done ;
	wire dout_vd;
	wire [31:0] data_out;

	// Instantiate the Unit Under Test (UUT)
	sim_fifo_top uut (
		.data_in(data_in), 
		.wr_clk(wr_clk), 
		.ref_clk(ref_clk),
      .sys_clk(sys_clk),
      .clk_200(clk_200),		
		.rd_clk(rd_clk), 
		.reset_n(reset_n), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		
		.full(full), 
		.almost_full(almost_full), 
		.empty(empty), 
		.almost_empty(almost_empty), 
		.phy_init_done(phy_init_done),
		.dout_vd(dout_vd), 
		.data_out(data_out)
	);

	
   parameter CLK_PERIOD               = 3750;   // Core/Mem clk period (in ps)
	
   parameter WR_PERIOD                = 20  ;
	parameter RD_PERIOD                = 10  ;
  
   localparam real CLK_PERIOD_NS      = CLK_PERIOD / 1000.0;
   localparam real TCYC_200           = 5.0;

   
	
	
	
	
	
	
	 //***************************************************************************
   // Clock generation and reset
   //***************************************************************************

   initial
     sys_clk   = 1'b0;
   always
     sys_clk   = #(CLK_PERIOD_NS/2) ~sys_clk;

   

   initial
       clk_200 = 1'b0;
   always
     clk_200   = #(TCYC_200/2) ~clk_200;

   
	initial 
	    wr_clk = 1'b0;
	 always
	    wr_clk =  #(WR_PERIOD/2)~wr_clk ;
		 
		 
  initial
       rd_clk  =  1'b0;
    always
       rd_clk  =  #(RD_PERIOD/2) ~rd_clk  ;	 
      
		 

   initial 
	
	begin
      reset_n   = 1'b0;
      #400;
      reset_n   = 1'b1;
   end
 
	
   //***************************************************************************
   //  data  generation 
   //***************************************************************************	
	
	
	
	    always@( posedge wr_clk   or   negedge  reset_n )
		 begin
		    if (!reset_n)	
            
            begin
				   data_in   <=  0;
							
             end 				
			
   	   else
			     if (wr_en)
           	  data_in   <=  data_in  +1  ;		
		         
		 
		 
		 end 
		 

      initial
		
		begin
		  
		  wr_en    =  0;
		  rd_en    =  0;
		  
		 #510 ;
        wr_en	  =  1 ;
 
       #3000;
        	wr_en	  =  0 ;	 
			
	    #200 ;
		   rd_en    =  1; 
			
		
		
		
		
		end 







	
		
		
		
		
		
		
endmodule

