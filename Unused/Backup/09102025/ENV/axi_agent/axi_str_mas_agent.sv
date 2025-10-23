/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_agent.sv

* Purpose : build monitor,driver,sequencer 

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_AGENT_SV
`define AXI_STR_MAS_AGENT_SV

class axi_str_mas_agent #(shortint DATA_SIZE=32, int USER_SIZE=32) extends uvm_agent; 
 
  //virtual interface 
  virtual axi_str_inf vif;
  
  //config active/passive
  axi_str_mas_config mas_cfg;
  
  axi_str_mas_driver    #(DATA_SIZE,USER_SIZE) master_drv; 
  axi_str_mas_monitor   #(DATA_SIZE,USER_SIZE) master_mon;
  axi_str_mas_sequencer #(DATA_SIZE,USER_SIZE) master_seqr;

  `uvm_component_param_utils(axi_str_mas_agent #(DATA_SIZE,USER_SIZE)) 
   
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_mas_agent", uvm_component parent=null); 
      super.new(name,parent); 
   endfunction: new 
  
   function void build_phase(uvm_phase phase);
      //get config mode
      if(!uvm_config_db #(axi_str_mas_config)::get(this,"","m_cfg",mas_cfg))
        `uvm_fatal(get_full_name(),"try again ! master agent config mode not available")
      
      if(!uvm_config_db #(virtual axi_str_inf)::get(this,"","vinf",vif))
        `uvm_fatal(get_full_name(),"try again ! master agent interface not available")
      
      if(mas_cfg.is_active == UVM_ACTIVE)
        begin
          master_drv  = axi_str_mas_driver #(DATA_SIZE,USER_SIZE) :: type_id::create("master_drv",this);
          master_seqr = axi_str_mas_sequencer #(DATA_SIZE,USER_SIZE) :: type_id::create("master_seqr",this);
        end

      master_mon = axi_str_mas_monitor #(DATA_SIZE,USER_SIZE) ::type_id::create("master_mon",this);  
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
    if(mas_cfg.is_active == UVM_ACTIVE) begin
      master_drv.seq_item_port.connect(master_seqr.seq_item_export);
      master_drv.vif = vif;
    end
    master_mon.vif = vif;
   endfunction : connect_phase
endclass : axi_str_mas_agent


`endif
