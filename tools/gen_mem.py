def _pow2_round(n):
    p = 1
    while p < n:
        p <<= 1
    return p

def generar_memorias_verilog(palabras, salida_hex):
    base = salida_hex.rsplit(".", 1)[0]
    n = len(palabras)
    npow = _pow2_round(n)
    addrw = max((npow - 1).bit_length(), 1)

    L = []
    L.append("// GENERADO AUTOMATICAMENTE por tools/gen_mem.py - NO EDITAR")
    L.append(f"// {n} palabras de instruccion ({npow} con relleno de ceros)")
    L.append("module game_rom (")
    L.append("  input  wire [31:0] addr_i,")
    L.append("  output wire [31:0] rdata_o")
    L.append(");")
    L.append(f"  wire [{addrw-1}:0] w = addr_i[{addrw+1}:2];")
    L.append("  reg [31:0] data;")
    L.append("  always @(*) begin")
    L.append("    case (w)")
    for i, p in enumerate(palabras):
        L.append(f"      {addrw}'d{i}: data = 32'h{p:08x};")
    L.append("      default: data = 32'h00000000;")
    L.append("    endcase")
    L.append("  end")
    L.append("  assign rdata_o = data;")
    L.append("endmodule")
    with open(base + "_rom.v", "w", encoding="utf-8") as f:
        f.write("\n".join(L) + "\n")

    L = []
    L.append("// GENERADO AUTOMATICAMENTE por tools/gen_mem.py - NO EDITAR")
    L.append(f"// {npow} palabras x 32 bits = {npow*32} flip-flops")
    L.append("module game_ffmem (")
    L.append("  input  wire        clk_i,")
    L.append("  input  wire        rst_ni,")
    L.append("  input  wire        a_req_i,")
    L.append("  input  wire [31:0] a_addr_i,")
    L.append("  output reg  [31:0] a_rdata_o,")
    L.append("  input  wire        b_req_i,")
    L.append("  input  wire        b_we_i,")
    L.append("  input  wire [3:0]  b_be_i,")
    L.append("  input  wire [31:0] b_addr_i,")
    L.append("  input  wire [31:0] b_wdata_i,")
    L.append("  output reg  [31:0] b_rdata_o")
    L.append(");")
    L.append(f"  localparam AW = {addrw};")
    L.append(f"  reg [{npow*32-1}:0] mem;")
    L.append("  wire [AW-1:0] a_word = a_addr_i[AW+1:2];")
    L.append("  wire [AW-1:0] b_word = b_addr_i[AW+1:2];")
    for g in range(npow):
        p = palabras[g] if g < n else 0
        L.append(f"  wire hit_{g} = b_req_i & b_we_i & (b_word == {addrw}'d{g});")
        L.append("  always @(posedge clk_i or negedge rst_ni) begin")
        L.append("    if (!rst_ni) begin")
        for b in range(4):
            byte = (p >> (8 * b)) & 0xFF
            L.append(f"      mem[{g}*32 + {b*8} +: 8] <= 8'h{byte:02x};")
        L.append("    end else begin")
        for b in range(4):
            L.append(f"      if (hit_{g} & b_be_i[{b}]) mem[{g}*32 + {b*8} +: 8] <= b_wdata_i[{b*8} +: 8];")
        L.append("    end")
        L.append("  end")
    L.append("  always @(posedge clk_i) begin")
    L.append("    if (a_req_i) a_rdata_o <= mem[a_word*32 +: 32];")
    L.append("    b_rdata_o <= mem[b_word*32 +: 32];")
    L.append("  end")
    L.append("endmodule")
    with open(base + "_ffmem.v", "w", encoding="utf-8") as f:
        f.write("\n".join(L) + "\n")
