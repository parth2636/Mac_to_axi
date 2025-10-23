
vlog ../ENV/axi_str_env_pkg.sv ../TEST/axi_str_pkg.sv ../TOP/axi_str_top.sv +incdir+../ENV/Master +incdir+../ENV/Slave +incdir+../ENV +incdir+../TEST
vsim -voptargs=+acc axi_str_top +UVM_OBJECTION_TRACE -sv_seed ${1}

do ./wave.do
run -all


