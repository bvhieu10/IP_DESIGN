`define WAIT_CYCLES 2
module ip_core(pclk, psel, presetn, pwrite, penable, paddr, pwdata, pready, pslverr, prdata);
 input  wire  pclk, psel, presetn, pwrite, penable;
 input  wire  [7:0] paddr, pwdata;
 output reg   pready, pslverr;
 output reg   [7:0] prdata;

 reg [7:0] select_reg;
 reg [1:0] count;
 reg [7:0] reg_A, reg_B, reg_C, reg_D, reg_E, reg_F, reg_G, reg_H;
 wire read_en;

 always @(paddr) begin
   case (paddr)
    8'h00:  select_reg =8'b0000_0001;
    8'h01:  select_reg =8'b0000_0010;
    8'h02:  select_reg =8'b0000_0100;
    8'h03:  select_reg =8'b0000_1000;
    8'h04:  select_reg =8'b0001_0000;
    8'h05:  select_reg =8'b0010_0000;
    8'h06:  select_reg =8'b0100_0000;
    8'h07:  select_reg =8'b1000_0000;
   default: select_reg =8'b0000_0000;
   endcase
end

//PSLVERR
always @(posedge pclk or negedge presetn) begin
  if(presetn==1'b0) begin
    pslverr<= 1'b0;
  end
  else if(select_reg==8'b0000_0000) begin
    pslverr<=1'b1;
  end  else begin
   pslverr<= 1'b0;
  end
end
//PREADY
always @(posedge pclk or negedge presetn) begin 
  if(~presetn) begin
    pready <= 1'b0;
    count  <= 2'b00;
    end 
    //set & anable
  else if(psel && penable && (count ==2'b00)) begin  //end of access
          #1;
          pready<=1'b0; //ready for next transfer
          end 
       else if(psel) begin
               if(count== `WAIT_CYCLES) begin
    		  count<= 2'b00; //WC khac 0 + WC =0
    		  #1;
    		  pready <= 1'b1; //Wait_cycles=0 + Wait_cycles khac 0
    		  end 
	       else begin
	          // count++
    		  count<= count+1'b1; //WC khac 0 va count khac WC
    		  end
    	       end 
    	    else begin
    	    pready<= 1'b0;
    	    end
end

//REG_A	
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_A<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[0]) begin
     reg_A<= pwdata;
   end else begin
     reg_A<= reg_A;
   end
  end
end

//REG_B
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_B<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[1]) begin
     reg_B<= pwdata;
   end else begin
     reg_B<= reg_B;
   end
  end
end

//REG_C
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_C<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[2]) begin
     reg_C<= pwdata;
   end else begin
     reg_C<= reg_C;
   end
  end
end

//REG_D
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_D<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[3]) begin
     reg_D<= pwdata;
   end else begin
     reg_D<= reg_D;
   end
  end
end

//REG_E
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_E<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[4]) begin
     reg_E<= pwdata;
   end else begin
     reg_E<= reg_E;
   end
  end
end

//REG_F
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_F<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[5]) begin
     reg_F<= pwdata;
   end else begin
     reg_F<= reg_F;
   end
  end
end

//REG_G
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_G<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[6]) begin
     reg_G<= pwdata;
   end else begin
     reg_G<= reg_G;
   end
  end
end

//REG_H
always @(posedge pclk or negedge presetn) begin
  if(~presetn) begin
   reg_H<= 8'h00;
  end else begin
   if(psel && penable && pwrite && pready && select_reg[7]) begin
     reg_H<= pwdata;
   end else begin
     reg_H<= reg_H;
   end
  end
end

// ENCODER
assign read_en= penable && psel && pready && ~pwrite;
always @(*) begin
  if(read_en) begin
    case (select_reg)
    8'b0000_0001: prdata <= reg_A;
    8'b0000_0010: prdata <= reg_B;
    8'b0000_0100: prdata <= reg_C;
    8'b0000_1000: prdata <= reg_D;
    8'b0001_0000: prdata <= reg_E;
    8'b0010_0000: prdata <= reg_F;
    8'b0100_0000: prdata <= reg_G;
    8'b1000_0000: prdata <= reg_H;
    8'b0000_0000: prdata <= 8'h00;
    endcase
  end else begin
    prdata <=8'h00;
  end
end

endmodule
