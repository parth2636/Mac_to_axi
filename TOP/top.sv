`timescale 1ns/1ps

`include "uvm_macros.svh"
import uvm_pkg::*;
import test_pkg::*;
`include "axi_str_inf.sv"

module top;

  // ----------------------------
  // Clock and reset
  // ----------------------------
  bit ACLK;
  bit ARESETn;

  // Clock generation: 100 MHz
  initial ACLK = 0;
  always #5 ACLK = ~ACLK;

  // ----------------------------
  // AXI Stream interface instances
  // ----------------------------
  axi_str_inf axi_vif0(.aclk(ACLK));
  axi_str_inf axi_vif1(.aclk(ACLK));
  axi_str_inf axi_vif2(.aclk(ACLK));

  // ----------------------------
  // Reset generation
  // ----------------------------
  initial begin
    axi_vif0.areset_n = 0;
    axi_vif1.areset_n = 0;
    axi_vif2.areset_n = 0;
    #10;
    axi_vif0.areset_n = 1;
    axi_vif1.areset_n = 1;
    axi_vif2.areset_n = 1;
  end

  // ----------------------------
  // TREADY generation
  // ----------------------------
  initial begin
    axi_vif0.tready = 0;
    axi_vif1.tready = 0;
    axi_vif2.tready = 0;
    @(posedge ACLK);
    forever begin
      
      axi_vif0.tready <= 1;
      axi_vif1.tready <= 1;
      axi_vif2.tready <= 1;
      @(posedge ACLK);
     
    end
  end

  // ----------------------------
  // Pass interface handles to UVM
  // ----------------------------
  initial begin
    // Assign interfaces to each agent's driver (master_drv)
	uvm_config_db#(virtual axi_str_inf)::set(null, "uvm_test_top.env.master_uvc.master_agent[0]", "vinf", axi_vif0);
	uvm_config_db#(virtual axi_str_inf)::set(null, "uvm_test_top.env.master_uvc.master_agent[1]", "vinf", axi_vif1);
	uvm_config_db#(virtual axi_str_inf)::set(null, "uvm_test_top.env.master_uvc.master_agent[2]", "vinf", axi_vif2);
    
    // Start UVM test
    run_test("sanity_test");
  end

endmodule

