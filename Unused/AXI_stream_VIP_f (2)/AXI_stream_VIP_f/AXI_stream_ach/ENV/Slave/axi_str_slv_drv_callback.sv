/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_slv_drv_callback.sv

* Purpose :

* Creation Date : 10-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_SLV_DRV_CALLBACK_SV
`define AXI_STR_SLV_DRV_CALLBACK_SV

class axi_str_slv_drv_callback extends uvm_callback; 
 
  `uvm_object_utils(axi_str_slv_drv_callback) 
   
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_slv_drv_callback"); 
      super.new(name); 
   endfunction: new 
                
   virtual function toggle_tready(byte unsigned frame_cnt, beats_cnt, output byte unsigned n_cycle_delay);
   endfunction : toggle_tready

endclass : axi_str_slv_drv_callback

`endif
