/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_env_pkg.sv

* Purpose : make package of file

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


//`ifndef _SV
//`define
`include "axi_str_inf.sv"
package axi_str_env_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

//master components
  `include "axi_str_mas_define.sv"
  `include "axi_str_mas_seq_item.sv"
  `include "axi_str_mas_sequencer.sv"
  `include "axi_str_mas_drv_callback.sv"
  `include "axi_str_mas_user_callback.sv"
  `include "axi_str_mas_driver.sv"
  `include "axi_str_mas_monitor.sv"
  `include "axi_str_mas_config.sv"
  `include "axi_str_mas_agent.sv"
  `include "axi_str_mas_uvc.sv"

//slave components
  `include "axi_str_slv_seq_item.sv"
  `include "axi_str_slv_sequencer.sv"
  `include "axi_str_slv_drv_callback.sv"
  `include "axi_str_slv_user_callback.sv"
  `include "axi_str_slv_driver.sv"
  `include "axi_str_slv_monitor.sv"
  `include "axi_str_slv_config.sv"
  `include "axi_str_slv_agent.sv"
  `include "axi_str_slv_uvc.sv"

endpackage

//`endif
