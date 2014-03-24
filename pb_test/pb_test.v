/******************************************************************************
Pushbutton Test Top Level Module
Description:
This module is used as a buffer for the design to utilize a reuseable UCF file
it aligns the inputs with the named values on the BASYS Development Board.
***********************Default Clock Frequency is 50MHz***********************
Author: Trevor Kroeger
Date: 3/13/2014
******************************************************************************/
module basys2_top(
// Clock Pins for Basys2 Board
input mclk,
input uclk,

// Pin Assignment for DispCtl
// Connected to Basys2 onBoard 7seg display
output [6:0] seg,
output       dp,
output [3:0] an,

// Pin Assignments for LEDs
output [7:0] Led,

// Pin Assignment for Switches
input  [7:0] sw,

// Pin Assignments for Push Buttons
input [3:0] btn
);

///////////////////////////////////////////////////////////////////////////////
//                     Transition between 64 bit Module                      //
///////////////////////////////////////////////////////////////////////////////
// Push Button Dummies
wire [15:0] btn_dumb;
assign btn_dumb[3:0]   = (sw[1:0]==2'b00)? btn : 4'h0;
assign btn_dumb[7:4]   = (sw[1:0]==2'b01)? btn : 4'h0;
assign btn_dumb[11:8]  = (sw[1:0]==2'b10)? btn : 4'h0;
assign btn_dumb[15:12] = (sw[1:0]==2'b11)? btn : 4'h0;

// Counter Bits
wire [63:0] cnt0;
wire [15:0] data_in;
assign data_in = (sw[1:0]==2'b00)? cnt0[15:0]  : (sw[1:0]==2'b01)? cnt0[31:16] :
                 (sw[1:0]==2'b10)? cnt0[47:32] : cnt0[63:48];

assign Led[0] = (sw[1:0]==2'b00);
assign Led[1] = (sw[1:0]==2'b01);
assign Led[2] = (sw[1:0]==2'b10);
assign Led[3] = (sw[1:0]==2'b11);
assign Led[4] = 1'b0;
assign Led[5] = 1'b0;
assign Led[6] = 1'b0;
assign Led[7] = sw[7];

///////////////////////////////////////////////////////////////////////////////
//                            Push Button Module                             //
///////////////////////////////////////////////////////////////////////////////
generate
genvar i;
for(i=1;i<5;i=i+1) begin: PB_Mods
  pb_cnt #(
  .size(4)
  )
  pb_mod
  (
  .clk(mclk),
  .rst(sw[7]),
  .pb(btn_dumb[(i*4)-1:(i-1)*4]),
  .cnt_out(cnt0[(i*16)-1:(i-1)*16])
  );
end
endgenerate
///////////////////////////////////////////////////////////////////////////////
//                        Seven Segment Display Module                       //
///////////////////////////////////////////////////////////////////////////////
seven_seg_dis
seg_dis(
.clk(mclk),
.rst(sw[7]),
.data_in(data_in),
.seg(seg),
.dp(dp),
.an(an)
);



endmodule
