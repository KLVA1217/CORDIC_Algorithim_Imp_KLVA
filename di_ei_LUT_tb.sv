`define OUTPUT_STR_1 "from display: t= %d|count_in= %d (%b)| di_ei_output_out= %b"

`define PERIOD 10
`define NUM_OF_CYCLES 8
`define BIT_WIDTH_PARAM 64

module testbench();
  
  reg [5:0] count_in;
  
  wire [`BIT_WIDTH_PARAM-1:0] di_ei_output_out;
  
  di_ei_LUT #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(count_in,
                                                di_ei_output_out);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             count_in,
             count_in,
             di_ei_output_out);
    end
  
  // Stimulus Process
  initial begin
    
    count_in = 3'b000;
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