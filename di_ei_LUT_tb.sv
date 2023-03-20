`define OUTPUT_STR_1 "from display: t= %d|count_in= %d (%b), coordinate_system_in= %b| di_ei_output_out= %b"

`define PERIOD 10
`define NUM_OF_CYCLES 8
`define WHOLE_BIT_WIDTH 4
`define BIT_WIDTH_PARAM 6

module testbench();
  
  reg [5:0] count_in;
  reg [1:0] coordinate_system_in;
  
  wire [`BIT_WIDTH_PARAM-1:0] di_ei_output_out;
  
  di_ei_LUT #(.WHOLE_BIT_WIDTH(`WHOLE_BIT_WIDTH),
              .BIT_WIDTH(`BIT_WIDTH_PARAM)) 
          UUT(count_in,
              coordinate_system_in,
              di_ei_output_out);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             count_in,
             count_in,
             coordinate_system_in,
             di_ei_output_out);
    end
  
  // Stimulus Process
  initial begin
    
    count_in = 3'b000;
    coordinate_system_in = 1;
    #(`PERIOD) count_in = count_in + 1;
    #(`PERIOD) count_in = count_in + 1;
    #(`PERIOD) count_in = count_in + 1;
    
    #(`PERIOD) count_in = count_in + 1;
    #(`PERIOD) count_in = count_in + 1;
    #(`PERIOD) count_in = count_in + 1;
    #(`PERIOD) count_in = count_in + 1;
    
    $finish;
  end         
             
endmodule