`ifndef SANITY_SEQ_TEST_SV
`define SANITY_SEQ_TEST_SV


class sanity_test extends mac_base_test;

  `uvm_component_utils(sanity_test)

   function new(string name = "sanity_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  sanity_seq virt_seq;
 
  // Run phase: start the virtual sequence
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);

    // Create virtual sequence
        virt_seq = sanity_seq::type_id::create("virt_seq");

    // Start virtual sequence on virtual sequencer
    virt_seq.start(env_h.mac_vsqr);

    phase.drop_objection(this);
  endtask

endclass 

`endif // SANITY_SEQ_TEST_SV

