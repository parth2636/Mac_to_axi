/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_monitor.sv

* Purpose : activity connvert pin level to transection level (sampling data) 

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_MONITOR_SV
`define AXI_STR_MAS_MONITOR_SV

class axi_str_mas_monitor #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_monitor ; 
 
  //virtual interface 
  virtual axi_str_inf vif;

  //factory registration
  `uvm_component_param_utils(axi_str_mas_monitor #(DATA_SIZE,USER_SIZE)) 
  
  uvm_analysis_port #(axi_str_mas_seq_item) item_collected_port;
   
  axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE) data_sample[$];
  int pkt_len;
  realtime pkt_end_time_ps, pkt_end_time_prev_ps, pkt_end_time_diff_ps;
  realtime pkt_start_time_ps, pkt_start_time_prev_ps, pkt_start_time_diff_ps;
  
   //-------------------------------------------------------------------------------- 
   // Method : 
      
   // Arguments : 
        
   // Description : 
          
   //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_mas_monitor", uvm_component parent=null); 
      super.new(name,parent); 
	  item_collected_port=new("item_collected_port",this);
   endfunction: new 
 
   function void build_phase(uvm_phase phase);
    //data_sample = axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE) ::type_id::create("data_sample");
   endfunction : build_phase

   task run_phase(uvm_phase phase);
    wait_reset_relase();
    forever begin
      fork : MONITOR
        
        //thread 1
        begin
          sample_data();
        end
      join_none
      
      wait_reset_assert();
      disable MONITOR;
      wait_reset_relase();
    end
   endtask : run_phase

   task wait_reset_relase(); //wait for reset 0 to 1
      @(posedge vif.areset_n);
   endtask : wait_reset_relase

   task wait_reset_assert(); //wait for reset apply 1,x to 0
      @(negedge vif.areset_n);
   endtask : wait_reset_assert
   
   task sample_data();
    int itr=0,itr_prev=-1;
    trans_type trans = SEQ;
    forever begin
      if(trans==SEQ) begin
        data_sample[itr] = axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE) ::type_id::create($sformatf("data_sample[%0d]",itr));
        pkt_len=0;
      end  
      @(posedge vif.mon_cb iff vif.mon_cb.tvalid);
      if(vif.mon_cb.tready == 1'b0) begin
        @(posedge vif.mon_cb iff vif.mon_cb.tready);
      end  
	  start_time_calc(itr,itr_prev);
      trans = NON_SEQ;
      data_sample[itr].tdata_q.push_back(vif.mon_cb.tdata*{8{vif.mon_cb.tkeep}});
      //$display($time," : data : %0p",data_sample[itr].tdata_q);
      data_sample[itr].tkeep_q.push_back(vif.mon_cb.tkeep);
      pkt_len++;
      data_sample[itr].pkt_len = pkt_len;
      data_sample[itr].tuser = vif.mon_cb.tuser;
	  itr_prev=itr;

      if (vif.mon_cb.tlast) begin
		end_time_calc(itr);
		item_collected_port.write(data_sample[itr]);
		`uvm_info("COLLECT_PKT",$sformatf("data monitoring is : %0s",data_sample[itr].sprint()),UVM_DEBUG);
		itr++;
        trans = SEQ;
	  end
    end
   endtask : sample_data
 
    function void start_time_calc(int itr, int itr_prev);
	  if (itr_prev != itr) begin
	    pkt_start_time_ps=$realtime/1ps;
        pkt_start_time_diff_ps = pkt_start_time_ps - pkt_start_time_prev_ps;
		data_sample[itr].pkt_start_time_ps=pkt_start_time_ps;
		`uvm_info("COLLECT_PKT_TIME",$sformatf(" : pkt_start_time_ps =%0f, pkt_start_time_prev_ps = %0f, pkt_start_time_diff_ps = %0f",pkt_start_time_ps,pkt_start_time_prev_ps,pkt_start_time_diff_ps), UVM_DEBUG)
        pkt_start_time_prev_ps=pkt_start_time_ps;
	  end
	endfunction
	
    function void end_time_calc(int itr);
	  pkt_end_time_ps=$realtime/1ps;
      pkt_end_time_diff_ps = pkt_end_time_ps - pkt_end_time_prev_ps;
      data_sample[itr].pkt_end_time_ps=pkt_end_time_ps;
      data_sample[itr].pkt_num=itr+1;
	  `uvm_info("COLLECT_PKT_TIME",$sformatf(" : pkt_end_time_ps =%0f, pkt_end_time_prev_ps = %0f, pkt_end_time_diff_ps = %0f",pkt_end_time_ps,pkt_end_time_prev_ps,pkt_end_time_diff_ps), UVM_DEBUG)
      pkt_end_time_prev_ps=pkt_end_time_ps;
	endfunction

endclass : axi_str_mas_monitor


`endif
