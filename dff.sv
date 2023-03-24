module dff
  #(parameter BIT_WIDTH = 64)
  (input     [BIT_WIDTH-1:0] d,
  input                      rst,
  input                      clk,
  output reg [BIT_WIDTH-1:0] q);
  
  always @ (posedge clk)
    if(rst) begin
      q <= 0 ;
    end
  
  	else begin
      q <= d;
    end
endmodule