module cordic_comp( input  [7:0] z_initial,
                    input        rst,
                    input        clk,
                    output [7:0] cordic_output);

  wire [7:0] mux_to_z_reg_wire,
             z_current,
  			 lut_output,
  			 z_next;
  
  wire [3:0] lut_count;
  
  wire di_control_comp_wire,
       mux_input;
  
  mux_input_controller mux_input_controller_inst1(clk,
                                                  rst,
                                                  mux_input);
  
  reg_2to1_mux z_current_mux(z_next,
                             z_initial,
                             mux_input,
                             mux_to_z_reg_wire);

  dff z_register (mux_to_z_reg_wire,
                  rst,
                  clk,
                  z_current);
  
  counter_mod UUT(clk,
                  rst,
                  lut_count);
  
  di_ei_LUT lut(lut_count,
                lut_output);
  
  di_control_comp di_control(z_current,
                             di_control_comp_wire);
  
  addorsub_2to1_mux z_next_mux(lut_output,
                         z_current,
                         di_control_comp_wire,
                         z_next);
  
  assign cordic_output = z_current;
  
endmodule