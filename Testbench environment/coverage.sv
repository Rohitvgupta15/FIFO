class coverage;
  transaction trans;
  
  covergroup fifo_cg;
    //cover point
    
    wr_en : coverpoint trans.wr_en  {
      bins wr_en_bins[] = {0,1};
    }
    rd_en : coverpoint trans.rd_en  {
      bins rd_en_bins[] = {0,1};
    }
    data_in0: coverpoint trans.data_in[0] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in1: coverpoint trans.data_in[1] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in2: coverpoint trans.data_in[2] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in3: coverpoint trans.data_in[3] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in4: coverpoint trans.data_in[4] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in5: coverpoint trans.data_in[5] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in6: coverpoint trans.data_in[6] {
    bins data_in_bins = {[0:8'hFF]};
  }
  data_in7: coverpoint trans.data_in[7] {
    bins data_in_bins = {[0:8'hFF]};
  }

  // Cover each data_out[i] over full range (1 bin)
  data_out0: coverpoint trans.data_out[0] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out1: coverpoint trans.data_out[1] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out2: coverpoint trans.data_out[2] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out3: coverpoint trans.data_out[3] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out4: coverpoint trans.data_out[4] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out5: coverpoint trans.data_out[5] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out6: coverpoint trans.data_out[6] {
    bins data_out_bins = {[0:8'hFF]};
  }
  data_out7: coverpoint trans.data_out[7] {
    bins data_out_bins = {[0:8'hFF]};
  }
    full : coverpoint trans.full  {
      bins full_bins[] = {0,1};
    }
    almost_full : coverpoint trans.almost_full  {
      bins almost_full_bins[] = {0,1};
    }
    empty : coverpoint trans.empty  {
      bins empty_bins[] = {0,1};
    }                             
  endgroup
                                 
    function new();
      trans = new;
      fifo_cg = new;                       
    endfunction
      
      function sample;
        fifo_cg.sample;
      endfunction
  
endclass

