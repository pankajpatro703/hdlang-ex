	module onecount (COUNT, DATA);
  		input [15:0] DATA;
  		output [4:0] COUNT;

  		reg [4:0] COUNT;
		integer i;
		always @(DATA) begin
			{COUNT} = 0;
			for (i=0; i<=15; i=i+1)
				if (DATA[i] == 1'b1) {COUNT} = {COUNT} + 1;
		end
	endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
	module bus_multiplexer_tb;
		reg [15:0] DATA;
		wire [4:0] COUNT;

		
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		onecount  oc (COUNT, DATA);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						DATA = 16'b0101010101010101;
					end
   				1:    	begin
						DATA = 16'b1111111111111111;
        				end
   				2:    	begin
						DATA = 16'b0000000000000111;
					end
   				3:	begin
						DATA = 16'b0000011111100000;
					end
   				4:	begin
						DATA = 16'b1111111111100000;
					end
   				5:	begin
						DATA = 16'b1111000000111100;
					end
   				6:	begin
						DATA = 16'b1100000000001111;
					end
   				7:	begin
						DATA = 16'b0000000000000000;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        					end
			endcase
			#10;
			if ( (testid == 0 && {COUNT} == 8) || (testid == 1 && {COUNT} == 16) || (testid == 2 && {COUNT} == 3) || (testid == 3 && {COUNT} == 6) || (testid == 4 && {COUNT} == 11) || (testid == 5 && {COUNT} == 8) || (testid == 6 && {COUNT} == 6) || (testid == 7 && {COUNT} == 0) )
        			pass();
			else
 				fail();
			
		end


 		task fail; 	begin
    					$display("Fail: for DATA = %b, COUNT = %2d is WRONG", DATA, COUNT);
  				end
  		endtask

  		task pass; 	begin
    					$display("Pass: for DATA = %b, COUNT = %2d", DATA, COUNT);
	    				
  				end
  		endtask

	endmodule
