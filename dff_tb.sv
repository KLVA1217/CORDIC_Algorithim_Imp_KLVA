`define OUTPUT_STR_1 "from display: t= %d, clk= %b|d_in=  %d, rst_in=  %b | q_output= %b (%d)"

`define PERIOD 10
`define NUM_OF_CYCLES 5
`define BIT_WIDTH_PARAM 64

module dff_tb();
  reg                         clk;
  reg  [`BIT_WIDTH_PARAM-1:0] d_in;
  reg                         rst_in;
  
  wire [`BIT_WIDTH_PARAM-1:0] q_output;
  
  dff #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) dff0 (d_in,
                                            rst_in,
                                            clk,
                                            q_output);
  
  // Clock Process
  initial begin
  	clk = 0;
    forever begin
  	 	#(`PERIOD/2) clk = ~clk;
   	end
  end
  
  // Display Process
  initial begin
    $monitor(`OUTPUT_STR_1,
             $time,
             clk,
             d_in,
             rst_in,
             q_output,
             q_output);
    end
  
    // Stimulus Process
  initial begin
    // t = 0
    rst_in=1;
    d_in = 87;
    
    #(`PERIOD)
    rst_in = 0;
    d_in = 87;
    
    #(`PERIOD)
    rst_in = 0;
    d_in = 2;
    
    #(`PERIOD)
    rst_in = 0;
    d_in = 68;
    
    #(`PERIOD)
    $finish;
  end
endmodule