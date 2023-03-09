module shifter
  #(parameter BIT_WIDTH = 64)
  ( input  signed [BIT_WIDTH-1:0] x,
    input  [5:0]                  shift_by,
    output signed [BIT_WIDTH-1:0] y);
  
  assign y = x >>> shift_by; 
  
endmodule