/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_pkg.sv

* Purpose : all component, object and interface 

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


package axi_str_pkg;
  import uvm_pkg::*;
  `include "uvm_macros.svh"

  import axi_str_env_pkg::*;
  `include "axi_str_mas_base_sequence.sv"
  `include "axi_str_slv_base_sequence.sv"
  `include "axi_str_mas_base_test.sv"

endpackage 
