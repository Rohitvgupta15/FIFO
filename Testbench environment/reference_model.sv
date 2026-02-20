class reference_model;

  transaction trans_w, trans_r;

  mailbox #(transaction) gen2scb_m;
  mailbox #(transaction) ref_m;

  function new (mailbox #(transaction) gen2scb_m,
                mailbox #(transaction) ref_m);
    this.gen2scb_m = gen2scb_m;
    this.ref_m = ref_m;
  endfunction

  bit [7:0] fifo_mem [8];     // 8-depth FIFO
  bit [2:0] wr_ptr_r, rd_ptr_r;
  bit [3:0] count;

  task run;
    trans_w = new;
    trans_r = new;
    forever begin
      gen2scb_m.peek(trans_w);
      gen2scb_m.get(trans_r);
      main(trans_r, trans_w);
//       $display("in reference model");
      ref_m.put(trans_r);
    end
  endtask

  task main(transaction trans_r, transaction trans_w);      
//     $display("in main of reference model");
//     $display("rd_en = %0b and wr_en = %0b ",trans_r.rd_en,trans_w.wr_en);
    if (trans_w.wr_en) begin
      for(int j = 0;j<8;j++) begin
        if (count < 8) begin
          fifo_mem[wr_ptr_r] = trans_w.data_in[wr_ptr_r];
//           $display("write of reference model trans_w.data_in = %0h || wr_ptr = %0d " ,fifo_mem[j],wr_ptr_r);
          wr_ptr_r = wr_ptr_r + 1;
          count = count + 1;
        end
      end
    end

    if (trans_r.rd_en) begin
      foreach (trans_r.data_out[i]) begin
        if (count > 0) begin
          trans_r.data_out[i] = fifo_mem[rd_ptr_r];  
//            $display("read of reference model trans_w.data_in = %0h || rd_ptr = %0d", trans_w.data_out[i],rd_ptr_r);
          rd_ptr_r = rd_ptr_r + 1;
          count = count - 1;
         
        end
      end
    end
//     foreach (fifo_mem[i]) begin
//     $display("fifo_mem[%0d] = %0h", i, fifo_mem[i]);
//   end
    trans_r.full = (count == 8);
    trans_r.almost_full = ((count == 7) && trans_w.wr_en);
    trans_r.empty = (count == 0);
  endtask

endclass
