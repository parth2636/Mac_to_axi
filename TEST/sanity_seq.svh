`ifndef SANITY_SEQ_SVH
`define SANITY_SEQ_SVH


class sanity_seq extends mac_tx_base_virtual_seq;

  `uvm_object_utils(sanity_seq)

   mac_base_seq max_tx_seqs[3];

  function new(string name = "sanity_seq");
    super.new(name);
  endfunction

task body();

  `uvm_info(get_type_name(), "Starting Sanity Virtual Sequence", UVM_LOW)

  fork
    `uvm_do_on_with(max_tx_seqs[0], p_sequencer.vsqr[0], {
      no_of_pkt   == 1;
      min_payload == 100;
      max_payload == 250;
      da          == 48'h010203040506;
      sa          == 48'h0A0B0C0D0E0F;
    });

    `uvm_do_on_with(max_tx_seqs[1], p_sequencer.vsqr[1], {
      no_of_pkt   == 1;
      min_payload == 100;
      max_payload == 150;
      da          == 48'h010203040506;
      sa          == 48'h0A0B0C0D0E0F;
    });

    `uvm_do_on_with(max_tx_seqs[2], p_sequencer.vsqr[2], {
      no_of_pkt   == 1;
      min_payload == 64;
      max_payload == 128;
      da          == 48'hDEADBEEFCAFE;
      sa          == 48'hFACEB00C1234;
    });
  join

  `uvm_info(get_type_name(), "Completed Sanity Virtual Sequence", UVM_LOW)

endtask
 
endclass 

`endif // SANITY_SEQ_SV

