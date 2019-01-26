module cpu (
  output [7:0]  led,
  output [15:0] seg0,
  output [15:0] seg1,
  output [15:0] seg2,
  output [15:0] seg3,
  output [15:0] seg4,
  output [15:0] seg5,
  output [15:0] seg6,
  output [15:0] seg7,
  output [15:0] seg8,
  output [15:0] seg9,
  output [15:0] sega,
  output [15:0] segb,
  output [15:0] segc,
  output [15:0] segd,
  output [15:0] sege,
  output [15:0] segf,
  input  start,
  input  stop,
  input  CLK,
  input  RSTN
  );	

  wire [3:0] ph;
  wire [15:0] w_imem, w_dmem;
  wire [15:0] w_pc,w_pc1, w_ir,w_irp1,w_irp2, w_sr1, w_sr2,w_alu, w_dr;
  wire [15:0] r0, r1, r2, r3, r4, r5, r6, r7;
  // Add wire/reg declarations here, if necessary.

  assign led = {4'b0000, ph[3:0]};
  assign seg0 = r0;
  assign seg1 = r1;
  assign seg2 = r2;
  assign seg3 = r3;
  assign seg4 = r4;
  assign seg5 = r5;
  assign seg6 = r6;
  assign seg7 = r7;
  assign seg8 = w_pc;
  assign seg9 = w_ir;
  assign sega = w_sr1;
  assign segb = w_sr2;
  assign segc = w_alu;
  assign segd = w_dr;
  assign sege = 16'h0000;
  assign segf = 16'h0000;

  // Add descriptions here, if necessary.

  // Add missing connections to following ports.
  //  pc.inc, pc.load, regfile.load, regfile.d
  //  ir.load, sr1.load, sr2.load, dr.load, dmem.wren

  sm sm (
    .q(ph), 
    .start(start), 
    .stop(stop), 
    .CLK(CLK), 
    .RSTN(RSTN)
  );

  count16rle pc (
    .q(w_pc),
    .load(ph[3] & w_irp2[15:11] == 5'b10000 || ph[3] & w_irp2[15:11] == 5'b10001 || ph[3] & w_irp2[15:14] == 2'b11 || ph[3] & w_irp2[15:11] == 5'b10010),
    .inc(ph[0]),
    .d(w_alu),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  count16rle pc1 (
    .q(w_pc1),
    .load(ph[1]),
    .d(w_pc),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  count16rle pc2 (
    .q(w_pc2),
    .load(ph[2]),
    .d(w_pc1),
    .CLK(CLK),
    .RSTN(RSTN)
  );
  imem imem (
    .address(w_pc),
    .clock(~CLK),
    .q(w_imem)
  );

  reg16 ir (
    .q(w_ir),
    .load(ph[0]),
    .d(w_imem),
    .CLK(CLK),
    .RSTN(RSTN)
  );
  
 reg16 irp1 (
    .q(w_irp1),
    .load(ph[1]),
    .d(w_ir),
    .CLK(CLK),
    .RSTN(RSTN)
  );
  
reg16 irp2 (
    .q(w_irp2),
    .load(ph[2]),
    .d(w_irp1),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  regfile regfile (
    .q0(r0),
    .q1(r1),
    .q2(r2),
    .q3(r3),
    .q4(r4),
    .q5(r5),
    .q6(r6),
    .q7(r7),
    .load(ph[3]),
    .wsel(w_irp2[15:0]),
    .d_d(w_dr),
	 .d_a(w_alu),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  muxreg16 sr1 (
    .q(w_sr1),
    .d0(r0),
    .d1(r1),
    .d2(r2),
    .d3(r3),
    .d4(r4),
    .d5(r5),
    .d6(r6),
    .d7(r7),
	 .load(ph[1]),
    .sel(w_ir[10:8]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  muxreg16 sr2 (
    .q(w_sr2),
    .d0(r0),
    .d1(r1),
    .d2(r2),
    .d3(r3),
    .d4(r4),
    .d5(r5),
    .d6(r6),
    .d7(r7),
	 .load(ph[1]),
    .sel(w_ir[7:5]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  alu alu (
    .q(w_alu),
    .sr1(w_sr1),
    .sr2(w_sr2),
    .pc(w_pc1),
    .ir(w_irp1),
    .load(ph[2]),
    .CLK(CLK),
    .RSTN(RSTN)
  );

  dmem dmem (
    .address(w_sr1),
    .clock(~CLK),
    .data(w_sr2),
    .wren(w_irp1[15:14] == 2'b00 & w_irp1[4:0] == 5'b00000),
    .q(w_dmem)
  );

  reg16 dr (
    .q(w_dr),
    .load(ph[2] & w_irp1[4:0] == 5'b00001 & w_irp1[15:14] == 2'b00),
    .d(w_dmem),
    .CLK(CLK),
    .RSTN(RSTN)
  );
 
endmodule
