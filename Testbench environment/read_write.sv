class read_write extends generator;
  int uid = 1;
  int no_of_trans;
  int write = 0;
  function new(mailbox #(transaction) gen2drv_m,
               mailbox #(transaction) gen2scb_m,
               event gen2drv_e );
    super.new(gen2drv_m,gen2scb_m,gen2drv_e);
  endfunction
  
  task run();  
     trans = new;
    // write - read write -- read -----
    repeat(no_of_trans) begin
      
      trans.rd_en = ~write;
      trans.wr_en = write;
      trans.uid=uid++;
      if (!trans.randomize() )
	   		$error("RAM_GEN","RANDOMIZATION FAILED");
      put_trans();
 	  write = ~write;
      trans.data_in.rand_mode(write);
	@gen2drv_e;
//     @done;
	end
endtask
endclass