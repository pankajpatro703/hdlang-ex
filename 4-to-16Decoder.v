module decoder416 (out, in, en);
  	input [0:3] in;
	input en;
  	output [0:15] out;
  	wire [0:2] t[0:15];

	tranif0(en,t[0][0],in[0]);
	tranif0(t[0][0],t[0][1], in[1]);
	tranif0(t[0][1],t[0][2], in[2]);
	tranif0(t[0][2],out[0], in[3]);

	tranif0(en,t[1][0],in[0]);
	tranif0(t[1][0],t[1][1], in[1]);
	tranif0(t[1][1],t[1][2], in[2]);
	tranif1(t[1][2],out[1], in[3]);

	tranif0(en,t[2][0],in[0]);
	tranif0(t[2][0],t[2][1], in[1]);
	tranif1(t[2][1],t[2][2], in[2]);
	tranif0(t[2][2],out[2], in[3]);

	tranif0(en,t[3][0],in[0]);
	tranif0(t[3][0],t[3][1], in[1]);
	tranif1(t[3][1],t[3][2], in[2]);
	tranif1(t[3][2],out[3], in[3]);

	tranif0(en,t[4][0],in[0]);
	tranif1(t[4][0],t[4][1], in[1]);
	tranif0(t[4][1],t[4][2], in[2]);
	tranif0(t[4][2],out[4], in[3]);

	tranif0(en,t[5][0],in[0]);
	tranif1(t[5][0],t[5][1], in[1]);
	tranif0(t[5][1],t[5][2], in[2]);
	tranif1(t[5][2],out[5], in[3]);

	tranif0(en,t[6][0],in[0]);
	tranif1(t[6][0],t[6][1], in[1]);
	tranif1(t[6][1],t[6][2], in[2]);
	tranif0(t[6][2],out[6], in[3]);

	tranif0(en,t[7][0],in[0]);
	tranif1(t[7][0],t[7][1], in[1]);
	tranif1(t[7][1],t[7][2], in[2]);
	tranif1(t[7][2],out[7], in[3]);

	tranif1(en,t[8][0],in[0]);
	tranif0(t[8][0],t[8][1], in[1]);
	tranif0(t[8][1],t[8][2], in[2]);
	tranif0(t[8][2],out[8], in[3]);

	tranif1(en,t[9][0],in[0]);
	tranif0(t[9][0],t[9][1], in[1]);
	tranif0(t[9][1],t[9][2], in[2]);
	tranif1(t[9][2],out[9], in[3]);

	tranif1(en,t[10][0],in[0]);
	tranif0(t[10][0],t[10][1], in[1]);
	tranif1(t[10][1],t[10][2], in[2]);
	tranif0(t[10][2],out[10], in[3]);

	tranif1(en,t[11][0],in[0]);
	tranif0(t[11][0],t[11][1], in[1]);
	tranif1(t[11][1],t[11][2], in[2]);
	tranif1(t[11][2],out[11], in[3]);

	tranif1(en,t[12][0],in[0]);
	tranif1(t[12][0],t[12][1], in[1]);
	tranif0(t[12][1],t[12][2], in[2]);
	tranif0(t[12][2],out[12], in[3]);

	tranif1(en,t[13][0],in[0]);
	tranif1(t[13][0],t[13][1], in[1]);
	tranif0(t[13][1],t[13][2], in[2]);
	tranif1(t[13][2],out[13], in[3]);

	tranif1(en,t[14][0],in[0]);
	tranif1(t[14][0],t[14][1], in[1]);
	tranif1(t[14][1],t[14][2], in[2]);
	tranif0(t[14][2],out[14], in[3]);
	
	tranif1(en,t[15][0],in[0]);
	tranif1(t[15][0],t[15][1], in[1]);
	tranif1(t[15][1],t[15][2], in[2]);
	tranif1(t[15][2],out[15], in[3]);  	
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
module dec416_tb;
	reg [0:3] in;
	reg en;
	wire [0:15] out;

	parameter STDIN = 32'h8000_0000;
	integer testid;
	integer ret;

	decoder416 dec1(out, in, en);

	initial begin
		ret = $fscanf(STDIN,"%d",testid);
		case(testid)
			1:	begin
					{in} = 3; en = 1'b0;
				end
			2:	begin
					{in} = 0; en = 1'b1;
				end
			3:	begin
					{in} = 7; en = 1'b1;
				end
			4:	begin
					{in} = 13; en = 1'b0;
				end
			5:	begin
					{in} = 13; en = 1'b1;
				end
			6:	begin
					{in} = 10; en = 1'b1;
				end
			7:	begin
					{in} = 15; en = 1'b1;
				end
			8:	begin
					{in} = 1; en = 1'b1;
				end
			default: begin
					$display("Bad testcase id %d",testid);		
					$finish;
				end				
		endcase
		#5;
		if ( ( en == out[in]) )
        		pass();
		else
 			fail();
	end


 	task fail;
    		$display("Fail: for En = %b and  In = %1d, Out[%1d] = %b is WRONG",en,in,in, out[in]);
  	endtask

  	task pass;
		$display("Pass: for En = %b and In = %1d, Out[%1d] = %b",en,in,in, out[in]);
  	endtask

endmodule
