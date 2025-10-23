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

  // Reset generation
  initial begin
     axi_vif.areset_n = 0;
    #10;
    axi_vif.areset_n = 1;
  end

  initial begin
    axi_vif.tready = 0;  // initialize
    @(posedge axi_vif.aclk);
    forever begin
      axi_vif.tready <= 1;
      @(posedge axi_vif.aclk);
    end
  end


  // ----------------------------
  // AXI Stream interface instance
  // ----------------------------
  axi_str_inf axi_vif(.aclk(ACLK));

  // Connect reset from TB to interface
/*  initial begin
    axi_vif.areset_n = ARESETn;
  end
*/
    initial begin

      // Pass the interface handle to UVM via config DB
    uvm_config_db#(virtual axi_str_inf)::set(null, "*", "vinf", axi_vif);

    // Start UVM test
    run_test("mac_ipv4_test");
  end

endmodule

