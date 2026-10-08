interface intf ( input bit clk,rstn);
  logic wr_en;
  logic rd_en;
  logic [7:0] data_in;
  logic [7:0] data_out;
  logic full;
  logic almost_full;
  logic empty;
  
  clocking drv_cb @(posedge clk);
	default input #1 output #1;

    output wr_en;
    output rd_en;
    output data_in;
    input data_out;
    input full;
    input almost_full;
    input empty;
  endclocking
  
  clocking mon_cb @(posedge clk);
	default input #1 output #1;

    input wr_en;
    input rd_en;
    input data_in;
    input data_out;
    input full;
    input almost_full;
    input empty;
  endclocking
  
  modport DRV_MP(clocking drv_cb);
  modport MON_MP(clocking mon_cb);
    
    // ASSERTION
    
    property full_check_p;
      @(posedge clk) $rose(wr_en) |-> ##[7:9] $rose(full);
    endproperty
  
              full_check : assert property (full_check_p)
                $display("%0t full check test pass",$time);
             else 
               $error("%0t full check test failed",$time);
      
    property almost_full_check_p;
      @(posedge clk) $rose(almost_full) |-> ##1 $rose(full);
    endproperty
  
              almost_full_check : assert property (almost_full_check_p)
              $display("%0t almost_full check test pass",$time);
           else 
             $error("%0t almost_full check test failed",$time);
        
    property read_check_p;
      @(posedge clk) $rose(rd_en) |-> ##8 $rose(empty);
    endproperty
  
                read_check : assert property (read_check_p)
              $display("%0t read_check check test pass",$time);
           else 
             $error("%0t read_check check test failed",$time);
endinterface