`ifndef MAC_AGENT_UVC_SV
`define MAC_AGENT_UVC_SV

class mac_agent_uvc extends uvm_env;
  `uvm_component_utils(mac_agent_uvc)

  // Array of MAC agent configurations
  mac_agent_config mac_cfg[];
  mac_agent_config mac_config;

  // Array of MAC agents
  mac_agent mac_agents[];

  int i;

  function new(string name = "mac_agent_uvc", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Fetch configuration for UVC
    if (!uvm_config_db#(mac_agent_config)::get(this, "", "mac_cfg", mac_config))
      `uvm_fatal(get_full_name(), "MAC agent configuration not found in config DB")


    // Allocate arrays based on config
    mac_cfg    = new[mac_config.no_of_mac_agents];
    mac_agents = new[mac_config.no_of_mac_agents];

    // Create each agent + its individual config
    foreach (mac_cfg[i]) begin
      mac_cfg[i] = mac_agent_config::type_id::create($sformatf("mac_cfg[%0d]", i));
      mac_cfg[i].id = i;

      mac_agents[i] = mac_agent::type_id::create($sformatf("mac_agents[%0d]", i), this);

      // Pass config to each agent through config DB
      uvm_config_db#(mac_agent_config)::set(
        this,
        $sformatf("mac_agents[%0d]", i),
        "mac_cfg",
        mac_cfg[i]
      );
    end 

  endfunction

endclass : mac_agent_uvc

`endif

