module regfile_tb;
  wire [15:0] q0, q1, q2, q3, q4, q5, q6, q7;
  reg [15:0] d;
  reg load;
  reg [2:0] wsel;
  reg CLK;
  reg RSTN;

  regfile regfile (
    .q0(q0), .q1(q1), .q2(q2), .q3(q3),
    .q4(q4), .q5(q5), .q6(q6), .q7(q7),
    .d(d), .load(load), .wsel(wsel),
    .CLK(CLK), .RSTN(RSTN)
  );

  initial begin
    CLK = 0;
    while (1) begin
      #10 CLK = ~CLK;
    end
  end

  initial begin
    while (1) begin
      d = $random;
      load = $random;
      wsel = $random;
      #20;
    end
  end

  initial begin
    RSTN = 0;
    #20
    RSTN = 1;
    #400
    $finish;
  end
endmodule
