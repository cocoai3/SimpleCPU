module reg16_tb;
  wire [15:0] q;
  reg [15:0] d;
  reg load;
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
    d = 0;
    while (1) begin
      #20
      d = $random;
    end
  end

  initial begin
    RSTN = 0;
    #20
    RSTN = 1;
    #700
    $finish;
  end

  reg16 reg16 (.q(q), .d(d), .load(load), .CLK(CLK), .RSTN(RSTN));

endmodule
