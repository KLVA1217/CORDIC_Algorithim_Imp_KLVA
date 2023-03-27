`define OUTPUT_STR_1 "from display: t= %d | y_input= %b, z_input= %b, mode_bit= %b, coordinate_system= %b, count= %b | cordic_controller_output= %b"

`define PERIOD 10
`define BIT_WIDTH_PARAM 8

module testbench();
  
  reg [`BIT_WIDTH_PARAM-1:0] y_input,
                             z_input;
  
  reg [5:0]                  count;
  
  reg [1:0]                  coordinate_system;
  
  reg                        mode_bit_input;
  
  wire cordic_controller_out;
  
  cordic_controller #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(y_input,
                                                        z_input,
                                                        count,
                                                        mode_bit_input,
                                                        coordinate_system,
                                                        cordic_controller_out);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             y_input,
             z_input,
             mode_bit_input,
             coordinate_system,
             count,
             cordic_controller_out);
   
    end
  
  // Stimulus Process
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    
    y_input = 4;
    z_input = 4;
    count = 6;
    
    mode_bit_input = 1;
    coordinate_system = -1;
    
    #(`PERIOD)
	count = count + 1;
    
    #(`PERIOD)
    count = count + 1;
    
    #(`PERIOD)
    $finish;
  end
endmodule