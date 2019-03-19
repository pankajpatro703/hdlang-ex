module dff (q, d, clk); 
	input d, clk;
	output q;
	reg q;

	always @ (negedge clk)
		q <= d;
endmodule  
//shift register
module shiftreg (sin, din, dout, ld, mode, clk);
	parameter N = 16;
	input  [N-1:0] din;
	input sin, ld, mode, clk;
	output [N-1:0] dout;
	
	dff D0  (dout[0],  (ld & din[1])  | (~ld & ~mode & din[1]) | (~ld & mode & sin), clk);
	dff D15 (dout[15], (ld & din[15]) | (~ld & ~mode & sin) | (~ld & mode & din[14]), clk);
	genvar x;
	generate for (x=1; x<N-1; x=x+1)
		dff D (dout[x], (ld & din[x]) | (~ld & ~mode & din[x+1]) | (~ld & mode & din[x-1]), clk);
	endgenerate
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
`timescale 1ns/1ps
module shiftreg_tb;
  reg  [15:0] din;
  reg sin, ld, mode, clk;
  wire [15:0] dout;
  

  shiftreg SR1(sin, din, dout, ld, mode, clk);

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

   initial
     begin
     	clk=1'b1;
     	forever #50 clk=~clk;  
     end
 
   initial
     begin
        ret = $fscanf(STDIN,"%d",testid);
	case(testid)
				
	0:  begin
    		din = 16'b1111111111111111;
	    	ld = 1'b1;

	    end
   
	1:  begin
	    	din = 16'b0000000011000000;
		ld = 1'b1;
		#100
        	sin = 1'b1;
        	ld = 1'b0;
		mode = 0;

	    end
   
    	2:  begin
		din = 16'b0000000011000000;
		ld = 1'b1;
		#100
        	sin = 1'b0;
        	ld = 1'b0;
		mode = 0;

	    end

	3:  begin
	    	din = 16'b0000000011000000;
		ld = 1'b1;
		#100
		sin = 1'b0;
        	ld = 1'b0;
		mode = 1;

	    end

	4:  begin
	    	din = 16'b0000111100001111;
	    	ld = 1'b1;

	    end

	5:  begin
    		din = 16'b0000000011000000;
		ld = 1'b1;
		#100
		sin = 1'b1;
        	ld = 1'b0;
		mode = 1;

	    end
	
	default: begin
			$display("Bad testcase id %d",testid);
			$finish();
		 end

     endcase 
     #100;
	if ( (testid == 0 && din == 65535 && dout == 65535) || 
		(testid == 1 && din == 192 && dout == 32864) ||
		(testid == 2 && din == 192 && dout == 96) || 
		(testid == 3 && din == 192 && dout == 384) || 
		(testid == 4 && din == dout) || 
		(testid == 5 && din == 192 && dout == 385) )
			pass();
	else
			fail();
	end


	task fail; 	begin
				$display("Fail: for clk=%d, mode=%d, ld=%d, sin=%d, din=%d and dout=%d is WRONG",clk, mode, ld, sin, din, dout);
				$finish();
			end
	endtask

	task pass; 	begin
				$display("Pass: for clk=%d, mode=%d, ld=%d, sin=%d, din=%d and dout=%d",clk, mode, ld, sin, din, dout);
				$finish();
			end
	endtask
   endmodule
