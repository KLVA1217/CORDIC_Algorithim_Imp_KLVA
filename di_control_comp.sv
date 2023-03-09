module di_control_comp
  #(parameter BIT_WIDTH = 64)
  ( input  [BIT_WIDTH-1:0] z_input,
    output                 di_control_comp_output);
  
  assign di_control_comp_output = ~(z_input[BIT_WIDTH-1]);
endmodule