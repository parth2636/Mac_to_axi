/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_drv_callback.sv

* Purpose : overite driver mathod (for wait transfer)

* Creation Date : 08-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_DRV_CALLBACK_SV
`define AXI_STR_MAS_DRV_CALLBACK_SV

class axi_str_mas_drv_callback extends uvm_callback; 
 
  `uvm_object_utils(axi_str_mas_drv_callback); 
   
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_mas_drv_callback"); 
      super.new(name); 
   endfunction: new 
   
   virtual function void tvalid_drv_random(byte unsigned frame_count,output tvalid_drv_mode_enum tvalid_drv_mode);//, tvalid_drv_mode_enum tvalid_mode);
   endfunction : tvalid_drv_random

   virtual function void tvalid_drv_user(byte unsigned frame_count,beats_count, output byte unsigned n_cycle_delay);
      //$display($time, " : this is driver call back wait transfer trans_count=%0d | n_cycle_delay=%0d",trans_count,n_cycle_delay);
   endfunction : tvalid_drv_user
   
endclass : axi_str_mas_drv_callback

`endif
