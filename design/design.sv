module fifo #(DEPTH = 8)
  (
  input clk,
  input rstn,
  input wr_en,
  input rd_en,
  input [7:0] data_in,
  output reg [7:0] data_out,
  output full,
  output almost_full,
  output empty
);

  reg [7:0] fifo_mem [DEPTH-1:0];     // 8-depth FIFO
  reg [$clog2(DEPTH) - 1:0] wr_ptr, rd_ptr;     // 3-bit pointers for 8 locations
  reg [3:0] count;              // to track number of items in FIFO

  // Write logic
  always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
      wr_ptr <= 0;
      rd_ptr <= 0;
      count <= 0;
      data_out <= 0;
    end else begin
      if (wr_en && !full) begin
        fifo_mem[wr_ptr] <= data_in;
        wr_ptr <= wr_ptr + 1;
        count <= count + 1;
      end
      
      if (rd_en && !empty) begin
        data_out <= fifo_mem[rd_ptr];
        rd_ptr <= rd_ptr + 1;
        count <= count - 1;
      end
    end
  end

  assign full = (count == DEPTH);
  assign almost_full = (count == DEPTH - 1 && wr_en);
  assign empty = (count == 0);

endmodule

