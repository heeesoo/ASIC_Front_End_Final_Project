######################################
# Report and Results directories
######################################
set REPORTS_DIR "4_Report"
file mkdir $REPORTS_DIR


######################################
# Library & Design Setup
######################################
### Mode : Generic

set lib_rvt 	"/tools/dk/SAED32_EDK/lib/stdcell_rvt/db_nldm" 	;#  Logic cell library directory
set lib_hvt 	"/tools/dk/SAED32_EDK/lib/stdcell_hvt/db_nldm" 	;#  Logic cell library directory
set lib_lvt 	"/tools/dk/SAED32_EDK/lib/stdcell_lvt/db_nldm" 	;#  Logic cell library directory
set lib_io 	"/tools/dk/SAED32_EDK/lib/io_std/db_nldm" 	;#  IO library directory
set lib_mem 	"/tools/dk/SAED32_EDK/lib/sram/db_nldm" 	;#  Memory library directory
set lib_pll 	"/tools/dk/SAED32_EDK/lib/pll/db_nldm" 		;#  PLL library directory
set RTL_path 	"../syn/2_Output/mapped/" 					;#  RTL directory

#set search_path ". $ADDITIONAL_SEARCH_PATH $search_path"
set search_path ". $lib_rvt \
		$lib_hvt \
		$lib_lvt \
		$lib_io \
		$lib_mem \
		$lib_pll \
		$RTL_path"

#set target_library $TARGET_LIBRARY_FILES
set target_library "saed32rvt_ss0p95v125c.db"

#set link_path "* $target_library $ADDITIONAL_LINK_LIB_FILES"
set link_library "* $target_library \
		saed32io_fc_ss0p95v125c_2p25v.db \
		saed32pll_ss0p95v125c_2p25v.db \
		saed32sram_ss0p95v125c.db"

# Provide list of Verilog netlist file. It can be compressed
# ---example "A.v B.v C.v"

# 여기 고침
set NETLIST_FILES "../syn/2_Output/mapped/fir_filter.v"
#set NETLIST_FILES "mydesign.v.gz"

# DESIGN_NAME will be checked for existence from common_setup.tcl
if {[string length $DESIGN_NAME] > 0} {
} else {
set DESIGN_NAME "fir_filter" ;# The name of the top-level design
}


######################################
# Back Annotation File Section
######################################
#PARASITIC Files --- example "top.sbpf A.sbpf"
#The path (instance name) and name of the parasitic file
# --- example "top.spef A.spef"
#Each PARASITIC_PATH entry corresponds to the related PARASITIC_FILE for the specific block"
#For a single toplevel PARASITIC file please use the toplevel design name in PARASITIC_PATHS variable."
set PARASITIC_PATHS "fir_filter"
set PARASITIC_FILES "fir_filter.SPEF.gz"


######################################
# Constraint Section Setup
######################################
# Provide one or a list of constraint files. for example "top.sdc" or "clock.sdc io.sdc te.sdc"
set CONSTRAINT_FILES "var_Day1.tcl fir_filter_pt_constraints.tcl"
