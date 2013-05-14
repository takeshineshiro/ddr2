`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:16:03 05/06/2013 
// Design Name: 
// Module Name:    cmd_gen 
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
module cmd_gen   # (
 
       parameter         DATA_WIDTH   =  64 ,
       parameter         WRITE_BURST  = 8		 
    

   )(
	  
//input
          input                 sys_clk ,
          input                 reset   ,
          input                 din_vd  ,
			 input  [9:0]          rd_data_count,
			 input  [9:0]          wr_data_count,
          input           		  almost_full,
          input                 almost_empty,
			 input                 prog_full  ,
          input                 prog_empty ,
 			 input                 phy_init_done,
			 input                 app_wdf_afull,
          input                 app_af_afull,
          input                  rd_en,
			 input                  addr_confilct,
			 
   
 //output
         output  reg             wr_fifo_rd ,
		   output  reg             wr_addr_en ,
			output  reg             rd_addr_en
			
			
		
			
   
	
	
	
	
    );
	 
	 
	 
	 
	 
	 
	  localparam         [3:0]   
	                       IDLE        =  4'b0000        ,
                          WAIT_0      =  4'b0001        ,
                          FIFO_RD     =  4'b0010        ,
                          WR_DDR      =  4'b0011        ,
								  DDR_BUF     =  4'b0100        ,
                          RD_DDR      =  4'b0101        ,
                          WAIT_FIFO_4 =  4'b0110        ,
                          WAIT_FIFO_8 =  4'b0111        ;


  								  
    localparam      BURST_LEN_DIV2    =   WRITE_BURST/2  ;
	 




	  
	  
	 
	 
	 
	 //wire
	 
	   wire                                     app_wdf_not_afull  ;
      wire	                                   app_af_not_afull	;
		
	 
	 
	 
	 //reg
	      
	    reg      [3:0]                           cur_state ,  next_state   ;
		 
		 reg      [4:0]                           burst_cnt                 ;
		 
		 reg      [7:0]                           delay_cnt                 ;
     
       reg                                       delay_done               ;	
  
       reg                                       wr_addr_en_reg           ;
		 
	 //combination
	 
	 assign      app_wdf_not_afull                 = ~app_wdf_afull ;
    assign      app_af_not_afull                  = ~app_af_afull  ;
    
	 
	 
	 
	 //seq
	 
	 
	 
	 
	   always@( posedge  sys_clk   or   posedge  reset  )
		
		begin
		      if  ( reset)
				
				   cur_state   <=    IDLE         ;
			  else
			    
			     cur_state   <=     next_state   ;  
		
		
		
		end 
	 
	 
	 
	   always@(*)
		
		begin
		 
		        next_state   <=  IDLE    ;
			 
		   case (cur_state)	
			
			    IDLE     :   
				            if (app_wdf_not_afull&&app_af_not_afull&&phy_init_done)
								     
									 next_state   <=  WAIT_0   ;
                         else
                           next_state   <= next_state ;
									
			
			
			
			WAIT_0    :
			               

                            if (!prog_empty)
									   
										 next_state     <=  FIFO_RD    ; 
								
								   else  if  (rd_en && !addr_confilct)

								
						
						             next_state     <= RD_DDR        ;
								                      
									                       
                            else
                               next_state     <=  next_state  ;
								 
								 
								 
								 
								 
        FIFO_RD   :  
		  
		                 if (prog_empty)
							  
							      next_state     <=   WAIT_0      ;
							    
		                 else  if (burst_cnt==1)
							     
							     next_state     <=   WAIT_0      ;
								
								else
								
								  next_state     <=  next_state  ; 
								  
								  
//								  
//                   if  ( !almost_empty &&(burst_cnt==1) )
//						 
//						      next_state     <=  WR_DDR      ;
//                   else
//                       						 
//						      next_state     <=  next_state  ; 
						      
						     
						 
   

								
								
								
								
//WR_DDR     :    
//                if  (rd_en && !addr_confilct)
//					 
//					     next_state     <= DDR_BUF        ;
//
//
//               else  
//					 
//					    next_state     <=   WAIT_0        ;



DDR_BUF  :

                if  ( delay_done)
					 
					next_state     <=   RD_DDR       ; 
					
					
					else
					
					 next_state     <=   next_state   ; 
					 




RD_DDR   :
                  
				    
	     
				  next_state     <=    WAIT_0           ;  
     
		  
				  



default  :
     
	       next_state     <=          IDLE         ;
			 
			 
			 
endcase


end 




     always@( posedge  sys_clk  or  posedge reset)
	 
	 begin
	   
		  if  (reset)
		   
			  wr_addr_en   <=   0;
			  
		else
		    
			wr_addr_en   <=   wr_addr_en_reg ;
		   
	 
 
	 end 






   always@ (posedge    sys_clk   or  posedge  reset)
	
	begin
	   
	     if  ( reset)  
            
				begin
                          burst_cnt         <=     0;
                          wr_fifo_rd        <=     0;
								  wr_addr_en_reg    <=     0 ;
								  rd_addr_en        <=     0 ;
			   end 

      else  if  ( (cur_state == 	FIFO_RD)&& app_wdf_not_afull && app_af_not_afull )   
      	
           begin
			  
            wr_fifo_rd   <=  1'b1  ;
				
				 if ( burst_cnt ==0) 
				 
				    begin
					        burst_cnt          <= BURST_LEN_DIV2/2 ;
                       wr_addr_en_reg     <= 1;                
					 					 
					 end 
				 else
				     begin
					  burst_cnt          <= burst_cnt - 1; 
				  	  wr_addr_en_reg     <= 0;	 
                 end 
          end 
         
       else  if  ((cur_state == RD_DDR) && app_af_not_afull ) 
		 
		    begin
			    
			     rd_addr_en    <=  1'b1  ;
					 
			 end 
		 
		 
		 		  
	
	end 






  always@( posedge sys_clk  or  posedge   reset)


  begin
        if (reset) 
          
        begin
		     delay_cnt              <=     0  ;
			  delay_done             <=     0  ;
		  end 

	   else  if (cur_state== DDR_BUF) 
        begin
         if (delay_cnt >=6)
			  begin
			     delay_cnt       <= 0;
				  delay_done      <= 1'b1 ;
			  
			  end
			 else
			   begin
				 delay_cnt            <= delay_cnt + 1 ;
				 delay_done           <=  1'b0  ;				
				end 


        end 		  
          
  
  end 










						

               
					

         								

	
  
  
                      
                          								
                         							  
					          
					
					
			
			
			
			
			
			
			
			
		  
		
		
		
		
		
		
		
		
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 


endmodule
