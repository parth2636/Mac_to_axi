`ifndef MAC_TX_VIRTUAL_SQR_SV
`define MAC_TX_VIRTUAL_SQR_SV

class mac_tx_virtual_sqr extends uvm_sequencer;
  // Dynamic array of MAC sequencers
  mac_sqr vsqr[$];  

  `uvm_component_utils(mac_tx_virtual_sqr)

  function new(string name = "mac_tx_virtual_sqr", uvm_component parent = null);
    super.new(name, parent);
  endfunction

 
endclass : mac_tx_virtual_sqr

`endif // MAC_TX_VIRTUAL_SQR_SV

