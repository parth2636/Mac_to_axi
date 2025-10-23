/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_slv_user_callback.sv

* Purpose : override method of driver callback

* Creation Date : 10-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_SLV_USER_CALLBACK_SV
`define AXI_STR_SLV_USER_CALLBACK_SV

class axi_str_slv_user_callback extends axi_str_slv_drv_callback; 
 
  `uvm_object_utils(axi_str_slv_user_callback) 
   
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_slv_user_callback"); 
      super.new(name); 
   endfunction: new 
                   
   function toggle_tready(byte unsigned frame_cnt,beats_cnt, output byte unsigned n_cycle_delay);
      if(frame_cnt == 1 && beats_cnt == 2)
        n_cycle_delay = 1;
      $display($time," : this is slave driver callback of slave tready toggle : frame_cnt=%0d | beats_cnt=%0d | n_cycle_delay=%0d",frame_cnt,beats_cnt,n_cycle_delay);
   endfunction : toggle_tready

endclass : axi_str_slv_user_callback

`endif
