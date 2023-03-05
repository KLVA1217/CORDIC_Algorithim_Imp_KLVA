module di_ei_LUT(input      [2:0] count,
                 output reg [7:0] di_ei_output);
  
  always @ (count) begin
    case(count)
      3'b000 : di_ei_output <= 8'b01100100; // arctan(2^0)  or tan(45_deg)
      3'b001 : di_ei_output <= 8'b00111011; // arctan(2^-1) or tan(26.57_deg)
      3'b010 : di_ei_output <= 8'b00011111; // arctan(2^-2) or tan(14.04_deg)
      3'b011 : di_ei_output <= 8'b00001111; // arctan(2^-3) or tan(7.13_deg)  
      3'b100 : di_ei_output <= 8'b00000111; // arctan(2^-4) or tan(3.58_deg)
      3'b101 : di_ei_output <= 8'b00000011; // arctan(2^-5) or tan(1.79_deg)
      3'b110 : di_ei_output <= 8'b00000001; // arctan(2^-6) or tan(0.9_deg)
      // 3'b111 : di_ei_output = 8'b // arctan(2^-7) or tan(_deg)  
      default: di_ei_output <= 0;
    endcase
  end
endmodule