/******************************************************************************
Code for a Push Button Counter
Author: Trevor Kroeger
Date: 3/13/2014
Description:
Just preforms hexadecimal counter. Default Size of the counter is 16-bits, but
it can be implemented in up to 64-bits.
******************************************************************************/

module pb_cnt #(
parameter size = 1
)
(
input       clk,
input       rst,
input [3:0] pb,
output reg [(size*4-1):0] cnt_out
);

generate
genvar i;
for(i=1;i<=size;i=i+1) begin : push_button_logic
reg  [24:0] cnt;
  always@(posedge clk) begin
    if(rst) begin
      cnt_out[((i*4)-1):((i-1)*4)] <= 0;
      cnt <= 0;
    end
    else begin
      if((pb[i-1])&(cnt==0)) begin
        cnt_out[((i*4)-1):((i-1)*4)] <= cnt_out[((i*4)-1):((i-1)*4)] + 1;
        cnt <= 1;
      end
      if(cnt!=0)begin
        cnt <= cnt + 1;
      end
    end
  end
end
endgenerate
endmodule
