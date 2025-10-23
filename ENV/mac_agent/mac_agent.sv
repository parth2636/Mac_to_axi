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
   mac_agent_config mac_cfg;

  function new(string name, uvm_component parent=null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

      if (!uvm_config_db#(mac_agent_config)::get(this, "", "mac_cfg", mac_cfg))
      `uvm_fatal(get_full_name(), "MAC agent configuration not found in config DB")

    
   // Create the conversion sequence
    mac_mon = mac_monitor::type_id::create("mac_mon",this);

    if (mac_cfg.is_active == UVM_ACTIVE) begin
      sequencer = mac_sqr::type_id::create("sequencer", this);
      conv_seq  = mac_to_axi_seq::type_id::create("conv_seq", this);
    end

  endfunction



 virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    if (mac_cfg.is_active == UVM_ACTIVE) begin
      // Connect upstream sequencer to conversion sequence
      conv_seq.up_seqr = this.sequencer;

      
        end
  endfunction

    task run_phase(uvm_phase phase);
   
   
    // Start the conversion sequence on the AXI sequencer so it drives DUT
   if (mac_cfg.is_active == UVM_ACTIVE) begin
      `uvm_info(get_type_name(), "Starting MAC?AXI conversion sequence", UVM_MEDIUM)
      conv_seq.start(axi_seqr);
      `uvm_info(get_type_name(), "MAC?AXI conversion sequence completed", UVM_LOW)
    end
    else begin
      `uvm_info(get_type_name(), "MAC agent is passive so no sequence started", UVM_LOW)
    end

  endtask


	 function void connect_to_dut_agent(uvm_sequencer #(axi_str_mas_seq_item) axi_mas_seqr);
		this.axi_seqr = axi_mas_seqr;
                //$display("Point to axi_agent sqr");
         endfunction : connect_to_dut_agent
   
   
endclass

`endif // MAC_AGENT_SV

