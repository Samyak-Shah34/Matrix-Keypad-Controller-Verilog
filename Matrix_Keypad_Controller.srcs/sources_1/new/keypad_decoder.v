//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2026 15:25:39
// Design Name: 
// Module Name: keypad_decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: keypad_decoder
// Description:
//      Decodes the active row and column from a 4x4 matrix keypad into
//      a hexadecimal value.
//
// Inputs:
//      row_sel : Currently scanned row (0-3)
//      col     : Active-low column input
//
// Output:
//      key     : Hexadecimal key value (0-F)
//      valid   : High when a valid key is detected
//////////////////////////////////////////////////////////////////////////////////

module keypad_decoder(

    input  wire [1:0] row_sel,
    input  wire [3:0] col,

    output reg  [3:0] key,
    output reg        valid

);

always @(*) begin

    valid = 1'b1;

    case ({row_sel,col})

        // Row 0
        6'b00_0001 : key = 4'h1;
        6'b00_0010 : key = 4'h2;
        6'b00_0100 : key = 4'h3;
        6'b00_1000 : key = 4'hA;

        // Row 1
        6'b01_0001 : key = 4'h4;
        6'b01_0010 : key = 4'h5;
        6'b01_0100 : key = 4'h6;
        6'b01_1000 : key = 4'hB;

        // Row 2
        6'b10_0001 : key = 4'h7;
        6'b10_0010 : key = 4'h8;
        6'b10_0100 : key = 4'h9;
        6'b10_1000 : key = 4'hC;

        // Row 3
        6'b11_0001 : key = 4'hE;
        6'b11_0010 : key = 4'h0;
        6'b11_0100 : key = 4'hF;
        6'b11_1000 : key = 4'hD;

        default begin
            key   = 4'hF;
            valid = 1'b0;
        end

    endcase

end

endmodule