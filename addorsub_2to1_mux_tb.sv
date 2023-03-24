`define OUTPUT_STR_1 "from display: t= %d | d0_in=  %b (%d), d1_in=  %b (%d), sel_in=  %b | y_output= %b (%d)"

`define PERIOD 10
`define BIT_WIDTH_PARAM 8

module mux_tb();
  reg [`BIT_WIDTH_PARAM-1:0] d0_in;
  reg [`BIT_WIDTH_PARAM-1:0] d1_in;
  reg sel_in;
  
  wire signed [`BIT_WIDTH_PARAM-1:0] y_output;
  
  addorsub_2to1_mux #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT (d0_in,
                                                         d1_in,
                                                         sel_in,
                                                         y_output);

  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             d0_in,
             d0_in,
             d1_in,
             d1_in,
             sel_in,
             y_output,
             y_output);
    end
  
    // Stimulus Process
  initial begin
    
    d0_in = 8'b00110010;
    d1_in = 8'b01000000;
    sel_in = 0;
    
    #(`PERIOD)
    
    sel_in = 1;
    
    #(`PERIOD)

    $finish;
  end
endmodule