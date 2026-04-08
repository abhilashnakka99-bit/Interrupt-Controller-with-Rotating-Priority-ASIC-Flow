# Set the units (Check your library, usually ns and pF)
set_units -time ns -resistance kOhm -capacitance pF -voltage V -current mA

# 1. Create Clock (100MHz = 10ns period)
create_clock -name "clk" -period 10.0 [get_ports clk]

# 2. Input Delays (Assume 20% of clock period for setup)
set_input_delay -clock clk 2.0 [get_ports {reset irq[*] mask[*] cpu_ack}]

# 3. Output Delays (Assume 20% of clock period)
set_output_delay -clock clk 2.0 [get_ports {irq_req irq_to_cpu[*]}]

# 4. Set Driving Cell (Optional, but good for Innovus)
# Replace 'BUF_X1' and 'library_name' with actual names from your .lib
# set_driving_cell -lib_cell BUF_X1 [all_inputs]

# 5. Set Load
set_load 0.1 [all_outputs]

# 6. False Paths (If any - though here everything is synchronous)
set_false_path -from [get_ports reset]
