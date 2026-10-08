
class environment;
   generator gen;
   driver drv;
   monitor mon;
   scoreboard scb;
   reference_model rf;
   virtual intf vif;
  
    mailbox #(transaction) gen2drv_m = new();
    mailbox #(transaction) gen2scb_m = new();
  	mailbox #(transaction) mon2scb_m = new();
    mailbox #(transaction) rf_m = new();

    event gen2drv_e;
  
  function new(virtual intf vif);
			   
	this.vif = vif;		   
    
			  
  endfunction
  
  task build;  
// 	gen = new(gen2drv_m, 
// 			  gen2scb_m,
// 			  gen2drv_e);
				 
    drv =  new(vif,
			   gen2drv_m,
			   gen2drv_e);
				 
    mon = new(vif,
			  mon2scb_m);
    scb = new(mon2scb_m,
			  gen2scb_m,
              rf_m);
    rf = new(gen2scb_m,rf_m);
  endtask
  
  task run;
	fork
		gen.run;
		drv.run;
        rf.run;
		mon.run;
		scb.run;
	join_none
  endtask
endclass