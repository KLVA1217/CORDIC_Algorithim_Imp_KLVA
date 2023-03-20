`define OUTPUT_STR_1 "from display: t= %d | x_input= %b, y_input= %b, z_input= %b, mode_bit= %b | di_control_comp_output= %b"

`define PERIOD 10
`define BIT_WIDTH_PARAM 4

module testbench();
  
  reg [`BIT_WIDTH_PARAM-1:0] x_input,
                             y_input,
                             z_input;
  
  reg                        mode_bit_input;
  
  wire di_control_comp_output;
  
  di_control_comp #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(x_input,
                                                      y_input,
                                                      z_input,
                                                      mode_bit_input,
                                                      di_control_comp_output);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             x_input,
             y_input,
             z_input,
             mode_bit_input,
             di_control_comp_output);
   
    end
  
  // Stimulus Process
  initial begin
    x_input = 0;
    y_input = 0;
    z_input = 1;
    
    mode_bit_input = 0;
    
    #(`PERIOD)
    x_input = 0;
    y_input = 0;
    z_input = -1;
    
    mode_bit_input = 0;
    
    #(`PERIOD)
    x_input = 1;
    y_input = 2;
    z_input = 0;
    
    mode_bit_input = 1;
    
    #(`PERIOD)
    $finish;
  end
endmodule