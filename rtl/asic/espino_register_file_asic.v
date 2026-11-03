// PROYECTO 3: registro de arquitectura sin la BRAM de la FPGA (SB_RAM40_4K).
// En la FPGA eran 2 bancos duplicados (4 x SB_RAM40_4K); en ASIC basta una
// matriz de 16x32 flip-flops con 2 puertos de lectura sincronos (mismo
// timing: READ_MODE 0 de la BRAM) y 1 puerto de escritura.
// x0: nunca se escribe (igual que en el P2) y SIEMPRE lee 0 (en la FPGA lo
// garantizaba INIT_0=0 de la BRAM; en ASIC se fuerza en el camino de lectura).
module espino_register_file (
  input  wire        clk_i,
  input  wire        rst_ni,     // sin uso: la BRAM tampoco se reseteaba
  input  wire [3:0]  raddr_a_i,
  output reg  [31:0] rdata_a_o,
  input  wire [3:0]  raddr_b_i,
  output reg  [31:0] rdata_b_o,
  input  wire [3:0]  waddr_i,
  input  wire [31:0] wdata_i,
  input  wire        we_i
);
  reg [31:0] bank [0:15];
  wire wr = we_i & (waddr_i != 4'd0);   // x0 no se escribe

  always @(posedge clk_i) begin
    if (wr) bank[waddr_i] <= wdata_i;
    rdata_a_o <= (raddr_a_i == 4'd0) ? 32'b0 : bank[raddr_a_i];
    rdata_b_o <= (raddr_b_i == 4'd0) ? 32'b0 : bank[raddr_b_i];
  end

  wire _unused = &{1'b0, rst_ni};
endmodule