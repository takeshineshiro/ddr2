`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:07 05/06/2013 
// Design Name: 
// Module Name:    fifo_control 
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
module fifo_control  # (

    parameter    DATA_WIDTH  =  64  ,  
    parameter    WRITE_BURST = 8   ,
	 parameter    COL_WIDTH   =  10 ,
    parameter    ROW_WIDTH    =  14,
    parameter    BANK_WIDTH   =  2  
		
    

   )(
		
	//input
	
	 input                  sys_clk ,
    input                  reset  ,
    input                  data_in_vd,
	 input  [9:0]           rd_data_count,
	 input  [9:0]           wr_data_count,
    input                  almost_full,
	 input                  almost_empty,
	 input                  prog_full ,
    input                  prog_empty ,
    input                  phy_init_done,
    input                  app_wdf_afull,
    input                  app_af_afull,
    input                  rd_en,
	 input [DATA_WIDTH-1:0] wr_fifo_in,
  	 input                  wr_fifo_vd, 
	 	
	  
 //output
 
    output                 wr_fifo_rd,
	 
	
	 output                 app_af_wren,
	 output [30:0]          app_af_addr,
	 output [2:0]           app_af_cmd ,
	 
    output [DATA_WIDTH-1:0]app_wdf_data,
    output                 app_wdf_wren
	 
	 

	
	
    );



   //wire 


  wire                             wr_addr_en     ;
  wire                             rd_addr_en     ;
  wire  [30:0]                     wr_addr        ;
  wire  [30:0]                     rd_addr        ;
  wire                             addr_confilct  ;
  












    addr_gen   # (
	 
	     .DATA_WIDTH(DATA_WIDTH),  
        .WRITE_BURST(WRITE_BURST),
		  .COL_WIDTH(COL_WIDTH) ,
        .ROW_WIDTH(ROW_WIDTH),
        .BANK_WIDTH(BANK_WIDTH) 
	 
	 
	 )   addr_gen  (
	 
	 //input
	     .sys_clk (sys_clk),
	     .reset (reset),
		  .wr_addr_en (wr_addr_en),
		  .rd_addr_en (rd_addr_en),
		  .rd_en (rd_en),
		  
		  
//output
    
	    .wr_addr(wr_addr),
		 .rd_addr(rd_addr),
		 .af_addr(app_af_addr),
		 .af_vd(app_af_wren),
		 .cmd (app_af_cmd),
		 .addr_confilct (addr_confilct) 
	 
	   );   











   data_gen   #  (
	
	 .DATA_WIDTH(DATA_WIDTH),  
    .WRITE_BURST(WRITE_BURST)
	
	
	  ) data_gen (
//input	  
	    .sys_clk (sys_clk),
		 .reset   (reset),
		 .data_in (wr_fifo_in),
		 .din_vd  (wr_fifo_vd),
		 
//output
      .data_out (app_wdf_data),
      .dout_vd  (app_wdf_wren)		
	 	  
	  
	  );




    cmd_gen    #  (
           .DATA_WIDTH(DATA_WIDTH)  ,  
           .WRITE_BURST(WRITE_BURST)
   
      )  cmd_gen  (
		
	//input
         .sys_clk      (sys_clk),
         .reset        (reset),
       	.din_vd       (data_in_vd),
			.rd_data_count(rd_data_count), 
			.wr_data_count(wr_data_count),
			.almost_full  (almost_full),
			.almost_empty (almost_empty),
			.prog_full    (prog_full),
         .prog_empty   (prog_empty),
			.phy_init_done(phy_init_done),
			.app_wdf_afull(app_wdf_afull),
         .app_af_afull (app_af_afull),			
	      .rd_en        (rd_en),
			.addr_confilct(addr_confilct),
	

  //output
      
        .wr_fifo_rd (wr_fifo_rd) ,
		  .wr_addr_en (wr_addr_en) ,
		  .rd_addr_en (rd_addr_en)
			
		
		);









endmodule
