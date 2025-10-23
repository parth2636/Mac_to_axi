onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /axi_str_top/inf/DATA_SIZE
add wave -noupdate /axi_str_top/inf/USER_SIZE
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/drv_cb_event
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/tvalid
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/tready
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/tdata
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/tkeep
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/tuser
add wave -noupdate -label sim:/axi_str_top/inf/drv_cb/Group1 -group {Region: sim:/axi_str_top/inf/drv_cb} /axi_str_top/inf/drv_cb/tlast
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/mon_cb_event
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/tvalid
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/tready
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/tdata
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/tkeep
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/tuser
add wave -noupdate -expand -label sim:/axi_str_top/inf/mon_cb/Group1 -group {Region: sim:/axi_str_top/inf/mon_cb} /axi_str_top/inf/mon_cb/tlast
add wave -noupdate /axi_str_top/inf/aclk
add wave -noupdate /axi_str_top/inf/areset_n
add wave -noupdate /axi_str_top/inf/tvalid
add wave -noupdate /axi_str_top/inf/tready
add wave -noupdate /axi_str_top/inf/tdata
add wave -noupdate /axi_str_top/inf/tkeep
add wave -noupdate /axi_str_top/inf/tuser
add wave -noupdate /axi_str_top/inf/tlast
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {86000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {247788 ps}
