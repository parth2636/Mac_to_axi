`ifndef MAC_TO_AXI_SVH
`define MAC_TO_AXI_SVH

class mac_to_axi extends uvm_component;
  `uvm_component_utils(mac_to_axi)

  // Input: MAC packets from MAC driver
  uvm_blocking_put_export #(mac_seq_item) mac_put_export;

  // Output: AXI beats to AXI driver
  uvm_blocking_put_port   #(axis_item) axi_put_port;

  function new(string name, uvm_component parent=null);
    super.new(name, parent);
    mac_put_export = new("mac_put_export", this);
    axi_put_port   = new("axi_put_port", this);
  endfunction

  // Conversion: mac_seq_item -> axis_item beats
virtual function void put(input mac_seq_item pkt);
  byte data_q[$];   // full byte stream of frame
  axis_item ax;
  int i, j;

  // 1. Flatten MAC fields + payload into one byte queue
  data_q = {>>{ pkt.dst_mac,
                pkt.src_mac,
                {pkt.vlan_id, pkt.pcp, pkt.dei}, // TCI field
                pkt.eth_type,
                pkt.payload,
                pkt.fcs }};

  // 2. Convert byte queue into 32-bit words
  for (i = 0; i < data_q.size(); i += 4) begin
    ax = axis_item::type_id::create("ax");
    ax.tdata = 0;

    // pack 4 bytes (big-endian)
    for (j = 0; j < 4; j++) begin
      int idx = i + j;
      byte b = (idx < data_q.size()) ? data_q[idx] : 8'h00;
      ax.tdata = (ax.tdata << 8) | b;
    end

    // 3. tlast/tkeep handling
    ax.tlast = ((i + 4) >= data_q.size());
    if (ax.tlast)
      ax.tkeep = (1 << (data_q.size() - i)) - 1;
    else
      ax.tkeep = 4'b1111;

    // 4. Send to AXI
    axi_put_port.put(ax);
  end
endfunction
 endclass

`endif // MAC_TO_AXI_SVH

