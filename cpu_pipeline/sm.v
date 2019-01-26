module sm(
  output reg [3:0] q,
  input start,
  input stop,
  input CLK,
  input RSTN
  );
 
 reg STOP = 0;
  
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      q <= 0;
    end
    else begin
      casex ({q,start,stop})
		6'b0000_0_x: q <= 4'b0000;
      6'b0000_1_x: q <= 4'b0001;
      6'b0001_x_x: q <= 4'b0011;
      6'b0011_x_x: q <= 4'b0111;
      6'b0111_x_x: q <= 4'b1111;
      6'b1111_x_0: q <= 4'b1111;
		6'b1111_x_1: q <= 4'b1110;
		6'b1110_x_x: q <= 4'b1100;
		6'b1100_x_x: q <= 4'b1000;
		6'b1000_x_x: q <= 4'b0000;
      endcase
    end
  end
endmodule
