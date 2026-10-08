class test;
	environment env;
	virtual intf vif;
	
	write_read wr;
	read_write rw;
	
    int total_testcase;
  
	function new(virtual intf vif);
			   
	this.vif = vif;		   

  endfunction
  
  task build_and_run();
	  
    env = new(vif);
	env.build();

    if ($test$plusargs("wr"))
       	begin
	 
      wr = new(env.gen2drv_m,env.gen2scb_m,env.gen2drv_e);
      wr.no_of_trans = 1000;
      total_testcase = wr.no_of_trans;
	  env.gen = wr;
	end
	
     if ($test$plusargs("rw"))
       	begin
      rw = new(env.gen2drv_m,env.gen2scb_m,env.gen2drv_e);
      rw.no_of_trans = 1000;
      total_testcase = rw.no_of_trans;
	  env.gen = rw;
	end
	env.run();
  endtask
 		function void print_report;
    $display("\n********************** TEST REPORT *********************");
    $display("Total no of test cases       : %0d", total_testcase);
    $display("Total no of passed test cases: %0d", env.scb.test_pass);
    $display("Failure rate                 : %0.2f %%", 
             100.0 * real'(total_testcase/2 - env.scb.test_pass) / real'(total_testcase/2));
    $display("Function coverage is         : %0.2f %% ", env.scb.cvg.fifo_cg.get_inst_coverage());
    $display("********************************************************");
endfunction
  
  
endclass