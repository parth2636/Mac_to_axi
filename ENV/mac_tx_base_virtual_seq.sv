`ifndef MAC_TX_BASE_VIRTUAL_SEQ_SV
`define MAC_TX_BASE_VIRTUAL_SEQ_SV

class mac_tx_base_virtual_seq extends uvm_sequence #(uvm_sequence_item);

 
  // Reference to virtual sequencer
  `uvm_declare_p_sequencer(mac_tx_virtual_sqr)

  `uvm_object_utils(mac_tx_base_virtual_seq)

  function new(string name = "mac_tx_base_virtual_seq");
    super.new(name);
  endfunction

  
endclass : mac_tx_base_virtual_seq

`endif // MAC_TX_VIRTUAL_SEQ_SV

