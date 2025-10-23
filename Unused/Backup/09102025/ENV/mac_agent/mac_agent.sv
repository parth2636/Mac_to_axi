`ifndef MAC_AGENT_SV
`define MAC_AGENT_SV

class mac_agent extends uvm_agent;
  `uvm_component_utils(mac_agent)

  // Components
  mac_sqr              sequencer;     // upstream sequencer providing mac_seq_item
  mac_to_axi_seq       conv_seq;      // conversion sequence
  mac_monitor          mac_mon;				      

  // Take UVM_SQR for point to mai AXI_SQR which conneted to dut through driver
  uvm_sequencer #(axi_str_mas_seq_item) axi_seqr;
 

  function new(string name, uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create the upstream sequencer
    sequencer = mac_sqr::type_id::create("sequencer", this);

   // Create the conversion sequence
    mac_mon = mac_monitor::type_id::create("mac_mon",this);

  endfunction

  virtual task run_phase(uvm_phase phase);
    // Create the conversion sequence
    conv_seq = mac_to_axi_seq::type_id::create("conv_seq");
   $display("after create conv_h");

    // Connect the conversion sequence to upstream sequencer
    conv_seq.up_seqr = this.sequencer;
   $display("after conneted sequencer");

    // Start the conversion sequence on the AXI sequencer so it drives DUT
    conv_seq.start(axi_seqr);
    $display("start cov_h");
  endtask


	 function void connect_to_dut_agent(uvm_sequencer #(axi_str_mas_seq_item) axi_mas_seqr);
		this.axi_seqr = axi_mas_seqr;
                //$display("Point to axi_agent sqr");
         endfunction : connect_to_dut_agent
   
   
endclass

`endif // MAC_AGENT_SV

