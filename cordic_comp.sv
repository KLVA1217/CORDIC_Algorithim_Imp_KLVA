module cordic_comp
  #( parameter WHOLE_BIT_WIDTH   = 3,
               DECIMAL_BIT_WIDTH = 5,
               BIT_WIDTH         = WHOLE_BIT_WIDTH + DECIMAL_BIT_WIDTH)
  (    input  [WHOLE_BIT_WIDTH-1   :0] x_initial_whole,
       input  [DECIMAL_BIT_WIDTH-1 :0] x_initial_decimal,
       input  [WHOLE_BIT_WIDTH-1   :0] y_initial_whole,
       input  [DECIMAL_BIT_WIDTH-1 :0] y_initial_decimal,
       input  [WHOLE_BIT_WIDTH-1   :0] z_initial_whole,
       input  [DECIMAL_BIT_WIDTH-1 :0] z_initial_decimal,
       input                           mode_bit,
       input  [1:0]                    coordinate_system,
       input                           rst,
       input                           clk,
       output [BIT_WIDTH-1:0] x_output,
       output [BIT_WIDTH-1:0] y_output,
       output [BIT_WIDTH-1:0] z_output);

  
  wire [BIT_WIDTH-1:0] x_initial,
                       y_initial,
                       z_initial;
  
  wire [BIT_WIDTH-1:0] mux_to_x_reg_wire,
                       x_current,
                       x_next;
  
  wire [BIT_WIDTH-1:0] mux_to_y_reg_wire,
                       y_current,
                       y_next;
  
  wire [BIT_WIDTH-1:0] mux_to_z_reg_wire,
                       z_current,
                       z_next;
  
  wire [BIT_WIDTH-1:0] x_shifted,
                       y_shifted;
  
  wire [BIT_WIDTH-1:0] lut_output;
  
  reg [BIT_WIDTH - 1 : 0] zeroes = 0;
  
  wire [BIT_WIDTH-1:0] x_next_second_term;
  
  wire [5:0] lut_count;
  
  wire di_control_comp_wire,
       mux_input;
  
  assign x_initial = {x_initial_whole, x_initial_decimal};
  assign y_initial = {y_initial_whole, y_initial_decimal};
  assign z_initial = {z_initial_whole, z_initial_decimal};
  
  mux_input_controller mux_input_controller(clk,
                                            rst,
                                            mux_input);
  
  reg_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) x_current_mux(x_next,
                                                      x_initial,
                                                      mux_input,
                                                      mux_to_x_reg_wire);
  
  reg_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) y_current_mux(y_next,
                                                      y_initial,
                                                      mux_input,
                                                      mux_to_y_reg_wire);
  
  reg_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) z_current_mux(z_next,
                                                      z_initial,
                                                      mux_input,
                                                      mux_to_z_reg_wire);

  reg_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) coordinate_system_mux(zeroes,
                                                              y_shifted,
                                                              coordinate_system,
                                                              x_next_second_term);
  
  dff #(.BIT_WIDTH(BIT_WIDTH)) x_register (mux_to_x_reg_wire,
                                           rst,
                                           clk,
                                           x_current);
  
  dff #(.BIT_WIDTH(BIT_WIDTH)) y_register (mux_to_y_reg_wire,
                                           rst,
                                           clk,
                                           y_current);
  
  dff #(.BIT_WIDTH(BIT_WIDTH)) z_register (mux_to_z_reg_wire,
                                           rst,
                                           clk,
                                           z_current);
  
  shifter #(.BIT_WIDTH(BIT_WIDTH)) x_shifter(x_current,
                                             lut_count,
                                             x_shifted);
  
  shifter #(.BIT_WIDTH(BIT_WIDTH)) y_shifter(y_current,
                                             lut_count,
                                             y_shifted);
  
  addorsub_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) x_next_mux(x_next_second_term,
                                                        x_current,
                                                        ~(di_control_comp_wire),
                                                        x_next);
  
  addorsub_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) y_next_mux(x_shifted,
                                                        y_current,
                                                        di_control_comp_wire,
                                                        y_next);
  
  addorsub_2to1_mux #(.BIT_WIDTH(BIT_WIDTH)) z_next_mux(lut_output,
                                                        z_current,
                                                        ~(di_control_comp_wire),
                                                        z_next);
  
  counter_mod counter(clk,
                      rst,
                      lut_count);
  
  di_ei_LUT #(.WHOLE_BIT_WIDTH(WHOLE_BIT_WIDTH),
              .BIT_WIDTH(BIT_WIDTH))
         lut (lut_count,
              coordinate_system,
              lut_output);
  
  di_control_comp #(.BIT_WIDTH(BIT_WIDTH)) di_control(x_current,
                                                      y_current,
                                                      z_current,
                                                      mode_bit,
                                                      di_control_comp_wire);
  
  assign x_output = x_current;
  assign y_output = y_current;
  assign z_output = z_current;
  
endmodule