`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:32 05/06/2013 
// Design Name: 
// Module Name:    addr_gen 
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
module addr_gen  # (

       parameter        DATA_WIDTH   =  64  ,
	    parameter        WRITE_BURST  =   8  ,
       parameter        COL_WIDTH    =  10  ,
       parameter        ROW_WIDTH    =  14  ,
       parameter        BANK_WIDTH   =  2   


)(
 
 //input
 
         input                sys_clk      ,
         input                reset	       ,
         input                wr_addr_en	 ,
         input         			rd_addr_en   ,
			input                rd_en        ,

			
    
	 
 //output
 
      output reg    [30:0]         wr_addr       ,
		output reg    [2:0]           cmd          ,
		
		output  reg  [30:0]         rd_addr        ,
		output       [30:0]         af_addr        ,
		output                      af_vd          ,
		
		output                      addr_confilct
 





    );


  // RAM initialization patterns
  // NOTE: Not all bits in each range may be used (e.g. in an application
  //  using only 10 column bits, bits[11:10] of ROM output will be unused
  //  COLUMN  = [11:0]
  //  ROW     = [27:12]
  //  BANK    = [30:28]
  //  CHIP    = [31]
  //  COMMAND = [35:32]
  
  
  
  //wire 
  
  // reg
  
     reg    [30:0]                           rd_addr_reg0   ;

     reg    [30:0]                           rd_addr_reg1   ;
	  
	  reg    [30:0]                           rd_addr_reg2   ;
	  
  
     reg                                     wr_addr_en_reg0 ;
     reg                                     wr_addr_en_reg1 ;
    
     reg                                     rd_addr_en_reg0 ;
     reg                                     rd_addr_en_reg1 ;
    	 
	 
	 
	 
	 
  
  
  assign      addr_confilct    =  (rd_addr< wr_addr) ? 0: (((rd_addr==wr_addr)&&rd_en)  ? 1: 0)   ;
  assign      af_vd            =  wr_addr_en_reg0 || rd_addr_en_reg0 ;
  
  assign      af_addr          =   wr_addr_en_reg0 ? wr_addr : (rd_addr_en_reg0 ? rd_addr :af_addr ) ;
  
  
  
  
  
  
   
  
  
   
	


	
	
	

	
  
  
  
  
//        always@(*)
//		  
//		begin
//        
//       if (rd_addr< wr_addr)		
//          		 
//		  	 addr_confilct  <=  0;
//      else  if  ((rd_addr== wr_addr)&&rd_addr_en))  
//             				
//          addr_confilct  <=  1;
//			 
//	 else
//	       addr_confilct  <=  0; 
//
//       end		
		  
  
	

     always@( posedge   sys_clk   or   posedge   reset)
	  
	  begin
	        if  (reset)  
			     begin
                   wr_addr_en_reg0  <= 0 ;
						 wr_addr_en_reg1  <= 0 ; 
                   rd_addr_en_reg0  <= 0 ;
						 rd_addr_en_reg1  <= 0 ;
              end				  
			 
         else
             begin
				    wr_addr_en_reg0  <=  wr_addr_en ;
				    wr_addr_en_reg1  <= wr_addr_en_reg0 ;
					 
					 rd_addr_en_reg0  <= rd_addr_en ;
					 rd_addr_en_reg1  <= rd_addr_en_reg0;			 
				 
				 end   
	  
	  end 
	  



      always@ (posedge  sys_clk   or  posedge  reset ) 
		begin
		        if (reset)
				    cmd      <=   0;  
              else  if (wr_addr_en)	
                 cmd     <=  3'b000 ; 	
             					  
		        else if (rd_addr_en && !addr_confilct)
				   
		         cmd     <=  3'b001 ; 
			     else
				    
		         cmd     <=  3'b000 ; 
		end 


	
		
		
		
		always@( posedge  sys_clk   or  posedge  reset )
		 begin
		     if (reset)
			        begin
			   
                         wr_addr  <=   0;
         	              			 
		           end 
					  
					  
		   else
              begin
				    
              if (wr_addr_en && (WRITE_BURST==4))	
                  begin
                        wr_addr    <=   wr_addr  + 4  ;
															
                       
                       	 						  
								
                								

                  end						
					 
					 if (wr_addr_en && (WRITE_BURST==8))	
                  begin
                        wr_addr        <=   wr_addr  + 8  ;
															
                        
							             								

                  end					
					 
					 
					 			  
				  
				  end 
 
		 
	end
		
		
		



       always@( posedge  sys_clk   or  posedge   reset)

      begin
	      
			   if  (reset)
				
				 begin
				            rd_addr   <=  0;
						      
				 				 
				 end 
		 
          else
             begin
				  
				    if  (rd_addr_en && (WRITE_BURST==4)&&(!addr_confilct))
					   
						 begin
						       rd_addr   <=  rd_addr +4 ;  
						       
						 
						 end 
				  
				    if(rd_addr_en && (WRITE_BURST==8)&&(!addr_confilct)) 
					 
					   begin
						      rd_addr    <=  rd_addr +8 ;  
						      
						
						
						
						end 
				  
				  
				 				 
				 
				 end 








			 
		 
		 
	 
	 
	 
	   end














endmodule
