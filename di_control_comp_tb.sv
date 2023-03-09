`define OUTPUT_STR_1 "from display: t= %d|z_input= %b|di_control_comp_output= %b"

`define PERIOD 10
`define BIT_WIDTH_PARAM 4

module testbench();
  
  reg [`BIT_WIDTH_PARAM-1:0] z_input;
  
  wire di_control_comp_output;
  
  di_control_comp #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(z_input,
                                                      di_control_comp_output);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             z_input,
             di_control_comp_output);
   
    end
  
  // Stimulus Process
  initial begin
    z_input = 1;
    
    #(`PERIOD)
    z_input = -1;
    
    #(`PERIOD)
    $finish;
  end
endmodule