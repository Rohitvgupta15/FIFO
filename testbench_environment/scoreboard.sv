class scoreboard;

  mailbox  #(transaction) mon2scb_m;
  mailbox  #(transaction) gen2scb_m;
  mailbox  #(transaction) rf_m;

  transaction exp_trans,actual_trans;
  coverage cvg;
  int test_pass;
  
  function new(mailbox #(transaction) mon2scb_m,  
               mailbox #(transaction) gen2scb_m,
               mailbox  #(transaction) rf_m);
    this.mon2scb_m = mon2scb_m;
    this.gen2scb_m = gen2scb_m;
    this.rf_m = rf_m;
    cvg = new;
  endfunction

  task run;
    forever begin
      rf_m.get(exp_trans);
      mon2scb_m.get(actual_trans);
 
      if((exp_trans.data_out === actual_trans.data_out))begin
        $display;
        $display;
        $display({60{"+"}});
        $display({60{"="}});
        $display("%0t [Scoreboard] :- WRITE and READ data is same",$time);
        $display({60{"="}});
        $display({60{"+"}});
        $display;
        $display;
        test_pass++;
      end
      else begin
        $display;
        $display;
        $display({60{"+"}});
        $display({60{"="}});
        $display("%0t [Scoreboard] :- WRITE and READ data is not same",$time);
        $display({60{"="}});
        $display({60{"+"}});
        $display;
        $display;
      end
      cvg.sample;
    end
  endtask
endclass