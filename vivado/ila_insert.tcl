# ila_insert.tcl
# OV5640 I2C / camera signal debug
# Usage: opt_design tcl.pre  OR  source ila_insert.tcl in TCL console

# --- ILA core ---
create_debug_core u_ila_0 ila
set_property C_DATA_DEPTH        131072 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN         false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN        false [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER       false [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL      true  [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 2   [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0     [get_debug_cores u_ila_0]

# --- clock: 25MHz ---
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets clk_25]

# --- probe0: config_done ---
set_property port_width 1 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets config_done]

# --- probe1: i2c_scl (fabric debug signal inside i2c_config) ---
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets u_i2c_config/scl_dbg]

# --- probe2: sda_actual (physical SDA bus = master + slave ACK) ---
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets u_i2c_config/sda_actual]

# --- probe3: vsync ---
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets ov5640_vsync_IBUF]

# --- probe4: href ---
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets ov5640_href_IBUF]

# --- probe5: camera_active ---
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets camera_active]

# --- probe6: clk12_5_dbg ---
create_debug_port u_ila_0 probe
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets clk12_5_dbg]


set_property C_CLK_INPUT_FREQ_HZ 25000000 [get_debug_cores dbg_hub]

implement_debug_core
