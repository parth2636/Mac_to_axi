/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_top.sv

* Purpose : main module

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/

`define CYCLE 10
`timescale 1 ns / 1 ps 
`include "uvm_macros.svh"
import uvm_pkg::*;
import axi_str_pkg::*;

module axi_str_top();

  bit aclk;

  axi_str_inf inf(aclk);

  always
    #(`CYCLE/2) aclk = ~aclk;
  
  /*initial 
    begin
      inf.tready = 1'b0;
     forever begin
        @(posedge aclk iff inf.tvalid);
        inf.tready <= 1'b1;
        @(negedge inf.tvalid)
        inf.tready <= 1'b0;
     end   
    end*/

  initial 
    begin : RESET
      @(posedge aclk);
      inf.areset_n = 1'b0; //reset active assert (active low) 
      @(posedge aclk);
      inf.areset_n = 1'b1; //reset relase
    end : RESET

  initial
    begin
      uvm_top.set_report_verbosity_level(UVM_DEBUG);
      uvm_config_db #(virtual axi_str_inf)::set(null,"*","vinf",inf);
      run_test("axi_str_mas_base_test");
    end
endmodule
