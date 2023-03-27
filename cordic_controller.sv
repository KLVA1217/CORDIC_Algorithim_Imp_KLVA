module cordic_controller
  #(parameter BIT_WIDTH = 64)
  ( input  [BIT_WIDTH-1:0] y_input,
    input  [BIT_WIDTH-1:0] z_input,
   input   [5:0]           count,
    input                  mode_bit,
   input   [1:0]           coordinate_system,
   input                   rst,
    output                 cordic_controller_output);
  
  reg [BIT_WIDTH - 1 : 0] zeroes = 0;
  
  reg converges,
      rotations; 
  
  wire [BIT_WIDTH - 1 : 0] selected_input;
  
  wire or1;
  
  assign selected_input = (mode_bit) ? y_input : z_input;
  
  always @ (selected_input) begin
    if ( (selected_input == 0) & (count > 1) )
      converges <= 1;
    else
      converges <= 0;
  end
  
  always @ (count) begin
    
    if ( (coordinate_system[1] == 0) & (count == BIT_WIDTH)) begin
      	rotations <= 1;
    end
    
    else if ( (coordinate_system[1] == 1) & (count == BIT_WIDTH + 1)) begin
      	rotations <= 1;
    end
    
    else begin
      rotations <= 0;
    end
    
  end
  
  or (or1, converges, rotations);
  
  or (cordic_controller_output, rst, or1);   
    
endmodule