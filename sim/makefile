TESTNAME ?=
SEED ?= random
COMPARG ?=

#======================

all:	clean build run

build:
	mkdir -p log
	vlib work
	vlog +cover=sbceftx -f compile.f ${COMPARG}
run:
	vsim -l ${TESTNAME}.log work.${TESTNAME} -do "run -all;exit" -sv_seed ${SEED}
	mv ${TESTNAME}.log ./log
	ln -sf ./log/${TESTNAME}.log sim.log
dump:
	vsim -gui -novopt work.${TESTNAME}

clean:
	rm -rf *.log
	rm -rf log
	#rm -rf work
	#rm -rf *.wlf
	#rm -rf *.transcript
	rm -rf coverage 
	rm -rf *.ucdb

run_cov:
	vsim -coverage -l ${TESTNAME}.log work.${TESTNAME} -voptargs="+cover=bcesfx" -do "coverage save -onexit ${TESTNAME}.ucdb;run -all;exit" -sv_seed ${SEED}
	mv ${TESTNAME}.log ./log
	ln -sf ./log/${TESTNAME}.log sim.log

gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -file coverage/summary_report.txt
	vcover report -zeros -detail -code bcefsx -All -codeAll IP.ucdb -file coverage/detail_report.txt
