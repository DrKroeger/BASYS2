/******************************************************************************
BASYS2 Generic Top Level Module
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

// Pin Assignment for EppCtl
// Connected to Basys2 onBoard USB controller
input EppAstb,
input EppDstb,
input EppWR,
input EppWait,
input [7:0] EppDB,

// Pin Assignment for DispCtl
// Connected to Basys2 onBoard 7seg display
output [6:0] seg,
output       dp,
output [3:0] an,

// Pin Assignments for LEDs
output [7:0] Led,

// Pin Assignment for Switches
input  {7:0] sw,

// Pin Assignments for Push Buttons
input [3:0] btn,

// Loop back/demo signals
// Pin assignment for PS2
input  PS2C,
input  PS2D,

// Pin assignment for VGA
output HSYNC,
output VSYNC,
output [2:0] OutRed,
output [2:0] OutGreen,
output [2:1] OutBlue,

// Loop Back only tested signals
inout [87:72] PIO

// These signals are described as follows:
// NET "PIO<72>" LOC = "B2", Signal name = JA1
// NET "PIO<73>" LOC = "A3", Signal name = JA2
// NET "PIO<74>" LOC = "J3", Signal name = JA3
// NET "PIO<75>" LOC = "B5", Signal name = JA4

// NET "PIO<76>" LOC = "C6", Signal name = JB1
// NET "PIO<77>" LOC = "B6", Signal name = JB2
// NET "PIO<78>" LOC = "C5", Signal name = JB3
// NET "PIO<79>" LOC = "B7", Signal name = JB4

// NET "PIO<80>" LOC = "A9", Signal name = JC1
// NET "PIO<81>" LOC = "B9", Signal name = JC2
// NET "PIO<82>" LOC = "A10", Signal name = JC3
// NET "PIO<83>" LOC = "C9", Signal name = JC4

// NET "PIO<84>" LOC = "C12", Signal name = JD1
// NET "PIO<85>" LOC = "A13", Signal name = JD2
// NET "PIO<86>" LOC = "C13", Signal name = JD3
// NET "PIO<87>" LOC = "D12", Signal name = JD4 
);
///////////////////////////////////////////////////////////////////////////////
//             Top Level of the Desired Module for Implementation            //
///////////////////////////////////////////////////////////////////////////////


endmodule
