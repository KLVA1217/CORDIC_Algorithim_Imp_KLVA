module mux_control_comp(input             rst,
                 input             clk,
                 output reg [3:0]  out);
  
  always @ (posedge clk)
    if(rst)
      internal_delay <= 0;
      count <= 0 ;
  	else

endmodule