class monitor;

	  virtual intf vif;
	  transaction trans;
	  mailbox #(transaction) mon2scb_m;

      function new(virtual intf vif, 
				   mailbox #(transaction) mon2scb_m);
		this.vif = vif;
		this.mon2scb_m = mon2scb_m;
	  endfunction

	  task run;
        forever begin
            trans = new;
            @(vif.mon_cb);
            wait(vif.rd_en == 1) ;
       		write_data;
        end
	  endtask
  
      task write_data;
        bit[7:0] i;
         @(vif.mon_cb);
        repeat(8) begin
           @(vif.mon_cb);
                trans.data_out[i] = vif.mon_cb.data_out;
          		trans.wr_en = vif.mon_cb.wr_en;
          		trans.rd_en = vif.mon_cb.rd_en;
          		trans.empty = vif.mon_cb.empty;
                $display("time = %0t | data_out = %0h | wr_en = %0b | rd_en = %0b",$time,trans.data_out[i],trans.wr_en,trans.rd_en);
          		i++;
              end
        repeat(2)@(vif.mon_cb);
        mon2scb_m.put(trans);
        vif.rd_en = 0;
      endtask
endclass