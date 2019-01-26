module muxreg16_tb;
  wire [15:0] q;
  reg [15:0] d0, d1, d2, d3, d4, d5, d6, d7;
  reg load;
  reg [2:0] sel;
  reg CLK;
  reg RSTN;

  initial begin
    CLK = 0;
    while(1) begin
      #10
      CLK = ~CLK;
    end
  end

  initial begin
    load = 0;
    #40
    while (1) begin
      load = 1;
      #20
      load = 0;
      #40;
    end
  end

  initial begin
    while (1) begin
      #20
      d0 = $random;
      d1 = $random;
      d2 = $random;
      d3 = $random;
      d4 = $random;
      d5 = $random;
      d6 = $random;
      d7 = $random;
      sel = $random;
    end
  end

  initial begin
    RSTN = 0;
    #20
    RSTN = 1;
    #700
    $finish;
  end

  muxreg16 muxreg16 (
    .q(q),
	 .d0(d0), .d1(d1), .d2(d2), .d3(d3),
    .d4(d4), .d5(d5), .d6(d6), .d7(d7),
	 .load(load), .sel(sel), .CLK(CLK), .RSTN(RSTN));

endmodule
