###################################################################

# Created by write_sdc on Fri May 30 17:49:31 2025

###################################################################
set sdc_version 2.1

# 기본 단위 설정
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports n_rst]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[7]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[6]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[5]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[4]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[3]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[2]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[1]}]
set_driving_cell -max -lib_cell INVX0_RVT -no_design_rule [get_ports {din[0]}]
set_load -pin_load 7.08126 [get_ports {dout[7]}]
set_load -pin_load 7.08126 [get_ports {dout[6]}]
set_load -pin_load 7.08126 [get_ports {dout[5]}]
set_load -pin_load 7.08126 [get_ports {dout[4]}]
set_load -pin_load 7.08126 [get_ports {dout[3]}]
set_load -pin_load 7.08126 [get_ports {dout[2]}]
set_load -pin_load 7.08126 [get_ports {dout[1]}]
set_load -pin_load 7.08126 [get_ports {dout[0]}]
set_max_capacitance 2.36042 [get_ports n_rst]
set_max_capacitance 2.36042 [get_ports {din[7]}]
set_max_capacitance 2.36042 [get_ports {din[6]}]
set_max_capacitance 2.36042 [get_ports {din[5]}]
set_max_capacitance 2.36042 [get_ports {din[4]}]
set_max_capacitance 2.36042 [get_ports {din[3]}]
set_max_capacitance 2.36042 [get_ports {din[2]}]
set_max_capacitance 2.36042 [get_ports {din[1]}]
set_max_capacitance 2.36042 [get_ports {din[0]}]
create_clock [get_ports clk]  -period 10  -waveform {0 5}
set_clock_latency -max 0.5  [get_clocks clk]
set_clock_latency -source -max 0.5  [get_clocks clk]
set_clock_uncertainty -setup 0.2  [get_clocks clk]
set_clock_transition -max -rise 0.2 [get_clocks clk]
set_clock_transition -max -fall 0.2 [get_clocks clk]
set_input_delay -clock clk  -max 6  [get_ports {din[7]}]
set_input_delay -clock clk  -max 6  [get_ports {din[6]}]
set_input_delay -clock clk  -max 6  [get_ports {din[5]}]
set_input_delay -clock clk  -max 6  [get_ports {din[4]}]
set_input_delay -clock clk  -max 6  [get_ports {din[3]}]
set_input_delay -clock clk  -max 6  [get_ports {din[2]}]
set_input_delay -clock clk  -max 6  [get_ports {din[1]}]
set_input_delay -clock clk  -max 6  [get_ports {din[0]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[7]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[6]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[5]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[4]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[3]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[2]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[1]}]
set_output_delay -clock clk  -max 4  [get_ports {dout[0]}]

# 1. 타이밍 경로가 존재하도록 입력 지연 부여
# set_input_delay -clock clk  -max 0.2  [get_ports n_rst]

set_input_delay -clock clk -max 0.0 [get_ports n_rst]
set_input_delay -clock clk -min 1.0 [get_ports n_rst]

# 2. false path 해제 (혹시 자동으로 설정된 경우 대비)
#remove_false_path -from [get_ports n_rst]