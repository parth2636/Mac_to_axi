`ifndef ENV_SV
`define ENV_SV
  import uvm_pkg::*;
 `include "uvm_macros.svh"

class env extends uvm_env;


  `uvm_component_utils(env)   

  // Agents
  mac_agent       mac_ag;       
  axi_str_mas_agent axi_ag;
     axi_str_mas_uvc master_uvc;
     axi_str_mas_config cfg;
     axi_str_mas_user_callback mas_callback_1;

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // ------------------------------
      // 1. Set configuration before env creation
      // ------------------------------
      master_uvc = axi_str_mas_uvc #(.DATA_SIZE(32),.USER_SIZE(32)) ::type_id::create("master_uvc",this);
      cfg = axi_str_mas_config::type_id::create("cfg");
      cfg.no_of_axis_mas = 1;  // Example: 2 AXI masters
      uvm_config_db #(axi_str_mas_config)::set(this, "*", "no_master", cfg);
      uvm_config_db #(axi_str_mas_config)::set(this, "*", "m_cfg", cfg);

      mas_callback_1 = axi_str_mas_user_callback::type_id::create("mas_callback_1");
    

    // Create MAC agent
    mac_ag = mac_agent::type_id::create("mac_ag", this);

    // Create AXI agent
 //   axi_ag = axi_str_mas_agent #(32,32)::type_id::create("axi_ag", this);

  
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
     uvm_callbacks#(axi_str_mas_driver, axi_str_mas_drv_callback)::add(master_uvc.master_agent[0].master_drv, mas_callback_1);

    mac_ag.connect_to_dut_agent(master_uvc.master_agent[0].master_seqr);  
 //   mac_ag.mac_mon.analysis_export.connect(axi_ag.master_mon.item_collected_port);
 


  endfunction 

endclass : env

`endif // ENV_SV

