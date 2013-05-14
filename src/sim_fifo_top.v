`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:42:15 05/08/2013 
// Design Name: 
// Module Name:    sim_fifo_top 
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
module sim_fifo_top #(

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
	parameter DM_WIDTH                = 4,      // # of data mask bits
	
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
     output  [DATA_WIDTH-1 :0]        data_out            


    );


    localparam    DEVICE_WIDTH         =   8  ;
    localparam real CLK_PERIOD_NS      = CLK_PERIOD / 1000.0;
    localparam real TCYC_200           = 5.0;
    localparam real TPROP_DQS          = 0.01;  // Delay for DQS signal during Write Operation
    localparam real TPROP_DQS_RD       = 0.01;  // Delay for DQS signal during Read Operation
    localparam real TPROP_PCB_CTRL     = 0.01;  // Delay for Address and Ctrl signals
    localparam real TPROP_PCB_DATA     = 0.01;  // Delay for data signal during Write operation
    localparam real TPROP_PCB_DATA_RD  = 0.01;  // Delay for data signal during Read operation

  



 //wire
 
   wire   [DQ_WIDTH-1:0]              ddr2_dq_0 ;
   wire   [ROW_WIDTH-1:0]             ddr2_a_0  ;
   wire   [BANK_WIDTH-1:0]            ddr2_ba_0 ;
   wire                               ddr2_ras_n_0;
   wire                               ddr2_cas_n_0;
   wire                               ddr2_we_n_0 ;
   wire   [CS_WIDTH-1:0]              ddr2_cs_n_0 ;
   wire   [ODT_WIDTH-1:0]             ddr2_odt_0;
   wire   [CKE_WIDTH-1:0]             ddr2_cke_0 ;
   wire   [DQS_WIDTH-1:0]             ddr2_dqs_0  ;
   wire   [DQS_WIDTH-1:0]             ddr2_dqs_n_0;
   wire   [CLK_WIDTH-1:0]             ddr2_ck_0 ;
   wire   [CLK_WIDTH-1:0]             ddr2_ck_n_0 ;
	wire   [DM_WIDTH-1:0]              ddr2_dm_fpga_0;
	
	
	wire [DQ_WIDTH-1:0]         		   ddr2_dq_sdram;
   wire [DQS_WIDTH-1:0]         			ddr2_dqs_sdram;
   wire [DQS_WIDTH-1:0]         			ddr2_dqs_n_sdram;
   wire [DM_WIDTH-1:0]               	ddr2_dm_sdram;
	
	
	wire                                ddr2_reset_n;
	
	
 //reg

   reg [DM_WIDTH-1:0]           ddr2_dm_sdram_tmp;
   reg [CLK_WIDTH-1:0]          ddr2_clk_sdram;
   reg [CLK_WIDTH-1:0]          ddr2_clk_n_sdram;
   reg [ROW_WIDTH-1:0]          ddr2_address_sdram;
   reg [BANK_WIDTH-1:0]         ddr2_ba_sdram;
   reg                          ddr2_ras_n_sdram;
   reg                          ddr2_cas_n_sdram;
   reg                          ddr2_we_n_sdram;
   reg [CS_WIDTH-1:0]           ddr2_cs_n_sdram;
   reg [CKE_WIDTH-1:0]          ddr2_cke_sdram;
   reg [ODT_WIDTH-1:0]          ddr2_odt_sdram;
 


   reg [ROW_WIDTH-1:0]           ddr2_address_reg;
   reg [BANK_WIDTH-1:0]          ddr2_ba_reg;
   reg [CKE_WIDTH-1:0]           ddr2_cke_reg;
   reg                           ddr2_ras_n_reg;
   reg                           ddr2_cas_n_reg;
   reg                           ddr2_we_n_reg;
   reg [CS_WIDTH-1:0]            ddr2_cs_n_reg;
   reg [ODT_WIDTH-1:0]           ddr2_odt_reg;	
 
 
 
 
 assign     ddr2_dm_fpga_0 = 'b0;













ddr2_fifo_top      # (

            .DATA_WIDTH (DATA_WIDTH),
	         .DO_WIDTH   (DO_WIDTH),	 
            .BANK_WIDTH (BANK_WIDTH),       
                                       // # of memory bank addr bits.
            .CKE_WIDTH  (CKE_WIDTH),       
                                       // # of memory clock enable outputs.
            .CLK_WIDTH  (CLK_WIDTH),       
                                       // # of clock outputs.
            .COL_WIDTH  (COL_WIDTH),       
                                       // # of memory column bits.
            .CS_NUM     (CS_NUM),       
                                       // # of separate memory chip selects.
            .CS_WIDTH   (CS_WIDTH),       
                                       // # of total memory chip selects.
            .CS_BITS    (CS_BITS),       
                                       // set to log2(CS_NUM) (rounded up).
            .DQ_WIDTH   (DQ_WIDTH),       
                                       // # of data width.
            .DQ_PER_DQS (DQ_PER_DQS),       
                                       // # of DQ data bits per strobe.
            .DQS_WIDTH  (DQS_WIDTH),       
                                       // # of DQS strobes.
            .DQ_BITS    (DQ_BITS),       
                                       // set to log2(DQS_WIDTH*DQ_PER_DQS).
            .DQS_BITS   (DQS_BITS),       
                                       // set to log2(DQS_WIDTH).
            .ODT_WIDTH  (ODT_WIDTH),       
                                       // # of memory on-die term enables.
            .ROW_WIDTH  (ROW_WIDTH),       
                                       // # of memory row and # of addr bits.
            .ADDITIVE_LAT(ADDITIVE_LAT),       
                                       // additive write latency.
            .BURST_LEN   (BURST_LEN),       
                                       // burst length (in double words).
            .BURST_TYPE  (BURST_TYPE),       
                                       // burst type (=0 seq; =1 interleaved).
            .CAS_LAT     (CAS_LAT),       
                                       // CAS latency.
            .ECC_ENABLE  (ECC_ENABLE),       
                                       // enable ECC (=1 enable).
            .APPDATA_WIDTH(APPDATA_WIDTH),       
                                       // # of usr read/write data bus bits.
            .MULTI_BANK_EN(MULTI_BANK_EN),       
                                       // Keeps multiple banks open. (= 1 enable).
            .TWO_T_TIME_EN(TWO_T_TIME_EN),       
                                       // 2t timing for unbuffered dimms.
            .ODT_TYPE      (ODT_TYPE),       
                                       // ODT (=0(none),=1(75),=2(150),=3(50)).
            .REDUCE_DRV    (REDUCE_DRV),       
                                       // reduced strength mem I/O (=1 yes).
            .REG_ENABLE    (REG_ENABLE),       
                                       // registered addr/ctrl (=1 yes).
            .TREFI_NS       (TREFI_NS),       
                                       // auto refresh interval (ns).
            .TRAS            (TRAS),       
                                       // active->precharge delay.
            .TRCD            (TRCD),       
                                       // active->read/write delay.
            .TRFC            (TRFC),       
                                       // refresh->refresh, refresh->active delay.
            .TRP             (TRP),       
                                       // precharge->command delay.
            .TRTP            (TRTP),       
                                       // read->precharge delay.
            .TWR              (TWR),       
                                       // used to determine write->precharge.
            .TWTR             (TWTR),       
                                       // write->read delay.
            .HIGH_PERFORMANCE_MODE (HIGH_PERFORMANCE_MODE),       
                              // # = TRUE, the IODELAY performance mode is set
                              // to high.
                              // # = FALSE, the IODELAY performance mode is set
                              // to low.
           .SIM_ONLY          (SIM_ONLY),       
                                       // = 1 to skip SDRAM power up delay.
           .DEBUG_EN           (DEBUG_EN),       
                                       // Enable debug signals/controls.
                                       // When this parameter is changed from 0 to 1,
                                       // make sure to uncomment the coregen commands
                                       // in ise_flow.bat or create_ise.bat files in
                                       // par folder.
           .CLK_PERIOD          (CLK_PERIOD),       
                                       // Core/Memory clock period (in ps).
           .DLL_FREQ_MODE       (DLL_FREQ_MODE),       
                                       // DCM Frequency range.
           .CLK_TYPE            (CLK_TYPE),       
                                       // # = "DIFFERENTIAL " ->; Differential input clocks ,
                                       // # = "SINGLE_ENDED" -> Single ended input clocks.
           .NOCLK200            (NOCLK200),       
                                       // clk200 enable and disable.
           .RST_ACT_LOW         (RST_ACT_LOW)        
	 
 
   )   ddr2_fifo_top  (
	
	                                                    // for  the  fifo_top_interface                                         
   // input
	          .data_in (data_in)  ,
		       .wr_clk  (wr_clk)   ,
		       .ref_clk (ref_clk)  ,         // 50M
				 .sys_clk (sys_clk)  ,
				 .clk_200 (clk_200)  ,
		       .rd_clk  (rd_clk)   ,  
		       .reset_n (reset_n)  ,
		       .wr_en   (wr_en)    ,
				 .rd_en   (rd_en)    ,
		
  // output
             .full   (full)        ,
             .almost_full(almost_full),
             .empty   (empty)      ,
             .almost_empty(almost_empty),
    
             .dout_vd(dout_vd)     ,
             .data_out(data_out)   , 
             .phy_init_done (phy_init_done),       	  
	 	
		
 // for  the  ddr2_interface
            .ddr2_dq(ddr2_dq_0),
            .ddr2_a(ddr2_a_0),
            .ddr2_ba(ddr2_ba_0),
            .ddr2_ras_n(ddr2_ras_n_0),
            .ddr2_cas_n(ddr2_cas_n_0),
            .ddr2_we_n(ddr2_we_n_0),
            .ddr2_cs_n(ddr2_cs_n_0),
            .ddr2_odt(ddr2_odt_0),
            .ddr2_cke(ddr2_cke_0),
            .ddr2_dqs(ddr2_dqs_0),
            .ddr2_dqs_n(ddr2_dqs_n_0),
            .ddr2_ck(ddr2_ck_0),
            .ddr2_ck_n(ddr2_ck_n_0)
	
		
	
	); 


   // Extra one clock pipelining for RDIMM address and
   // control signals is implemented here (Implemented external to memory model)
   always @( posedge ddr2_clk_sdram[0] ) begin
      if ( ddr2_reset_n == 1'b0 ) begin
         ddr2_ras_n_reg    <= 1'b1;
         ddr2_cas_n_reg    <= 1'b1;
         ddr2_we_n_reg     <= 1'b1;
         ddr2_cs_n_reg     <= {CS_WIDTH{1'b1}};
         ddr2_odt_reg      <= 1'b0;
      end
      else begin
         ddr2_address_reg  <= #(CLK_PERIOD_NS/2) ddr2_address_sdram;
         ddr2_ba_reg       <= #(CLK_PERIOD_NS/2) ddr2_ba_sdram;
         ddr2_ras_n_reg    <= #(CLK_PERIOD_NS/2) ddr2_ras_n_sdram;
         ddr2_cas_n_reg    <= #(CLK_PERIOD_NS/2) ddr2_cas_n_sdram;
         ddr2_we_n_reg     <= #(CLK_PERIOD_NS/2) ddr2_we_n_sdram;
         ddr2_cs_n_reg     <= #(CLK_PERIOD_NS/2) ddr2_cs_n_sdram;
         ddr2_odt_reg      <= #(CLK_PERIOD_NS/2) ddr2_odt_sdram;
      end
   end

   // to avoid tIS violations on CKE when reset is deasserted
   always @( posedge ddr2_clk_n_sdram[0] )
      if ( ddr2_reset_n == 1'b0 )
         ddr2_cke_reg      <= 1'b0;
      else
         ddr2_cke_reg      <= #(CLK_PERIOD_NS) ddr2_cke_sdram;









// =============================================================================
//                             BOARD Parameters
// =============================================================================
// These parameter values can be changed to model varying board delays
// between the Virtex-5 device and the memory model


  always @( * ) begin
    ddr2_clk_sdram        <=  #(TPROP_PCB_CTRL) ddr2_ck_0;
    ddr2_clk_n_sdram      <=  #(TPROP_PCB_CTRL) ddr2_ck_n_0;
    ddr2_address_sdram    <=  #(TPROP_PCB_CTRL) ddr2_a_0;
    ddr2_ba_sdram         <=  #(TPROP_PCB_CTRL) ddr2_ba_0;
    ddr2_ras_n_sdram      <=  #(TPROP_PCB_CTRL) ddr2_ras_n_0;
    ddr2_cas_n_sdram      <=  #(TPROP_PCB_CTRL) ddr2_cas_n_0;
    ddr2_we_n_sdram       <=  #(TPROP_PCB_CTRL) ddr2_we_n_0;
    ddr2_cs_n_sdram       <=  #(TPROP_PCB_CTRL) ddr2_cs_n_0;
    ddr2_cke_sdram        <=  #(TPROP_PCB_CTRL) ddr2_cke_0;
    ddr2_odt_sdram        <=  #(TPROP_PCB_CTRL) ddr2_odt_0;
    ddr2_dm_sdram_tmp     <=  #(TPROP_PCB_DATA) ddr2_dm_fpga_0 ;//DM signal generation
  end

  assign ddr2_dm_sdram = ddr2_dm_sdram_tmp;


// Controlling the bi-directional BUS
  genvar dqwd;
  generate
    for (dqwd = 0;dqwd < DQ_WIDTH;dqwd = dqwd+1) begin : dq_delay
      WireDelay #
       (
        .Delay_g     (TPROP_PCB_DATA),
        .Delay_rd    (TPROP_PCB_DATA_RD)
       )
      u_delay_dq
       (
        .A           (ddr2_dq_0[dqwd]),
        .B           (ddr2_dq_sdram[dqwd]),
        .reset       (reset_n)
       );
    end
  endgenerate




  genvar dqswd;
  generate
    for (dqswd = 0;dqswd < DQS_WIDTH;dqswd = dqswd+1) begin : dqs_delay
      WireDelay #
       (
        .Delay_g     (TPROP_DQS),
        .Delay_rd    (TPROP_DQS_RD)
       )
      u_delay_dqs
       (
        .A           (ddr2_dqs_0[dqswd]),
        .B           (ddr2_dqs_sdram [dqswd]),
        .reset       (reset_n)
       );

      WireDelay #
       (
        .Delay_g     (TPROP_DQS),
        .Delay_rd    (TPROP_DQS_RD)
       )
      u_delay_dqs_n
       (
        .A           (ddr2_dqs_n_0[dqswd]),
        .B           (ddr2_dqs_n_sdram[dqswd]),
        .reset       (reset_n)
       );
    end
  endgenerate












   //***************************************************************************
   // Memory model instances
   //***************************************************************************
   assign ddr2_dm_fpga = 'b0;
   genvar i, j;
   generate
      if (DEVICE_WIDTH == 16)
    		begin
         // if memory part is x16
          if ( REG_ENABLE ) 
			    begin
           // if the memory part is Registered DIMM
           for(j = 0; j < CS_NUM; j = j+1) 
			       begin : gen_cs
             for(i = 0; i < DQS_WIDTH/2; i = i+1) 
				    begin : gen
                ddr2_model u_mem0
                  (
                   .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                   .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                   .cke       (ddr2_cke_reg[j]),
                   .cs_n      (ddr2_cs_n_reg[CS_WIDTH*i/DQS_WIDTH]),
                   .ras_n     (ddr2_ras_n_reg),
                   .cas_n     (ddr2_cas_n_reg),
                   .we_n      (ddr2_we_n_reg),
                   .dm_rdqs   (ddr2_dm_sdram[(2*(i+1))-1 : i*2]),
                   .ba        (ddr2_ba_reg),
                   .addr      (ddr2_address_reg),
                   .dq        (ddr2_dq_sdram[(16*(i+1))-1 : i*16]),
                   .dqs       (ddr2_dqs_sdram[(2*(i+1))-1 : i*2]),
                   .dqs_n     (ddr2_dqs_n_sdram[(2*(i+1))-1 : i*2]),
                   .rdqs_n    (),
                   .odt       (ddr2_odt_reg[ODT_WIDTH*i/DQS_WIDTH])
                   );
             end
           end
         end
			
         else 
			
			
			   begin
             // if the memory part is component or unbuffered DIMM
              if ( DQ_WIDTH%16 )
    				  begin
              // for the memory part x16, if the data width is not multiple
              // of 16, memory models are instantiated for all data with x16
              // memory model and except for MSB data. For the MSB data
              // of 8 bits, all memory data, strobe and mask data signals are
              // replicated to make it as x16 part. For example if the design
              // is generated for data width of 72, memory model x16 parts
              // instantiated for 4 times with data ranging from 0 to 63.
              // For MSB data ranging from 64 to 71, one x16 memory model
              // by replicating the 8-bit data twice and similarly
              // the case with data mask and strobe.
              for(j = 0; j < CS_NUM; j = j+1) 
				       begin : gen_cs
                 for(i = 0; i < DQ_WIDTH/16 ; i = i+1) 
					     begin : gen
                   ddr2_model u_mem0
                     (
                      .ck        (ddr2_clk_sdram[i]),
                     .ck_n      (ddr2_clk_n_sdram[i]),
                      .cke       (ddr2_cke_sdram[j]),
                      .cs_n      (ddr2_cs_n_sdram[(j*(CS_WIDTH/CS_NUM))+i]),
                      .ras_n     (ddr2_ras_n_sdram),
                      .cas_n     (ddr2_cas_n_sdram),
                      .we_n      (ddr2_we_n_sdram),
                      .dm_rdqs   (ddr2_dm_sdram[(2*(i+1))-1 : i*2]),
                      .ba        (ddr2_ba_sdram),
                      .addr      (ddr2_address_sdram),
                      .dq        (ddr2_dq_sdram[(16*(i+1))-1 : i*16]),
                      .dqs       (ddr2_dqs_sdram[(2*(i+1))-1 : i*2]),
                      .dqs_n     (ddr2_dqs_n_sdram[(2*(i+1))-1 : i*2]),
                      .rdqs_n    (),
                      .odt       (ddr2_odt_sdram[i])
                      );
                    end
                   ddr2_model u_mem1
                     (
                      .ck        (ddr2_clk_sdram[CLK_WIDTH-1]),
                      .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH-1]),
                      .cke       (ddr2_cke_sdram[j]),
                      .cs_n      (ddr2_cs_n_sdram[CS_WIDTH-1]),
                      .ras_n     (ddr2_ras_n_sdram),
                      .cas_n     (ddr2_cas_n_sdram),
                      .we_n      (ddr2_we_n_sdram),
                      .dm_rdqs   ({ddr2_dm_sdram[DM_WIDTH - 1],
                                   ddr2_dm_sdram[DM_WIDTH - 1]}),
                      .ba        (ddr2_ba_sdram),
                      .addr      (ddr2_address_sdram),
                      .dq        ({ddr2_dq_sdram[DQ_WIDTH - 1 : DQ_WIDTH - 8],
                                   ddr2_dq_sdram[DQ_WIDTH - 1 : DQ_WIDTH - 8]}),
                      .dqs       ({ddr2_dqs_sdram[DQS_WIDTH - 1],
                                   ddr2_dqs_sdram[DQS_WIDTH - 1]}),
                      .dqs_n     ({ddr2_dqs_n_sdram[DQS_WIDTH - 1],
                                   ddr2_dqs_n_sdram[DQS_WIDTH - 1]}),
                      .rdqs_n    (),
                      .odt       (ddr2_odt_sdram[ODT_WIDTH-1])
                      );
              end
            end
            else 
				   begin
              // if the data width is multiple of 16
              for(j = 0; j < CS_NUM; j = j+1) 
				     begin : gen_cs
                for(i = 0; i < CS_WIDTH/CS_NUM; i = i+1) 
					   begin : gen
                   ddr2_model u_mem0
                     (
                      .ck        (ddr2_clk_sdram[i]),
                     .ck_n      (ddr2_clk_n_sdram[i]),
                      .cke       (ddr2_cke_sdram[j]),
                      .cs_n      (ddr2_cs_n_sdram[(j*(CS_WIDTH/CS_NUM))+i]),
                      .ras_n     (ddr2_ras_n_sdram),
                      .cas_n     (ddr2_cas_n_sdram),
                      .we_n      (ddr2_we_n_sdram),
                      .dm_rdqs   (ddr2_dm_sdram[(2*(i+1))-1 : i*2]),
                      .ba        (ddr2_ba_sdram),
                      .addr      (ddr2_address_sdram),
                      .dq        (ddr2_dq_sdram[(16*(i+1))-1 : i*16]),
                      .dqs       (ddr2_dqs_sdram[(2*(i+1))-1 : i*2]),
                      .dqs_n     (ddr2_dqs_n_sdram[(2*(i+1))-1 : i*2]),
                      .rdqs_n    (),
                      .odt       (ddr2_odt_sdram[i])
                      );
                end
              end
            end
         end

      end else
        if (DEVICE_WIDTH == 8) begin
           // if the memory part is x8
           if ( REG_ENABLE ) begin
             // if the memory part is Registered DIMM
             for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
               for(i = 0; i < DQ_WIDTH/DQ_PER_DQS; i = i+1) begin : gen
                  ddr2_model u_mem0
                    (
                     .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                     .cke       (ddr2_cke_reg[j]),
                     .cs_n      (ddr2_cs_n_reg[CS_WIDTH*i/DQS_WIDTH]),
                     .ras_n     (ddr2_ras_n_reg),
                     .cas_n     (ddr2_cas_n_reg),
                     .we_n      (ddr2_we_n_reg),
                     .dm_rdqs   (ddr2_dm_sdram[i]),
                     .ba        (ddr2_ba_reg),
                     .addr      (ddr2_address_reg),
                     .dq        (ddr2_dq_sdram[(8*(i+1))-1 : i*8]),
                     .dqs       (ddr2_dqs_sdram[i]),
                     .dqs_n     (ddr2_dqs_n_sdram[i]),
                     .rdqs_n    (),
                     .odt       (ddr2_odt_reg[ODT_WIDTH*i/DQS_WIDTH])
                     );
               end
             end
           end
           else begin
             // if the memory part is component or unbuffered DIMM
             for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
               for(i = 0; i < CS_WIDTH/CS_NUM; i = i+1) begin : gen
                  ddr2_model u_mem0
                    (
                     .ck        (ddr2_clk_sdram[i]),
                    .ck_n      (ddr2_clk_n_sdram[i]),
                     .cke       (ddr2_cke_sdram[j]),
                     .cs_n      (ddr2_cs_n_sdram[(j*(CS_WIDTH/CS_NUM))+i]),
                     .ras_n     (ddr2_ras_n_sdram),
                     .cas_n     (ddr2_cas_n_sdram),
                     .we_n      (ddr2_we_n_sdram),
                     .dm_rdqs   (ddr2_dm_sdram[i]),
                     .ba        (ddr2_ba_sdram),
                     .addr      (ddr2_address_sdram),
                     .dq        (ddr2_dq_sdram[(8*(i+1))-1 : i*8]),
                     .dqs       (ddr2_dqs_sdram[i]),
                     .dqs_n     (ddr2_dqs_n_sdram[i]),
                     .rdqs_n    (),
                     .odt       (ddr2_odt_sdram[i])
                     );
               end
             end
           end

        end else
          if (DEVICE_WIDTH == 4) begin
             // if the memory part is x4
             if ( REG_ENABLE ) begin
               // if the memory part is Registered DIMM
               for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
                  for(i = 0; i < DQS_WIDTH; i = i+1) begin : gen
                     ddr2_model u_mem0
                       (
                        .ck        (ddr2_clk_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                        .ck_n      (ddr2_clk_n_sdram[CLK_WIDTH*i/DQS_WIDTH]),
                        .cke       (ddr2_cke_reg[j]),
                        .cs_n      (ddr2_cs_n_reg[CS_WIDTH*i/DQS_WIDTH]),
                        .ras_n     (ddr2_ras_n_reg),
                        .cas_n     (ddr2_cas_n_reg),
                        .we_n      (ddr2_we_n_reg),
                        .dm_rdqs   (ddr2_dm_sdram[i]),
                        .ba        (ddr2_ba_reg),
                        .addr      (ddr2_address_reg),
                        .dq        (ddr2_dq_sdram[(4*(i+1))-1 : i*4]),
                        .dqs       (ddr2_dqs_sdram[i]),
                        .dqs_n     (ddr2_dqs_n_sdram[i]),
                        .rdqs_n    (),
                        .odt       (ddr2_odt_reg[ODT_WIDTH*i/DQS_WIDTH])
                        );
                  end
               end
             end
             else begin
               // if the memory part is component or unbuffered DIMM
               for(j = 0; j < CS_NUM; j = j+1) begin : gen_cs
                 for(i = 0; i < CS_WIDTH/CS_NUM; i = i+1) begin : gen
                    ddr2_model u_mem0
                      (
                       .ck        (ddr2_clk_sdram[i]),
                      .ck_n      (ddr2_clk_n_sdram[i]),
                       .cke       (ddr2_cke_sdram[j]),
                       .cs_n      (ddr2_cs_n_sdram[(j*(CS_WIDTH/CS_NUM))+i]),
                       .ras_n     (ddr2_ras_n_sdram),
                       .cas_n     (ddr2_cas_n_sdram),
                       .we_n      (ddr2_we_n_sdram),
                       .dm_rdqs   (ddr2_dm_sdram[i]),
                       .ba        (ddr2_ba_sdram),
                       .addr      (ddr2_address_sdram),
                       .dq        (ddr2_dq_sdram[(4*(i+1))-1 : i*4]),
                       .dqs       (ddr2_dqs_sdram[i]),
                       .dqs_n     (ddr2_dqs_n_sdram[i]),
                       .rdqs_n    (),
                       .odt       (ddr2_odt_sdram[i])
                       );
                 end
               end
             end
          end
   endgenerate













endmodule
