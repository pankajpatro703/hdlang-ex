module srlatch(S,R,En,Q,Qc);
	input S, R;    
	input En; 
	output Q, Qc;     
	assign	Q  = ~(Qc | (R & En));
	assign  Qc = ~(Q  | (S & En));

endmodule

//4-bit S-R latch module
module srlatch4(S,R,En,Q,Qc);
    input [3:0] S, R;    
    input En; 
    output [3:0] Q, Qc;     
    
    srlatch l0 (S[0],R[0],En,Q[0], Qc[0]);
    srlatch l1 (S[1],R[1],En,Q[1], Qc[1]);
    srlatch l2 (S[2],R[2],En,Q[2], Qc[2]);
    srlatch l3 (S[3],R[3],En,Q[3], Qc[3]);
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
	module srlatch4_tb;
		reg [3:0] S, R, Qp, Qcp;
		reg En;
		wire [3:0] Q, Qc;

		srlatch4 srl4 ( S, R, En, Q, Qc);
    		srlatch  srl  (S[0],R[0],En,Q[0], Qc[0]);

		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		initial begin  

			ret = $fscanf(STDIN,"%d",testid);
			case(testid)
				0:    	begin
						S = 4'b0000; R = 4'b1111; En = 1; 
						#5; {Qp, Qcp} = {Q, Qc}; S = 4'b0000; R = 4'b0000; En = 1;
					end
				1:    	begin
						S = 4'b0101; R = 4'b1010; En = 1; 
						#5; {Qp, Qcp} = {Q, Qc}; S = 4'b1100; R = 4'b0000; En = 0;    
					end
				2:    	begin
						S = 4'b1111; R = 4'b0000; En = 1; 
						#5; {Qp, Qcp} = {Q, Qc}; S = 4'b1100; R = 4'b0011; En = 1;    
					end
				3:    	begin
						S = 4'b1100; R = 4'b0011; En = 1; 
						#5; {Qp, Qcp} = {Q, Qc}; S = 4'b1010; R = 4'b0101; En = 1;    
					end
				
				default:	begin
							$display("Bad testcase id %d",testid);
        						$finish();
						end
			endcase
        		#5;
			if ( (testid==0 && Q == 4'b0000 && Qc == 4'b1111) || (testid==1 && Q == 4'b0101 && Qc == 4'b1010) 
                            || (testid==2 && Q == 4'b1100 && Qc == 4'b0011) || (testid==3 && Q == 4'b1010 && Qc == 4'b0101) )
				begin
					if ( ((testid==0 || testid==2 || testid==3) && Q[0] == 1'b0 && Qc[0] == 1'b1) || (testid==1 && Q[0] == 1'b1 && Qc[0] == 1'b0) )
	        				pass();
					else
						fail_single();	
				end
			else
 				fail();
		end

		task fail_single; 	begin
    					$display("Fail: for Q(t) = %b,  Qc(t) = %b and S = %b, R = %b, En =%b, Q(t+1) = %b, Qc(t+1) = %b is WRONG",Qp[0], Qcp[0], S[0], R[0], En, Q[0], Qc[0]);
					$finish();
  				end
  		endtask

	
 		task fail; 	begin
    					$display("Fail: for Q(t) = %b,  Qc(t) = %b and S = %b, R = %b, En =%b, Q(t+1) = %b, Qc(t+1) = %b is WRONG",Qp, Qcp, S, R, En, Q, Qc);
					$finish();
  				end
  		endtask

  		task pass; 	begin
    		    			$display("Pass: for Q(t) = %b,  Qc(t) = %b and S = %b, R = %b, En =%b, Q(t+1) = %b, Qc(t+1) = %b",Qp, Qcp, S, R, En, Q, Qc);
					$finish();
				end
		endtask

      
endmodule
