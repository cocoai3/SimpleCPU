module cpu_tb;

  wire [7:0] led;
  wire [15:0] seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7;
  wire [15:0] seg8, seg9, sega, segb, segc, segd, sege, segf;
  reg start;
  reg stop;
  reg CLK;
  reg RSTN;

  initial
  begin
    CLK = 0;
    while (1)
    begin
      #10
      CLK = ~CLK;
    end
  end

  initial
  begin
    RSTN = 0;
    start = 0;
    stop = 0;
    #40
    RSTN = 1;
    #60
    start = 1;
    #20
    start = 0;
    #200
    stop = 1;
    #20
    stop = 0;
    #60
    start = 1;
    #20
    start = 0;
    #3000
    $finish;
  end

  cpu cpu (
	.led(led), 
	.seg0(seg0),
	.seg1(seg1),
	.seg2(seg2),
	.seg3(seg3),
	.seg4(seg4),
	.seg5(seg5),
	.seg6(seg6),
	.seg7(seg7),
	.seg8(seg8),
	.seg9(seg9),
	.sega(sega),
	.segb(segb),
	.segc(segc),
	.segd(segd),
	.sege(sege),
	.segf(segf),
	.start(start), 
	.stop(stop), 
	.CLK(CLK), 
	.RSTN(RSTN)
	);

endmodule
