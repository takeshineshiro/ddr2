`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:56 04/28/2013 
// Design Name: 
// Module Name:    dd2_top_module 
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
module ddr2_fifo_top  #(

   parameter   DATA_WIDTH             = 32 ,
	parameter   DO_WIDTH               = 64 ,
	
	 
   parameter BANK_WIDTH              = 3,       
                                       // # of memory bank addr bits.
   parameter CKE_WIDTH               = 1,       
                                       // # of memory clock enable outputs.
   parameter CLK_WIDTH               = 4,       
                                       // # of clock outputs.
   parameter COL_WIDTH               = 10,       
                                       // # of memory column bits.
   parameter CS_NUM                  = 1,       
                                       // # of separate memory chip selects.
   parameter CS_WIDTH                = 4,       
                                       // # of total memory chip selects.
   parameter CS_BITS                 = 0,       
                                       // set to log2(CS_NUM) (rounded up).
   parameter DQ_WIDTH                = 32,       
                                       // # of data width.
   parameter DQ_PER_DQS              = 8,       
                                       // # of DQ data bits per strobe.
   parameter DQS_WIDTH               = 4,       
                                       // # of DQS strobes.
   parameter DQ_BITS                 = 5,       
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
   parameter DQS_BITS                = 2,       
                                       // set to log2(DQS_WIDTH).
   parameter ODT_WIDTH               = 4,       
                                       // # of memory on-die term enables.
   parameter ROW_WIDTH               = 15,       
                                       // # of memory row and # of addr bits.
   parameter ADDITIVE_LAT            = 0,       
                                       // additive write latency.
   parameter BURST_LEN               = 8,       
                                       // burst length (in double words).
   parameter BURST_TYPE              = 0,       
                                       // burst type (=0 seq; =1 interleaved).
   parameter CAS_LAT                 = 4,       
                                       // CAS latency.
   parameter ECC_ENABLE              = 0,       
                                       // enable ECC (=1 enable).
   parameter APPDATA_WIDTH           = 64,       
                                       // # of usr read/write data bus bits.
   parameter MULTI_BANK_EN           = 1,       
                                       // Keeps multiple banks open. (= 1 enable).
   parameter TWO_T_TIME_EN           = 0,       
                                       // 2t timing for unbuffered dimms.
   parameter ODT_TYPE                = 1,       
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
   parameter REDUCE_DRV              = 0,       
                                       // reduced strength mem I/O (=1 yes).
   parameter REG_ENABLE              = 0,       
                                       // registered addr/ctrl (=1 yes).
   parameter TREFI_NS                = 7800,       
                                       // auto refresh interval (ns).
   parameter TRAS                    = 40000,       
                                       // active->precharge delay.
   parameter TRCD                    = 15000,       
                                       // active->read/write delay.
   parameter TRFC                    = 197500,       
                                       // refresh->refresh, refresh->active delay.
   parameter TRP                     = 15000,       
                                       // precharge->command delay.
   parameter TRTP                    = 7500,       
                                       // read->precharge delay.
   parameter TWR                     = 15000,       
                                       // used to determine write->precharge.
   parameter TWTR                    = 7500,       
                                       // write->read delay.
   parameter HIGH_PERFORMANCE_MODE   = "TRUE",       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
   parameter SIM_ONLY                = 0,       
                                       // = 1 to skip SDRAM power up delay.
   parameter DEBUG_EN                = 0,       
                                       // Enable debug signals/controls.
                                       // When this parameter is changed from 0 to 1,
                                       // make sure to uncomment the coregen commands
                                       // in ise_flow.bat or create_ise.bat files in
                                       // par folder.
   parameter CLK_PERIOD              = 3750,       
                                       // Core/Memory clock period (in ps).
   parameter DLL_FREQ_MODE           = "HIGH",       
                                       // DCM Frequency range.
   parameter CLK_TYPE                = "SINGLE_ENDED",       
                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
   parameter NOCLK200                = 0,       
                                       // clk200 enable and disable.
   parameter RST_ACT_LOW             = 1        
	 




     )(
                                                        // for  the  fifo_top_interface                                         
   // input
	   input   [DATA_WIDTH-1 :0]      data_in   ,
		input                          wr_clk    ,
		input                          ref_clk   ,         // 50M
		input                          sys_clk   ,
		input                          clk_200   ,
		input                          rd_clk    ,  
		input                          reset_n   ,
		input                          wr_en     ,
		input                          rd_en     ,
		
  // output
     output                           full       ,
     output                           almost_full,
     output	                          empty      ,
     output                           almost_empty,
	  output                           phy_init_done,
    
     output                           dout_vd    ,
     output  [DATA_WIDTH-1 :0]        data_out   ,         	  
	 	
		
 // for  the  ddr2_interface
   inout  [DQ_WIDTH-1:0]              ddr2_dq,
   output [ROW_WIDTH-1:0]             ddr2_a,
   output [BANK_WIDTH-1:0]            ddr2_ba,
   output                             ddr2_ras_n,
   output                             ddr2_cas_n,
   output                             ddr2_we_n,
   output [CS_WIDTH-1:0]              ddr2_cs_n,
   output [ODT_WIDTH-1:0]             ddr2_odt,
   output [CKE_WIDTH-1:0]             ddr2_cke,
   inout  [DQS_WIDTH-1:0]             ddr2_dqs,
   inout  [DQS_WIDTH-1:0]             ddr2_dqs_n,
   output [CLK_WIDTH-1:0]             ddr2_ck,
   output [CLK_WIDTH-1:0]             ddr2_ck_n
 
		

    );
	 
	

 //wire 

 wire                                            clk_100     ;
 
 wire                                            locked      ;
 wire                                            rst_ddr_n   ;
 wire   [DO_WIDTH-1:0]                           din_fifo    ;
 wire                                            din_fifo_vd ;  
 wire                                            wr_fifo_rd  ;
 
 
 wire                                            app_wdf_wren ;
 wire                                            app_af_wren  ;
 wire  [30:0]                                    app_af_addr  ;
 wire  [2:0]                                     app_af_cmd   ;
 wire   [(APPDATA_WIDTH)-1:0]                    app_wdf_data ;
 wire                                            app_wdf_afull;
 wire                                            app_af_afull ;
 
 wire   [9 : 0]                                  rd_data_count;
 wire   [9 : 0]                                  wr_data_count;
 wire                                            almost_full_wr  ;
 wire                                            almost_empty_wr ;
 wire                                            prog_full_wr    ;
 wire                                            prog_empty_wr   ;
 wire   [DO_WIDTH-1:0]                            wr_fifo_out  ;
 wire                                             wr_fifo_vd   ;
 
 
 
 
 wire                                            rd_data_valid    ;
 wire [(APPDATA_WIDTH)-1:0]                      rd_data_fifo_out ;
 
 wire [(APPDATA_WIDTH)-1:0]                      rd_fifo_out      ;
 wire                                            fifo_out_vd      ;
 
 
 
 
 
 
 

//reg




//combination


 //  assign  rst_ddr_n    =    reset_n&locked                 ;    

   assign  rst_ddr_n    =    reset_n                       ;






//
   
	
	
//	clk_gen      clk_gen_inter   (
//	
//	     .CLKIN1_IN(ref_clk),                  // 50M
//        .RST_IN(!reset_n),
//        .CLKOUT0_OUT(clk_100),
//        .CLKOUT1_OUT(clk_200),
//        .LOCKED_OUT(locked)	
//	
//	
//	);
//	
	
	
	
	
	
 


    data_format_in    #(
	    
		   .DI_WIDTH(DATA_WIDTH),
	      .DO_WIDTH(DO_WIDTH)
	 
	 
	 
	    )  data_format_in  (
	
	  //input
	        .clk (wr_clk),
	        .reset(!reset_n),
			  .data_in(data_in),
	        .din_valid(wr_en),
			    
	//output
	      .dout (din_fifo),
		   .dout_vd(din_fifo_vd)
			  	
	
	) ;






// write  data to fifo ,pingpang caozuo(no necessary) 


  wr_fifo    # (
         .DATA_WIDTH(DO_WIDTH),
			.WRITE_BURST (BURST_LEN)
      
  
        )   wr_fifo_module    (
	

  // input	
		  .wr_clk  (wr_clk),
		  .rd_clk  (sys_clk),
		  .reset   (!reset_n),
		  .data_in (din_fifo),
		  .wr_fifo (din_fifo_vd),
		  .rd_fifo (wr_fifo_rd),		  
		  
//output	
       .rd_data_count(rd_data_count),
       .wr_data_count(wr_data_count),
	    .almost_full  (almost_full_wr)  ,
       .almost_empty (almost_empty_wr) ,
		 .prog_full    (prog_full_wr),
       .prog_empty   (prog_empty_wr),
       .data_out     ( wr_fifo_out) ,
	    .dout_vd      ( wr_fifo_vd)
		  
		  
		  ) ;  




 fifo_control   # (
      .DATA_WIDTH(DO_WIDTH),
      .WRITE_BURST(BURST_LEN),
		.COL_WIDTH(COL_WIDTH) ,
      .ROW_WIDTH(ROW_WIDTH),
      .BANK_WIDTH(BANK_WIDTH)  
 
 
 )  fifo_control  (
 
 //input
     .sys_clk      (sys_clk ),
     .reset        (!reset_n),
     .data_in_vd   (din_fifo_vd),
	  .rd_data_count(rd_data_count),
     .wr_data_count(wr_data_count),
	  .almost_full  (almost_full_wr)  ,
     .almost_empty (almost_empty_wr) ,
	  .prog_full    (prog_full_wr),
     .prog_empty   (prog_empty_wr),
     .phy_init_done(phy_init_done),
     .app_wdf_afull(app_wdf_afull),
     .app_af_afull (app_af_afull),
     .rd_en        (rd_en),
     .wr_fifo_in   (wr_fifo_out),
     .wr_fifo_vd   (wr_fifo_vd),	  
 
 
 //output
 
    .wr_fifo_rd (wr_fifo_rd),
 
   .app_wdf_wren(app_wdf_wren),
   .app_af_wren(app_af_wren),
   .app_af_addr(app_af_addr),
   .app_af_cmd(app_af_cmd) ,
   .app_wdf_data(app_wdf_data)
	
  

 
 );
 
 
 
 
 
 
    rd_fifo   # (  
	      .DATA_WIDTH(DO_WIDTH),
			.WRITE_BURST (BURST_LEN)
	 
	 
	 )  rd_fifo_module(
	
// input	
	   .wr_clk 		(sys_clk),
		.rd_clk 		(rd_clk),
		.reset      (!rst_ddr_n),
		.rd_fifo_in (rd_data_fifo_out),
		.rd_fifo_vd	(rd_data_valid),
		.rd_en 		(rd_en),
		
 //output
      .full        (full),
		.almost_full (almost_full) ,
      .empty       (empty),
	   .almost_empty (almost_empty),
      .rd_fifo_out (rd_fifo_out),
		.fifo_out_vd (fifo_out_vd)
		
	 
	 
	 
	 );
	 
	 
	 
	data_format_out    # (
	
	   .DI_WIDTH (DO_WIDTH),
		.DO_WIDTH (DATA_WIDTH)
	
	
	
	  ) data_format_out (
	  
//input
       .clk    (rd_clk),
		 .reset  (!rst_ddr_n),
		 .data_in(rd_fifo_out),
		 .din_vd (fifo_out_vd),
		 
//output
   	.data_out(data_out),
      .dout_vd (dout_vd)		
	  	  
	  
	  );
	 

    
	
 ddr_sdram #  (
            .BANK_WIDTH(BANK_WIDTH),       
                                       // # of memory bank addr bits.
            .CKE_WIDTH(CKE_WIDTH),                     
                                       // # of memory clock enable outputs.
            .CLK_WIDTH(CLK_WIDTH),                      
                                       // # of clock outputs.
            .COL_WIDTH(COL_WIDTH),                     
                                       // # of memory column bits.
            .CS_NUM(CS_NUM),                    
                                       // # of separate memory chip selects.
            .CS_WIDTH(CS_WIDTH),               
                                       // # of total memory chip selects.
            .CS_BITS(CS_BITS),                   
                                       // set to log2(CS_NUM) (rounded up).
            .DQ_WIDTH(DQ_WIDTH),             
                                       // # of data width.
            .DQ_PER_DQS(DQ_PER_DQS),                     
                                       // # of DQ data bits per strobe.
            .DQS_WIDTH(DQS_WIDTH),                 
                                       // # of DQS strobes.
            .DQ_BITS(DQ_BITS),                    
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
            .DQS_BITS(DQS_BITS),                
                                       // set to log2(DQS_WIDTH).
            .ODT_WIDTH(ODT_WIDTH),                 
                                       // # of memory on-die term enables.
            .ROW_WIDTH(ROW_WIDTH),                   
                                       // # of memory row and # of addr bits.
            .ADDITIVE_LAT(ADDITIVE_LAT),       
                                       // additive write latency.
            .BURST_LEN(BURST_LEN),                  
                                       // burst length (in double words).
            .BURST_TYPE(BURST_TYPE),                
                                       // burst type (=0 seq; =1 interleaved).
            .CAS_LAT(CAS_LAT),                   
                                       // CAS latency.
            .ECC_ENABLE(ECC_ENABLE),                  
                                       // enable ECC (=1 enable).
            .APPDATA_WIDTH(APPDATA_WIDTH),        
                                       // # of usr read/write data bus bits.
            .MULTI_BANK_EN(MULTI_BANK_EN),             
                                       // Keeps multiple banks open. (= 1 enable).
            .TWO_T_TIME_EN(TWO_T_TIME_EN),       
                                       // 2t timing for unbuffered dimms.
            .ODT_TYPE(ODT_TYPE),                 
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
            .REDUCE_DRV(REDUCE_DRV),          
                                       // reduced strength mem I/O (=1 yes).
            .REG_ENABLE(REG_ENABLE),         
                                       // registered addr/ctrl (=1 yes).
            .TREFI_NS(TREFI_NS),       
                                       // auto refresh interval (ns).
            .TRAS(TRAS),                         
                                       // active->precharge delay.
            .TRCD(TRCD),                           
                                       // active->read/write delay.
            .TRFC(TRFC),                    
                                       // refresh->refresh, refresh->active delay.
            .TRP(TRP),                   
                                       // precharge->command delay.
            .TRTP(TRTP),                         
                                       // read->precharge delay.
            .TWR(TWR),                         
                                       // used to determine write->precharge.
            .TWTR(TWTR),                          
                                       // write->read delay.
            .HIGH_PERFORMANCE_MODE(HIGH_PERFORMANCE_MODE),       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
            .SIM_ONLY(SIM_ONLY),       
                                       // = 1 to skip SDRAM power up delay.
            .DEBUG_EN(DEBUG_EN),       
                                       // Enable debug signals/controls.
                                       // When this parameter is changed from 0 to 1,
                                       // make sure to uncomment the coregen commands
                                       // in ise_flow.bat or create_ise.bat files in
                                       // par folder.
           .CLK_PERIOD(CLK_PERIOD),                    
                                       // Core/Memory clock period (in ps).
           .DLL_FREQ_MODE(DLL_FREQ_MODE),                
                                       // DCM Frequency range.
           .CLK_TYPE(CLK_TYPE),                     
                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
           .NOCLK200(NOCLK200),                 
                                       // clk200 enable and disable.
           .RST_ACT_LOW(RST_ACT_LOW)               
                                       // =1 for active low reset, =0 for active high.
         )   ddr_sdram(
           .ddr2_dq(ddr2_dq),
           .ddr2_a(ddr2_a),
           .ddr2_ba(ddr2_ba),
           .ddr2_ras_n(ddr2_ras_n),
           .ddr2_cas_n(ddr2_cas_n),
           .ddr2_we_n(ddr2_we_n),
           .ddr2_cs_n(ddr2_cs_n),
           .ddr2_odt(ddr2_odt),
           .ddr2_cke(ddr2_cke),
			  .ddr2_dqs(ddr2_dqs),
           .ddr2_dqs_n(ddr2_dqs_n),
           .ddr2_ck(ddr2_ck),
           .ddr2_ck_n(ddr2_ck_n),
 //input
           .sys_clk(sys_clk),
           .idly_clk_200(clk_200),
           .sys_rst_n(rst_ddr_n), 
			  .app_wdf_wren(app_wdf_wren),
           .app_af_wren(app_af_wren),
           .app_af_addr(app_af_addr),
           .app_af_cmd(app_af_cmd),
			  .app_wdf_data(app_wdf_data),
//output
           .phy_init_done(phy_init_done),
           .rst0_tb(),
           .clk0_tb(),
           .app_wdf_afull(app_wdf_afull),
           .app_af_afull(app_af_afull),
           .rd_data_valid(rd_data_valid),
           .rd_data_fifo_out(rd_data_fifo_out)
   
   
   );
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 


endmodule
