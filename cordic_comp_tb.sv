`define OUTPUT_STR_1 "from display: t= %d| mode_bit_input= %b, coordinate_system_in= %b, x_out = %b, y_out = %b, z_out = %b"

`define PERIOD 10
`define NUM_OF_CYCLES 1

// Minimum Whole Bit Width is 2
`define WHOLE_BIT_WIDTH_PARAM 2
`define DECIMAL_BIT_WIDTH_PARAM 6

module testbench();
  
  reg [(`WHOLE_BIT_WIDTH_PARAM-1):0] x_initial_whole_in,
                                     y_initial_whole_in,
                                     z_initial_whole_in;
  
  
  reg [(`DECIMAL_BIT_WIDTH_PARAM-1):0] x_initial_decimal_in,
                                       y_initial_decimal_in,
                                       z_initial_decimal_in;
  
  reg mode_bit_input, 
      rst, 
      clk;
  
  reg [1:0] coordinate_system_in;
  
  wire [(`WHOLE_BIT_WIDTH_PARAM + `DECIMAL_BIT_WIDTH_PARAM - 1 ):0] x_out, 
                                                                    y_out, 
                                                                    z_out;
  
  // Display Process
  initial begin
    
    $monitor(`OUTPUT_STR_1,
             $time,
             mode_bit_input,
             coordinate_system_in,
             x_out,
             y_out,
             z_out);
  
    end
  
//////////////////////////////////////////////////////////////////////////////////////////////
  cordic_comp #(.WHOLE_BIT_WIDTH(`WHOLE_BIT_WIDTH_PARAM),
                .DECIMAL_BIT_WIDTH(`DECIMAL_BIT_WIDTH_PARAM) )
            UUT(x_initial_whole_in,
                x_initial_decimal_in,
                y_initial_whole_in,
                y_initial_decimal_in,
                z_initial_whole_in,
                z_initial_decimal_in,
                mode_bit_input,
                coordinate_system_in,
                rst,
                clk,
                x_out,
                y_out,
                z_out);
  
//////////////////////////////////////////////////////////////////////////////////////////////
  
  // Clock Process
  initial begin
    clk = 0;
    forever begin
      #(`PERIOD/2) clk = ~clk;
    end
  end
  
  // Stimulus Process for 8 bits
  initial begin 
    
    $dumpfile("dump.vcd"); $dumpvars;
    
    // t = 0
    rst = 1;
/////////////////////////////////////////////////////////////////////////////////////////////
    // Coordinate System Modifier
    // coordinate_system_in = 1; //Circular Coordinate System
    // coordinate_system_in = 0; //Linear Coordinate System
    coordinate_system_in = -1;
    
/////////////////////////////////////////////////////////////////////////////////////////////
    //Rotation Mode Test Case
    //mode_bit_input= 0; //Setting mode_bit to rotation
    
	// Original Binary
    
    // Circular Coordinate System Test Case
    // x_initial_in   = 8'b01001101; // Setting x to 1/K in radian binary
    // y_initial_in   = 8'b00000000; // Setting y to 0
    // z_initial_in   = 8'b00100001; // Setting z to 30 degrees in radian binary
    
    // Circular Coordinate System Test Case 
    /*
    x_initial_whole_in   = 0; // Setting x_whole   to 0 in binary
    x_initial_decimal_in = 6'b100110; // Setting x_decimal to 1/K in binary
    
    y_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    y_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    
    z_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    z_initial_decimal_in = 6'b100001; // Setting y_decimal to 30 degree radian in binary
    */
    
    // Linear Coordinate System Test Case 
    /*
    x_initial_whole_in   = 2; // Setting x_whole   to 2 in binary
    x_initial_decimal_in = 0; // Setting x_decimal to 0 in binary
    
    y_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    y_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    
    z_initial_whole_in   = 1; // Setting y_whole   to 1 in binary
    z_initial_decimal_in = 13'b1000000000000; // Setting y_decimal to 0.5 in binary
    */
    
    // Hyperbolic Coordinate System Test Case
    /*
    x_initial_whole_in   = 1;         // Setting x_whole   to 1 in binary
    x_initial_decimal_in = 6'b001101; // Setting x_decimal to decimal portion of 1/(K') in binary
    
    y_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    y_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    
    z_initial_whole_in   = 1; // Setting y_whole   to 1 in binary
    z_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    */
    
    // Rotation Mode Test Case End

/////////////////////////////////////////////////////////////////////////////////////////////
    //Vectoring Mode
    mode_bit_input= 1; //Setting mode_bit to vectoring
    
    // Original Binary
    // x_initial_in   = 8'b00100000; // Setting x to 1
    // y_initial_in   = 8'b01000000; // Setting y to 2
    // z_initial_in   = 8'b00000000; // Setting z to 0
    
    // Binary to LITERAL DECIMAL
    // x_initial_in   = 32; // Setting x to 1
    // y_initial_in   = 64; // Setting y to 2
    // z_initial_in   = 0;  // Setting z to 0
    
    // Linear Coordinate System Test Case 
    /*
    x_initial_whole_in   = 4; // Setting x_whole   to 4 in binary
    x_initial_decimal_in = 0; // Setting x_decimal to 0 in binary
    
    y_initial_whole_in   = 2; // Setting y_whole   to 2 in binary
    y_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    
    z_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    z_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    */
    
    // Hyperbolic Coordinate System Test Case
    
    x_initial_whole_in   = 1;         // Setting x_whole   to 1 in binary
    x_initial_decimal_in = 0; // Setting x_decimal to 0 in binary
    
    y_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    y_initial_decimal_in = 6'b100000; // Setting y_decimal to 0.5 in binary
    
    z_initial_whole_in   = 0; // Setting y_whole   to 0 in binary
    z_initial_decimal_in = 0; // Setting y_decimal to 0 in binary
    
    // Vectoring Mode Test Case End
    
/////////////////////////////////////////////////////////////////////////////////////////////

    // t = 10 | Iteration 0
    #(`PERIOD)
    rst = 0;
    
    #( ( (`WHOLE_BIT_WIDTH_PARAM + `DECIMAL_BIT_WIDTH_PARAM) ) * `PERIOD )
 
    
    $finish;
  end

endmodule