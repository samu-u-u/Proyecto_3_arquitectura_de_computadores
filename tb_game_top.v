`timescale 1ns/1ps
module tb_game_top;
  reg clk = 1'b0;
  reg [3:0] btn = 4'b0000;          // SW1-SW4 sin presionar (activo alto)
  reg spi_sclk = 0, spi_mosi = 0, spi_cs_n = 1;
  wire [3:0] led;
  wire s1a,s1b,s1c,s1d,s1e,s1f,s1g;
  wire s2a,s2b,s2c,s2d,s2e,s2f,s2g;
  wire spi_miso;

  game_top dut (
    .i_Clk(clk), .o_LED(led), .i_Switch(btn),
    .o_Segment1_A(s1a), .o_Segment1_B(s1b), .o_Segment1_C(s1c),
    .o_Segment1_D(s1d), .o_Segment1_E(s1e), .o_Segment1_F(s1f), .o_Segment1_G(s1g),
    .o_Segment2_A(s2a), .o_Segment2_B(s2b), .o_Segment2_C(s2c),
    .o_Segment2_D(s2d), .o_Segment2_E(s2e), .o_Segment2_F(s2f), .o_Segment2_G(s2g),
    .i_SPI_SCLK(spi_sclk), .i_SPI_MOSI(spi_mosi),
    .i_SPI_CS_n(spi_cs_n), .o_SPI_MISO(spi_miso)
  );

  always #20 clk = ~clk;             // 25 MHz

  wire [31:0] pc = dut.u_pochoco.u_core.u_if.pc_q;
  reg [31:0] last_pc = 32'hDEADBEEF;
  integer prints = 0;

  always @(posedge clk) begin
    if (pc !== last_pc && prints < 300) begin
      $display("%0t ns: PC=%03x  instr=%08x  LED=%b  stall=%b",
               $time, pc, dut.u_pochoco.u_core.instr_rdata_i, led,
               dut.u_pochoco.u_core.u_if.stall_i);
      last_pc <= pc;
      prints = prints + 1;
    end
  end

  always @(led) $display("%0t ns: >>> LED cambia a %b", $time, led);

  initial begin
    #2_000_000;                      // 2 ms simulados
    $display("--- Fin: LED=%b  PC=%03x ---", led, pc);
    $finish;
  end
endmodule