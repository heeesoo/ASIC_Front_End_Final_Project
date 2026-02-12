# Clock Setting 

create_clock -period 10 [get_ports clk]                                     ;# 1. clk 주기 설정.
                                                                            
set_clock_uncertainty -setup 0.2 [get_clocks clk]                           ;# 2. clk 불확실성을 setup time 기준으로 설정 
                                                                            
set_clock_transition -max 0.2 [get_clocks clk]                              ;# 3. transition time

set_clock_latency -source -max 0.5 [get_clocks clk]                         ;# source latency (Insertion Delay)

set_clock_latency -max 0.5 [get_clocks clk]                                 ;# 5. network latency (Insertion Delay)

# set_propagated_clock [get_ports clk]                                      ;# used in post-CTS (transition time, network latency not needed)
                                                                            ;# BackEnd에서 처리


# Input/Output Ports Setting

set_input_delay -max 6.0 -clock clk [get_ports din]


set_output_delay -max 4.0 -clock clk [get_ports dout]



set ALL_INPUT_EXC_CLK [remove_from_collection [all_inputs] [get_ports clk]]

set_driving_cell -max -no_design_rule -lib_cell INVX0_RVT $ALL_INPUT_EXC_CLK

set MAX_LOAD [expr {[load_of saed32rvt_ss0p95v125c/AND2X1_RVT/A1] * 5}]

set_max_capacitance $MAX_LOAD $ALL_INPUT_EXC_CLK

set_load -max [expr {$MAX_LOAD * 3 }] [all_outputs]
