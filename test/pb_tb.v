// Testbench Pushbutton Module
module pb_tb();

reg          clk;
reg          rst;
reg    [3:0] pb;
wire  [15:0] cnt_out;

pb_cnt #(
.size(4)
)
pb_mod
(
.clk(clk),
.rst(rst),
.pb(pb),
.cnt_out(cnt_out)
);

initial begin
//Initial Clock Value
clk <= 0;
pb <= 4'h0;
// Initial Reset
rst <= 1'b1;
#50;
rst <= 1'b0;

// Run Tests
#1000000
pb <= 4'hF;
#100000000;
pb <= 4'h4;
#100000000;
pb <= 4'h3;
#100000000;
pb <= 4'h9;
#100000000;
$stop;
end

always #1 clk <= ~clk;

endmodule
