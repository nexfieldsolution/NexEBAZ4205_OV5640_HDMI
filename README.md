# NexEBAZ4205_OV5640_HDMI

EBAZ4205 + hellofpga IO board + OV5640 camera → HDMI output

## Status

- [x] 프로젝트 생성 (2026-05-15)
- [x] HDMI 컬러바 출력 확인 (5색: White / Yellow / Cyan / Green / Purple)
- [ ] OV5640 영상 미확인
  - vsync 미감지 → camera_active=0 유지 → 컬러바만 출력
  - OV5640은 XCLK 필수. 카메라 모듈 내장 오실레이터 유무 확인 필요
  - FPGA에서 24MHz XCLK 공급 추가 (J18 핀, 2026-05-22)

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

## 하드웨어 점퍼 변경 내역
- ov5640_reset 핀: M18 → G20 으로 JUMPER (M18 트레이스 절단)
- ov5640_pclk 핀: J20 → J18 으로 JUMPER (J20은 non-SRCC → J18(MRCC P-type)로 변경. K18은 N-type CCIO라 불가)

| Signal          | Pin | IOSTANDARD | Description                    |
|-----------------|-----|------------|--------------------------------|
| ov5640_pclk     | J18 | LVCMOS33   | Pixel clock (MRCC P-type, 54MHz)|
| ov5640_vsync    | M17 | LVCMOS33   | Vertical sync            |
| ov5640_href     | N20 | LVCMOS33   | Horizontal ref           |
| ov5640_data[0]  | M20 | LVCMOS33   | Pixel data bit 0         |
| ov5640_data[1]  | L16 | LVCMOS33   | Pixel data bit 1         |
| ov5640_data[2]  | L17 | LVCMOS33   | Pixel data bit 2         |
| ov5640_data[3]  | L19 | LVCMOS33   | Pixel data bit 3         |
| ov5640_data[4]  | L20 | LVCMOS33   | Pixel data bit 4         |
| ov5640_data[5]  | J19 | LVCMOS33   | Pixel data bit 5         |
| ov5640_data[6]  | K19 | LVCMOS33   | Pixel data bit 6         |
| ov5640_data[7]  | H20 | LVCMOS33   | Pixel data bit 7         |
| ov5640_sioc     | P18 | LVCMOS33   | I2C SCL                  |
| ov5640_siod     | M19 | LVCMOS33   | I2C SDA                  |
| ov5640_reset    | G20 | LVCMOS33   | Reset (active low)       |   (OV5640 모듈의 ㅡ18 핀을 끊고, IO보드의 G18 로 점프함)
| ov5640_pwdn     | G19 | LVCMOS33   | Power down (active high) |
