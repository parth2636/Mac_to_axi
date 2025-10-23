`ifndef ENV_PKG_SV
`define ENV_PKG_SV


package env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import axi_agent_pkg::*;
  import mac_agent_pkg::*; // Import both agent pkgs


  `include "env.sv"


endpackage : env_pkg

`endif
