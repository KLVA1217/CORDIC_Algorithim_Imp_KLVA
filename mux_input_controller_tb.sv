`define OUTPUT_STR_1 "from display: t= %d | del = %b | rst = %b | q = %b(%d) out = %b(%d) "  

`define PERIOD 10
`define NUM_OF_CYCLES 1

module testbench();
  
  reg        clk, rst;
  wire       out;
  
  mux_input_controller UUT(clk,
                           rst,
                           out);
  
  // Monitor Process
  initial begin
    
    $monitor(`OUTPUT_STR_1,
             $time,
             UUT.del,
             rst,
             UUT.q,
             UUT.q,
             out,
             out);
  end
  
  // Stimulus Process
  initial begin 
    
    $dumpfile("dump.vcd"); $dumpvars;
    
	rst = 1;
    
    // t = 10
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