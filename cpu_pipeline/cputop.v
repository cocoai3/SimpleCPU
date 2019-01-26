module cputop(
	output [7:0] SEGX_A,
	output [7:0] SEGX_B,
	output [7:0] SEGX_C,
	output [7:0] SEGX_D,
	output [7:0] SEGX_E,
	output [7:0] SEGX_F,
	output [7:0] SEGX_G,
	output [7:0] SEGX_H,
	output [8:0] SEGX_SEL,
	output [7:0] SEG_A,
	output [7:0] SEG_B,
	output [3:0] SEG_SELA,
	output [3:0] SEG_SELB,
	output [7:0] LED,
	output BZ,
	input PSW_D0,
	input PSW_D1,
	input CLK,
	input CLK20MHZ,
	input RSTN
	);

	wire [15:0] DATA0, DATA1, DATA2, DATA3;
	wire [15:0] DATA4, DATA5, DATA6, DATA7;
	wire [15:0] DATAP, DATAQ, DATAR, DATAS;
	wire [15:0] DATAT, DATAU, DATAV, DATAW;
	
	assign SEG_A = 8'b01101110;
	assign SEG_B = 8'b00011100;
	assign SEG_SELA = 4'b1111;
	assign SEG_SELB = 4'b1111;

	cpu cpu (
		.led(LED[7:0]),
		.seg8(DATAP),
		.seg9(DATAQ),
		.sega(DATAR),
		.segb(DATAS),
		.segc(DATAT),
		.segd(DATAU),
		.sege(DATAV),
		.segf(DATAW),
		.seg0(DATA0),
		.seg1(DATA1),
		.seg2(DATA2),
		.seg3(DATA3),
		.seg4(DATA4),
		.seg5(DATA5),
		.seg6(DATA6),
		.seg7(DATA7),
		.start(~PSW_D0),
		.stop(~PSW_D1),
		.CLK(CLK),
		.RSTN(RSTN)
		);

	sevenseg sevenseg (
		.SEGX_SEL(SEGX_SEL),
		.SEGX_A(SEGX_A),
		.SEGX_B(SEGX_B),
		.SEGX_C(SEGX_C),
		.SEGX_D(SEGX_D),
		.SEGX_E(SEGX_E),
		.SEGX_F(SEGX_F),
		.SEGX_G(SEGX_G),
		.SEGX_H(SEGX_H),
		.LEDX(64'b0),
		.DATA0(DATA0),
		.DATA1(DATA1),
		.DATA2(DATA2),
		.DATA3(DATA3),
		.DATA4(DATA4),
		.DATA5(DATA5),
		.DATA6(DATA6),
		.DATA7(DATA7),
		.DATAP(DATAP),
		.DATAQ(DATAQ),
		.DATAR(DATAR),
		.DATAS(DATAS),
		.DATAT(DATAT),
		.DATAU(DATAU),
		.DATAV(DATAV),
		.DATAW(DATAW),
		.CLK(CLK20MHZ),
		.RSTN(RSTN)
		);
		
	sound sound (
		.BZ(BZ),
		.data(DATA0),
		.CLK(CLK20MHZ),
		.RSTN(RSTN)
		);
endmodule

`define SEG_DIVIDER 14
module sevenseg (
	output [8:0] SEGX_SEL,
	output [7:0] SEGX_A,
	output [7:0] SEGX_B,
	output [7:0] SEGX_C,
	output [7:0] SEGX_D,
	output [7:0] SEGX_E,
	output [7:0] SEGX_F,
	output [7:0] SEGX_G,
	output [7:0] SEGX_H,
	input [63:0] LEDX,
	input [15:0] DATA0,
	input [15:0] DATA1,
	input [15:0] DATA2,
	input [15:0] DATA3,
	input [15:0] DATA4,
	input [15:0] DATA5,
	input [15:0] DATA6,
	input [15:0] DATA7,
	input [15:0] DATAP,
	input [15:0] DATAQ,
	input [15:0] DATAR,
	input [15:0] DATAS,
	input [15:0] DATAT,
	input [15:0] DATAU,
	input [15:0] DATAV,
	input [15:0] DATAW,
	input CLK,
	input RSTN
	);

	reg [`SEG_DIVIDER-1:0] count0;
	reg [3:0] count1;

	always @(posedge CLK or negedge RSTN) 
	begin
		if (!RSTN)
		begin
			count0 <= `SEG_DIVIDER'd0;
		end
		else
		begin
			count0 <= count0+`SEG_DIVIDER'd1;
		end
	end

	always @(posedge CLK or negedge RSTN)
	begin
		if (!RSTN)
		begin
			count1 <= 4'd0;
		end
		else if (count0 == (1<<`SEG_DIVIDER)-1)
		begin
			if (count1 == 4'd8)
			begin
				count1 <= 4'd0;
			end
			else
			begin
				count1 <= count1+4'd1;
			end
		end
	end

	assign SEGX_SEL[0] = (count1==0 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[1] = (count1==1 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[2] = (count1==2 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[3] = (count1==3 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[4] = (count1==4 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[5] = (count1==5 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[6] = (count1==6 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[7] = (count1==7 && count0==1) ? 1'b1 : 1'b0;
	assign SEGX_SEL[8] = (count1==8 && count0==1) ? 1'b1 : 1'b0;

	assign SEGX_A = leddec(count1,DATA0[15:12],DATA2[15:12],DATA4[15:12],DATA6[15:12],
			             DATAP[15:12],DATAR[15:12],DATAT[15:12],DATAV[15:12],LEDX[63:56]);
	assign SEGX_B = leddec(count1,DATA0[11: 8],DATA2[11: 8],DATA4[11: 8],DATA6[11: 8],
			             DATAP[11: 8],DATAR[11: 8],DATAT[11: 8],DATAV[11: 8],LEDX[55:48]);
	assign SEGX_C = leddec(count1,DATA0[ 7: 4],DATA2[ 7: 4],DATA4[ 7: 4],DATA6[ 7: 4],
			             DATAP[ 7: 4],DATAR[ 7: 4],DATAT[ 7: 4],DATAV[ 7: 4],LEDX[47:40]);
	assign SEGX_D = leddec(count1,DATA0[ 3: 0],DATA2[ 3: 0],DATA4[ 3: 0],DATA6[ 3: 0],
			             DATAP[ 3: 0],DATAR[ 3: 0],DATAT[ 3: 0],DATAV[ 3: 0],LEDX[39:32]);

	assign SEGX_E = leddec(count1,DATA1[15:12],DATA3[15:12],DATA5[15:12],DATA7[15:12],
			             DATAQ[15:12],DATAS[15:12],DATAU[15:12],DATAW[15:12],LEDX[31:24]);
	assign SEGX_F = leddec(count1,DATA1[11: 8],DATA3[11: 8],DATA5[11: 8],DATA7[11: 8],
			             DATAQ[11: 8],DATAS[11: 8],DATAU[11: 8],DATAW[11: 8],LEDX[23:16]);
	assign SEGX_G = leddec(count1,DATA1[ 7: 4],DATA3[ 7: 4],DATA5[ 7: 4],DATA7[ 7: 4],
			             DATAQ[ 7: 4],DATAS[ 7: 4],DATAU[ 7: 4],DATAW[ 7: 4],LEDX[15: 8]);
	assign SEGX_H = leddec(count1,DATA1[ 3: 0],DATA3[ 3: 0],DATA5[ 3: 0],DATA7[ 3: 0],
			             DATAQ[ 3: 0],DATAS[ 3: 0],DATAU[ 3: 0],DATAW[ 3: 0],LEDX[ 7: 0]);

	function [7:0] leddec;
		input [3:0] count1;
		input [3:0] d0,d1,d2,d3,d4,d5,d6,d7;
		input [7:0] led;
		case (count1)
			0:	leddec = bintoled(d0);
			1:	leddec = bintoled(d1);
			2:	leddec = bintoled(d2);
			3:	leddec = bintoled(d3);
			4:	leddec = bintoled(d4);
			5:	leddec = bintoled(d5);
			6:	leddec = bintoled(d6);
			7:	leddec = bintoled(d7);
			default:leddec = {led[0],led[1],led[2],led[3],led[4],led[5],led[6],led[7]};
		endcase
	endfunction

	function [7:0] bintoled;
		input [3:0] data;
		case (data)
			4'h0: bintoled = 8'b11111100;
	      		4'h1: bintoled = 8'b01100000;
	      		4'h2: bintoled = 8'b11011010;
	      		4'h3: bintoled = 8'b11110010;
	      		4'h4: bintoled = 8'b01100110;
	      		4'h5: bintoled = 8'b10110110;
	      		4'h6: bintoled = 8'b10111110;
	      		4'h7: bintoled = 8'b11100000;
	      		4'h8: bintoled = 8'b11111110;
	      		4'h9: bintoled = 8'b11110110;
	      		4'ha: bintoled = 8'b11101110;
	      		4'hb: bintoled = 8'b00111110;
	      		4'hc: bintoled = 8'b00011010;
	      		4'hd: bintoled = 8'b01111010;
	      		4'he: bintoled = 8'b10011110;
	      		4'hf: bintoled = 8'b10001110;
		endcase
	endfunction
endmodule

module sound (output BZ, input [15:0] data, input CLK, input RSTN);
  reg [16:0] count;
  reg [16:0] counter;
  always @* begin
    case (data)
     1: count = 17'd90909;
     2: count = 17'd85806;
     3: count = 17'd80990;
     4: count = 17'd76445;
     5: count = 17'd72154;
     6: count = 17'd68104;
     7: count = 17'd64282;
     8: count = 17'd60674;
     9: count = 17'd57269;
    10: count = 17'd54054;
    11: count = 17'd51021;
    12: count = 17'd48157;
    13: count = 17'd45454;
    14: count = 17'd42903;
    15: count = 17'd40495;
    16: count = 17'd38222;
    17: count = 17'd36077;
    18: count = 17'd34052;
    19: count = 17'd32141;
    20: count = 17'd30337;
    21: count = 17'd28634;
    22: count = 17'd27027;
    23: count = 17'd25510;
    24: count = 17'd24078;
    25: count = 17'd22727;
    26: count = 17'd21451;
    27: count = 17'd20247;
    28: count = 17'd19111;
    29: count = 17'd18038;
    30: count = 17'd17026;
    31: count = 17'd16070;
    32: count = 17'd15168;
    33: count = 17'd14317;
    34: count = 17'd13513;
    35: count = 17'd12755;
    36: count = 17'd12039;
    37: count = 17'd11363;
    38: count = 17'd10725;
    39: count = 17'd10123;
    40: count =  17'd9555;
    41: count =  17'd9019;
    42: count =  17'd8513;
    43: count =  17'd8035;
    44: count =  17'd7584;
    45: count =  17'd7158;
    46: count =  17'd6756;
    47: count =  17'd6377;
    48: count =  17'd6019;
    49: count =  17'd5681;
    50: count =  17'd5362;
    51: count =  17'd5061;
    52: count =  17'd4777;
    default: count = 17'd0;
	 endcase
  end
  
  always @(posedge CLK or negedge RSTN) begin
    if (!RSTN) begin
	   counter <= 17'd0;
	 end
	 else begin
	   if (counter == 0) counter <= count;
		else counter <= counter - 17'd1;
	 end
  end
  
  assign BZ = (counter>(count>>1));
endmodule
