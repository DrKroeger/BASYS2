// Testbench for Seven Segment Display
// Tests the functionality of Each of the Bit Configurations
// and the output switch between the bits.
module seg_tb();

reg         clk;
reg         rst;
reg  [15:0] data_in;
wire  [6:0] seg;
wire        dp;
wire  [3:0] an;

seven_seg_dis display(
.clk(clk),
.rst(rst),
.data_in(data_in),
.seg(seg),
.dp(dp),
.an(an)
);

initial begin
//Initial Clock Value
clk <= 0;
// Initial Reset
rst <= 1'b1;
#50;
rst <= 1'b0;

// Run Tests
data_in <= 16'h0123;
#100000;
data_in <= 16'h4567;
#100000;
data_in <= 16'h89AB;
#100000;
data_in <= 16'hCDEF;
#100000;
$stop;
end

always #1 clk <= ~clk;


endmodule