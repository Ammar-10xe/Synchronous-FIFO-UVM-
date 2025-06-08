//-------------------------------------------------------------------------
//				   testbench.sv
//-------------------------------------------------------------------------
//---------------------------------------------------------------

 //including uvm package and macros
`include "uvm_macros.svh"
 import uvm_pkg::*;

 //including interface and testcase files
`include "mem_interface.sv"
`include "mem_test.sv"
`include "mem_wr_rd_test.sv"
//---------------------------------------------------------------

module tb_top;

  // mem_if intf;
  reg clk;
  reg reset;
  mem_if intf(clk,reset);

  initial begin // 100MH clk generation
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin // reset generation
    reset = 1;
    repeat(5) @(posedge clk);
    reset = 0;
  end

  memory DUT ( // DUT instantiations
    .clk(intf.clk),
    .reset(intf.reset),
    .addr(intf.addr),
    .wr_en(intf.wr_en),
    .rd_en(intf.rd_en),
    .wdata(intf.wdata),
    .rdata(intf.rdata)
   );

  initial begin // passing the interface handle to lower heirarchy using set method
    uvm_config_db#(virtual mem_if)::set(uvm_root::get(),"*","vif",intf);
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial begin
    run_test("");
  end

endmodule