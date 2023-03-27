`define OUTPUT_STR_1 "from display: t= %d |d_in=  %d, rst_in=  %b, en= %b | q_output= %b (%d)"

`define PERIOD 10
`define NUM_OF_CYCLES 5
`define BIT_WIDTH_PARAM 8

module dff_tb();
  reg                         clk,
                              rst_in,
                              en;
  
  reg  [`BIT_WIDTH_PARAM-1:0] d_in,
                              q_output;
  
  dff #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) dff0 (d_in,
                                            rst_in,
                                            clk,
                                            rst_in,
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
             d_in,
             rst_in,
             dff0.en,
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