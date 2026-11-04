`timescale 1ns/1ps
// Modelos funcionales v2 - pines verificados contra el netlist real
// AND / OR
module gf180mcu_fd_sc_mcu7t5v0__and2_1(A1,A2,Z);input A1,A2;output Z;assign Z=A1&A2;endmodule
module gf180mcu_fd_sc_mcu7t5v0__and3_1(A1,A2,A3,Z);input A1,A2,A3;output Z;assign Z=A1&A2&A3;endmodule
module gf180mcu_fd_sc_mcu7t5v0__and4_1(A1,A2,A3,A4,Z);input A1,A2,A3,A4;output Z;assign Z=A1&A2&A3&A4;endmodule
module gf180mcu_fd_sc_mcu7t5v0__or2_1(A1,A2,Z);input A1,A2;output Z;assign Z=A1|A2;endmodule
module gf180mcu_fd_sc_mcu7t5v0__or3_1(A1,A2,A3,Z);input A1,A2,A3;output Z;assign Z=A1|A2|A3;endmodule
module gf180mcu_fd_sc_mcu7t5v0__or4_1(A1,A2,A3,A4,Z);input A1,A2,A3,A4;output Z;assign Z=A1|A2|A3|A4;endmodule
// NAND / NOR / INV / XNOR
module gf180mcu_fd_sc_mcu7t5v0__nand2_1(A1,A2,ZN);input A1,A2;output ZN;assign ZN=!(A1&A2);endmodule
module gf180mcu_fd_sc_mcu7t5v0__nand3_1(A1,A2,A3,ZN);input A1,A2,A3;output ZN;assign ZN=!(A1&A2&A3);endmodule
module gf180mcu_fd_sc_mcu7t5v0__nand4_1(A1,A2,A3,A4,ZN);input A1,A2,A3,A4;output ZN;assign ZN=!(A1&A2&A3&A4);endmodule
module gf180mcu_fd_sc_mcu7t5v0__nor2_1(A1,A2,ZN);input A1,A2;output ZN;assign ZN=!(A1|A2);endmodule
module gf180mcu_fd_sc_mcu7t5v0__nor3_1(A1,A2,A3,ZN);input A1,A2,A3;output ZN;assign ZN=!(A1|A2|A3);endmodule
module gf180mcu_fd_sc_mcu7t5v0__nor3_2(A1,A2,A3,ZN);input A1,A2,A3;output ZN;assign ZN=!(A1|A2|A3);endmodule
module gf180mcu_fd_sc_mcu7t5v0__nor4_1(A1,A2,A3,A4,ZN);input A1,A2,A3,A4;output ZN;assign ZN=!(A1|A2|A3|A4);endmodule
module gf180mcu_fd_sc_mcu7t5v0__xnor2_1(A1,A2,ZN);input A1,A2;output ZN;assign ZN=!(A1^A2);endmodule
module gf180mcu_fd_sc_mcu7t5v0__xnor3_1(A1,A2,A3,ZN);input A1,A2,A3;output ZN;assign ZN=!(A1^A2^A3);endmodule
module gf180mcu_fd_sc_mcu7t5v0__inv_2(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__inv_3(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__inv_4(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__inv_8(I,ZN);input I;output ZN;assign ZN=!I;endmodule
// XOR
module gf180mcu_fd_sc_mcu7t5v0__xor2_1(A1,A2,Z);input A1,A2;output Z;assign Z=A1^A2;endmodule
module gf180mcu_fd_sc_mcu7t5v0__xor3_1(A1,A2,A3,Z);input A1,A2,A3;output Z;assign Z=A1^A2^A3;endmodule
// AOI (pines unicos: B, C - salida ZN)
module gf180mcu_fd_sc_mcu7t5v0__aoi21_1(A1,A2,B,ZN);input A1,A2,B;output ZN;assign ZN=!((A1&A2)|B);endmodule
module gf180mcu_fd_sc_mcu7t5v0__aoi22_1(A1,A2,B1,B2,ZN);input A1,A2,B1,B2;output ZN;assign ZN=!((A1&A2)|(B1&B2));endmodule
module gf180mcu_fd_sc_mcu7t5v0__aoi211_1(A1,A2,B,C,ZN);input A1,A2,B,C;output ZN;assign ZN=!((A1&A2)|B|C);endmodule
module gf180mcu_fd_sc_mcu7t5v0__aoi221_1(A1,A2,B1,B2,C,ZN);input A1,A2,B1,B2,C;output ZN;assign ZN=!((A1&A2)|(B1&B2)|C);endmodule
module gf180mcu_fd_sc_mcu7t5v0__aoi222_1(A1,A2,B1,B2,C1,C2,ZN);input A1,A2,B1,B2,C1,C2;output ZN;assign ZN=!((A1&A2)|(B1&B2)|(C1&C2));endmodule
// OAI (pines unicos: B, C - salida ZN)
module gf180mcu_fd_sc_mcu7t5v0__oai21_1(A1,A2,B,ZN);input A1,A2,B;output ZN;assign ZN=!((A1|A2)&B);endmodule
module gf180mcu_fd_sc_mcu7t5v0__oai22_1(A1,A2,B1,B2,ZN);input A1,A2,B1,B2;output ZN;assign ZN=!((A1|A2)&(B1|B2));endmodule
module gf180mcu_fd_sc_mcu7t5v0__oai211_1(A1,A2,B,C,ZN);input A1,A2,B,C;output ZN;assign ZN=!((A1|A2)&B&C);endmodule
module gf180mcu_fd_sc_mcu7t5v0__oai221_1(A1,A2,B1,B2,C,ZN);input A1,A2,B1,B2,C;output ZN;assign ZN=!((A1|A2)&(B1|B2)&C);endmodule
module gf180mcu_fd_sc_mcu7t5v0__oai222_1(A1,A2,B1,B2,C1,C2,ZN);input A1,A2,B1,B2,C1,C2;output ZN;assign ZN=!((A1|A2)&(B1|B2)&(C1|C2));endmodule
module gf180mcu_fd_sc_mcu7t5v0__oai31_1(A1,A2,A3,B,ZN);input A1,A2,A3,B;output ZN;assign ZN=!((A1|A2|A3)&B);endmodule
module gf180mcu_fd_sc_mcu7t5v0__oai32_1(A1,A2,A3,B1,B2,ZN);input A1,A2,A3,B1,B2;output ZN;assign ZN=!((A1|A2|A3)&(B1|B2));endmodule
// MUX
module gf180mcu_fd_sc_mcu7t5v0__mux2_2(I0,I1,S,Z);input I0,I1,S;output Z;assign Z=S?I1:I0;endmodule
module gf180mcu_fd_sc_mcu7t5v0__mux4_1(I0,I1,I2,I3,S0,S1,Z);input I0,I1,I2,I3,S0,S1;output Z;assign Z=S1?(S0?I3:I2):(S0?I1:I0);endmodule
// Buffers y reloj (entrada I)
module gf180mcu_fd_sc_mcu7t5v0__buf_1(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__buf_2(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__buf_3(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__buf_4(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkbuf_1(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkbuf_2(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkbuf_3(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkbuf_4(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkbuf_8(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkbuf_16(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkinv_1(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkinv_2(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkinv_4(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__clkinv_8(I,ZN);input I;output ZN;assign ZN=!I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__dlyb_1(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__dlyc_1(I,Z);input I;output Z;assign Z=I;endmodule
module gf180mcu_fd_sc_mcu7t5v0__antenna(I,Z);input I;output Z;assign Z=I;endmodule
// Flip-flops
module gf180mcu_fd_sc_mcu7t5v0__dffq_1(D,CLK,Q);input D,CLK;output reg Q;always@(posedge CLK)Q<=D;endmodule
module gf180mcu_fd_sc_mcu7t5v0__dffrnq_1(D,CLK,RN,Q);input D,CLK,RN;output reg Q;always@(posedge CLK or negedge RN)if(!RN)Q<=1'b0;else Q<=D;endmodule
module gf180mcu_fd_sc_mcu7t5v0__dffsnq_1(D,CLK,SETN,Q);input D,CLK,SETN;output reg Q;always@(posedge CLK or negedge SETN)if(!SETN)Q<=1'b1;else Q<=D;endmodule
// Celdas fisicas sin funcion
module gf180mcu_fd_sc_mcu7t5v0__fill_1();endmodule
module gf180mcu_fd_sc_mcu7t5v0__fill_2();endmodule
module gf180mcu_fd_sc_mcu7t5v0__filltie();endmodule
module gf180mcu_fd_sc_mcu7t5v0__fillcap_4();endmodule
module gf180mcu_fd_sc_mcu7t5v0__fillcap_8();endmodule
module gf180mcu_fd_sc_mcu7t5v0__fillcap_16();endmodule
module gf180mcu_fd_sc_mcu7t5v0__fillcap_32();endmodule
module gf180mcu_fd_sc_mcu7t5v0__fillcap_64();endmodule
module gf180mcu_fd_sc_mcu7t5v0__endcap();endmodule
