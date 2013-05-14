`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:51:44 05/06/2013 
// Design Name: 
// Module Name:    data_gen 
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
module data_gen   #(
 
      parameter    DATA_WIDTH  =64,
      parameter    WRITE_BURST =8		
    

   )(
	
	//input	
      input                              sys_clk ,
      input                              reset   ,
      input [DATA_WIDTH-1:0]             data_in ,		
	   input                              din_vd  ,  
	  
		
//output
     output [DATA_WIDTH-1:0]             data_out,
     output                              dout_vd  	  

     
    );




     localparam   BURST_LENGTH       =    WRITE_BURST   ;
	  localparam   HALF_WIDTH         =    DATA_WIDTH/2  ;  

     localparam   WR_IDLE_FIRST_DATA =       2'b00      ;
     localparam   WR_SECOND_DATA     =       2'b01      ;
     localparam   WR_THIRD_DATA      =       2'b10      ;
     localparam   WR_FOURTH_DATA     =       2'b11      ;
       


  //wire 
      
		

  




  // reg 

      reg    [HALF_WIDTH-1 :0]              wr_data_rise ;
		reg    [HALF_WIDTH-1 :0]              wr_data_fall ;  
      reg                                   wr_data_vd   ;		
		reg    [1:0]                          wr_state     ;


  
  //combination
  
     assign      data_out     =  {wr_data_fall ,wr_data_rise}  ;
     assign	     dout_vd      =  wr_data_vd   ;
  
  
  




     always@( posedge sys_clk)
	  
	  begin
	  
	  wr_data_vd            <=      din_vd   ;
	  
	  
	  end 






	  

   genvar  i   ;
	
	generate   
	
	   if (BURST_LENGTH ==4)  
		
		 begin
		 
		     always@(  posedge  sys_clk  or   posedge  reset ) 
            begin
				   if (reset) 
                 begin
					      wr_data_rise    <=  0;
							wr_data_fall    <=  0;
					
							wr_state        <= WR_IDLE_FIRST_DATA ;
					  
					  
					  end 
				  else 
                 begin
					    case (wr_state )
						 
						 WR_IDLE_FIRST_DATA  :    if  (din_vd) 
       
                                              begin
														      wr_data_rise   <=  data_in[HALF_WIDTH-1:0]; 
																wr_data_fall   <=  data_in[DATA_WIDTH-1:HALF_WIDTH]; 
																
																wr_state       <=  WR_SECOND_DATA;
														        														  
														     end 
                             		 
						 
						 WR_SECOND_DATA   :     if (din_vd)
						                       
													     begin
														      wr_data_rise   <=  data_in[HALF_WIDTH-1:0]; 
																wr_data_fall   <=  data_in[DATA_WIDTH-1:HALF_WIDTH]; 
																wr_state       <=   WR_IDLE_FIRST_DATA ;
														  														  
														  end 
						 
						 
						 default        :           begin
						                              wr_data_rise   <=  0; 
																wr_data_fall   <=  0; 
																wr_state       <=  WR_IDLE_FIRST_DATA ;
						 
						 
						                             end
						 
					  
					  
					  
					  endcase 
					  					  					  
					  end			
				
				end 
       			  		 
		 
		 
		end  
		
	  else if (BURST_LENGTH ==8)
	    begin
		     
           always@( posedge sys_clk   or   posedge   reset )
     
	        begin
			  
                if  (reset)  	
                         begin
						 		      wr_data_rise    <=  0;
							         wr_data_fall    <=  0;
							         wr_state        <= WR_IDLE_FIRST_DATA ;
								 
																 
								 end 

              else
                  begin
						
					   case(wr_state)	
						
						         WR_IDLE_FIRST_DATA  :    if  (din_vd) 
       
                                                    begin
														                   wr_data_rise   <=  data_in[HALF_WIDTH-1:0]; 
																             wr_data_fall   <=  data_in[DATA_WIDTH-1:HALF_WIDTH]; 
																             wr_state       <=  WR_SECOND_DATA;
														        														  
														           end 
                             		 
						 
						          WR_SECOND_DATA   :     if (din_vd)
						                       
													              begin
														                  wr_data_rise   <=  data_in[HALF_WIDTH-1:0]; 
																            wr_data_fall   <=  data_in[DATA_WIDTH-1:HALF_WIDTH]; 
																            wr_state       <=   WR_THIRD_DATA ;
														  														  
														           end 
						
						
						          WR_THIRD_DATA  :      if (din_vd)
						                       
													              begin
														                  wr_data_rise   <=  data_in[HALF_WIDTH-1:0]; 
																            wr_data_fall   <=  data_in[DATA_WIDTH-1:HALF_WIDTH]; 
																            wr_state       <=   WR_FOURTH_DATA ;
														  														  
														           end 
						
						
						          WR_FOURTH_DATA  :    if (din_vd)
						                       
													              begin
														                  wr_data_rise   <=  data_in[HALF_WIDTH-1:0]; 
																            wr_data_fall   <=  data_in[DATA_WIDTH-1:HALF_WIDTH]; 
																            wr_state       <=  WR_IDLE_FIRST_DATA  ;
														  														  
														           end   
						 						
						
						
						endcase 
						
																		
						
						end 
			  
			  
			  
			  end 

	 
		 
		 end 
	
		
	
	
	endgenerate 

















endmodule
