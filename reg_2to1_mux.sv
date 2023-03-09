module reg_2to1_mux
  #(parameter BIT_WIDTH = 64)
   (input  [BIT_WIDTH-1:0] d0,
    input  [BIT_WIDTH-1:0] d1,
    input                  sel,
    output [BIT_WIDTH-1:0] y);
  
  assign y = (sel) ? d1 : d0;
endmodule