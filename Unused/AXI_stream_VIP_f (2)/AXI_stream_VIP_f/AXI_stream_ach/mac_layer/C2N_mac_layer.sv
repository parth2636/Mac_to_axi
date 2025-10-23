`define MT_MAIN0_KEYEXCH 8'h00
`define MT_CTRL1_INBAND 8'h10
`define MT_C2N 8'h60
module top();
class 	param;
	rand bit [7:0] da_addr [0:5];
	bit [7:0] da_addr_check [0:5];
	rand bit [7:0] sa_addr [0:5];
	bit [7:0] sa_addr_check [0:5];
	rand bit [7:0] session_id;
	bit [7:0] session_id_check;
	rand bit [7:0] key_id;
	bit [7:0] key_id_check;
	rand bit [7:0] packet [$];
	bit [7:0] packet_check [$];
	rand bit [7:0] ethertype [0:1];
	bit [7:0] ethertype_check [0:1];
	
	constraint data {
						foreach(da_addr[i]) { da_addr[i] inside {[1:200]}; }						
						foreach(sa_addr[i]) { sa_addr[i] inside {[1:200]}; }						
						foreach(session_id[i]) { session_id[i] inside {[1:200]}; }						
						key_id == 'h2c;						
						foreach(ethertype[i]) { ethertype[i] inside {[1:200]}; }
						packet.size() == 30;
						foreach(packet[i]) {packet[i] inside  {[1:500]}; }		
					}
			function void display();
				$display("dest_addr da_addr = %0p",da_addr);
				$display("sender_addr sa_addr = %0p",sa_addr);
				$display("ethertype  = %0p",ethertype);
				$display("session_param session_id = %0h",session_id);
				$display("key_param key_id = %0h",key_id);
				$display("payload packet= %0p",packet);
			endfunction
			function void display_check();
				$display("dest_addr da_addr_check = %0p",da_addr_check);
				$display("sender_addr sa_addr_check = %0p",sa_addr_check);
				$display("ethertype_check  = %0p",ethertype_check);
				$display("session_param session_id_check = %0h",session_id_check);
				$display("key_param key_id_check = %0h",key_id_check);
				$display("payload packet_check= %0p",packet_check);
			endfunction			
 endclass	
 
 int j=0,k=0;
 bit [0:31] frame [$];
 param p1;
 initial 
	begin
		p1 = new();
		if(!p1.randomize()) 
			$error("randomize is failed");
		p1.display();	
		frame = {>>{p1.da_addr,p1.sa_addr,p1.ethertype,`MT_C2N,p1.session_id,p1.key_id,p1.packet}};
		$display("fame : %0p",frame);
		foreach(frame[i])
		begin
			$display("frame [%0d] = [%0h]",i,frame[i]);
			//$display("fram slice [%0d][%0d] = %0d",i,j,frame[i][j]);
		end
 	repeat($size(p1.da_addr)) begin
		int m;
		p1.da_addr_check[m][7:0] = frame[j][(k*8)+:8];
		k++;
		m++;
		if(k==$size(p1.da_addr)-2) begin k=0;	frame.delete(0);  end
	end 			
		$display("da_addr_check=%0p",p1.da_addr_check);
	repeat($size(p1.sa_addr)) begin
		int m;
		p1.sa_addr_check[m][7:0] = frame[j][(k*8)+:8];
		k++;
		m++;
		if(k==$size(p1.sa_addr)-2) begin k=0;	frame.delete(0);  end
	end 			
		$display("sa_addr_check=%0p",p1.sa_addr_check); 
	repeat($size(p1.ethertype)) begin
		int m;
		p1.ethertype_check[m][7:0] = frame[j][(k*8)+:8];
		k++;
		m++;
		if(k==$size(p1.ethertype)+1) begin k=0;	frame.delete(0);  end
	end 				
		$display("ethertype_check=%0p",p1.ethertype_check); 
		p1.session_id_check = frame[j][(3*8)+:8];
		$display("session_id_check=%0h",p1.session_id_check);
		frame.delete(0);		
		p1.key_id_check = frame[j][(0*8)+:8];
		$display("key_id_check=%0h",p1.key_id_check);
	repeat($size(p1.packet)) begin
		
		int m;
		p1.packet_check[m][7:0] = frame[j][(k*8)+:8];
		k++;
		m++;
		if(k==4) begin k=0;	frame.delete(0);  end
	end		
		$display("packet_check=%0p",p1.packet_check);
		#100ns;
	    $finish();
	end
endmodule
/* {p1.da_addr_check,p1.sa_addr_check.p1.ethertype_check,p1.session_id_check,p1.key_id_check,p1.packet_check}= frame[i];
			p1.display_check(); 
		while(k < 6) begin
			for(int count=0;count<4;count++) begin
				$display("fram slice [%0d][%0d] = %0d",k,count,frame[k][count]);
				p1.da_addr_check[k[7:0]] = frame[k][count[7:0]];
			    $display("da_addr=%0p",p1.da_addr_check);
				k++;
			end
		end
			*/
/* 	repeat($size(p1.da_addr)) begin
		p1.da_addr_check[k][7:0] = frame[j][(k*8)+:8];
		k++;
		if(k==4) begin k=0;	frame.delete(0);  end
		$display("da_addr_check=%0p",p1.da_addr_check); 
	end */			