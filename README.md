# NexEBAZ4205_OV5640_HDMI

EBAZ4205 + hellofpga IO board + OV5640 camera → HDMI output

## Status

- [x] 프로젝트 생성
- [ ] OV5640 테스트 미완성

- OV5640 DVP 1280x720 RGB565 → 3:1 subsample → 320x240 BRAM → 2x upscale → 640x480
- HDMI output via rgb2dvi (Digilent)
- Vivado project: `vivado -mode batch -source vivado/build.tcl`

## Pin Map

### System

| Signal   | Pin | IOSTANDARD | Description        |
|----------|-----|------------|--------------------|
| CLK      | N18 | LVCMOS33   | 50MHz PL clock     |
| UART_TX  | H17 | LVCMOS33   | UART TX (CH340)    |

### HDMI (hellofpga IO board, TMDS)

| Signal      | Pin | IOSTANDARD | Description     |
|-------------|-----|------------|-----------------|
| HDMI_CLK_P  | F19 | TMDS_33    | TMDS clock +    |
| HDMI_CLK_N  | F20 | TMDS_33    | TMDS clock -    |
| HDMI_P[0]   | D19 | TMDS_33    | TMDS data0 +    |
| HDMI_N[0]   | D20 | TMDS_33    | TMDS data0 -    |
| HDMI_P[1]   | C20 | TMDS_33    | TMDS data1 +    |
| HDMI_N[1]   | B20 | TMDS_33    | TMDS data1 -    |
| HDMI_P[2]   | B19 | TMDS_33    | TMDS data2 +    |
| HDMI_N[2]   | A20 | TMDS_33    | TMDS data2 -    |

### OV5640 (hellofpga IO board 20-pin camera connector)

| Signal          | Pin | IOSTANDARD | Description         |
|-----------------|-----|------------|---------------------|
| ov5640_pclk     | J20 | LVCMOS33   | Pixel clock         |
| ov5640_vsync    | M17 | LVCMOS33   | Vertical sync       |
| ov5640_href     | N20 | LVCMOS33   | Horizontal ref      |
| ov5640_data[0]  | M20 | LVCMOS33   | Pixel data bit 0    |
| ov5640_data[1]  | L16 | LVCMOS33   | Pixel data bit 1    |
| ov5640_data[2]  | L17 | LVCMOS33   | Pixel data bit 2    |
| ov5640_data[3]  | L19 | LVCMOS33   | Pixel data bit 3    |
| ov5640_data[4]  | L20 | LVCMOS33   | Pixel data bit 4    |
| ov5640_data[5]  | J19 | LVCMOS33   | Pixel data bit 5    |
| ov5640_data[6]  | K19 | LVCMOS33   | Pixel data bit 6    |
| ov5640_data[7]  | H20 | LVCMOS33   | Pixel data bit 7    |
| ov5640_sioc     | P18 | LVCMOS33   | I2C SCL             |
| ov5640_siod     | M19 | LVCMOS33   | I2C SDA             |
| ov5640_reset    | M18 | LVCMOS33   | Reset (active low)  |
| ov5640_pwdn     | G19 | LVCMOS33   | Power down (active high) |
