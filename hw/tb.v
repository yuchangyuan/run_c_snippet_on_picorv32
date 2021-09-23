`timescale 1ns/10ps

module tb;
   reg clk;
   reg rst_n;

   wire [7:0] out_dat;
   wire       out_ctl;

   wire       trap;

   top dut(.clk(clk),
           .rst_n(rst_n),
           .trap(trap),
           .out_dat(out_dat),
           .out_ctl(out_ctl));

   // clock
   initial begin
      clk = 1'b0;
      rst_n = 1'b0;
      #105 rst_n = 1'b1;

      wait (trap == 1'b1);
      $display(">> trap");
      $finish();
   end

   always #50 clk = !clk;

   // output
   reg [7:0] dat;
   initial begin
      wait (rst_n == 1);

      $display(">> reset done");
      forever begin
         @(out_ctl)
           @(negedge clk) dat = out_dat;
         
         $write("%c", dat);
         $fflush(0);
      end
   end

   // vcd
   initial begin
`ifndef NO_VCD
      $dumpfile("tb.vcd");
      $dumpvars(0, tb);
`endif
   end

endmodule // tb
