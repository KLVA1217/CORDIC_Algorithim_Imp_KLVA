module counter_mod
  (input            clk,
   input            rst,
   input [1:0]      coordinate_system,
   input            en,
   output reg [5:0] q);

  reg del;
  
  always @ (posedge clk) begin
    
    if(rst) begin
      	if (coordinate_system[1]) begin
      		q <= 1 ;
        end
      
        else begin
    		q <= 0 ;
        end
      
    	del <= 0;
    end
    
    else if (!en) begin
      if (coordinate_system[1]) begin
      	if(q == 4-1 || q == 13-1 || q == 40-1) begin
        	del <= 0;
        end
      end
      
      if (!del) begin
        del <= del + 1;
      end
        
      else begin
        q <= q + 1;
      end
   
  	end
    
  end
endmodule