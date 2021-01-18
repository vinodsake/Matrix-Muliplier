# dc-template.tcl script 
#
# Debugging
# list -designs
# list -libraries
# list -files 
#
# Add if you like:
# Annotates inputs, but doesn't propagate through design to clear warnings.
#   set_switching_activity -toggle_rate 0.25 -clock "clk" { "in31a" }
# More power info
#   report_power -net
#   report_power -hier
#   set_max_delay
#   write -format db -output prac.db
#
# Doesn't work quite the way I expect
#   NameDesign = prac    Set variable ok, but how to concatenate?
#   write_rtl -format verilog -output prac.vg


#===== Set: libraries
set search_path [list . /pkgs/synopsys/2020/design_compiler/syn/Q-2019.12-SP3/libraries/syn /pkgs/synopsys/2020/design_compiler/syn/Q-2019.12-SP3/dw/syn_ver /pkgs/synopsys/2020/design_compiler/syn/Q-2019.12-SP3/dw/sim_ver]

set target_library lsi_10k.db
set link_library { * lsi_10k.db}
set symbol_library [list generic.sdb]
set synthetic_library [list dw_foundation.sldb]

#===== Set: make sure you change design name elsewhere in this file
set NameDesign "prac"

#===== Set some timing parameters
set CLK "clk"

#===== All values are in units of ns for NanGate 45 nm library
set clk_period     9 

set clock_skew      [expr {$clk_period} * 0.05 ]
set input_setup     [expr {$clk_period} * 0.97 ]
set output_delay    [expr {$clk_period} * 0.04 ]
set input_delay     [expr {$clk_period} - {$input_setup}]

# It appears one "analyze" command is needed for each .v file. This works best
# (only?) with one command line per module.
# BEFORE_ANALYZE_SECTION
# Below will not be in final tcl script, should be replaced with all files from .vfv
analyze -library WORK -format FORMAT ./prac_file
# AFTER_ANALYZE_SECTION

elaborate $NameDesign
current_design $NameDesign
link
uniquify
if { [sizeof_collection [get_cells * -filter "is_hierarchical==true"]] > 0 } {
   ungroup -all -flatten -simple_names
   }
set_max_area 0.0

#===== Timing and input/output load constraints
create_clock $CLK -name $CLK -period $clk_period -waveform [list 0.0 [expr {$clk_period} / 2.0 ] ] 

set_clock_uncertainty $clock_skew $CLK
#set_clock_skew -plus_uncertainty $clock_skew $CLK
#set_clock_skew -minus_uncertainty $clock_skew $CLK

set_input_delay     $input_delay  -clock $CLK [all_inputs]
#remove_input_delay               -clock $CLK [all_inputs] 
set_output_delay    $output_delay -clock $CLK [all_outputs]

set_load 1.5 [all_outputs]

compile -map_effort medium

# Comment "ungroup" line to maybe see some submodules
if { [sizeof_collection [get_cells * -filter "is_hierarchical==true"]] > 0 } {
   ungroup -all -flatten -simple_names
   }
# compile -map_effort medium    # May help, or maybe not

#===== Generate NetList
write -hierarchy -format verilog -output prac_syn.v

#===== Reports
write -format ddc -output prac.vg -hierarchy $NameDesign

report_area               > prac.area
report_cell               > prac.cell
report_hierarchy          > prac.hier
report_net                > prac.net
report_power              > prac.pow
report_timing -nworst 10  > prac.tim

check_timing
check_design

exit

