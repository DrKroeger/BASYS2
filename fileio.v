`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:26:10 10/29/2013
// Design Name:   dut
// Module Name:   C:/Verilog_Projects/Verilog_FILE_IO/fileio.v
// Project Name:  Verilog_FILE_IO
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: dut
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////
module fileio;

integer in,out,mon;
reg clk;

reg  enable;
wire valid;
reg [31:0] din;
reg [31:0] exp;
wire [31:0] dout;
integer statusI,statusO;

dut dut (clk,enable,din,dout,valid);

initial begin
  clk = 0;
  enable  = 0;
  din = 0;
  exp = 0;
  in  = $fopen("input.txt","r");
  out = $fopen("output.txt","r");
  mon = $fopen("C:\Verilog_Projects\Verilog_FILE_IO\monitor.txt","w");
end

always # 1 clk = ~clk;

// DUT input driver code
initial begin
    repeat (10) @ (posedge clk);
    while (!$feof(in)) begin
      @ (negedge clk);
      enable = 1;
      statusI = $fscanf(in,"%h %h\n",din[31:16],din[15:0]);
      @ (negedge clk);
      enable = 0;
    end
    repeat (10) @ (posedge clk);
    $fclose(in);
    $fclose(out);
    $fclose(mon);
    //#100 $finish;
end

// DUT output monitor and compare logic
always @ (posedge clk)
 if (valid) begin
   $fwrite(mon,"%h %h\n",dout[31:16],dout[15:0]);
   statusO = $fscanf(out,"%h %h\n",exp[31:16],exp[15:0]);
   if (dout !== exp) begin
     $display("%0dns Error : input and output does not match",$time);
     $display("       Got  %h",dout);
     $display("       Exp  %h",exp);
   end else begin
     $display("%0dns Match : input and output match",$time);
     $display("       Got  %h",dout);
     $display("       Exp  %h",exp);
   end
 end

endmodule