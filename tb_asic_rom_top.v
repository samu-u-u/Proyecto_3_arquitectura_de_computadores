`timescale 1ns/1ps
module tb_asic_rom_top;
  reg clk = 1'b0;
  reg rst_n = 1'b0;
  reg [3:0] btn = 4'b0000;
  reg spi_sclk = 0, spi_mosi = 0, spi_cs_n = 1;
  wire [3:0] led;
  wire s1a,s1b,s1c,s1d,s1e,s1f,s1g;
  wire s2a,s2b,s2c,s2d,s2e,s2f,s2g;
  wire spi_miso;

  asic_rom_top dut (
    .i_Clk(clk), .i_Rst_n(rst_n), .i_Btn(btn), .o_LED(led),
    .o_Segment1_A(s1a), .o_Segment1_B(s1b), .o_Segment1_C(s1c),
    .o_Segment1_D(s1d), .o_Segment1_E(s1e), .o_Segment1_F(s1f), .o_Segment1_G(s1g),
    .o_Segment2_A(s2a), .o_Segment2_B(s2b), .o_Segment2_C(s2c),
    .o_Segment2_D(s2d), .o_Segment2_E(s2e), .o_Segment2_F(s2f), .o_Segment2_G(s2g),
    .i_SPI_SCLK(spi_sclk), .i_SPI_MOSI(spi_mosi),
    .i_SPI_CS_n(spi_cs_n), .o_SPI_MISO(spi_miso)
  );

  always #20 clk = ~clk;             // 25 MHz como el GoBoard

  always @(led) $display("%0t ns: >>> LED cambia a %b", $time, led);

  initial begin
    repeat (10) @(posedge clk);
    rst_n = 1'b1;
    $display("--- Reset liberado ---");
  end

  initial begin
    #1_000_000;                     // 20 ms simulados
    $display("--- Fin: LED=%b ---", led);
    $finish;
  end
endmodule
