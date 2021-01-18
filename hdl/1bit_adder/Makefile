# Notes for vcs:
#  -Mdir     Temporary file space; can give a big speedup
#  -Mupdate  Incremental compile
#  -PP       Enables vcs to work with vcd+ files
#  -R        Run executable after compiling and linking
#  -RI       Bring up interactive GUI after compiling and linking
#  -RPP      Run post-processing mode; starts virsim


#----- Set the top-level module name here
NAME		:= module_name

#----- Some variables
USERNAME	:= $(shell whoami)
DIR_TMP		:= /tmp/$(USERNAME)verilog

COM = vcs
COM_OPTS = -Mupdate -pp -debug -sverilog 
DVE_OPTS = -R -gui
VERDI = verdi
DEF_OPTS = -full64  
INC_DIR = +incdir+../common/+../1bit_adder/+../nbit_adder/
VERDI_OPTS = -kdb -debug_access+all -lca
LOG = -l $(NAME).logv
FORMAT := verilog

#----- Targets
default:
	@echo
	@echo "Make targets. Either change module name in Makefile line 16 or add the"
	@echo "text 'NAME=xyz' after 'make' for simulation and synthesis targets below."
	@echo "  make                     print this help summary"
	@echo "  make clean               deletes some generated files"
	@echo "  make cleanall            deletes all generated files"
	@echo "Make targets for simulation"
	@echo "  make compile             compile only with .vfv and vcs	(make compile NAME=<module> CFLAGS=+debug)"
	@echo "  make run                 run with vcs"
	@echo "  make viewer              start verdi"
	@echo "Make targets for synthesis"
	@echo "  make check               compile only with .vfs and vcs"
	@echo "  make synth               synthesize default module"
	@echo
	@echo "Procedure to synthesize top-level module 'xyz'"
	@echo "  1) change 'NAME := abc' to 'NAME := xyz' at top of Makefile"
	@echo "  2) add all modules to be synthesized to file xyz.vfs"
	@echo "  3) 'make check' and fix any errors"
	@echo "  4) 'make synth'"
	@echo
	@echo "Alternate procedure:"
	@echo "  1) add all modules to be synthesized to file xyz.vfs"
	@echo "  2) 'make NAME=xyz check' and fix any errors"
	@echo "  3) 'make NAME=xyz synth'"
	@echo

#Disabled .vfv file generation.
sim_files :
	$(shell find . \( -name '*.v' -o -name '*.sv' \) -exec realpath "{}" \; > $(NAME).vfv)

syn_files : 
	$(shell find . \( -name '*.v' -o -name '*.sv' \) -prune ! -name '*tb*' -exec realpath "{}" \; > $(NAME).vfs)

netlist_files :
	$(shell find . \( -name '*_syn.*' -o -name '*tb*' \) -exec realpath "{}" \; > $(NAME).vfn)

#----- Simulation. Put all hdl & testbench files in a ".vfv" file. Add only hdl files to .vfs
compile : 
	$(COM) $(VERDI_OPTS) $(COM_OPTS) $(INC_DIR) -f $(NAME).vfv $(DEF_OPTS) &

# Run simulation in VCS 
run:
	./simv $(LOG) $(CFLAGS)  &

# Start viewer
verdi:
	./simv -verdi &
	#$(VERDI) $(VERDI_OPTS) $(INC_DIR) -f $(NAME).vfv $(DEF_OPTS) & 
dve:
	$(COM) $(DVE_OPTS) $(COM_OPTS) $(DEF_OPTS) $(INC_DIR) -f $(NAME).vfv &

#----- Synthesis. Put all files in a ".vfs" file.
check:	syn_files	
	$(COM) $(VERDI_OPTS) $(COM_OPTS) -f $(NAME).vfs $(DEF_OPTS) &

netlist_run: netlist_files
	$(COM) $(VERDI_OPTS) $(COM_OPTS) -f $(NAME).vfn $(DEF_OPTS) -o simv_syn &
	./simv $(LOG) $(CFLAGS)  &

# Note: alternate top of file cmd instead of awk: sed '/BEFORE_ANALYZE_SEC.../q'
dc-$(NAME).tcl: syn_files dc-template.tcl $(NAME).vfs Makefile
	@echo "===== Making a new dc-$(NAME).tcl"
	awk '/BEFORE_ANALYZE_SECTION/ {exit} {print}' dc-template.tcl | sed 's/prac/$(NAME)/' | sed 's/dc-template.tcl/dc-$(NAME).tcl/' > dc-$(NAME).tcl
	grep -v '#' $(NAME).vfs | awk '{print "analyze -library WORK -format $(FORMAT) " $$1}' >> dc-$(NAME).tcl
	awk '/AFTER_ANALYZE_SECTION/,EOF' dc-template.tcl | grep -v 'AFTER_ANALYZE_SECTION' | sed 's/prac/$(NAME)/' | sed 's/FORMAT/${FORMAT}/' >> dc-$(NAME).tcl
	@echo "===== New dc-$(NAME).tcl ready"
	@echo 

synth: dc-$(NAME).tcl
	dc_shell-t -f dc-$(NAME).tcl | tee $(NAME).logs
#	@grep -v '^Warning:.*Intraassignment delays for nonblocking assignments are ignored. (VER-130)' $(NAME).logs > $(NAME).logs.clean

#----- Cleanup generated files
clean:
	rm -f  *.mr
	rm -f  *-verilog.pvl
	rm -f  *-verilog.syn
	rm -f  default.svf
	rm -f  simv
	rm -rf simv.daidir
	rm -f  vcs.key
	rm -f  ncverilog.key
	rm -rf simv.daidir/
	rm -rf simv_syn.daidir/
	rm -rf $(DIR_TMP)
	rm -rf INCA_libs/
	rm -rf csrc/
	rm -rf ucli.key

cleanall: clean
	rm -f $(NAME).area
	rm -f $(NAME).cell
	rm -f dc-$(NAME).tcl
	rm -f $(NAME).db
	rm -f $(NAME).hier
	rm -f $(NAME).history
	rm -f $(NAME).log
	rm -f $(NAME).logs
	rm -f $(NAME).logs.clean
	rm -f $(NAME).logv
	rm -f $(NAME).net
	rm -f $(NAME).pow
	rm -f $(NAME).tim
	rm -f $(NAME).vg
	rm -f $(NAME).dsn
	rm -f $(NAME).trn
	rm -f $(NAME)_test.dsn
	rm -f $(NAME)_test.trn
	rm -f $(NAME).vpd
	#rm -f $(NAME).vfv
	#rm -f ${NAME}.vfs
	rm -f ${NAME}.vfn
	rm -rf ${NAME}_syn.v
	rm -f command.log
	rm -rf DVEfiles/
	rm -rf .saveDVEfiles/
	rm -f *.vpd
	rm -f .restartSimSession.tcl.old
	rm -f .synopsys_dve_rebuild.tcl


