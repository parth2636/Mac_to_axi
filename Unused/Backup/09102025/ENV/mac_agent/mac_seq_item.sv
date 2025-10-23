`ifndef MAC_SEQ_ITEM_SV
`define MAC_SEQ_ITEM_SV

`include "mac_define.svh"

class mac_seq_item extends uvm_sequence_item;

  // Ethernet Header Fields
  rand bit [8*`DST_MAC_BYTES-1:0] dst_mac;
  rand bit [8*`SRC_MAC_BYTES-1:0] src_mac;

  rand bit [`VLAN_ID_BITS-1:0] vlan_id;
  rand bit [`PCP_BITS-1:0]  pcp;
  rand bit [`DEI_BITS-1:0]  dei;

  rand bit [8*`ETH_TYPE_BYTES-1:0] eth_type;

  // Payload + FCS
  rand byte payload[];
  rand bit [8*`FCS_BYTES-1:0] fcs;

  // Payload size constraint
  constraint payload_c {
    payload.size() inside {[`MIN_PAYLOAD:`MAX_PAYLOAD]};
  }

  function new(string name="mac_seq_item");
    super.new(name);
  endfunction

  // UVM field macros
  `uvm_object_utils_begin(mac_seq_item)
    `uvm_field_int(dst_mac, UVM_HEX | UVM_ALL_ON)
    `uvm_field_int(src_mac, UVM_HEX | UVM_ALL_ON)
    `uvm_field_int(vlan_id, UVM_DEC | UVM_ALL_ON)
    `uvm_field_int(pcp, UVM_DEC | UVM_ALL_ON)
    `uvm_field_int(dei, UVM_DEC | UVM_ALL_ON)
    `uvm_field_int(eth_type, UVM_HEX | UVM_ALL_ON)
    `uvm_field_array_int(payload, UVM_HEX | UVM_ALL_ON)
    `uvm_field_int(fcs, UVM_HEX | UVM_ALL_ON)
  `uvm_object_utils_end




   

endclass

`endif // MAC_SEQ_ITEM_SV

