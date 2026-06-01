# NexEBAZ4205_OV5640_HDMI constraints
# EBAZ4205 + hellofpga IO board 20-pin camera connector

# Clock: 50MHz PL oscillator
set_property -dict {PACKAGE_PIN N18 IOSTANDARD LVCMOS33} [get_ports CLK]
create_clock -period 20.000 -name sys_clk -waveform {0.000 10.000} [get_ports CLK]

# UART TX (hellofpga Type-C CH340, H17)
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [get_ports UART_TX]

# HDMI (TMDS, hellofpga IO board)
set_property -dict {PACKAGE_PIN F20 IOSTANDARD TMDS_33} [get_ports HDMI_CLK_N]
set_property -dict {PACKAGE_PIN F19 IOSTANDARD TMDS_33} [get_ports HDMI_CLK_P]
set_property -dict {PACKAGE_PIN D20 IOSTANDARD TMDS_33} [get_ports {HDMI_N[0]}]
set_property -dict {PACKAGE_PIN D19 IOSTANDARD TMDS_33} [get_ports {HDMI_P[0]}]
set_property -dict {PACKAGE_PIN B20 IOSTANDARD TMDS_33} [get_ports {HDMI_N[1]}]
set_property -dict {PACKAGE_PIN C20 IOSTANDARD TMDS_33} [get_ports {HDMI_P[1]}]
set_property -dict {PACKAGE_PIN A20 IOSTANDARD TMDS_33} [get_ports {HDMI_N[2]}]
set_property -dict {PACKAGE_PIN B19 IOSTANDARD TMDS_33} [get_ports {HDMI_P[2]}]

# OV5640 - hellofpga IO board 20-pin camera connector
# connector(FPGA) ↔ camera signal
set_property -dict {PACKAGE_PIN M17 IOSTANDARD LVCMOS33} [get_ports ov5640_vsync]
set_property -dict {PACKAGE_PIN N20 IOSTANDARD LVCMOS33} [get_ports ov5640_href]
set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports ov5640_reset]
set_property -dict {PACKAGE_PIN P18 IOSTANDARD LVCMOS33 PULLUP true} [get_ports ov5640_sioc]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVCMOS33 PULLUP true} [get_ports ov5640_siod]
set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[0]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[1]}]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[2]}]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[3]}]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[4]}]
set_property -dict {PACKAGE_PIN J19 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[5]}]
set_property -dict {PACKAGE_PIN K19 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[6]}]
set_property -dict {PACKAGE_PIN H20 IOSTANDARD LVCMOS33} [get_ports {ov5640_data[7]}]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD LVCMOS33} [get_ports ov5640_pclk]
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports ov5640_pwdn]

# J18, K18: 미연결 (카메라 모듈에 XCLK 핀 없음, 모듈 내부 오실레이터)

# PCLK은 non-SRCC 핀(J20)이므로 BUFG 경로 허용
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets ov5640_pclk_IBUF]
