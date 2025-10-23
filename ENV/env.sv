`ifndef ENV_SV
`define ENV_SV

class env extends uvm_env;
  `uvm_component_utils(env)

  // UVC Handles
  axi_str_mas_uvc master_uvc;
  mac_agent_uvc   mac_uvc;
  mac_tx_virtual_sqr  mac_vsqr;

  function new(string name = "env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create AXI and MAC UVCs (configs come from test)
    master_uvc = axi_str_mas_uvc #(.DATA_SIZE(32), .USER_SIZE(32))::type_id::create("master_uvc", this);
    mac_uvc    = mac_agent_uvc::type_id::create("mac_uvc", this);
     mac_vsqr   =  mac_tx_virtual_sqr::type_id::create("mac_vsqr", this);

  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect MAC agents to AXI sequencer
    foreach (mac_uvc.mac_agents[i]) begin
      mac_uvc.mac_agents[i].connect_to_dut_agent(
        master_uvc.master_agent[i].master_seqr
      );
      
        // Collect MAC sequencer handles for virtual sequences
      mac_vsqr.vsqr.push_back(mac_uvc.mac_agents[i].sequencer);
    end
  endfunction

endclass : env

`endif // ENV_SV

