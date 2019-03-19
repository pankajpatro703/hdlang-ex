module bus_multiplexer (DATABUS, D0, D1, D2, D3, D4, D5, D6, D7, SEL);
  input [31:0] D0, D1, D2, D3, D4, D5, D6, D7;
  input [2:0] SEL;
  output [31:0] DATABUS;

  assign DATABUS = ~SEL[2] & ~SEL[1] & ~SEL[0] ? D0 : ~SEL[2] & ~SEL[1] & SEL[0] ? D1 : ~SEL[2] & SEL[1] & ~SEL[0]  ? D2 : ~SEL[2] & SEL[1] & SEL[0]  ? D3 : SEL[2] & ~SEL[1] & ~SEL[0]  ? D4 : SEL[2] & ~SEL[1] & SEL[0]  ? D5 : SEL[2] & SEL[1] & ~SEL[0]  ? D6 : D7;
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
	module bus_multiplexer_tb;
		reg [31:0] D0, D1, D2, D3, D4, D5, D6, D7;
		reg [2:0] SEL;
		wire [31:0] DATABUS;
		
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		bus_multiplexer  BM (DATABUS, D0, D1, D2, D3, D4, D5, D6, D7, SEL);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{D0} = 23; {D1} = 15; {D2} = 24; {D3} = 55; {D4} = 19; {D5} = 35; {D6} = 79; {D7} = 43; {SEL} = 0;
					end
   				1:    	begin
						{D0} = 13; {D1} = 45; {D2} = 28; {D3} = 75; {D4} = 99; {D5} = 33; {D6} = 59; {D7} = 73; {SEL} = 1;
        				end
   				2:    	begin
						{D0} = 21; {D1} = 19; {D2} = 27; {D3} = 45; {D4} = 39; {D5} = 65; {D6} = 89; {D7} = 13; {SEL} = 2;
					end
   				3:	begin
						{D0} = 63; {D1} = 35; {D2} = 74; {D3} = 25; {D4} = 18; {D5} = 37; {D6} = 49; {D7} = 83; {SEL} = 3;
					end
   				4:	begin
						{D0} = 27; {D1} = 18; {D2} = 34; {D3} = 49; {D4} = 59; {D5} = 65; {D6} = 89; {D7} = 73; {SEL} = 4;
					end
   				5:	begin
						{D0} = 83; {D1} = 75; {D2} = 64; {D3} = 41; {D4} = 59; {D5} = 25; {D6} = 39; {D7} = 13; {SEL} = 5;
					end
   				6:	begin
						{D0} = 29; {D1} = 65; {D2} = 54; {D3} = 65; {D4} = 14; {D5} = 85; {D6} = 71; {D7} = 46; {SEL} = 6;
					end
   				7:	begin
						{D0} = 11; {D1} = 22; {D2} = 33; {D3} = 44; {D4} = 55; {D5} = 66; {D6} = 77; {D7} = 88; {SEL} = 7;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        					end
			endcase
			#5;
			if ( (SEL==0 && DATABUS == D0) || (SEL==1 && DATABUS == D1) || (SEL==2 && DATABUS == D2) || (SEL==3 && DATABUS == D3) || (SEL==4 && DATABUS == D4) || (SEL==5 && DATABUS == D5) || (SEL==6 && DATABUS == D6) || (SEL==7 && DATABUS == D7) )
        				pass();
			else
 					fail();
		end


 		task fail; 	begin
    					$display("Fail: for D0 = %2d, D1 = %2d, D2 = %2d, D3 = %2d, D4 = %2d, D5 = %2d, D6 = %2d, D7 = %2d and SEL = %1d, OUTBUS = %2d is WRONG", D0, D1, D2, D3, D4, D5, D6, D7, SEL, DATABUS);
  				end
  		endtask

  		task pass; 	begin
    					$display("Pass: for D0 = %2d, D1 = %2d, D2 = %2d, D3 = %2d, D4 = %2d, D5 = %2d, D6 = %2d, D7 = %2d and SEL = %1d, OUTBUS = %2d", D0, D1, D2, D3, D4, D5, D6, D7, SEL, DATABUS);
	    				
  				end
  		endtask

	endmodule
