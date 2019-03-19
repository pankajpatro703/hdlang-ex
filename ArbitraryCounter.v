// 3 -> 0 -> 1 -> 5 -> 2 -> 7 -> 6 -> 4 -> 9 -> 12
module arb_counter (out, count, init, set, reset, clk);
	input  set, reset, clk;
	input [3:0] init;
	output [3:0] count; 
	output out;
	reg [3:0] count;
	reg out;

  always @(negedge clk or negedge set or negedge reset)
     begin
	if (!set) begin count = init; out = 0; end
	else if (!reset) begin count = 4'b0011; out = 0; end
	else begin
		case (count)
			4'b0011: begin
				count = 4'b0000;
				out = 0;
			end

			4'b0000: begin
				count = 4'b0001;
				out = 0;
			end

			4'b0001: begin
				count = 4'b0101;
				out = 0;
			end

			4'b0101: begin
				count = 4'b0010;
				out = 0;
			end

			4'b0010: begin
				count = 4'b0111;
				out = 0;
			end

			4'b0111: begin
				count = 4'b0110;
				out = 0;
			end

			4'b0110: begin
				count = 4'b0100;
				out = 0;
			end

			4'b0100: begin
				count = 4'b1001;
				out = 0;
			end

			4'b1001: begin
				count = 4'b1100;
				out = 0;
			end

			4'b1100: begin
				count = 4'b0011;
				out = 1;
			end

			default: begin
				count = 4'b0101;
				out = 0;
			end
		endcase
	end
     end
endmodule 
//************************************************************************
//End of Sample Solution
//************************************************************************
`timescale 1ns/1ps
module arb_counter_tb;
  reg  set, reset, clk;
  reg [3:0] init;	
  wire [3:0] count;
  wire out;
  reg [3:0] count_p, count_c;
  reg out_p, out_c;

  arb_counter SA(out, count, init, set, reset, clk);

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

   initial
     begin
     	clk=1'b1;
     	forever #10 clk=~clk;  
     end
 //3 -> 0 -> 1 -> 5 -> 2 -> 7 -> 6 -> 4 -> 9 -> 12
   initial
     begin
        ret = $fscanf(STDIN,"%d",testid);
	case(testid)
				
	0:  begin  //reset the counter 
    			#2 set=1'b1; reset=1'b0;   
			#5 count_p=count; out_p = out; reset=1'b1; 
			//#20 $display("%d", count);
			#60 count_c=count; out_c = out;    
	    end
				
	1:  begin  //set the counter 
    			#2 set=1'b0; reset=1'b1; init=4'b0110;   
			#5 count_p=count; out_p = out; set=1'b1;
			#80 count_c=count; out_c = out;    
	    end
				
	2:  begin  //set the counter 
    			#2 set=1'b0; reset=1'b1; init=4'b1111;   
			#5 count_p=count; out_p = out; set=1'b1;
			#20 count_c=count; out_c = out;    
	    end

				
	3:  begin  //set the counter 
    			#2 set=1'b1; reset=1'b0;   
			#5 count_p=count; out_p = out; reset=1'b1;
			#200 count_c=count; out_c = out;    
	    end

				
	4:  begin  //set the counter 
    			#2 set=1'b0; reset=1'b1; init=4'b0110;   
			#5 count_p=count; out_p = out; set=1'b1;
			#200 count_c=count; out_c = out;    
	    end

				
	5:  begin  //set the counter 
    			#2 set=1'b0; reset=1'b1; init=4'b0111;   
			#5 count_p=count; out_p = out; set=1'b1;
			#100 count_c=count; out_c = out;    
	    end

				
	6:  begin  //set the counter 
    			#2 set=1'b0; reset=1'b1; init=4'b1001;   
			#5 count_p=count; out_p = out; set=1'b1;
			#20 count_c=count; out_c = out;    
	    end

				
	7:  begin  //set the counter 
    			#2 set=1'b0; reset=1'b1; init=4'b1100;   
			#5 count_p=count; out_p = out; set=1'b1;
			#20 count_c=count; out_c = out;    
	    end
	
	default: begin
			$display("Bad testcase id %d",testid);
			$finish();
		 end

       endcase 
       if ( (testid == 0 & count_c == 5 & out_c == 0 & count_p == 3 & out_p == 0) ||
            (testid == 1 & count_c == 3 & out_c == 1 & count_p == 6 & out_p == 0) ||
            (testid == 2 & count_c == 5 & out_c == 0 & count_p == 15 & out_p == 0)||
            (testid == 3 & count_c == 3 & out_c == 1 & count_p == 3 & out_p == 0) ||
            (testid == 4 & count_c == 6 & out_c == 0 & count_p == 6 & out_p == 0) ||
            (testid == 5 & count_c == 3 & out_c == 1 & count_p == 7 & out_p == 0) ||
            (testid == 6 & count_c == 12 & out_c == 0 & count_p == 9 & out_p == 0) ||
            (testid == 7 & count_c == 3 & out_c == 1 & count_p == 12 & out_p == 0))
			pass();
       else
			fail();
       end 
      
      task fail; 	begin
				$display("Fail: for init(count,out)=(%d, %b), after period =%2d arb_counter(count, out)=(%d, %b) is WRONG", count_p, out_p, $time/20, count_c, out_c);
				$finish();
			end
      endtask

      task pass; 	begin
				$display("Pass: for init(count,out)=(%d, %b), after period =%2d arb_counter(count, out)=(%d, %b)", count_p, out_p, $time/20, count_c, out_c);
				$finish();
			end
      endtask
        
endmodule
