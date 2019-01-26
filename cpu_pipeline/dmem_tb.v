`define ADDR 8

module dmem_tb;
  reg CLK;
  reg wren;
  reg [15:0] adr;
  reg [15:0] dat;
  wire [15:0] w_dmem;
  reg [15:0] dr;
  integer i;
  reg read;

  dmem dmem (
    .address(adr),
    .data(dat),
    .wren(wren),
    .clock(~CLK),
    .q(w_dmem)
  );

  initial begin
    CLK = 0;
    while (1) begin
      #10 CLK = ~CLK;
    end
  end

  initial begin
    read = 0;
    wren = 0;
    adr = -1;
    dat = -1;
    for (i=0;i<(1<<`ADDR);i=i+1) begin
      #10
      adr = i;
      dat = reverse(i);
      wren = 1;
      #20
      wren = 0;
      dat = ~dat;
      #10;
    end
    for (i=0;i<(1<<`ADDR);i=i+1) begin
      #10
      adr = reverse(i);
      #10
      read = 1;
      #10
		adr = -1;
		#10
		read = 0;
    end
    #20 $finish;
  end

  always @(posedge CLK) begin
    if (read) dr <= w_dmem;
  end
  
  function [15:0] reverse;
    input [15:0] d;
	 integer i;
    begin
	   reverse = 0;
      for (i=0;i<`ADDR;i=i+1) begin
        reverse[i] = d[`ADDR-1-i];
      end
    end
  endfunction

endmodule
