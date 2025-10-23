// mac_monitor.sv
`ifndef MAC_MONITOR_SV
`define MAC_MONITOR_SV


class mac_monitor extends uvm_component;


   
  // analysis export to receive axi_item from axi_monitor
//  uvm_analysis_imp #(axi_str_mas_seq_item,mac_monitor) analysis_export;

  // analysis port to publish mac_item to scoreboard/others
   //uvm_analysis_port #(mac_seq_item) analysis_port;

 
  `uvm_component_utils(mac_monitor)

  function new(string name = "mac_monitor", uvm_component parent = null);
    super.new(name, parent);
     endfunction

  // build_phase - create ports/exports
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  //  analysis_export = new("analysis_export", this); // will implement write()
   // analysis_port   = new("analysis_port", this);
  endfunction

  // connect_phase - usually nothing to connect inside monitor itself.
  // The environment will connect axi_monitor.analysis_port -> mac_monitor.analysis_export
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
  endfunction

  
endclass : mac_monitor

`endif // MAC_MONITOR_SV

