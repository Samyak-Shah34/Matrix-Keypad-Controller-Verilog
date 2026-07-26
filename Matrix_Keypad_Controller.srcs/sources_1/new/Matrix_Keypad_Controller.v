module Matrix_Keypad_Controller #
(
    parameter integer SCAN_PERIOD = 500000
)

(
    input  wire       clk,
    input  wire       rst,
    output wire  [3:0] row,
    input  wire [3:0] col,
    output wire  [6:0] seg
);

wire [3:0] decoded_key;
wire       key_valid;
wire [1:0] row_sel;

reg [3:0]  key_value;

seven_segment_decoder u_seven_segment_decoder(

    .data_in(key_value),
    .seg(seg)

);

keypad_decoder u_keypad_decoder(

    .row_sel(row_sel),
    .col(col),

    .key(decoded_key),
    .valid(key_valid)

);

keypad_scanner #(

    .SCAN_PERIOD(SCAN_PERIOD)

)

u_keypad_scanner(

    .clk(clk),
    .rst(rst),

    .row_sel(row_sel),
    .row(row)

);

always @(posedge clk or posedge rst)
begin

    if(rst)
        key_value <= 4'hF;

    else if(key_valid)
        key_value <= decoded_key;

end
endmodule
