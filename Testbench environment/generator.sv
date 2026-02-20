virtual class generator;

  transaction trans;
  event gen2drv_e;
  mailbox #(transaction) gen2drv_m;
  mailbox #(transaction) gen2scb_m;
  
  function new(mailbox #(transaction) gen2drv_m,
               mailbox #(transaction) gen2scb_m,
               event gen2drv_e );
    this.gen2drv_m = gen2drv_m;
    this.gen2scb_m = gen2scb_m;
    this.gen2drv_e = gen2drv_e;//event
  endfunction
  
  pure virtual task run();
  
    protected task put_trans();     

    gen2drv_m.put(trans);           // Send to write mailbox
    gen2scb_m.put(trans);           // Send to read mailbox
  endtask
    
endclass

