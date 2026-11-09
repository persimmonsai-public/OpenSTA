# Opt-in glitch estimate (STA_POWER_GLITCH_ESTIMATE) on combinational
# cells. u_skew has input arcs with different delays and glitches;
# u_bal has identical arcs and does not.
read_liberty power_glitch_estimate.lib
read_verilog power_glitch_estimate.v
link_design top
set_cmd_units -time ns
create_clock -name clk -period 10 [get_ports clk]
set_input_delay 0 -clock clk [get_ports {a b}]
set_load 0.01 [all_outputs]

# Power is cached until the activities change, so each case sets them again.
proc power_case { label } {
  puts $label
  set_power_activity -input_ports {a b} -density 0.02 -duty 0.5
  report_power -instances {u_skew u_bal} -digits 5
}

power_case "default"

# Values "" and "0" leave the model off.
set ::env(STA_POWER_GLITCH_ESTIMATE) 0
power_case "STA_POWER_GLITCH_ESTIMATE=0"

set ::env(STA_POWER_GLITCH_ESTIMATE) 1
power_case "STA_POWER_GLITCH_ESTIMATE=1"
