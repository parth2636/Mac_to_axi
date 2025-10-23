`ifndef MAC_BASE_TEST_SV
`define MAC_BASE_TEST_SV
 import uvm_pkg::*;
  `include "uvm_macros.svh"


class mac_base_test extends uvm_test;
  `uvm_component_utils(mac_base_test)

  env env_h;
  axi_str_mas_config axi_cfg;
  mac_agent_config   mac_cfg;
  axi_str_mas_user_callback mas_cb;


  function new(string name = "mac_base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // ==================================================
    // ENV CREATION
    // ==================================================
    env_h = env::type_id::create("env", this);


    // ==================================================
    // AXI MASTER UVC CONFIGURATION
    // ==================================================
    axi_cfg = axi_str_mas_config::type_id::create("axi_cfg");
    axi_cfg.no_of_axis_mas = 3; 
    axi_cfg.is_active      = UVM_ACTIVE;

    uvm_config_db#(axi_str_mas_config)::set(this, "*", "m_cfg", axi_cfg);
    uvm_config_db#(axi_str_mas_config)::set(this, "*", "no_master", axi_cfg);

    // ==================================================
    // MAC UVC CONFIGURATION
    // ==================================================
    mac_cfg = mac_agent_config::type_id::create("mac_cfg");
    mac_cfg.is_active = UVM_ACTIVE;
    mac_cfg.no_of_mac_agents = 3;

    uvm_config_db#(mac_agent_config)::set(this, "*", "mac_cfg", mac_cfg);
   
      endfunction


  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // ==========================================
    // ADD CALLBACKS FOR EACH MASTER AGENT
    // ==========================================
   
    for (int i = 0; i < env_h.master_uvc.mas_config.no_of_axis_mas; i++) begin
      mas_cb = axi_str_mas_user_callback::type_id::create($sformatf("mas_cb[%0d]", i));
      uvm_callbacks#(axi_str_mas_driver, axi_str_mas_drv_callback)::add(
        env_h.master_uvc.master_agent[i].master_drv,mas_cb);
    end
  endfunction


  function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction

endclass : mac_base_test

`endif // MAC_BASE_TEST_SV

