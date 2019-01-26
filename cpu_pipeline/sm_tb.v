module sm_tb;
  wire [3:0] ph;
  reg start;
  reg stop;
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
    RSTN = 0;
    start = 0;
    stop = 0;
    #100
    RSTN = 1;
    #80
    start = 1;
    #80
    start = 0;
    #200
    stop = 1;
    #100
    stop = 0;
    #50
    $finish;
  end

  sm sm (.q(ph), .start(start), .stop(stop), .CLK(CLK), .RSTN(RSTN));

endmodule
