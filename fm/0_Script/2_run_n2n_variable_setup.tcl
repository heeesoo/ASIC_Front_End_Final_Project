	##Common Variable Setup
	set synopsys_auto_setup true
	
	set hdlin_error_on_mismatch_message false
	set hdlin_warning_on_mismatch_message {FMR_ELAB-147 FMR_ELAB-116 FMR_ELAB-115}
	set hdlin_unresolved_modules black_box

	if {$clock_gating_mode} {
		set verification_clock_gate_reverse_gating true
	} else {
		set verification_clock_gate_edge_analysis true
	}
	
	set verification_failing_point_limit 1000
	set verification_timeout_limit 72:00:00

	set verification_run_analyze_points true
#
	set svf_presto_parameter_naming true

	set verification_ignore_unmatched_implementation_blackbox_input true
	set verification_inversion_push false

	set fm_enable_new_fne true
	set hdlin_enable_vpp true

	set hdlin_vrlg_std 2001



