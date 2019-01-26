module count16rle_tb;
  wire [15:0] q;
  reg [15:0] d;
  reg load;
  reg inc;
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
    inc = 0;
    #40
    while (1) begin
      inc = 1;
      #20
      inc = 0;
      #40;
    end
  end

  initial begin
    load = 0;
    #320
    while (1) begin
      load = 1;
      #20
      load = 0;
      #160;
    end
  end

  initial begin
    RSTN = 0;
    d = 16'h0003;
    #20
    RSTN = 1;
    #700
    $finish;
  end

  count16rle count16rle (.q(q), .d(d), .load(load), .inc(inc), .CLK(CLK), .RSTN(RSTN));

endmodule
