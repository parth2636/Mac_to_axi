`ifndef MAC_BASE_SEQ_SVH
`define MAC_BASE_SEQ_SVH

`include "mac_define.svh"

class mac_base_seq extends uvm_sequence #(mac_seq_item);

  // -------------------
  // Transaction handle
  // -------------------
  mac_seq_item pkt;

   rand int no_of_pkt;
   rand bit [8*`DST_MAC_BYTES-1:0] dst_mac;
   rand bit [8*`SRC_MAC_BYTES-1:0] src_mac;



    function new(string name="mac_base_seq");
    super.new(name);
  endfunction

   // Soft constraint for default value
    constraint { no_of_pkt== 5; }
    constraint { dst_mac == 101010; src_mac == 101010;}







    

   `uvm_object_utils_begin(mac_base_seq)
     `uvm_field_int(no_of_pkt, UVM_ALL_ON | UVM_UNSIGNED)
     `uvm_field_int(dst_mac, UVM_ALL_ON | UVM_UNSIGNED)
     `uvm_field_int(src_mac, UVM_ALL_ON | UVM_UNSIGNED)
    `uvm_object_utils_end

   

 virtual task body();
    repeat (trans_cnt) begin
     `uvm_do(pkt)
     end
  endtask

endclass

`endif // MAC_BASE_SEQ_SVH

