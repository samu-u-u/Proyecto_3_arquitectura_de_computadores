// PROYECTO 3: memoria de instrucciones como ROM combinacional (game_rom,
// generada por el assembler) con registro de salida para conservar el
// timing de la RAM original del P2 (lectura registrada si a_req).
module pochoco_rom (
  input  wire        clk_i,
  input  wire        a_req_i,
  input  wire [31:0] a_addr_i,
  output reg  [31:0] a_rdata_o
);
  wire [31:0] rom_data;
  game_rom u_rom (.addr_i(a_addr_i), .rdata_o(rom_data));
  always @(posedge clk_i) begin
    if (a_req_i) a_rdata_o <= rom_data;
  end
endmodule