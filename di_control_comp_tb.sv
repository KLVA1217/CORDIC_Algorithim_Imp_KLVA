`define OUTPUT_STR_1 "from display: t= %d|z_input= %b|di_control_comp_output= %b"

`define PERIOD 10

module testbench();
  
  reg [7:0] z_input;
  
  wire      di_control_comp_output;
  
  di_control_comp UUT(z_input,
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
    z_input = 8'b01111111;
    
    #(`PERIOD)
    z_input = 8'b10000000;
    
    #(`PERIOD)
    $finish;
  end
endmodule