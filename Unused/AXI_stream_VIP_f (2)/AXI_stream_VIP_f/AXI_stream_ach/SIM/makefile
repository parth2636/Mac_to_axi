
#seed_num=--seed
comp:
	vlog ..\ENV\axi_str_env_pkg.sv ..\TEST\axi_str_pkg.sv ..\TOP\axi_str_top.sv +incdir+../ENV/Master +incdir+../ENV/Slave +incdir+../ENV +incdir+../TEST
sim:
	vsim -voptargs=+acc axi_str_top -c -do "run -all;exit" -sv_seed $(seed_num)	