primitive ffjk (Q, Clk, set, reset, J, K);
  input Clk, set, reset, J, K;
  output Q;
  reg Q;
  
  table 
	// Clk set reset J K : Q : Q_new
	? 1 0 ? ? : ? : 1; // Asyn. set
 	? 0 1 ? ? : ? : 0; // Asyn. reset
	r 0 0 0 1 : ? : 0; // Reset cond.
	r 0 0 1 0 : ? : 1; // Set cond.
	r 0 0 1 1 : 0 : 1; // Toggle cond.
	r 0 0 1 1 : 1 : 0; // Toggle cond. 
	r 0 0 0 0 : ? : -; // No change
	f 0 0 ? ? : ? : -; // No change
	? f 0 ? ? : ? : -; // No change
	? 0 f ? ? : ? : -; // No change
	? 0 0 * ? : ? : -; // No change
	? 0 0 ? * : ? : -; // No change
  endtable
endprimitive
//************************************************************************
//End of Sample Solution
//************************************************************************
module ffjk_tb;

	reg Clk, set, reset, J, K, Qp;
	reg [1:0] cedge;
	wire Q;
	

        ffjk F1(Q, Clk, set, reset, J, K);

	parameter STDIN = 32'h8000_0000;
	integer testid;
	integer ret;

	initial Clk = 1'b0;
	
	always #10 Clk = ~Clk;

	initial begin  

			ret = $fscanf(STDIN,"%d",testid);
			case(testid)
			
			0:	begin 
					#5 J=0; K=1; set=0; reset=0;
					#10 Qp=Q; set=1; reset=0;
					#10 cedge=2'b10;
				end
			1:	begin 
					#5  J=0; K=1; set=0; reset=0;
					#10 Qp=Q; J=1; K=1; set=0; reset=0;
					#20 cedge=2'b01;
				end
			2:	begin 
					#5  J=1; K=0; set=0; reset=0;
					#10 Qp=Q; J=0; K=1; set=0; reset=0;
					#20 cedge=2'b01;
				end
			3:	begin 
					#5  J=0; K=1; set=0; reset=0;
					#10 Qp=Q; J=1; K=0; set=0; reset=0;
					#20 cedge=2'b01;
				end
			4:	begin 
					#5  J=1; K=0; set=0; reset=0;
					#15 Qp=Q; J=0; K=1; set=0; reset=0;
					#10 cedge=2'b10;
				end
			5:	begin 
					#5  J=1; K=0; set=0; reset=0;
					#10 Qp=Q; J=0; K=0; set=0; reset=0;
					#20 cedge=2'b01;
				end
			6:	begin 
					#5  J=1; K=0; set=0; reset=0;
					#10 Qp=Q; J=0; K=0; set=0; reset=1;
					#10 cedge=2'b10;
				end
			7:	begin 
					#5  J=0; K=1; set=0; reset=0;
					#10 Qp=Q; J=1; K=1; set=0; reset=0;
					#10 cedge=2'b10;
				end
			default:	begin
				$display("Bad testcase id %d",testid);
				$finish();
					end
	endcase

	if ( (testid == 0 && Q == 1)   || 
		(testid == 1 && Q == ~Qp) || 
		(testid == 2 && Q == 0)   || 
		(testid == 3 && Q == 1)   || 
		(testid == 4 && Q == Qp)  || 
           (testid == 5 && Q == Qp)  || 
           (testid == 6 && Q == 0)   || 
           (testid == 7 && Q == Qp) )
			pass();
	else
			fail();
	end


	task fail; 	begin
				$display("Fail: for Clk=%b, Set=%b, Rst=%b, J=%b, K=%b, Q(t)=%b and Q(t+1)=%b is WRONG", cedge, set, reset, J, K, Qp, Q);
				$finish();
			end
	endtask

	task pass; 	begin
				$display("Pass: for Clk=%b, Set=%b, Rst=%b, J=%b, K=%b, Q(t)=%b and Q(t+1)=%b", cedge, set, reset, J, K, Qp, Q);
				$finish();
			end
	endtask
endmodule	
