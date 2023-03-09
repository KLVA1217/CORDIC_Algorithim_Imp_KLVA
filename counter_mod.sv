module counter_mod
  (input            clk,
   input            rst,
   output reg [5:0] q);

  reg del = 0;
  
  always @ (posedge clk) begin
    
    if(rst) begin
    	q <= 0 ;
    	del <= 0;
    end
    
  	else
      
      if (!del) begin
        del <= del + 1;
    	q <= 0;
      end
    
      else
        q <= q + 1;
    
  	end
endmodule