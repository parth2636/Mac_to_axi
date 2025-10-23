/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_user_callback.sv

* Purpose :

* Creation Date : 09-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_USER_CALLBACK_SV
`define AXI_STR_MAS_USER_CALLBACK_SV
typedef axi_str_mas_driver; 

class axi_str_mas_user_callback extends axi_str_mas_drv_callback; 
 
  `uvm_object_utils(axi_str_mas_user_callback) 
   axi_str_mas_driver#() drv_h;
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_mas_user_callback"); 
      super.new(name); 
   endfunction: new 
   
   function void tvalid_drv_random(byte unsigned frame_count,output tvalid_drv_mode_enum tvalid_drv_mode);//, tvalid_drv_mode_enum tvalid_mode);
      //if(frame_count == 1)
	   tvalid_drv_mode = RANDOM;
   endfunction : tvalid_drv_random

   function void tvalid_drv_user(byte unsigned frame_count,beats_count,  output byte unsigned n_cycle_delay);//, tvalid_drv_mode_enum tvalid_mode);
	  //if(frame_count == 2 && beats_count == 2)
       // n_cycle_delay = 1;
      
      //$display($time," : this is master driver callback mathod of wait transfer frame_count=%0d beats_count=%0d | n_cycle_delay=%0d",frame_count,beats_count,n_cycle_delay);
   endfunction : tvalid_drv_user
endclass : axi_str_mas_user_callback


`endif
