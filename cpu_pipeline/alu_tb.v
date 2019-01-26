module alu_tb;
  wire [15:0] w_alu;
  reg [15:0] sr1, sr2, pc, ir;
  reg CLK, RSTN;
  
  alu alu (.q(w_alu), .sr1(sr1), .sr2(sr2), .pc(pc), .ir(ir), .CLK(CLK), .RSTN(RSTN));

  initial begin
    CLK = 0;
    while (1) begin
      #10 CLK = ~CLK;
    end
  end

  initial begin
    RSTN = 0;
    pc  = 8;
    #20
    RSTN = 1;
	 ir = 16'b01_110_000_00000001;  // LI r6 1
    sr1 = 0; sr2 = 0;
    #20
    ir = 16'b01_101_000_11111111;  // LI r5 -1
	 sr1 = 0; sr2 = 7;
    #20
    ir = 16'b00_100_010_011_00010; // ADD r4 r2 r3
	 sr1 = 2; sr2 = 3;
	 #20
    ir = 16'b10_001_000_00000100;  // BNZ r0 4
    sr1 = 0; sr2 = 0;
    #20
    ir = 16'b10_001_001_11111101;  // BNZ r1 -3
    sr1 = 1; sr2 = 7;
    #20
    ir = 16'b10_000_000_11111010;  // B -6
	 sr1 = 0; sr2 = 7;
	 #20
	 $finish;
  end
endmodule