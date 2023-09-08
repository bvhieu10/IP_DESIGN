module wr_rd_simple();

// KHAI BAO
reg [7:0] address, data;
reg fail_flag;
reg [7:0] rdata;
integer i=0;

	testbench top();
        
        initial begin
          #100;
	  repeat (5) begin
	    data= $random();
	    $display("Write- Read- Check at %2d times", i);
            top.cpu.apb_write(8'h01, data); 
	    #10;
            top.cpu.apb_read(8'h01,rdata);
	    i=i+1;
            if(rdata!=data)
            fail_flag=1;
            else
            fail_flag=0;
	    #10;
            top.result(fail_flag);
	    end 
          #10;
	  $finish();
	  end 
endmodule
