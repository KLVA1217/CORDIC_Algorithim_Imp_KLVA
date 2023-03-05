module mux_input_controller(input      clk,
                            input      rst,
                            output reg q);

  reg del = 0;
  
  always @ (posedge clk) begin
    
    if(rst) begin
    	q <= 1;
    	del <= 0;
    end
    
  	else
      
      if (!del) begin
        del <= del + 1;
    	q <= 0;
      end
    
      else
        q <= 0;
    
  	end
endmodule