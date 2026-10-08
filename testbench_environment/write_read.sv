class write_read extends generator;
  
  int uid = 1;
  int no_of_trans;
  int write = 1;
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
   	   gen2drv_m.put(trans);           // Send to write mailbox
       gen2scb_m.put(trans); 
      write = ~write;
      trans.data_in.rand_mode(write);
#10;
	@gen2drv_e;
	end
endtask
endclass