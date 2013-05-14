`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:08:17 05/06/2013 
// Design Name: 
// Module Name:    wr_fifo 
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
module wr_fifo   # (

   parameter  DATA_WIDTH   = 64 ,  
   parameter  WRITE_BURST  = 8
      )

   (
	
	//input
	  
	 input                               wr_clk  ,
    input                               rd_clk  ,
    input                               reset   ,
    input  	[DATA_WIDTH-1:0]            data_in ,
    input           	                   wr_fifo ,
	 input                               rd_fifo ,
	 
	 
//output	
   output  [9 : 0]                      rd_data_count,
   output  [9 : 0]                      wr_data_count,
	output                               almost_full  ,
   output                               almost_empty ,
	output                               prog_full ,
   output                               prog_empty,
   output [DATA_WIDTH-1:0]              data_out ,
   output                               dout_vd 	
      
	
	
	
	
    );


//wire




//reg






fifo_0    fifo_0  (

//input 
     .rst   (reset) ,
     .wr_clk(wr_clk),
     .rd_clk(rd_clk),
     .din   (data_in),
     .wr_en (wr_fifo),
     .rd_en (rd_fifo),

//output	  
     .dout(data_out),
	  .valid(dout_vd),
     .full(),
     .almost_full(almost_full),
     .empty(),
     .almost_empty(almost_empty),
     .rd_data_count(rd_data_count),
     .wr_data_count(wr_data_count),
	  .prog_full(prog_full),
     .prog_empty(prog_empty)




);
















endmodule
