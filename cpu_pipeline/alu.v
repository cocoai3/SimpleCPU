module alu (
  output reg [15:0] q,
  input [15:0] sr1,
  input [15:0] sr2,
  input [15:0] pc,
  input [15:0] ir,
  input load,
  input CLK,
  input RSTN
  );

  wire [15:0] imm = {{8{ir[7]}},ir[7:0]};
  wire [7:0] imm2 = {ir[13:11],ir[4:0]};
  wire [15:0] imm3 = {{8{imm2[7]}},imm2};

  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else if (load) begin
      casex (ir)
      16'b00000_xxxxxx_00000:;	// ST
      16'b00_xxx_xxx_00000001:;  // LD
      16'b00_xxx_xxx_xxx00010:   // ADD
	    q <= sr1 + sr2;
      16'b01_xxx_000_xxxxxxxx:   // LI
	    q <= imm;
      16'b10_000_000_xxxxxxxx:   // B
        q <= pc + imm;
      16'b10001_xxx_xxxxxxxx:    // BNZ
	   if (sr1) begin
	     q <= pc + imm;
	   end
      else begin
        q <= pc;
	   end
      16'b10010_xxx_xxxxxxxx:    // BZ
	   if (!sr1) begin
	     q <= pc + imm;
	   end
      else begin
        q <= pc;
	   end
      16'b11_xxx_xxx_xxx_xxxxx:    // BGE
      if (sr1 >= sr2) begin
        q <= pc + imm3;
	   end
	   else begin
	   q <= pc;
	   end
      16'b00_xxx_xxx_xxx00011:    // MUL
	   q <= sr1*sr2;
      endcase
    end
  end
endmodule
