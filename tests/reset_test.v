module reset_test();

  reg [7:0] wdata, address, rdata;
  reg fail_flag;  
  integer i;
  
  testbench top();
  
  initial begin
  
  #100;
  $display("===================================");
  $display("======WRITE - READ - TEST==========");
  $display("===================================");
  repeat (5) begin
  
  address[7:4] = 4'b0000;
  address[3:0] = $urandom();
  wdata = $urandom();
  top.cpu.apb_write(address, wdata);
  top.cpu.apb_read(address, rdata);
  if(address < 8'h08) begin
  $display("====Valid Address==== \n");
  if(rdata==wdata) begin
  $display("At time= %2d, wdata= 8'h%2h, rdata= 8'h%2h,--PASS-- \n", $time, wdata, rdata);
  end else begin
  fail_flag = 1'b1;
  top.result(fail_flag);
  $display("At time= %2d, wdata= 8'h%2h, rdata= 8'h%2h,--FAIL-- \n", $time, wdata, rdata);
  end
  end else begin
  $display("====In_valid Address==== \n");
  end 
  end
  #100;
  $display("==>REG value before reset<== \n");
  $display("      REG_A 8'h%h", top.ip.reg_A);
  $display("      REG_B 8'h%h", top.ip.reg_B);
  $display("      REG_C 8'h%h", top.ip.reg_C);
  $display("      REG_D 8'h%h", top.ip.reg_D);
  $display("      REG_E 8'h%h", top.ip.reg_E);
  $display("      REG_F 8'h%h", top.ip.reg_F);
  $display("      REG_G 8'h%h", top.ip.reg_G);
  $display("      REG_H 8'h%h", top.ip.reg_H);
  top.system.presetn=1'b0;
  #50;
 // top.system.presetn=1'b1;
  
  $display("==>REG value after reset<== \n");
  $display("      REG A 8'h%h", top.ip.reg_A);
  $display("      REG B 8'h%h", top.ip.reg_B);
  $display("      REG C 8'h%h", top.ip.reg_C);
  $display("      REG D 8'h%h", top.ip.reg_D);
  $display("      REG E 8'h%h", top.ip.reg_E);
  $display("      REG F 8'h%h", top.ip.reg_F);
  $display("      REG G 8'h%h", top.ip.reg_G);
  $display("      REG H 8'h%h", top.ip.reg_H);
  
  if({top.ip.reg_A,top.ip.reg_B,top.ip.reg_C,top.ip.reg_D,top.ip.reg_E,top.ip.reg_F,top.ip.reg_G,top.ip.reg_H} != 64'h0) begin
  fail_flag= 1'b1;
  top.result(fail_flag);
  $display("REG is not reset --FAIL--");
  end else begin
  top.result(fail_flag);
  $display("REG is not reset --PASS--");
  end
  
  end
endmodule

