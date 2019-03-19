module fadder (A,B,Cin,Sum,Cout);
		input A,B;
		input Cin;
		output Sum;
		output Cout;
		
		wire t1, t2, t3;
		
		xor G1 (Sum, A, B, Cin);
	
		and G2 (t1, A, B);
		and G3 (t2, B, Cin);
		and G4 (t3, A, Cin);
		or  G4 (Cout, t1, t2, t3);
	
endmodule

//4-bit adder-subtractor module
module add_sub_4(A,B,In,Res,Out);
		input [3:0] A, B;
		input In;
		output [3:0] Res;
		output Out;
		wire [2:0] Out_In;
		
		
		fadder	F1	(A[0], B[0]^In, In,        Res[0], Out_In[0]);
		fadder	F2	(A[1], B[1]^In, Out_In[0], Res[1], Out_In[1]);
		fadder	F3	(A[2], B[2]^In, Out_In[1], Res[2], Out_In[2]); 
		fadder	F4	(A[3], B[3]^In, Out_In[2], Res[3], Out);
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
module add_sub_tb;
		reg [3:0] A, B;
		reg In;
		wire [3:0] Res;
		wire Out, Cout, Sum;
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		add_sub_4  AS4 ( A, B, In, Res, Out);
 		fadder	fad  (A[0],B[0],In, Sum, Cout);

		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{A} = 5;  {B} = 2;  In = 0;
					end
   				1:    	begin
   						{A} = 3;  {B} = 7; In = 1;
        				end
   				2:    	begin
						{A} = 6; {B} = 11;  In = 0;
					end
   				3:	begin
						{A} = 5; {B} = 1; In = 1;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        						end
			endcase
			#5;
			if(Res == A+B+In && ((Out == 0 && testid == 0) || (Out == 1 && testid == 2)))
        			add_pass();
			else if(Res == A+~B+In && ((Out == 0 && testid == 1) || (Out == 1 && testid == 3)))
        			sub_pass();
			else if (testid == 0 || testid == 2)
 				add_fail();
			else 
				sub_fail();
		end


 		task add_fail; 	begin
    					$display("FAIL: %b + %b != %b", A,B,{Out,Res});
					$finish();
  				end
  		endtask

		task sub_fail; 	begin
    					$display("FAIL: %b - %b != %b", A,B,{Out,Res});
					$finish();
  				end
  		endtask

  		task add_pass; 	begin
					if (Sum == 1 && Cout == 0 )
		    				$display("PASS: %b + %b = %b", A,B,{Out,Res});
					else
						$display("FAIL: %b + %b != %b", A[0],B[0],{Cout,Sum});
					$finish();
  				end
  		endtask

		task sub_pass; 	begin
                           if(Sum == 1 && Cout == 1)
		    				$display("PASS: %b - %b = %b", A,B,{Out,Res});
					else
						$display("FAIL: %b + %b != %b", A[0],B[0],{Cout,Sum});
					$finish();
  				end
  		endtask

endmodule
