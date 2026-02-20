`include "package.sv"

module test;
  bit clk,rst;
  intf vif(clk,rst);
  test test_h;
  
  fifo dut(.clk(clk),
           .rstn(rst),
           .wr_en(vif.wr_en),
           .rd_en(vif.rd_en),
           .data_in(vif.data_in),
           .data_out(vif.data_out),
           .full(vif.full),
           .almost_full(vif.almost_full),
           .empty(vif.empty)
          );
  
  always
  begin 
   #5 clk = ~clk;
   end
   
   
  initial begin
    $dumpvars;
    $dumpfile("a.vcd");
    rst = 0;
    #10; rst = 1;
    test_h=new(vif);
    test_h.build_and_run();
    repeat (13 * ((test_h.wr != null) ? test_h.wr.no_of_trans : test_h.rw.no_of_trans)) 
      @(posedge clk);
	test_h.print_report;
    $finish;     
  end
  endmodule