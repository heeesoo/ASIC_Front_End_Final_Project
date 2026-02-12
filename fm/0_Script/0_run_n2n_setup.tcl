	#setup version
	set ver [getenv dft_ver]
	set fm_ver [getenv fm_ver]
	set curr_dir [pwd]
	set REPORTS ${curr_dir}/4_Report/${fm_ver}
	set SCRIPTS ${curr_dir}/0_Script
	
	##reference design path
	set reference_design_path ../2_Synthesis/2_Output/mapped
	##implement_design_path
	set implement_design_path ../3_DFT/2_Output/${ver}
	
	##TOP module
	set TOP_MODULE "ORCA"

	set clock_gating_mode 1
	set QUIT_ON_FINISH 0
