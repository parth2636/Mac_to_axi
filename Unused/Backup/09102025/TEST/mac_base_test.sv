`ifndef MAC_BASE_TEST_SV
`define MAC_BASE_TEST_SV

class mac_base_test extends uvm_test;
   `uvm_component_utils(mac_base_test)
  
    env env_h;
  

    

   function new(string name = "mac_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction



  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

            
    env_h = env::type_id::create("env", this);
   
     
  endfunction

function void end_of_elaboration_phase(uvm_phase phase);
  super.end_of_elaboration_phase(phase);
   uvm_top.print_topology();
endfunction
 


    
endclass 

`endif // MAC_BASE_TEST_SV
