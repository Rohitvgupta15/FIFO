VCS_DIR := /cad/synopsys/synthesis/2019.12

.PHONY: all rtl write_read read_write merge clean

rtl:
	vcs -full64 -sverilog \
	    -cm line+cond+tgl+branch \
	    -debug_access+all \
	    design/design.sv "testbench_environment/testbench.sv" \
	    -o simv

write_read:
	./simv +wr \
	    -cm line+cond+tgl+branch \
	    -cm_dir cov_wr.vdb

read_write:
	./simv +rw \
	    -cm line+cond+tgl+branch \
	    -cm_dir cov_rw.vdb

merge:
	urg -full64 \
	    -dir simv.vdb \
	    -dir cov_wr.vdb \
	    -dir cov_rw.vdb \
	    -dbname merged.vdb \
	    -report merged_report

clean:
	rm -rf simv simv.daidir simv.vdb \
	       cov_wr.vdb cov_rw.vdb \
	       coverage_report merged.vdb merged_report \
	       csrc ucli.key .fsm.sch.verilog.xml a.vcd \
	       *.log *.xml vc_hdrs.h
report:
	code --reuse-window merged_report/dashboard.html
all: clean rtl write_read read_write merge