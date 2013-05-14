`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:13:34 05/06/2013 
// Design Name: 
// Module Name:    data_format_out 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module data_format_out   # (

     parameter    DI_WIDTH  =  64,
	  parameter    DO_WIDTH  =  32 
)(

//input
     input                          clk     ,
	  input                          reset   ,
	  input [DI_WIDTH-1:0]           data_in ,
     input                          din_vd  ,
		 
//output
   output  reg  [DO_WIDTH-1:0]           data_out,
   output  reg                           dout_vd	

    );




   localparam      DIV_WIDTH            =   DI_WIDTH/DO_WIDTH  ;
	
	
	
	wire                                        empty        ;
	
	
	
	
	
	
	 wire         [DO_WIDTH-1:0]                data_out_reg  ;
    wire                        	             dout_vd_reg   ;
	
	
	
	
	


     always@( posedge clk  or  posedge reset)
     begin  
  
           if (reset)
			 begin
			       data_out         <=  0;
					 dout_vd          <=  0;
					
			 end 
	    else
           
         begin
              data_out     <=  data_out_reg ;
              dout_vd      <=  dout_vd_reg  ;


         end			
		 
  
    end
  
  
  
  
  
  
  
  fifo    fifo_out    (
   //input
	      .rst    (reset),
         .wr_clk (clk),
         .rd_clk (clk),
         .din    (data_in),
         .wr_en  (din_vd), 
			.rd_en  (!empty),
			
         .dout   (data_out_reg),
         .full   (),
         .almost_full(),
         .empty (empty),
         .valid (dout_vd_reg)
   
  
  
       );
  
  
  
   
  
  
  
  

//   genvar  i ;
//
//
//
//  generate 
//  
//    for ( i=0 ;  i< DIV_WIDTH  ;  i= i+1 ) 
//	 
//	 begin :  gen_cyc
//	 
//	  
//	 always @( posedge  clk )  
//	  begin
//	     data_out_reg   <=  
//	     dout_vd_reg    <=   
//	  
//	  
//	  
//	  
//	  end 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 
//	 end 
//  
//  
//  
//  
//  endgenerate










endmodule
