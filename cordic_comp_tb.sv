`define OUTPUT_STR_1 "from display: t= %d| x_out = %b, y_out = %b, z_out = %b"

`define PERIOD 10
`define NUM_OF_CYCLES 1

`define BIT_WIDTH_PARAM 8

module testbench();
  
  reg [`BIT_WIDTH_PARAM-1:0] x_initial_in,
                             y_initial_in,
                             z_initial_in;
  reg                        rst, clk;
  
  wire [`BIT_WIDTH_PARAM-1:0] x_out, 
                              y_out, 
                              z_out;
  
  cordic_comp #(.BIT_WIDTH(`BIT_WIDTH_PARAM)) UUT(x_initial_in,
                                                  y_initial_in,
                                                  z_initial_in,
                                                  rst,
                                                  clk,
                                                  x_out,
                                                  y_out,
                                                  z_out);
  
  // Display Process
  initial begin
    
    $monitor(`OUTPUT_STR_1,
             $time,
             x_out,
             y_out,
             z_out);
  
    end
  
  
  // Stimulus Process
  initial begin 
    
    $dumpfile("dump.vcd"); $dumpvars;
    
    // t = 0
    rst = 1;
    x_initial_in   = 8'b01001101;
    y_initial_in   = 8'b00000000;
    z_initial_in   = 8'b01000011;
    
    // t = 10 | Rotation 1
    #(`PERIOD)
    rst = 0;
    
    #((`BIT_WIDTH_PARAM-1) * `PERIOD)
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