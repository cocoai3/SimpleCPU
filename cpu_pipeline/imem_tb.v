module imem_tb;
  reg CLK;
  reg [15:0] adr;
  reg [15:0] ir;
  wire [15:0] w_imem;

  imem imem (
    .address(adr),
    .clock(~CLK),
    .q(w_imem)
  );

  initial begin
    CLK = 0;
    while (1) begin
      #10 CLK = ~CLK;
    end
  end

  initial begin
    adr = 0;
	 #10;
    while (1) begin
      #80 adr = (adr==5) ? 3 : adr+1;
    end
  end

  always @(posedge CLK) begin
    ir <= w_imem;
  end
  
  initial begin
    #1200
	 $finish;
  end
endmodule
