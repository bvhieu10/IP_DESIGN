module decoder(
input  [7:0] paddr, pwdata,
input  pclk, preset_n, psel, penable, pwrite,
output reg [7:0] prdata,
input  pready,
output reg pslverr
);
//paremeter
//8bits -32bits ->parameter


assign pready=1'b1;
reg [7:0] select_reg;
reg [7:0] reg_A, reg_B, reg_C, reg_D, reg_E, reg_F, reg_G, reg_H;

// Decoder
always @(paddr) begin
  case(paddr)
    8'h00: select_reg=8'b0000_0001; //A_register
    8'h01: select_reg=8'b0000_0010; //B_register
    8'h02: select_reg=8'b0000_0100; //C_register
    8'h03: select_reg=8'b0000_1000;
    8'h04: select_reg=8'b0001_0000;
    8'h05: select_reg=8'b0010_0000;
    8'h06: select_reg=8'b0100_0000;
    8'h07: select_reg=8'b1000_0000; //H_register
  default:
           select_reg=8'b0000_0000;
  endcase
end


//A_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_A<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[0])
          reg_A<= pwdata;
        else
          reg_A<= reg_A;
    end
end
//B_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_B<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[1])
          reg_B<= pwdata;
        else
          reg_B<= reg_B;
    end
end


//C_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_C<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[2])
          reg_C<= pwdata;
        else
          reg_C<= reg_C;
    end
end

//D_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_D<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[3])
          reg_D<= pwdata;
        else
	  reg_D<= reg_D;
   end
end

//E_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_E<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[4])
          reg_E<= pwdata;
        else
          reg_E<= reg_E;
    end
end

//F_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_F<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[5])
          reg_F<= pwdata;
        else
          reg_F<= reg_F;
    end
end

//G_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_G<=8'h00;
  else
    begin
    if(psel && penable && pwrite && pready && select_reg[6])
          reg_G<= pwdata;
        else
          reg_G<= reg_G;
    end
end

//H_register
always @(posedge pclk or negedge preset_n) begin
  if(!preset_n)
    reg_H<=8'h00;
  else
    begin
        if(psel && penable && pwrite && pready && select_reg[7])
          reg_H<= pwdata;
        else
          reg_H<= reg_H;
    end
end

endmodule


