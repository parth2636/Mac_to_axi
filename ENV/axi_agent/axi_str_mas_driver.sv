/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_driver.sv

* Purpose : convert transsection level to pin level (sequence item to interface pin)

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_DRIVER_SV
`define AXI_STR_MAS_DRIVER_SV

class axi_str_mas_driver #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_driver #(axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE)); 
   
   //virtual interface
   virtual axi_str_inf vif;
   int i;
   byte unsigned frame_count=1;

  //factory registration
  `uvm_component_param_utils(axi_str_mas_driver #(DATA_SIZE,USER_SIZE)) 
   
   `uvm_register_cb(axi_str_mas_driver,axi_str_mas_drv_callback)
   //put transection in que
   //axi_str_mas_seq_item write_clone;
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
  function new (string name="axi_str_mas_driver", uvm_component parent=null); 
     super.new(name,parent); 
  endfunction: new 
  
  //function void build_phase(uvm_phase phase);
  //endfunction : build_phase

  virtual task run_phase(uvm_phase phase);
     

      initialize();
       
   

      wait_reset_relase();
      
    forever begin
      fork : RUN
        //thread 1
        forever begin
         
          seq_item_port.get_next_item(req);
        
          `uvm_info(get_full_name(),$sformatf("req data in driver : %0s",req.sprint()),UVM_LOW);
          drive_to_inf(req);
          seq_item_port.item_done();
        end
      join_none

      wait_reset_assert();
      disable RUN;
      wait_reset_relase();
    end
  endtask : run_phase

  task wait_reset_relase(); //wait for reset 0 to 1
    @(posedge vif.areset_n);
	initialize();
  endtask : wait_reset_relase

  task wait_reset_assert(); //wait for reset apply 1,x to 0
    @(negedge vif.areset_n);
  endtask : wait_reset_assert
  
  task initialize();
    vif.drv_cb.tvalid <= 0;
    vif.drv_cb.tdata  <= 0;
    //vif.drv_cb.tstrb  <= 0;
    vif.drv_cb.tkeep  <= 0;
    vif.drv_cb.tlast  <= 0;
  endtask : initialize

  task drive_to_inf(axi_str_mas_seq_item #(DATA_SIZE) req);
    byte unsigned n_cycle_dly;
	tvalid_drv_mode_enum tvalid_drv_mode;
	bit tvalid_q [$];
	bit tvalid_tmp;
    

	`uvm_do_callbacks(axi_str_mas_driver,axi_str_mas_drv_callback,tvalid_drv_random(frame_count,tvalid_drv_mode));  
	for(i=0;i<=req.pkt_len-1;i++) begin
      if (tvalid_drv_mode == RANDOM) begin
	    //foreach(tdata_q[i]) tvalid_q.push_back(1'b1);
	    //repeat($urandom_range(2,5)) tvalid_q.push_back(1'b0);
	    //tvalid_q.shuffle();
	    /*if (tvalid_q[i]) begin
		  while (tvalid_q[i]) begin
            vif.drv_cb.tvalid <= 1'b0;
		    @(vif.drv_cb);
			tvalid_q.delete(i);
		  end
		end*/
		do begin
		 tvalid_tmp = $urandom;
		 if (!tvalid_tmp) begin 
		   vif.drv_cb.tvalid <= 1'b0;
		   @(vif.drv_cb);
		 end
		end while(!tvalid_tmp);
	  end
	  else begin
	    `uvm_do_callbacks(axi_str_mas_driver,axi_str_mas_drv_callback,tvalid_drv_user(frame_count,i,n_cycle_dly));
        $display($time," : n_cycle_dly=%0d",n_cycle_dly);
        if(n_cycle_dly > 0)
          vif.drv_cb.tvalid <= 1'b0;
          repeat(n_cycle_dly) begin
            @(vif.drv_cb);
            n_cycle_dly = 0;
          end 
	  end
      vif.drv_cb.tvalid <= 1'b1;
      vif.drv_cb.tuser <= req.tuser;
      vif.drv_cb.tdata  <= req.tdata_q.pop_front();
      vif.drv_cb.tkeep  <= req.tkeep_q.pop_front();
      vif.drv_cb.tlast  <= 1'b0;

      if(i == req.pkt_len-1) begin
        vif.drv_cb.tlast <= 1'b1;  
      end
      
      @(posedge vif.drv_cb iff vif.drv_cb.tready);

    end
    frame_count++;
    vif.drv_cb.tlast  <= 1'b0;
    vif.drv_cb.tvalid <= 1'b0;
     
  endtask : drive_to_inf
endclass : axi_str_mas_driver


`endif
