`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.07.2026 15:31:55
// Design Name: 
// Module Name: keypad_scanner
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

//////////////////////////////////////////////////////////////////////////////////
// Module Name: keypad_scanner
// Description:
//      Generates the scanning rows for a 4x4 matrix keypad.
//
// Outputs:
//      row_sel : Current row index (0-3)
//      row     : Active-low row outputs
//////////////////////////////////////////////////////////////////////////////////

module keypad_scanner #

(
    parameter integer SCAN_PERIOD = 500000
)

(
    input wire clk,
    input wire rst,

    output reg [1:0] row_sel,
    output reg [3:0] row
);

reg [19:0] scan_counter;
localparam SCAN_ROW0 = 2'd0;
localparam SCAN_ROW1 = 2'd1;
localparam SCAN_ROW2 = 2'd2;
localparam SCAN_ROW3 = 2'd3;

always @(posedge clk or posedge rst)
begin

    if(rst)
    begin
        scan_counter <= 20'd0;
        row_sel <= SCAN_ROW0;
    end

    else
    begin

        if(scan_counter == SCAN_PERIOD-1)
        begin
            scan_counter <= 0;

            case(row_sel)
                SCAN_ROW0: row_sel <= SCAN_ROW1;
                SCAN_ROW1: row_sel <= SCAN_ROW2;
                SCAN_ROW2: row_sel <= SCAN_ROW3;
                SCAN_ROW3: row_sel <= SCAN_ROW0;
                default: row_sel <= SCAN_ROW0;
            endcase
        end
        else
        begin
            scan_counter <= scan_counter + 1'b1;
        end

    end

end

always @(*)
begin

    case(row_sel)

    SCAN_ROW0 : row = 4'b1110;
    SCAN_ROW1 : row = 4'b1101;
    SCAN_ROW2 : row = 4'b1011;
    SCAN_ROW3 : row = 4'b0111;

    default : row = 4'b1111;

    endcase

end

endmodule