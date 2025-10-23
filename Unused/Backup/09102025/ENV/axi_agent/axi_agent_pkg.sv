`ifndef AXI_AGENT_PKG_SV
`define AXI_AGENT_PKG_SV


package axi_agent_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"


// Include all AXI agent related files
`include "axi_str_mas_define.sv"
`include "axi_str_mas_config.sv"
`include "axi_str_mas_seq_item.sv"
`include "axi_str_mas_sequencer.sv"
`include "axi_str_mas_base_sequence.sv"
`include "axi_str_mas_drv_callback.sv"

`include "axi_str_mas_driver.sv"
`include "axi_str_mas_monitor.sv"
`include "axi_str_mas_user_callback.sv"
`include "axi_str_mas_agent.sv"
`include "axi_str_mas_uvc.sv"


endpackage : axi_agent_pkg

`endif   
