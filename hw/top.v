module top(input            clk,
           input            rst_n,
           output           trap,
           output reg [7:0] out_dat,
           output reg       out_ctl);

   wire                     mem_valid;
   wire                     mem_ready;
   wire [31:0]              mem_addr;
   wire [31:0]              mem_wdata;
   wire [ 3:0]              mem_wstrb;
   wire [31:0]              mem_rdata;

   wire                     rom0_ce, rom1_ce, ram_ce, out_ce;

   assign rom0_ce = mem_valid && (mem_addr[31:17] == 15'h0); // [0, 128Ki)
   assign rom1_ce = mem_valid && (mem_addr[31:17] == 15'h1); // [128Ki, 256Ki)
   assign ram_ce  = mem_valid && (mem_addr[31:18] == 14'h1); // [256Ki, 512Ki)
   assign out_ce  = mem_valid && (mem_addr[31: 0] == 32'h80000); // 512Ki

   // signal for read_rdy
   // read has always 1 cycle latency
   reg                      read_rdy;

   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) read_rdy <= 1'b0;
      else if (mem_valid) read_rdy <= !mem_ready;
   end

   // for write & invalid address read, mem_ready is at current cycle
   wire                     valid_read;

   assign valid_read = (rom0_ce || rom1_ce || ram_ce) &&
                       (mem_wstrb == 4'b0);
   assign mem_ready = valid_read ? read_rdy : 1'b1;

   // rom0
   wire [31:0]              rom0_q;
   rom0 rom0(.clk(clk),
             .q(rom0_q),
             .addr(mem_addr[31:2]));
   // rom1
   wire [31:0]              rom1_q;
   rom1 rom1(.clk(clk),
             .q(rom1_q),
             .addr(mem_addr[31:2]));


   // ram
   wire [31:0]             ram_q;
   ram ram(.clk(clk),
           .q(ram_q),
           .wr(mem_wstrb),
           .d(mem_wdata),
           .addr(mem_addr[17:2]),
           .ce(ram_ce));

   // out
   always @(posedge clk, negedge rst_n) begin
      if (!rst_n) begin
         out_dat <= 8'h0;
         out_ctl <= 1'b0;
      end
      else if (out_ce) begin
         out_ctl <= ~out_ctl;
         out_dat <= mem_wdata[7:0];
      end
   end

   // mem_rdata
   assign mem_rdata = (rom0_ce ? rom0_q : 32'h0) |
                      (rom1_ce ? rom1_q : 32'h0) |
                      (ram_ce  ? ram_q  : 32'h0);

   // here we ignore unused signal
   picorv32 #(.COMPRESSED_ISA(1),
              .ENABLE_MUL(1),
              .ENABLE_FAST_MUL(1))
   core(.clk(clk),
        .resetn(rst_n),

        .mem_valid(mem_valid),
        .mem_ready(mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata),

        .trap(trap),

        // other unused signal
        .mem_instr(),
        .mem_la_read(),
	    .mem_la_write(),
	    .mem_la_addr(),
	    .mem_la_wdata(),
	    .mem_la_wstrb(),

	    .pcpi_valid(),
	    .pcpi_insn(),
	    .pcpi_rs1(),
	    .pcpi_rs2(),
	    .pcpi_wr(1'b0),
	    .pcpi_rd(32'b0),
	    .pcpi_wait(1'b0),
	    .pcpi_ready(1'b0),

	    .irq(32'b0),
	    .eoi(),
	    .trace_valid(),
	    .trace_data()
        );

endmodule // top
