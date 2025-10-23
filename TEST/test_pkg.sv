`ifndef TEST_PKG_SV
`define TEST_PKG_SV


package test_pkg;

 `include "uvm_macros.svh"

   import uvm_pkg::*;
     import env_pkg::*;  // Import env package which also brings AXI & MAC
    import mac_agent_pkg::*;
    import axi_agent_pkg::*;

   // Include test-related files
 `include "mac_base_test.sv"

`include "sanity_seq.svh"
`include "sanity_test.sv"




endpackage : test_pkg

`endif
