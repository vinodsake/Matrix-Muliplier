# Matrix-Muliplier
Matrix muliplier using system verilog and UVM

Synthesis: 
1. use: ./G-2012.06/libraries/sim/examples/lsi_10k_FTGS.vhd for lsi_10k cell library
2. create .synopsys_vss.setup with DEFAULT : ./WORK
3. create WORK dir
4.  vlogan +v2k FA_syn.v
5. vhdlan ./G-2012.06/libraries/sim/examples/lsi_10k_FTGS.vhd
6. vcs FA -debug_all -full64
Error-[SC_DONUT_NO_MORE_GATESIM] Gatesim not supported in VCS MX
  Found Gatesim instance "/\/FA/U8\/...   EO(FTGS){private_instance}" in file
  "/pkgs/synopsys/2020/design_compiler/syn/Q-2019.12-SP3/libraries/sim/examples/lsi_10k_FTGS.vhd"
  between lines 5853-5914. VCS MX does not support Gatesim. Exiting ...

