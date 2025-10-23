`ifndef MAC_SQR_SVH
`define MAC_SQR_SVH

`include "mac_define.svh"

class mac_sqr extends uvm_sequencer #(mac_seq_item);
  `uvm_component_utils(mac_sqr)

  function new(string name = "mac_sqr", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass

`endif // MAC_SQR_SVH

