module di_control_comp
  #(parameter BIT_WIDTH = 64)
  ( input  [BIT_WIDTH-1:0] x_input,
    input  [BIT_WIDTH-1:0] y_input,
    input  [BIT_WIDTH-1:0] z_input,
    input                  mode_bit,
    output                 di_control_comp_output);
  
  wire rotation_mode_output,
       vectoring_mode_output;
  
  /*
  nor (vectoring_mode_output,
       x_input[BIT_WIDTH-1],
       y_input[BIT_WIDTH-1]);
  */
  
  assign rotation_mode_output = (z_input[BIT_WIDTH-1]);
  assign vectoring_mode_output = ~(y_input[BIT_WIDTH-1]);
  
  assign di_control_comp_output = (mode_bit) ? vectoring_mode_output : rotation_mode_output;
endmodule