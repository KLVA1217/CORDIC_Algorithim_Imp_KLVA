`define OUTPUT_STR_1 "from display: t= %d | x_in = %b, shift_by_in = %d | y_out = %b"

`define PERIOD 10
`define BIT_WIDTH_PARAM 8

module shifter_tb();
  reg clk;
  
  reg [`BIT_WIDTH_PARAM-1:0]  x_in;
  reg [5:0]                   shift_by_in;
  
  wire [`BIT_WIDTH_PARAM-1:0] y_out;
  
  shifter #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(x_in,
                                              shift_by_in,
                                              y_out);
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             x_in,
             shift_by_in,
             y_out);
    end
  
  
  // Stimulus Process
  initial begin 
    
    //$dumpfile("dump.vcd"); $dumpvars;
    
    // t = 0
    x_in = 8'b01111111;
    x_in = ~(x_in);
    shift_by_in = 0;
    
    #(`PERIOD)
    shift_by_in = 1;
    
    #(`PERIOD)
    shift_by_in = 2;
    
    #(`PERIOD)
    shift_by_in = 3;
    
    $finish;
  end
  
  // Clock Process
  initial begin
    clk = 0;
    forever begin
      #(`PERIOD/2) clk = ~clk;
    end
  end
 
endmodule