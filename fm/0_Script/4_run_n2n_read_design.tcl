#####################################################################
# Read reference design - RTL
#####################################################################

read_verilog -r -libname WORK ${reference_design_path}/ORCA_gate.v

set_top r:/WORK/${TOP_MODULE}

#####################################################################
# Read implement design - Netlist
#####################################################################

read_verilog -i -libname WORK ${implement_design_path}/ORCA_scan_comp.v

set_top i:/WORK/${TOP_MODULE}

