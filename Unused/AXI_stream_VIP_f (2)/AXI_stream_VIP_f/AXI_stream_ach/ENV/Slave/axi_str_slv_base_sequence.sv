/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_slv_base_sequence.sv

* Purpose : generate inputs according to testcase

* Creation Date : 09-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_SLV_BASE_SEQUENCE_SV
`define AXI_STR_SLV_BASE_SEQUENCE_SV

class axi_str_slv_base_sequence #(shortint DATA_SIZE=32,int USER_SIZE=32)extends uvm_sequence; 
 
  `uvm_object_param_utils(axi_str_slv_base_sequence #(DATA_SIZE,USER_SIZE))

  axi_str_slv_seq_item req;
   
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_slv_base_sequence"); 
      super.new(name); 
   endfunction: new 

   /*virtual task body();
    begin
    end
    //#200;
    
   endtask : body*/
                   
endclass : axi_str_slv_base_sequence


`endif
