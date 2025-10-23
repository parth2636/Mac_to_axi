/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_slv_seq_item.sv

* Purpose : transection class

* Creation Date : 08-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_SLV_SEQ_ITEM_SV
`define AXI_STR_SLV_SEQ_ITEM_SV

class axi_str_slv_seq_item #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_sequence_item; 
 
   //rand transfer_type trans;

 rand shortint unsigned total_bytes;
 rand shortint unsigned no_of_bytes;
 rand bit [(USER_SIZE-1):0] tuser;
 rand bit [(DATA_SIZE-1):0] tdata_q [$];
 bit [((DATA_SIZE/8)-1):0] tkeep_q [$];
 int pkt_len;
  

  `uvm_object_param_utils_begin(axi_str_slv_seq_item #(DATA_SIZE,USER_SIZE))
    `uvm_field_int(total_bytes,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(no_of_bytes,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(pkt_len,UVM_ALL_ON | UVM_DEC)
    `uvm_field_queue_int(tdata_q,UVM_ALL_ON | UVM_HEX)
    `uvm_field_queue_int(tkeep_q,UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(tuser,UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end

  //`uvm_object_utils_end

    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_slv_seq_item"); 
      super.new(name); 
   endfunction: new 
                   
endclass : axi_str_slv_seq_item


`endif
