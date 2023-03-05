`define OUTPUT_STR_1 "from display: t= %d|count_in= %b | di_ei_output_out= %b"

`define PERIOD 10
`define NUM_OF_CYCLES 8

module testbench();
  
  reg [2:0] count_in;
  
  wire [7:0] di_ei_output_out;
  
  di_ei_LUT UUT(count_in,
             di_ei_output_out);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
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