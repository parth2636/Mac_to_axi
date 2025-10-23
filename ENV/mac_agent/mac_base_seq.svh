`ifndef MAC_BASE_SEQ_SVH
`define MAC_BASE_SEQ_SVH

`include "mac_define.svh"

class mac_base_seq extends uvm_sequence #(mac_seq_item);
  
   
  mac_seq_item pkt;




  rand int no_of_pkt;
  rand bit [8*`DST_MAC_BYTES-1:0] da; // Destination address
  rand bit [8*`SRC_MAC_BYTES-1:0] sa; // Source address

  rand int unsigned min_payload;
  rand int unsigned max_payload;

 


  constraint default_c {
    soft no_of_pkt   == 5;
    soft da          == 48'hAAAA_AAAA_AAAA;
    soft sa          == 48'hBBBB_BBBB_BBBB;
    soft min_payload == `MIN_PAYLOAD;
    soft max_payload == `MAX_PAYLOAD;
  }



  function new(string name = "mac_base_seq");
    super.new(name);
  endfunction



  `uvm_object_utils_begin(mac_base_seq)
    `uvm_field_int(no_of_pkt,    UVM_ALL_ON)
    `uvm_field_int(da,           UVM_ALL_ON)
    `uvm_field_int(sa,           UVM_ALL_ON)
    `uvm_field_int(min_payload,  UVM_ALL_ON)
    `uvm_field_int(max_payload,  UVM_ALL_ON)
  `uvm_object_utils_end

   


  task body();
 
    repeat (no_of_pkt) begin
      `uvm_do_with(pkt, {
         dst_mac == da;
         src_mac == sa;
        payload.size() inside {[min_payload : max_payload]};
      })
    end
  endtask

endclass

`endif // MAC_BASE_SEQ_SVH

