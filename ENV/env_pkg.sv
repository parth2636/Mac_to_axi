`ifndef ENV_PKG_SV
`define ENV_PKG_SV


package env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"
  import axi_agent_pkg::*;
  import mac_agent_pkg::*; // Import both agent pkgs


   `include "mac_tx_virtual_sqr.sv"

  `include "mac_tx_base_virtual_seq.sv"
 

  `include "env.sv"
  

endpackage : env_pkg

`endif
