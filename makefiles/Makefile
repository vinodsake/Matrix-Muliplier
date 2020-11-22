SRC_FILE = *.sv
COM = vcs
COM_OPTS = -Mupdate -debug -sverilog
DVE_OPTS = -R -gui
DEF_OPTS = -full64
VERDI_OPTS = -kdb -debug_access+all -lca

com : *.sv
	$(COM) $(VERDI_OPTS) $(COM_OPTS) $(SRC_FILE) $(DEF_OPTS) &

sim : simv
	./simv $(CFLAGS) &

dve : *.sv
	$(COM) $(DVE_OPTS) $(DEF_OPTS) $(SRC_FILE) &

verdi :
	$(COM) $(VERDI_OPTS) $(SRC_FILE) $(DEF_OPTS) &

clean :
	find . -type f -not \( -name '*.sv' -or -name '*.v' \) -delete
	find -type d -exec rm -rf {} \;
