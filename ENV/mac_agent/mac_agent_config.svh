`ifndef MAC_AGENT_CONFIG_SVH
`define MAC_AGENT_CONFIG_SVH

class mac_agent_config extends uvm_object;

  // Active/passive mode for agent
  uvm_active_passive_enum is_active = UVM_ACTIVE;

  // Number of MAC agents to create in the UVC
  int no_of_mac_agents = 1;

  // Unique ID per MAC agent
  int id;



    `uvm_object_utils_begin(mac_agent_config)
  	 `uvm_field_enum(uvm_active_passive_enum, is_active, UVM_DEFAULT)
    	`uvm_field_int(no_of_mac_agents, UVM_DEFAULT)
    	`uvm_field_int(id, UVM_DEFAULT)
    `uvm_object_utils_end

  function new(string name = "mac_agent_config");
    super.new(name);
  endfunction

endclass 

`endif

