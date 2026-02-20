class transaction;
  bit [7:0] uid;
  bit wr_en;
  bit rd_en;
  rand bit [7:0] data_in[8];
  bit [7:0] data_out[8];
  bit full;
  bit almost_full;
  bit empty;

  function void display_write();
    $display("Time %0t: Writing data = %0p (Full = %b, Almost_Full = %b)",
             $time, data_in, full, almost_full);
  endfunction

  function void display_read();
    $display("Time %0t: Reading data = %0p (Empty = %b)",
             $time, data_out, empty);
  endfunction
  


  
endclass
