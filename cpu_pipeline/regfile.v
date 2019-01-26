module regfile (
  output reg [15:0] q0,
  output reg [15:0] q1,
  output reg [15:0] q2,
  output reg [15:0] q3,
  output reg [15:0] q4,
  output reg [15:0] q5,
  output reg [15:0] q6,
  output reg [15:0] q7,
  input load,
  input [15:0] wsel,
  input [15:0] d_a,
  input [15:0] d_d,
  input CLK,
  input RSTN
  );
  always @(posedge CLK or negedge RSTN)
  begin
    if (!RSTN) begin
      {q0,q1,q2,q3,q4,q5,q6,q7} <= 128'b0;
    end
    else if (load) begin
      if(wsel[15:14] == 2'b10) begin // B and BNZ 
      end
      else if(wsel[15:14] == 2'b11) begin // BGE
      end
      else if (wsel[15:14] == 2'b00 & wsel[4:0] == 5'b00000) begin //ST
      end
      else if (wsel[15:14] == 2'b00 & wsel[4:0] == 5'b00001) begin //LD
      case (wsel[13:11])
      3'b000 : q0 <= d_d;
      3'b001 : q1 <= d_d;
      3'b010 : q2 <= d_d;
      3'b011 : q3 <= d_d;
      3'b100 : q4 <= d_d;
      3'b101 : q5 <= d_d;
      3'b110 : q6 <= d_d;
      3'b111 : q7 <= d_d;
      endcase
      end
      else begin // ADD and LI and MUL
      case (wsel[13:11])
      3'b000 : q0 <= d_a;
      3'b001 : q1 <= d_a;
      3'b010 : q2 <= d_a;
      3'b011 : q3 <= d_a;
      3'b100 : q4 <= d_a;
      3'b101 : q5 <= d_a;
      3'b110 : q6 <= d_a;
      3'b111 : q7 <= d_a;
      endcase
      end
    end
  end
endmodule
