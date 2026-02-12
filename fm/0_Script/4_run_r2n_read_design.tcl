#####################################################################
# Read reference design - RTL
#####################################################################

	read_verilog -r -libname WORK {\
                                     ../rtl/fir_filter.v \
	}
	
	set_top r:/WORK/${TOP_MODULE}

#####################################################################
# Read implement design - Netlist
#####################################################################

	read_verilog -i -libname WORK ${implement_design_path}/fir_filter.v
 	
	set_top i:/WORK/${TOP_MODULE}

