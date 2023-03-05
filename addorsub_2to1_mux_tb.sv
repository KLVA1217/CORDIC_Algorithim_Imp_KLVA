`define OUTPUT_STR_1 "from display: t= %d|d0_in=  %d or %b, d1_in=  %d or %b, sel_in=  %b|y_output= %d or %b"

`define PERIOD 10

module mux_tb();
  reg [7:0] d0_in;
  reg [7:0] d1_in;
  reg sel_in;
  
  wire signed [7:0] y_output;
  
  addorsub_2to1_mux UUT (d0_in,
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
    
    d0_in = 45;
    d1_in = 30;
    sel_in = 0;
    
    #(`PERIOD)
    
    sel_in = 1;
    
    #(`PERIOD)

    $finish;
  end
endmodule