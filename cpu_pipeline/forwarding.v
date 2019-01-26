
module forwarding(
  output reg sr1,
  output reg sr2,
  output reg sr1_dr,
  output reg sr2_dr,
  input [15:0] irp1,
  input [15:0] ir,
  input [15:0] imem,
  input load,
  input CLK,
  input RSTN
  );
  
  wire ld = (irp1[15:14] == 2'b00 && irp1[7:0] == 8'b00000001);
  wire add = (irp1[15:14] == 2'b00 && irp1[4:0] == 5'b00010);
  wire li = (irp1[15:14] == 2'b01 && irp1[10:8] == 3'b000);
  wire mul = (irp1[15:14] == 2'b00 && irp1[4:0] == 5'b00011);
  wire nop = (irp1[15:0] != 16'b0000000000000000);
  
  wire nop_ = (imem[15:0] != 16'b0000000000000000);
  
 
  wire f = ((ld || add || li || mul) && nop && nop_);
  
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
    sr1 <= 0;
	 sr2 <= 0;
	 sr1_dr <= 0;
	 sr2_dr <= 0;
    end
    else begin
      if (load) begin
		   sr1 <= 0;
			sr2 <= 0;
			sr1_dr <= 0;
			sr2_dr <= 0;
		  if (imem[10:8] == irp1[13:11] && ld  == 1 && nop == 1 && nop_ == 1) begin
		  sr1_dr <= 1;
		  end
		  else if (imem[7:5] == irp1[13:11] && ld == 1 && nop == 1 && nop_ == 1) begin
		  sr2_dr <= 1;
		  end
        else if (imem[10:8] == irp1[13:11] && f == 1) begin
        sr1 <= 1;
	     end
        else if (imem[7:5] == irp1[13:11] && f == 1) begin
        sr2 <= 1;
	     end
		  end
      end
    end
endmodule