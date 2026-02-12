#------------------------------------------------------------------
# Copyright (c) 2013 by Ando Ki.
# All right reserved.
#
# This code is distributed in the hope that it will
# be useful to understand Ando Ki's work,
# but WITHOUT ANY WARRANTY.
#------------------------------------------------------------------
SHELL		= /bin/sh
MAKEFILE	= Makefile
#------------------------------------------------------------------
ARCH	= $(shell uname)
ifeq ($(ARCH), CYGWIN_NT-5.1)
else
ifeq ($(ARCH), MINGW32_NT-5.1)
else
endif
endif
#--------------------------------------------------------
VLIB	= $(shell which vlib)
VLOG	= $(shell which vlog)
VSIM	= $(shell which vsim)
WORK	= simv
#--------------------------------------------------------
TOP	= top
#--------------------------------------------------------
all: vcs

irun:
	irun 

#	vcs -R -debug_acc+all -sverilog -timescale=1ns/1ns -reportstats -kdb -f run.f
# vcs -full64 -R -debug_acc+all -sverilog -kdb -timescale=1ns/1ps -f run.f
vcs:
	if [ -d $(WORK) ]; then /bin/rm -rf $(WORK); fi
	vcs -full64 -debug_acc+all -kdb +define+SDF_PRE +neg_tchk +maxdelays -timescale=1ns/1ps +lint=TFIPC-L -f run_pre.f -l run_pre.log

xrun:
	if [ -d $(WORK) ]; then /bin/rm -rf $(WORK); fi
	xrun -64bit -access +rwc -f run.f

#	Verdi-Ultra -sv -ssf wave.fsdb -dbdir ./simv.daidir -f run.f &
# Verdi-Ultra -sv -ssf test.pre.fsdb -dbdir ./simv.daidir -f run_pre.f &
verdi:
	Verdi-Ultra -f run_pre.f -ssf test.pre.fsdb &
	
vlib:
	if [ -d $(WORK) ]; then /bin/rm -rf $(WORK); fi
	($(VLIB) $(WORK) || exit -1) 2>&1 | tee compile.log

compile:
	($(VLOG) -lint -work $(WORK)\
		-f run.f || exit -1) 2>&1 | tee compile.log

simulate: compile
	$(VSIM) -novopt -c -do "add wave *; run -all; quit"\
		$(WORK).$(TOP)

#--------------------------------------------------------
clean:
	-@/bin/rm -rf $(WORK)
	-@/bin/rm -f  transcript
	-@/bin/rm -f  wave.vcd dump.vcd
	-@/bin/rm -f  vsim.wlf
	-@/bin/rm -f  vish_stacktrace.vstf
	-@/bin/rm -f  wlft*
	-@/bin/rm -f  compile.log
	-@/bin/rm -f  xrun.history
	-@/bin/rm -f  xrun.log
	-@/bin/rm -f  novas_dump.log
	-@/bin/rm -f  wave.fsdb
	-@/bin/rm -rf  VerdiLog *.vpd
	-@/bin/rm -rf  simv csrc simv.daidir ucli.key
	-@/bin/rm -rf  verdi_config_file
	-@/bin/rm -rf  Verdi-UltraLog/

	-@/bin/rm -rf  novas.rc
	-@/bin/rm -rf  novas.conf
	-@/bin/rm -rf  novas_dump.log
	-@/bin/rm -rf  top.fsdb
	-@/bin/rm -rf  vcs.log
	-@/bin/rm -rf  csrc
	-@/bin/rm -rf  simv.daidir
	-@/bin/rm -rf  ucli.key
	-@/bin/rm -rf  csrc

	-@/bin/rm -rf  wave.fsdb.chain
	-@/bin/rm -rf  wave.fsdb.field
	-@/bin/rm -rf  wave.fsdb.lock
	-@/bin/rm -rf  wave.fsdb.netwk
	-@/bin/rm -rf  wave.fsdb.pidat
	-@/bin/rm -rf  wave.fsdb.podat
	-@/bin/rm -rf  wave.fsdb.sinf
	-@/bin/rm -rf  wave.fsdb.slist
	-@/bin/rm -rf  wave.fsdb.slock
	-@/bin/rm -rf  wave.fsdb.str
	-@/bin/rm -rf  wave.fsdb.tlist
	-@/bin/rm -rf  wave.fsdb.xlist

	-@/bin/rm -rf  test.fsdb.chain
	-@/bin/rm -rf  test.fsdb.field
	-@/bin/rm -rf  test.fsdb.lock
	-@/bin/rm -rf  test.fsdb.netwk
	-@/bin/rm -rf  test.fsdb.pidat
	-@/bin/rm -rf  test.fsdb.podat
	-@/bin/rm -rf  test.fsdb.sinf
	-@/bin/rm -rf  test.fsdb.slist
	-@/bin/rm -rf  test.fsdb.slock
	-@/bin/rm -rf  test.fsdb.str
	-@/bin/rm -rf  test.fsdb.tlist
	-@/bin/rm -rf  test.fsdb.xlist
	-@/bin/rm -rf  test.pre.fsdb
	-@/bin/rm -rf  run_pre.log

cleanup: clean

clobber: cleanup
#--------------------------------------------------------
