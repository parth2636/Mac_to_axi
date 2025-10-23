/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_slv_monitor.sv

* Purpose : monitor sample data convert pin level to transection level

* Creation Date : 08-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_SLV_MONITOR_SV
`define AXI_STR_SLV_MONITOR_SV

class axi_str_slv_monitor #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_monitor ; 

  //virtual interface 
  virtual axi_str_inf vif;

  `uvm_component_param_utils(axi_str_slv_monitor #(DATA_SIZE,USER_SIZE)) 
   
   axi_str_slv_seq_item #(DATA_SIZE,USER_SIZE) data_sample [$];
   int pkt_count;
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="axi_str_slv_monitor", uvm_component parent=null); 
      super.new(name,parent); 
   endfunction: new 

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
    int i;
    trans_type trans = SEQ;
    forever begin
      if(trans==SEQ) begin
        data_sample[i] = axi_str_slv_seq_item #(DATA_SIZE,USER_SIZE) ::type_id::create($sformatf("data_sample[%0d]",i));
        pkt_count=0;
      end  
      begin
        @(posedge vif.mon_cb iff vif.mon_cb.tvalid);
        if(vif.mon_cb.tready == 1'b0) begin
          $display($time," : vaild is not clear");
          @(posedge vif.mon_cb iff vif.mon_cb.tready);
        end  
        trans = NON_SEQ;
        data_sample[i].tdata_q.push_back(vif.mon_cb.tdata);
        //$display($time," : data : %0p",data_sample[i].tdata_q);
        data_sample[i].tkeep_q.push_back(vif.mon_cb.tkeep);
        pkt_count++;
        data_sample[i].pkt_len = pkt_count;
        data_sample[i].tuser = vif.mon_cb.tuser;
      end 

      if(vif.mon_cb.tlast) begin
        `uvm_info("COLLECT_PKT",$sformatf("data monitoring is : %0s",data_sample[i].sprint()),UVM_DEBUG);
        i++;
        trans = SEQ;
      end
    end
   endtask : sample_data

endclass : axi_str_slv_monitor


`endif
