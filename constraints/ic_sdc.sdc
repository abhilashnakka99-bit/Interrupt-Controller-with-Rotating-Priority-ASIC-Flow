# ####################################################################

#  Created by Genus(TM) Synthesis Solution 21.14-s082_1 on Wed Apr 08 16:35:39 IST 2026

# ####################################################################

set sdc_version 2.0

set_units -capacitance 1000fF
set_units -time 1000ps

# Set the current design
current_design pic_top

create_clock -name "clk" -period 10.0 -waveform {0.0 5.0} [get_ports clk]
set_load -pin_load 0.1 [get_ports irq_req]
set_load -pin_load 0.1 [get_ports {irq_to_cpu[2]}]
set_load -pin_load 0.1 [get_ports {irq_to_cpu[1]}]
set_load -pin_load 0.1 [get_ports {irq_to_cpu[0]}]
set_false_path -from [get_ports reset]
set_clock_gating_check -setup 0.0 
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports reset]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[7]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[6]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[5]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[4]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[3]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[2]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[1]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {mask[0]}]
set_input_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports cpu_ack]
set_output_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports irq_req]
set_output_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq_to_cpu[2]}]
set_output_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq_to_cpu[1]}]
set_output_delay -clock [get_clocks clk] -add_delay 2.0 [get_ports {irq_to_cpu[0]}]
set_wire_load_mode "enclosed"
