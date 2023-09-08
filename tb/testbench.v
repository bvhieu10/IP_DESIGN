module testbench();

wire  pclk, presetn, pwrite, psel, penable, pready, pslverr;
wire  [7:0] paddr, pwdata, prdata;
wire  [7:0] DUT_regA, DUT_regB, DUT_regC, DUT_regD, DUT_regE, DUT_regF, DUT_regG, DUT_regH;
wire  [1:0] DUT_count;
assign DUT_count= ip.count;
assign DUT_regA= ip.reg_A;
assign DUT_regB= ip.reg_B;
assign DUT_regC= ip.reg_C;
assign DUT_regD= ip.reg_D;
assign DUT_regE= ip.reg_E;
assign DUT_regF= ip.reg_F;
assign DUT_regG= ip.reg_G;
assign DUT_regH= ip.reg_H;
//encoder
/*
encoder enc_inst(
	.pclk(pclk),
	.preset_n(presetn),
	.pwrite(pwrite),
	.psel(psel),
	.penable(penable),
	.pready(pready),
	.paddr(paddr),
	.prdata(prdata),
	.pslverr(pslverr),
	.reg_A(reg_A),
	.reg_B(reg_B),
	.reg_C(reg_C),
	.reg_D(reg_D),
	.reg_E(reg_E),
	.reg_F(reg_F),
	.reg_G(reg_G),
	.reg_H(reg_H)

);
*/
//ip_core

ip_core ip(
	.pclk(pclk),
	.presetn(presetn),
	.psel(psel),
	.pwrite(pwrite),
	.penable(penable),
	.paddr(paddr),
	.pwdata(pwdata),
	.pready(pready),
	.pslverr(pslverr),
	.prdata(prdata)
);
//assign DUT_count=ip.count;
//assign DUT_regA= ip.reg_A;
//assign DUT_regB= ip.reg_B;
//assign DUT_regC= ip.reg_C;
//assign DUT_regD= ip.reg_D;
//assign DUT_regE= ip.reg_E;
//assign DUT_regF= ip.reg_F;
//assign DUT_regG= ip.reg_G;
//assign DUT_regH= ip.reg_H;


//decoder

//decoder dec_inst(
//	.pclk(pclk),
//	.preset_n(presetn),
//	.pwrite(pwrite),
//	.psel(psel),
//	.penable(penable),
//	.pready(pready),
//	.pslverr(pslverr),
//	.paddr(paddr),
//	.pwdata(pwdata),
//	.prdata(prdata)
//
//);

system_signal system(
	.pclk(pclk),
	.presetn(presetn)

);

cpu_model cpu(
	.cpu_clk(pclk),
	.cpu_rstn(presetn),
	.cpu_pready(pready),
	.cpu_pslverr(pslverr),
	.cpu_pwrite(pwrite),
	.cpu_psel(psel),
	.cpu_penable(penable),
	.cpu_pwdata(pwdata),
	.cpu_prdata(prdata),
	.cpu_paddr(paddr)
);



task result(input reg a);
begin
  if(a) begin
        $display("=========================");
        $display("========TEST_FAILED======");
        $display("=========================");
        end
  else  begin
        $display("=========================");
        $display("========TEST_PASSED======");
        $display("=========================");
        end

end
endtask

endmodule
