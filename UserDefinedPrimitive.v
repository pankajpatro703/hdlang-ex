primitive myfunc (F, A, B, C, D);
  input A, B, C, D;
  output F;

  table 
	// A B C D: F
	   1 0 ? ?: 0; 
	   ? 0 1 ?: 0; 
	   0 ? ? 1: 0; 
	   1 1 ? ?: 1;
	   0 ? 0 0: 1;
	   0 1 1 0: 1;
  endtable
endprimitive

//************************************************************************
//End of Sample Solution
//************************************************************************
module myfunc_tb;

	reg A, B, C, D;
	wire F;
	
	 myfunc F1(F, A, B, C, D);

	parameter STDIN = 32'h8000_0000;
	integer testid;
	integer ret;

	initial begin  

			ret = $fscanf(STDIN,"%d",testid);
			case(testid)
			
			0:    	begin A=0; B=0; C=0; D=0; end

			1:    	begin A=1; B=1; C=0; D=1; end

			2:    	begin A=1; B=0; C=0; D=1; end

			3:    	begin A=1; B=0; C=1; D=0; end

			4:    	begin A=0; B=0; C=1; D=0; end

			5:    	begin A=0; B=1; C=0; D=1; end

			6:    	begin A=0; B=1; C=1; D=0; end

			7:    	begin A=1; B=1; C=1; D=1; end

			default:	begin
				$display("Bad testcase id %d",testid);
				$finish();
					end
	endcase

	#1;
	if ( (testid == 0 && F == 1) || (testid == 1 && F == 1) || (testid == 2 && F == 0) || (testid == 3 && F == 0) || (testid == 4 && F == 0) || (testid == 5 && F == 0) || 
(testid == 6 && F == 1) || (testid == 7 && F == 1) )
			pass();
	else
			fail();
	end


	task fail; 	begin
				$display("Fail: for A = %b, B = %b, C = %b, D = %b and F = %b is WRONG", A, B, C, D, F);
				$finish();
			end
	endtask

	task pass; 	begin
				$display("Pass: for A = %b, B = %b, C = %b, D = %b and F = %b", A, B, C, D, F);
				$finish();
			end
	endtask
endmodule	
