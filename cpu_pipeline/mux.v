module mux (
  output reg [15:0] q,
  input [15:0] d_a,
  input [15:0] d_d,
  input load,
  input [15:0] wsel,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else if (load) begin
      if (wsel[15:14] == 2'b00 && wsel[7:0] == 8'b00000001) begin
      q <= d_d; // LD
		end
		else begin
		q <= d_a;
		end
    end		
  end
endmodule
