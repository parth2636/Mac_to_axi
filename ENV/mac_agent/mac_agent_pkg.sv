`ifndef MAC_AGENT_PKG_SV
`define MAC_AGENT_PKG_SV



package mac_agent_pkg;

    import uvm_pkg::*;
  `include "uvm_macros.svh"
  import axi_agent_pkg::*;


// Include all MAC agent related files

`include "mac_define.svh"
`include "mac_seq_item.sv"
`include "mac_sqr.sv"

`include "mac_base_seq.svh"
`include "mac_to_axi_seq.svh"

`include "mac_monitor.sv"
`include "mac_agent_config.svh"

`include "mac_agent.sv"

`include "mac_agent_uvc.svh"


endpackage : mac_agent_pkg

`endif   
