	module encoder (CODE, DATA);
  		input [7:0] DATA;
  		output [2:0] CODE;

  		reg [2:0] CODE;

		always @(DATA) begin

			     if (DATA == 8'b00000001) CODE = 3'b000;
			else if (DATA == 8'b00000010) CODE = 3'b001;
			else if (DATA == 8'b00000100) CODE = 3'b010;
			else if (DATA == 8'b00001000) CODE = 3'b011;
			else if (DATA == 8'b00010000) CODE = 3'b100;
			else if (DATA == 8'b00100000) CODE = 3'b101;
			else if (DATA == 8'b01000000) CODE = 3'b110;
			else if (DATA == 8'b10000000) CODE = 3'b111;
			else                          CODE = 3'bxxx;
		end
	endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
	module bus_multiplexer_tb;
		reg [7:0] DATA;
		wire [2:0] CODE;

		
		parameter STDIN = 32'h8000_0000;
		integer testid;
		integer ret;

		encoder  en (CODE, DATA);
 
		initial begin
			ret = $fscanf(STDIN,"%d",testid);
			case(testid)

				0:    	begin
						{DATA} = 1;
					end
   				1:    	begin
						{DATA} = 5;
        				end
   				2:    	begin
						{DATA} = 4;
					end
   				3:	begin
						{DATA} = 64;
					end
   				4:	begin
						{DATA} = 0;
					end
   				5:	begin
						{DATA} = 123;
					end
   				6:	begin
						{DATA} = 128;
					end
   				7:	begin
						{DATA} = 255;
					end

    				default:	begin
        							$display("Bad testcase id %d",testid);
        							$finish();
        					end
			endcase
			#5;
			case(CODE)
				3'bxxx: if (testid == 1 || testid == 4 || testid == 5 || testid == 7)
						pass();
					else 
						fail();
				default: if ( (testid == 0 && CODE == 3'b000) || (testid == 2 && CODE == 3'b010) || (testid == 3 && CODE == 3'b110) || (testid == 6 && CODE == 3'b111) )
        					pass();
					else
 						fail();
			endcase
		end


 		task fail; 	begin
    					$display("Fail: for DATA = %b, CODE = %1d is WRONG", DATA, CODE);
  				end
  		endtask

  		task pass; 	begin
    					$display("Pass: for DATA = %b, CODE = %1d", DATA, CODE);
	    				
  				end
  		endtask

	endmodule
