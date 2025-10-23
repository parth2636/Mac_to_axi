`ifndef MAC_IPV4_TEST_SVH
`define MAC_IPV4_TEST_SVH



class mac_ipv4_test extends mac_base_test;


   `uvm_component_utils(mac_ipv4_test)


    mac_ipv4_seq  seq_h;

    function new(string name = "mac_ipv4_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction


    task run_phase(uvm_phase phase);
   	 phase.raise_objection(this);
          $display("run test start");

    	// Create virtual sequence
         seq_h  = mac_ipv4_seq::type_id::create("seq_h");
         seq_h.start(env_h.mac_ag.sequencer);
         
          
         $display($time ,"after start");
          
        

    phase.drop_objection(this);
  endtask

endclass : mac_ipv4_test

`endif 



