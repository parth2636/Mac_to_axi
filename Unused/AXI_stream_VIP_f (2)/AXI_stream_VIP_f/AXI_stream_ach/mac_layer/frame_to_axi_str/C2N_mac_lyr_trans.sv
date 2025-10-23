/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : C2N_mac_lyr_trans.sv

* Purpose : convert ethernet frame to axi stream

* Creation Date : 10-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef C2N_MAC_LYR_TRANS_SV
`define C2N_MAC_LYR_TRANS_SV

class c2n_mac_lyr_trans extends uvm_object; 
 
 	rand bit [7:0] da_addr [0:5];
	rand bit [7:0] sa_addr [0:5];
	rand bit [7:0] session_id;
	rand bit [7:0] key_id;
	rand bit [7:0] packet [$];
	rand bit [7:0] ethertype [0:1];
  bit [31:0] c2n_mac_frame [$];

  `uvm_object_utils_begin(c2n_mac_frame)
    `uvm_field_array_int(da_addr,UVM_ALL_ON | UVM_HEX);
    `uvm_field_array_int(sa_addr,UVM_ALL_ON | UVM_HEX);
    `uvm_field_array_int(ethertype,UVM_ALL_ON | UVM_HEX);
    `uvm_field_int(session_id,UVM_ALL_ON | UVM_HEX);
    `uvm_field_int(key_id,UVM_ALL_ON | UVM_HEX);
    `uvm_field_queue_int(packet,UVM_ALL_ON | UVM_HEX);
    `uvm_field_queue_int(c2n_mac_frame,UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end

  	constraint data {
						foreach(da_addr[i]) { da_addr[i] inside {[1:200]}; }						
						foreach(sa_addr[i]) { sa_addr[i] inside {[1:200]}; }						
						foreach(session_id[i]) { session_id[i] inside {[1:200]}; }						
						foreach(key_id[i]) { key_id[i] inside {[1:200]}; }						
						foreach(ethertype[i]) { ethertype[i] inside {[1:200]}; }
						packet.size() == 30;
						foreach(packet[i]) {packet[i] inside  {[1:500]}; }		
					}
   
    //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //--------------------------------------------------------------------------------- 
   function new (string name="c2n_mac_lyr_frame"); 
      super.new(name); 
   endfunction: new 

   function void post_randomize();
      c2n_mac_lyr_frame();
   endfunction : post_randomize 
   
                 
   function void c2n_mac_lyr_frame();
    		frame = {>>{p1.da_addr,p1.sa_addr,p1.ethertype,`MT_C2N,p1.session_id,p1.key_id,p1.packet}};
   endfunction : c2n_mac_lyr_frame
endclass : c2n_mac_lyr_trans

`endif
