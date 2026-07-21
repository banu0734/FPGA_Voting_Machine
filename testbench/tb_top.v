############################################################
## Clock
############################################################

set_property PACKAGE_PIN W5 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]
create_clock -period 10.000 -name sys_clk_pin -waveform {0 5} [get_ports clk]

############################################################
## Push Buttons
############################################################

# Party A (BTNU)
set_property PACKAGE_PIN T18 [get_ports btnA]
set_property IOSTANDARD LVCMOS33 [get_ports btnA]

# Party B (BTNL)
set_property PACKAGE_PIN W19 [get_ports btnB]
set_property IOSTANDARD LVCMOS33 [get_ports btnB]

# Party C (BTNC)
set_property PACKAGE_PIN U18 [get_ports btnC]
set_property IOSTANDARD LVCMOS33 [get_ports btnC]

# Party D (BTNR)
set_property PACKAGE_PIN T17 [get_ports btnD]
set_property IOSTANDARD LVCMOS33 [get_ports btnD]

# Party E (BTND)
set_property PACKAGE_PIN U17 [get_ports btnE]
set_property IOSTANDARD LVCMOS33 [get_ports btnE]

############################################################
## Reset Switch (SW15)
############################################################

set_property PACKAGE_PIN R2 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]

############################################################
## Slide Switches
############################################################

# Display Party A
set_property PACKAGE_PIN V17 [get_ports swA]
set_property IOSTANDARD LVCMOS33 [get_ports swA]

# Display Party B
set_property PACKAGE_PIN V16 [get_ports swB]
set_property IOSTANDARD LVCMOS33 [get_ports swB]

# Display Party C
set_property PACKAGE_PIN W16 [get_ports swC]
set_property IOSTANDARD LVCMOS33 [get_ports swC]

# Display Party D
set_property PACKAGE_PIN W17 [get_ports swD]
set_property IOSTANDARD LVCMOS33 [get_ports swD]

# Display Party E
set_property PACKAGE_PIN W15 [get_ports swE]
set_property IOSTANDARD LVCMOS33 [get_ports swE]

############################################################
## Seven Segment Display Segments
############################################################

set_property PACKAGE_PIN W7 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN W6 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]

set_property PACKAGE_PIN U8 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]

set_property PACKAGE_PIN V8 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]

set_property PACKAGE_PIN U5 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]

set_property PACKAGE_PIN V5 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]

set_property PACKAGE_PIN U7 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]

############################################################
## Seven Segment Anodes
############################################################

set_property PACKAGE_PIN U2 [get_ports {an[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]

set_property PACKAGE_PIN U4 [get_ports {an[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[1]}]

set_property PACKAGE_PIN V4 [get_ports {an[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[2]}]

set_property PACKAGE_PIN W4 [get_ports {an[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {an[3]}]
