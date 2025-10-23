/* -.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.-.

* File Name : axi_str_mas_seq_item.sv

* Purpose : transection class

* Creation Date : 04-05-2024

* Last Modified :

* Created By :  

_._._._._._._._._._._._._._._._._._._._._.*/


`ifndef AXI_STR_MAS_SEQ_ITEM_SV
`define AXI_STR_MAS_SEQ_ITEM_SV

class axi_str_mas_seq_item #(shortint DATA_SIZE=32,int USER_SIZE=32) extends uvm_sequence_item; 
 
 //write data 
 rand shortint unsigned total_bytes;
 rand shortint unsigned no_of_bytes;
 rand bit [(USER_SIZE-1):0] tuser;
 rand bit [(DATA_SIZE-1):0] tdata_q [$];
 bit [((DATA_SIZE/8)-1):0] tkeep_q [$];
 int pkt_len, pkt_num;
 realtime pkt_end_time_ps;
 realtime pkt_start_time_ps;
  

  `uvm_object_param_utils_begin(axi_str_mas_seq_item #(DATA_SIZE,USER_SIZE))
    `uvm_field_real(pkt_start_time_ps,UVM_ALL_ON | UVM_DEC)
    `uvm_field_real(pkt_end_time_ps,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(total_bytes,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(no_of_bytes,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(pkt_len,UVM_ALL_ON | UVM_DEC)
    `uvm_field_int(pkt_num,UVM_ALL_ON | UVM_HEX)
    `uvm_field_queue_int(tdata_q,UVM_ALL_ON | UVM_HEX)
    `uvm_field_queue_int(tkeep_q,UVM_ALL_ON | UVM_HEX)
    `uvm_field_int(tuser,UVM_ALL_ON | UVM_HEX)
  `uvm_object_utils_end
   
   //-------------------------------------------------------------------------------- 
     // Method : 
      
       // Arguments : 
        
         // Description : 
          
           //---------------------------------------------------------------------------------

  constraint data_que_size { 
                            tdata_q.size() == (((total_bytes%no_of_bytes)==0) ?  (int'(total_bytes/no_of_bytes)) :
                                                                                 (int'(total_bytes/no_of_bytes) + 1'b1));
                            solve tdata_q.size before tdata_q;
                            solve total_bytes before tdata_q.size;
                           } //fix size of write data queue array

  constraint NO_OF_BYTES {no_of_bytes==(DATA_SIZE/8);
                          solve no_of_bytes before tdata_q.size;}
						  
  //
  /*constraint TVALID_SIZE {
                          tvalid_q.size() inside {[7:10]};
                          //solve tvalid_q.size before tdata_q.size;
                         }

  constraint TVALID_DATA {
                          tvalid_q.sum == 5;
 						  solve tvalid_q.size before tvalid_q;
						 } */
						  
  //fix range of data each index of write data queue array
  constraint data_rand { foreach(tdata_q[i]) 
                          { 
                            tdata_q[i] inside {[1:500]};

                          }
                       }    
					   

   function new (string name="axi_str_mas_seq_item"); 
      super.new(name); 
   endfunction: new 
  
   function void post_randomize();
      strobe_cal();
   endfunction : post_randomize

   function void len_cal();
   endfunction

   function void strobe_cal();
      int total_bytes_temp,j;
	  bit keep_q [];
      pkt_len = ((total_bytes%no_of_bytes) == 0) ? (total_bytes/no_of_bytes) :
                                                (total_bytes/no_of_bytes + 1);
	  $display("pkt_len=%0d",pkt_len);
	  total_bytes_temp = total_bytes;	
      tkeep_q.delete();	  
      for(int itr=0;itr<pkt_len;itr++) begin
		j = no_of_bytes;
		if (total_bytes_temp < no_of_bytes)
		   j = total_bytes_temp;
	    $display("total_bytes_temp = %0d, j = %0d",total_bytes_temp,j);
		keep_q = new[DATA_SIZE/8];
	    for (int i=0;i<j;i++)
           keep_q[i] = 1'b1;
		tkeep_q.push_back({>>{keep_q}});
		total_bytes_temp-=no_of_bytes;

      end
   endfunction
  
endclass : axi_str_mas_seq_item


`endif
