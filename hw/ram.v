module ram
  (input         clk,
   output reg [31:0] q,
   input [3:0]   wr,
   input [31:0]  d,
   input [15:0]  addr,
   input         ce);

   // 256Ki mem
   reg [31:0]    mem[0:64 * 1024-1];

   // read
   always @(posedge clk) begin
     if (ce && (wr == 4'h0)) q <= mem[addr];
   end

   // write
   always @(posedge clk) begin
      if (ce) begin
         if (wr[0]) mem[addr][ 7: 0] <= d[ 7: 0];
         if (wr[1]) mem[addr][15: 8] <= d[15: 8];
         if (wr[2]) mem[addr][23:16] <= d[23:16];
         if (wr[3]) mem[addr][31:24] <= d[31:24];
      end
   end
endmodule // ram
