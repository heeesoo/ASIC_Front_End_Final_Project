	set curr_dir [pwd]
	set REPORTS ${curr_dir}/reports
	set SCRIPTS ${curr_dir}/scripts

	set TOP_MODULE "ORCA"

#####################################################################
# control variables
#####################################################################

	set clock_gating_mode 0
	set QUIT_ON_FINISH 0


#####################################################################
# Remove possible old design entries
#####################################################################

	remove_container r
	remove_container i
	remove_guidance
	remove_constant -all
	remove_black_box -all
	remove_user_match -all
	remove_dont_verify_point -all
	remove_library -all

#####################################################################
# Common Variable Setup
#####################################################################

	set synopsys_auto_setup true
	
	set hdlin_error_on_mismatch_message false
	set hdlin_warning_on_mismatch_message {FMR_ELAB-147 FMR_ELAB-116 FMR_ELAB-115}
	set hdlin_ignore_full_case false
	set hdlin_ignore_parallel_case false
	set hdlin_dyn_array_bnd_check both
	set hdlin_unresolved_modules black_box

	if {$clock_gating_mode} {
		set verification_clock_gate_reverse_gating true
	} else {
		set verification_clock_gate_edge_analysis true
	}
	
	set verification_clock_gate_hold_mode low
	
	set verification_failing_point_limit 1000
	set verification_timeout_limit 72:00:00


	set signature_analysis_match_compare_points false

	set verification_run_analyze_points true
	set gui_report_length_limit 1000000


#####################################################################
# Read Library
#####################################################################

	source -e -v ${SCRIPTS}/lib_setup.tcl


#####################################################################
# Common Variable Setup #2
#####################################################################
	set verification_effort_level high

	set svf_presto_parameter_naming true

	set signature_analysis_matching false
	set verification_ignore_unmatched_implementation_blackbox_input true
	set verification_inversion_push false

	set fm_enable_new_fne true
	set hdlin_enable_vpp true

	set hdlin_vrlg_std 2001

	set svf_ignore_unqualified_fsm_information false
	set signature_analysis_allow_subset_match false
	
	set verification_set_undriven_signals synthesis


#####################################################################
# svf setup
#####################################################################

	#set_svf ../outputs/${TOP_MODULE}.svf
	#set_svf /data/user/alps07/230207/1_scan/default.svf

#####################################################################
# r read_design
#####################################################################



	#read_verilog -r -libname WORK ../outputs/${TOP_MODULE}_initial_RVT.v
	#source -e -v ../outputs/dirty_read.tcl

        #read_verilog -r -libname WORK /data/user/alps07/230207/1_scan/2_output/ORCA.v
	read_verilog -r -libname WORK /data/user/alps07/230207/1_scan/2_output/ORCA.v
	
	set_top r:/WORK/${TOP_MODULE}

	#load_upf -r /data/user/alps04/pdd/allreview/upf_scripts/upf.upf

#####################################################################
# i read_design
#####################################################################

	source -e -v ${SCRIPTS}/lib_setup_i.tcl
	#read_verilog -i -libname WORK ../outputs/${TOP_MODULE}_final.v

	#read_verilog -i -libname WORK /data/user/alps07/230207/1_scan/2_output/ORCA_scan_comp.v
	read_verilog -i -libname WORK /data/user/alps04/ORCA_14/2_output/ORCA_trans_fix.v
 	
	set_top i:/WORK/${TOP_MODULE}

	#load_upf -i /data/user/alps04/pdd/allreview/outputs/ChipTop_final_full_only.upf

#####################################################################
# Exceptions
#####################################################################

#	set_constant -type port i:/WORK/${TOP_MODULE}/I_SCAN_EN 0
#	set_constant -type port i:/WORK/${TOP_MODULE}/I_SCAN_COMP_EN 0
#	set_constant -type port i:/WORK/${TOP_MODULE}/I_SCAN_CG_EN 0
#
#	set_constant -type port r:/WORK/${TOP_MODULE}/I_SCAN_EN 0
#	set_constant -type port r:/WORK/${TOP_MODULE}/I_SCAN_COMP_EN 0
#	set_constant -type port r:/WORK/${TOP_MODULE}/I_SCAN_CG_EN 0
#	set_constant -type port r:/WORK/${TOP_MODULE}/OCC_MODE 0


	#set_constant -type port r:/WORK/${TOP_MODULE}/CLK_150_core_wrapper/core_3/PwrCtrl/gprs_sd 1

      #  set_constant -type port i:/WORK/${TOP_MODULE}/scan_en 0
        #set_constant -type port i:/WORK/${TOP_MODULE}/test_mode 0
	#set_constant -type port i:/WORK/${TOP_MODULE}/TM_COMP 0

	#set_constant -type port r:/WORK/${TOP_MODULE}/scan_en 0
        #set_constant -type port r:/WORK/${TOP_MODULE}/test_mode 0
