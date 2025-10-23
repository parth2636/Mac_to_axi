/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_slv_driver.sv

* Purpose : driver singals convert from transection level to pin level

* Creation Date : 08-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_SLV_DRIVER_SV
`define AXI_STR_SLV_DRIVER_SV

class axi_str_slv_driver #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_driver #(axi_str_slv_seq_item #(DATA_SIZE,USER_SIZE));
   //virtual interface
   virtual axi_str_inf vif;
   byte unsigned frame_cnt=1;
   int i;
  //factory registration
  `uvm_component_param_utils(axi_str_slv_driver #(DATA_SIZE,USER_SIZE)) 
   
   `uvm_register_cb(axi_str_mas_driver,axi_str_slv_drv_callback)
   
   //put transection in que
   //axi_str_mas_seq_item write_clone;
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
  function new (string name="axi_str_slv_driver", uvm_component parent=null); 
     super.new(name,parent); 
  endfunction: new   

  virtual task run_phase(uvm_phase phase);
    initialize();
    wait_reset_relase();
    forever begin
      fork : RESET
          driver_rx();
      join_none
      wait_reset_assert();
      disable RESET;
      wait_reset_relase();
    end   
  endtask : run_phase

  task wait_reset_relase(); //wait for reset 0 to 1
    @(posedge vif.areset_n);
  endtask : wait_reset_relase

  task wait_reset_assert(); //wait for reset apply 1,x to 0
    @(negedge vif.areset_n);
  endtask : wait_reset_assert

  task initialize();
    vif.slv_drv_cb.tready <= 1'b0;
  endtask : initialize

  task driver_rx();
    byte unsigned n_cycle_delay;
    forever begin
     do begin
      @(posedge vif.slv_drv_cb iff vif.slv_drv_cb.tvalid);
     // fork : DRIVE_TREADY
        begin
          `uvm_do_callbacks(axi_str_slv_driver,axi_str_slv_drv_callback,toggle_tready(frame_cnt,i,n_cycle_delay));
          if(n_cycle_delay > 0) begin
            vif.slv_drv_cb.tready <= 1'b0;
            repeat(n_cycle_delay) @(vif.slv_drv_cb);
          end
          vif.slv_drv_cb.tready <= 1'b1;
          i++;
         // $display($time, " : pkt size in  slave i = %0d",i);
        end
     // join_none
      //@(negedge vif.slv_drv_cb.tvalid);
     // initialize();
     // disable DRIVE_TREADY;
    end while(!vif.slv_drv_cb.tlast);
   // $display($time," : TLAST is asserted");
       fork begin
         @(vif.slv_drv_cb);
         if (!vif.slv_drv_cb.tvalid)
           vif.slv_drv_cb.tready <= 1'b0;
       end join_none
       //if(vif.slv_drv_cb.tlast)
        frame_cnt++;
    end
  endtask : driver_rx

endclass : axi_str_slv_driver
`endif
