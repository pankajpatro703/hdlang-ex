//F = (A.D + E.(B + C))’ using CMOS logic
module computeF (F, A, B, C, D, E);
	input A, B, C, D, E;
	output F;
	supply1 vdd;
	supply0 gnd;
	wire a,b;
	
	pmos p1(t3,vdd,A);
	pmos p2(t3,vdd,D);
	pmos p3(F,t3,E);
	pmos p4(t4,t3,B);
	pmos p5(F,t4,C);

	nmos n1(F,t1,A);
	nmos n2(t1,gnd,D);
	nmos n3(F,t2,E);
	nmos n4(t2,gnd, B);
	nmos n5(t2, gnd, C);
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
 module computeF_tb;
	reg A, B, C, D, E;
	wire F; 


	computeF f1(F, A, B, C, D, E);

	parameter STDIN = 32'h8000_0000;
	integer testid;
	integer ret;

	initial begin
		ret = $fscanf(STDIN,"%d",testid);
		case(testid)
		1:    begin
				A = 1'b0; B = 1'b0; C = 1'b0;
			end
		2:    begin
				A = 1'b1; D = 1'b1;
			end
		3:    begin
				A = 1'b0; E = 1'b0; 
			end
		4:    begin
				B = 1'b1; E = 1'b1;
			end
		5:    begin
				B = 1'b0; C = 1'b0; D = 1'b0;
			end
		6:    begin
				C = 1'b1; E = 1'b1;
			end
		7:    begin
				D = 1'b0; E = 1'b0;
			end
		default: begin
				$display("Bad testcase id %d",testid);	
				$finish;
			end				

		endcase
		#5
		if ( ((testid==1 || testid == 3 || testid==5 ||  testid==7) && F == 1) || ((testid==2 || testid == 4 || testid==6) && F == 0)) 
       			pass();
		else
				fail();
	end

	task fail;
		$display("Fail: for A = %b, B = %b, C = %b, D = %b, and E = %b, F = %b is WRONG",A, B, C, D, E, F);
	endtask

  	task pass;
		$display("Pass: for A = %b, B = %b, C = %b, D = %b, and E = %b, F = %b",A, B, C, D, E, F);
  	endtask

endmodule
