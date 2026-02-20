class driver;

	transaction trans;
	mailbox #(transaction) gen2drv_m;
	virtual intf vif;
    event gen2drv_e;
	
	function new(virtual intf vif,
				 mailbox #(transaction) gen2drv_m,
				 event gen2drv_e);
		this.vif = vif;
		this.gen2drv_m = gen2drv_m;
		this.gen2drv_e = gen2drv_e;
	endfunction
	
	task run;
     forever begin
        gen2drv_m.get(trans);
          if(trans.wr_en) begin
            repeat(2) @(vif.drv_cb);
            $display({60{"="}});
            $display("           Packet ID - %0d",trans.uid);
            $display("        Time %0t: Writing data",$time);
            $display({60{"="}});
            $display;
            
          foreach(trans.data_in[i]) begin
            @(vif.drv_cb);
            vif.drv_cb.wr_en <= trans.wr_en;
            vif.drv_cb.rd_en <= trans.rd_en;
            vif.drv_cb.data_in <= trans.data_in[i];
            $display("time = %0t | data_in = %0h | wr_en = %0b | rd_en = %0b",$time,trans.data_in[i],trans.wr_en,trans.rd_en);
                      
          end
             $display;
@(vif.drv_cb);
        end
        else if(!trans.wr_en) begin
          $display({60{"="}});
          $display("           Packet ID - %0d",trans.uid);
          $display("    Time %0t: Reading operation start",$time);
          $display({60{"="}});
          $display;
          repeat(8) begin
             @(vif.drv_cb);
            vif.drv_cb.wr_en <= trans.wr_en;
            vif.drv_cb.rd_en <= trans.rd_en;
          end
          repeat(2)@(vif.drv_cb);
        end
       @(vif.drv_cb);
       ->gen2drv_e;
      end
	endtask
endclass