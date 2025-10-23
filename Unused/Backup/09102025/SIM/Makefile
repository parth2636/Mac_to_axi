# Makefile for UVM Testbench

# Library name
work = work 

# Directories
INC = +incdir+../ENV \
      +incdir+../ENV/axi_agnet \
      +incdir+../ENV/mac_agnet \
      +incdir+../TESR \
      +incdir+../TOP \
      +incdir+../rtl 
     
module = "top"


#RTL = ../RTL/*.sv

APKG = ../ENV/axi_agent/axi_agent_pkg.sv
MPKG = ../ENV/mac_agent/mac_agent_pkg.sv
ENVPKG = ../ENV/env_pkg.sv
TESTPKG = ../TEST/test_pkg.sv
 
       
SVTB = ../TOP/top.sv 

	
# Compile order: RTL -> Interface -> Packages -> TB
comp:
	vlog    $(APKG) $(MPKG) $(ENVPKG) $(TESTPKG)  $(SVTB)  $(INC)

 

sim:
	vsim -voptargs=+acc   $(module) -c -do "run -all;exit"





