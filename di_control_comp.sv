module di_control_comp( input  [7:0] z_input,
                        output       di_control_comp_output);
  
  assign di_control_comp_output = ~(z_input[7]);
endmodule