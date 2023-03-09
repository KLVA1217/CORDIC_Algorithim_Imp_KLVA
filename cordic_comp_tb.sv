`define OUTPUT_STR_1 "from display: t= %d| z_out = %b | UUT.z_current = %b"

`define PERIOD 10
`define NUM_OF_CYCLES 1

`define BIT_WIDTH_PARAM 8

module testbench();
  
  reg [`BIT_WIDTH_PARAM-1:0] z_initial_in;
  reg                        rst, clk;
  
  wire [`BIT_WIDTH_PARAM-1:0] z_out;
  
  cordic_comp #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(z_initial_in,
                                                  rst,
                                                  clk, 
                                                  z_out);
  
  // Display Process
  initial begin
    
    $monitor(`OUTPUT_STR_1,
             $time,
             z_out,
             UUT.z_current);
    end
  
  
  // Stimulus Process
  initial begin 
    
    $dumpfile("dump.vcd"); $dumpvars;
    
    // t = 0
    rst = 1;
    z_initial_in   = 8'b01000011;
    
    // t = 10 | Rotation 1
    #(`PERIOD)
    rst = 0;
    
    #(5 * `PERIOD)
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