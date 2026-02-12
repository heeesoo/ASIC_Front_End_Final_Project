##########################################################################################
# User-defined variables for logical library, RTL setup
##########################################################################################
set lib_rvt 	"../../0_DesignKit/SAED32_EDK/lib/stdcell_rvt/db_nldm" 	;#  Logic cell library directory
set lib_io 	"../../0_DesignKit/SAED32_EDK/lib/io_std/db_nldm" 	;#  IO library directory
set lib_mem 	"../../0_DesignKit/SAED32_EDK/lib/sram/db_nldm" 	;#  Memory library directory
set lib_pll 	"../../0_DesignKit/SAED32_EDK/lib/pll/db_nldm" 		;#  PLL library directory

######################################################################
# Search path Settings
######################################################################
set search_path ". $lib_rvt \
		   $lib_io \
		   $lib_mem \
		   $lib_pll \
		   "

######################################################################
# Read DB Read DB
######################################################################
read_db saed32rvt_ss0p95v125c.db
read_db saed32io_fc_ss0p95v125c_2p25v.db
read_db saed32pll_ss0p95v125c_2p25v.db
read_db saed32sram_ss0p95v125c.db
