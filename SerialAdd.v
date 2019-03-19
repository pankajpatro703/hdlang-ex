module serialadd (a, b, s, reset, clk);
   input  a, b, reset, clk;
   output s;
   reg s, cfsm, cfsm_nxt;  

   always @(posedge(clk) or posedge(reset)) begin
      if (reset) cfsm <= 1'b0;
      else begin
         case ({a,b})
         2'b00, 2'b11: begin
            s = cfsm;
         end         
         2'b01, 2'b10: begin
            s = !cfsm;
         end                  
         endcase
         case (cfsm)
         1'b0: begin
            if (a&b)
               cfsm_nxt = 1'b1;
            else
               cfsm_nxt = cfsm;
         end
         1'b1: begin
            if (!(a|b))
               cfsm_nxt = 1'b0;
            else
               cfsm_nxt = cfsm;
         end
        endcase
        cfsm <= cfsm_nxt;
      end
   end
   
endmodule
//************************************************************************
//End of Sample Solution
//************************************************************************
`timescale 1ns/1ps
module serialadd_tb;
  reg  a, b, reset, clk;
  reg [3:0] s_t;	
  reg [4:0] a_t, b_t;
  wire s;

  serialadd SA(a, b, s, reset, clk);

  parameter STDIN = 32'h8000_0000;
  integer testid;
  integer ret;

   initial
     begin
     	clk=1'b0;
     	forever #10 clk=~clk;  
     end
 
   initial
     begin
        ret = $fscanf(STDIN,"%d",testid);
	case(testid)
				
	0:  begin  //add 11 and 19 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=11; b_t=19;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end
   
	1:  begin  //add 23 and 15 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=23; b_t=15;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end

	2:  begin  //add 22 and 6 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=22; b_t=6;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end
   
	3:  begin  //add 8 and 17 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=8; b_t=17;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end
   
	4:  begin  //add 1 and 31 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=1; b_t=31;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end
   
	5:  begin  //add 31 and 0 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=31; b_t=0;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end

	6:  begin  //add 31 and 31 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=31; b_t=31;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end
   
	7:  begin  //add 0 and 0 
    			#2 reset = 1'b1; a = 1'b0; b = 1'b0; a_t=0; b_t=0;  
			#5; reset = 1'b0; a = a_t[0]; b = b_t[0];
			#15; s_t[0] = s;   

                #5; a = a_t[1]; b = b_t[1]; 
                #15; s_t[1] = s;   

			#5; a = a_t[2]; b = b_t[2]; 
			#15; s_t[2] = s;      

			#5; a = a_t[3]; b = b_t[3]; 
			#15; s_t[3] = s;   
                
                #5; a = a_t[4]; b = b_t[4]; 			
	    end
	
	default: begin
			$display("Bad testcase id %d",testid);
			$finish();
		 end

       endcase 
       #15;
       if ( a_t + b_t == {s,s_t} )
			pass();
       else
			fail();
       end 
      
      task fail; 	begin
				$display("Fail: for a (%b) + b (%b) != s (%b)", a_t, b_t, {s,s_t});
				$finish();
			end
      endtask

      task pass; 	begin
				$display("Pass: for a (%b) + b (%b) = s (%b)", a_t, b_t, {s,s_t});
				$finish();
			end
      endtask
        
endmodule
