	##set constant 0 
	##scan enalbe
	set_constant -type port r:/WORK/${TOP_MODULE}/scan_en 0
        ##test mode
	set_constant -type port r:/WORK/${TOP_MODULE}/test_mode 0
	##compression enable
	set_constant -type port r:/WORK/${TOP_MODULE}/pad[6] 0

        set_constant -type port i:/WORK/${TOP_MODULE}/scan_en 0
        set_constant -type port i:/WORK/${TOP_MODULE}/test_mode 0
	set_constant -type port i:/WORK/${TOP_MODULE}/pad[6] 0

