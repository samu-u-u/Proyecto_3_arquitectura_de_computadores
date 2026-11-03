// PROYECTO 3: pochoco_soc adaptado a ASIC.
//   - reset externo i_Rst_n (reemplaza el POR de valor inicial del P2)
//   - sin MemFile/$readmemh: la memoria se elige con MEM_IMPL
//     MEM_IMPL=0: ROM combinacional + RAM de datos (estrategia a)
//     MEM_IMPL=1: memoria unificada de flip-flops (estrategia b)
// Los nombres de instancia se conservan para la trazabilidad (informe 3.3).
module pochoco_soc_asic #(
  parameter MEM_IMPL = 0
) (
  input  wire       i_Clk,
  input  wire       i_Rst_n,
  output wire [3:0] o_LED,
  input  wire [3:0] i_Btn,
  output wire       o_Segment1_A, o_Segment1_B, o_Segment1_C, o_Segment1_D,
  output wire       o_Segment1_E, o_Segment1_F, o_Segment1_G,
  output wire       o_Segment2_A, o_Segment2_B, o_Segment2_C, o_Segment2_D,
  output wire       o_Segment2_E, o_Segment2_F, o_Segment2_G,
  input  wire       i_SPI_SCLK,
  input  wire       i_SPI_MOSI,
  input  wire       i_SPI_CS_n,
  output wire       o_SPI_MISO
);
  wire clk    = i_Clk;
  wire rst_ni = i_Rst_n;   // en un chip completo este pad alimenta un POR

  wire        instr_req;
  wire [31:0] instr_addr, instr_rdata;
  wire        data_req, data_we;
  wire [3:0]  data_be;
  wire [31:0] data_addr, data_wdata, data_rdata;

  espino_core #(.BootAddr(32'h0000_0000)) u_core (
    .clk_i(clk), .rst_ni(rst_ni),
    .instr_req_o(instr_req), .instr_addr_o(instr_addr), .instr_rdata_i(instr_rdata),
    .data_req_o(data_req), .data_we_o(data_we), .data_be_o(data_be),
    .data_addr_o(data_addr), .data_wdata_o(data_wdata), .data_rdata_i(data_rdata)
  );

  wire is_mmio, spi_sel, per_sel;
  assign is_mmio = data_addr[31];
  assign per_sel = is_mmio & ~data_addr[16];
  assign spi_sel = is_mmio &  data_addr[16];

  wire ram_b_req, per_req, spi_req;
  assign ram_b_req = data_req & ~is_mmio;
  assign per_req   = data_req &  per_sel;
  assign spi_req   = data_req &  spi_sel;

  wire [31:0] ram_b_rdata, per_rdata, spi_rdata;

  reg rd_is_per, rd_is_spi;
  always @(posedge clk or negedge rst_ni) begin
    if (!rst_ni) begin
      rd_is_per <= 1'b0;
      rd_is_spi <= 1'b0;
    end else if (data_req & ~data_we) begin
      rd_is_per <= per_sel;
      rd_is_spi <= spi_sel;
    end
  end
  assign data_rdata = rd_is_per ? per_rdata :
                      rd_is_spi ? spi_rdata : ram_b_rdata;

  // ---- seleccion de estrategia de memoria ----
  generate
    if (MEM_IMPL == 0) begin : g_mem_rom_ram
      pochoco_rom  u_imem (.clk_i(clk), .a_req_i(instr_req),
                           .a_addr_i(instr_addr), .a_rdata_o(instr_rdata));
      pochoco_dram #(.NumWords(64)) u_dmem (
        .clk_i(clk), .b_req_i(ram_b_req), .b_we_i(data_we), .b_be_i(data_be),
        .b_addr_i(data_addr), .b_wdata_i(data_wdata), .b_rdata_o(ram_b_rdata));
    end else begin : g_mem_ff
      game_ffmem u_mem (
        .clk_i(clk), .rst_ni(rst_ni),
        .a_req_i(instr_req), .a_addr_i(instr_addr), .a_rdata_o(instr_rdata),
        .b_req_i(ram_b_req), .b_we_i(data_we), .b_be_i(data_be),
        .b_addr_i(data_addr), .b_wdata_i(data_wdata), .b_rdata_o(ram_b_rdata));
    end
  endgenerate

  wire [6:0] seg1, seg2;
  pochoco_periph u_periph (
    .clk_i(clk), .rst_ni(rst_ni), .sel_i(per_sel), .req_i(per_req),
    .we_i(data_we), .addr_i(data_addr[7:0]), .wdata_i(data_wdata),
    .rdata_o(per_rdata), .leds_o(o_LED), .btn_i(i_Btn),
    .seg1_o(seg1), .seg2_o(seg2)
  );

  pochoco_spi_slave u_spi (
    .clk_i(clk), .rst_ni(rst_ni), .sel_i(spi_sel), .req_i(spi_req),
    .we_i(data_we), .addr_i(data_addr[7:0]), .wdata_i(data_wdata),
    .rdata_o(spi_rdata),
    .spi_sclk_i(i_SPI_SCLK), .spi_mosi_i(i_SPI_MOSI),
    .spi_cs_n_i(i_SPI_CS_n), .spi_miso_o(o_SPI_MISO)
  );

  // polaridad activa-baja heredada del P2 (decision logica del macro)
  assign {o_Segment1_G, o_Segment1_F, o_Segment1_E, o_Segment1_D,
          o_Segment1_C, o_Segment1_B, o_Segment1_A} = ~seg1;
  assign {o_Segment2_G, o_Segment2_F, o_Segment2_E, o_Segment2_D,
          o_Segment2_C, o_Segment2_B, o_Segment2_A} = ~seg2;
endmodule