#	set_constant -type port r:/WORK/${TOP_MODULE}/TM_COMP 0



#####################################################################
# Matching
#####################################################################

	match

	report_unmatched_point > ${REPORTS}/unmatched_points_post_matching.rpt
	report_user_matches > ${REPORTS}/user_matches_post_matching.rpt

#####################################################################
# Verifying
#####################################################################

	if {[verify]} {
			puts ""
			puts " PPPPPPPPPPPPPPPPP        AAA                 SSSSSSSSSSSSSSS    SSSSSSSSSSSSSSS  "
			puts " P::::::::::::::::P      A:::A              SS:::::::::::::::S SS:::::::::::::::S "
			puts " P::::::PPPPPP:::::P    A:::::A            S:::::SSSSSS::::::SS:::::SSSSSS::::::S "
			puts " PP:::::P     P:::::P  A:::::::A           S:::::S     SSSSSSSS:::::S     SSSSSSS "
			puts "   P::::P     P:::::P A:::::::::A          S:::::S            S:::::S             "
			puts "   P::::P     P:::::PA:::::A:::::A         S:::::S            S:::::S             "
			puts "   P::::PPPPPP:::::PA:::::A A:::::A         S::::SSSS          S::::SSSS          "
			puts "   P:::::::::::::PPA:::::A   A:::::A         SS::::::SSSSS      SS::::::SSSSS     "
			puts "   P::::PPPPPPPPP A:::::A     A:::::A          SSS::::::::SS      SSS::::::::SS   "
			puts "   P::::P        A:::::AAAAAAAAA:::::A            SSSSSS::::S        SSSSSS::::S  "
			puts "   P::::P       A:::::::::::::::::::::A                S:::::S            S:::::S "
			puts "   P::::P      A:::::AAAAAAAAAAAAA:::::A               S:::::S            S:::::S "
			puts " PP::::::PP   A:::::A             A:::::A  SSSSSSS     S:::::SSSSSSSS     S:::::S "
			puts " P::::::::P  A:::::A               A:::::A S::::::SSSSSS:::::SS::::::SSSSSS:::::S "
			puts " P::::::::P A:::::A                 A:::::AS:::::::::::::::SS S:::::::::::::::SS  "
			puts " PPPPPPPPPPAAAAAAA                   AAAAAAASSSSSSSSSSSSSSS    SSSSSSSSSSSSSSS    "
			puts ""

	} else {

                                                                                
			puts ""
			puts " FFFFFFFFFFFFFFFFFFFFFF      AAA               IIIIIIIIIILLLLLLLLLLL              "
			puts " F::::::::::::::::::::F     A:::A              I::::::::IL:::::::::L              "
			puts " F::::::::::::::::::::F    A:::::A             I::::::::IL:::::::::L              "
			puts " FF::::::FFFFFFFFF::::F   A:::::::A            II::::::IILL:::::::LL              "
			puts "   F:::::F       FFFFFF  A:::::::::A             I::::I    L:::::L                "
			puts "   F:::::F              A:::::A:::::A            I::::I    L:::::L                "
			puts "   F::::::FFFFFFFFFF   A:::::A A:::::A           I::::I    L:::::L                "
			puts "   F:::::::::::::::F  A:::::A   A:::::A          I::::I    L:::::L                "
			puts "   F:::::::::::::::F A:::::A     A:::::A         I::::I    L:::::L                "
			puts "   F::::::FFFFFFFFFFA:::::AAAAAAAAA:::::A        I::::I    L:::::L                "
			puts "   F:::::F         A:::::::::::::::::::::A       I::::I    L:::::L                "
			puts "   F:::::F        A:::::AAAAAAAAAAAAA:::::A      I::::I    L:::::L         LLLLLL "
			puts " FF:::::::FF     A:::::A             A:::::A   II::::::IILL:::::::LLLLLLLLL:::::L "
			puts " F::::::::FF    A:::::A               A:::::A  I::::::::IL::::::::::::::::::::::L "
			puts " F::::::::FF   A:::::A                 A:::::A I::::::::IL::::::::::::::::::::::L "
			puts " FFFFFFFFFFF  AAAAAAA                   AAAAAAAIIIIIIIIIILLLLLLLLLLLLLLLLLLLLLLLL "
			puts ""


	}


	report_failing_point > ${REPORTS}/failing_points.rpt
	report_aborted_point > ${REPORTS}/aborted_points.rpt
	report_unverified_point > ${REPORTS}/unverified_points.rpt
	report_black_box > ${REPORTS}/black_box.rpt
	report_constants > ${REPORTS}/constants.rpt
	report_dont_verify_points > ${REPORTS}/dont_verify_points.rpt

	save_session -replace saved_session

	if {$QUIT_ON_FINISH} {
		exit
	} 

