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
#set_property -dict {PACKAGE_PIN M18 IOSTANDARD LVCMOS33} [get_ports ov5640_reset]
# connector NC pin → jumper to camera RST pin
set_property -dict {PACKAGE_PIN G20 IOSTANDARD LVCMOS33} [get_ports ov5640_reset] 
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
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVCMOS33} [get_ports ov5640_pclk]
set_property -dict {PACKAGE_PIN G19 IOSTANDARD LVCMOS33} [get_ports ov5640_pwdn]

# G20: ov5640_reset (connector NC pin → jumper to camera RST pin)
# J18: PCLK (MRCC P-type, J20→J18 점퍼로 변경. 카메라 모듈 내부 오실레이터 54MHz)
# K18: 미연결 (N-type CCIO, 단일종단 클럭 입력 불가)

# PCLK: MRCC P-type 핀(J18), BUFG 라우팅 가능 (CLOCK_DEDICATED_ROUTE 불필요)
# create_clock이 없으면 pclk 도메인 FF이 unconstrained → 타이밍 미검사
create_clock -period 18.519 -name pclk [get_ports ov5640_pclk]

# pclk ↔ clk25: 비동기 클럭 도메인, CDC 경로 timing 검사 제외
set_clock_groups -asynchronous -group [get_clocks pclk] -group [get_clocks clk25_buf]
