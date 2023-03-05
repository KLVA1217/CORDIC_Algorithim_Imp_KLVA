module dff(input      [7:0] d,
          input             rst,
          input             clk,
           output reg [7:0] q);
  
  always @ (posedge clk)
    if(rst)
      q <= 0 ;
  	else
      q <= d;
endmodule