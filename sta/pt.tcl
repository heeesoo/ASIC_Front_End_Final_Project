source ./common_setup.tcl
source ./pt_setup.tcl

set_app_var sh_source_uses_search_path true
set_app_var search_path " $search_path"

set_app_var link_path "* $link_path"
read_verilog $NETLIST_FILES
current_design $DESIGN_NAME
link_design -verbose

#read_parasitics $PARASITIC_FILES


#foreach constraint_file $CONSTRAINT_FILES {
#    if {[file extension $constraint_file] eq "./0_Con/mydesign_pt.sdc"} {
#        read_sdc -echo $constraint_file
#    } else {
#        source -echo $constraint_file
#    }
#}

#if {[file extension $constraint_file] eq "./0_Con/mydesign_pt.sdc"} {
#    read_sdc -echo $constraint_file }
#else {
#    source -echo $constraint_file
#}

read_sdc ./6_Con/fir_filter_pt.sdc

update_timing

report_analysis_coverage

file delete -force fir_filter_savesession
save_session fir_filter_savesession

#quit 
