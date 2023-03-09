module cordic_comp
	#( parameter BIT_WIDTH = 64)
     ( input  [BIT_WIDTH-1:0] z_initial,
       input                  rst,
       input                  clk,
       output [BIT_WIDTH-1:0] z_output);

  wire [BIT_WIDTH-1:0] mux_to_z_reg_wire,
                       z_current,
  			           z_next;
  
  wire [63:0] lut_output;
  
  wire [5:0] lut_count;
  
  wire di_control_comp_wire,
       mux_input;
  
  mux_input_controller mux_input_controller_z(clk,
                                              rst,
                                              mux_input);
  
  reg_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) z_current_mux(z_next,
                                                      z_initial,
                                                      mux_input,
                                                      mux_to_z_reg_wire);

  dff #(.BIT_WIDTH(BIT_WIDTH)) z_register (mux_to_z_reg_wire,
                                                  rst,
                                                  clk,
                                                  z_current);

  counter_mod counter(clk,
                      rst,
                      lut_count);
  
  di_ei_LUT lut(lut_count,
                lut_output);
  
  di_control_comp #(.BIT_WIDTH(BIT_WIDTH)) di_control(z_current,
                                                      di_control_comp_wire);
  
  addorsub_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) z_next_mux(lut_output[63 : (63 - (BIT_WIDTH - 1))],
                                                        z_current,
                                                        di_control_comp_wire,
                                                        z_next);
  
  assign z_output = z_current;
  
endmodule