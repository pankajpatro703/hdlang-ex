module mux2x1 (in, sel, out);
	input [1:0] in;
	input sel;
	output out;

	wire t1, t2, t3;

	not	G1	(t1, sel);
	and	G2	(t2, in[0], t1), 
		G3      (t3, in[1], sel);
	or	G4	(out, t2, t3);
endmodule

//mux8x1 module
module mux8x1 (in, sel, out);
	input [7:0] in;
	input [2:0] sel;
	output out;
	
	wire [5:0] t;

	mux2x1 M1 (in[1:0], sel[0], t[0]);
	mux2x1 M2 (in[3:2], sel[0], t[1]);
	mux2x1 M3 (in[5:4], sel[0], t[2]);
	mux2x1 M4 (in[7:6], sel[0], t[3]);

	mux2x1 M5 (t[1:0], sel[1], t[4]);
	mux2x1 M6 (t[3:2], sel[1], t[5]);

	mux2x1 M7 (t[5:4], sel[2], out);
endmodule


	module rcadder4_tb;
		reg [7:0] in;
		reg [2:0] sel;
		wire out, t;

		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		mux8x1  M8x1( in, sel, out);
		mux2x1  M2x1 (in[1:0], sel[0], t);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{in} = 1;   {sel} = 0;
					end
   				1:    	begin
   						{in} = 34;  {sel} = 1;
        				end
   				2:    	begin
						{in} = 5;   {sel} = 2;
					end
   				3:	begin
						{in} = 128; {sel} = 7;
					end
   				4:	begin
						{in} = 239; {sel} = 4;
					end


    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			if ( (sel==0 && out == in[0]) || (sel==1 && out == in[1]) || (sel==2 && out == in[2]) || (sel==3 && out == in[3]) || (sel==4 && out == in[4]) || (sel==5 && out == in[5]) || (sel==6 && out == in[6]) || (sel==7 && out == in[7]) )
				begin
					if ( (sel[0]==0 && t ==in[0]) || (sel[0]==1 && t==in[1]) )
        					pass();
					else
						fail_single();
				end
			else
 				fail();
		end

		task fail_single; 	begin
    					$display("Fail: for sel = %b and in = %b, out = %b is WRONG",sel[0],in[1:0],t);
  				end
  		endtask

 		task fail; 	begin
    					$display("Fail: for sel = %b and in = %b, out = %b is WRONG",sel,in,out);
  				end
  		endtask

  		task pass; 	begin
	    				$display("Pass: for sel = %b and in = %b out = %b",sel,in,out);
  				end
  		endtask

	endmodule
