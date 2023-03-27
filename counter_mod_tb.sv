`define OUTPUT_STR_1 "from display: t= %d | del = %b | rst = %b, coordinate_system= %b | q = %b(%d) out = %b(%d) "  

`define PERIOD 10
`define NUM_OF_CYCLES 8

module testbench();
  
  reg        clk, rst, en;
  reg [1:0]  coordinate_system_in;
  wire [5:0] out;
  
  counter_mod UUT(clk,
                 rst,
                 coordinate_system_in,
                 en,
                 out);
  
  // Monitor Process
  initial begin
    
    $monitor(`OUTPUT_STR_1,
             $time,
             UUT.del,
             rst,
             coordinate_system_in,
             UUT.q,
             UUT.q,
             out,
             out);
  end
  
  // Stimulus Process
  initial begin 
    
    $dumpfile("dump.vcd"); $dumpvars;
    
	rst = 1;
    coordinate_system_in = -1;
    en = 0;
    
    // t = 10
    #(`PERIOD)
    rst = 0;
    
    en = 1;
    
    #(`NUM_OF_CYCLES * `PERIOD)
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