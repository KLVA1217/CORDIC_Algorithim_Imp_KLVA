`define OUTPUT_STR_1 "from display: t= %d| cordic_out = %b"

`define PERIOD 10
`define NUM_OF_CYCLES 1

module testbench();
  
  reg [7:0] z_initial_in;
  reg       rst, clk;
  
  wire [7:0] cordic_out;
  
  cordic_comp UUT(z_initial_in,
                 rst,
                 clk, 
                 cordic_out);
  
  // Display Process
  initial begin
    
    $monitor(`OUTPUT_STR_1,
             $time,
             cordic_out);
    end
  
  
  // Stimulus Process
  initial begin 
    
    //$dumpfile("dump.vcd"); $dumpvars;
    
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