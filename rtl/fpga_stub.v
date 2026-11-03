// Stub (* blackbox *) de la BRAM de la iCE40 - SOLO para la corrida
// exploratoria de evidencia (informe 3.1). En ASIC no existe.
(* blackbox *)
module SB_RAM40_4K #(
  parameter [0:0]   READ_MODE  = 1'b0,
  parameter [0:0]   WRITE_MODE = 1'b0,
  parameter [255:0] INIT_0     = 256'h0
) (
  output [15:0] RDATA,
  input  [10:0] RADDR,
  input         RCLK, RCLKE, RE,
  input  [15:0] WDATA,
  input  [10:0] WADDR,
  input         WCLK, WCLKE, WE,
  input  [15:0] MASK
);
endmodule