module encoder(
input pclk, preset_n, pwrite, psel, penable,
input [7:0] paddr,
input pready,

output reg [7:0] prdata,
output reg pslverr,

output reg   [7:0] reg_A = 8'h32,
output reg    [7:0] reg_B = 8'h12,
output reg    [7:0] reg_C = 8'h45,
output reg    [7:0] reg_D = 8'h78,
output reg    [7:0] reg_E = 8'h65,
output reg    [7:0] reg_F = 8'h74,
output reg    [7:0] reg_G = 8'h15,
output reg    [7:0] reg_H = 8'h63

);

reg [7:0] select_reg;
wire read_en;
assign pready=1'b1;
always @(paddr) begin
	case(paddr)
	8'h00: select_reg = 8'b0000_0001;
	8'h01: select_reg = 8'b0000_0010;	
	8'h02: select_reg = 8'b0000_0100;	
	8'h03: select_reg = 8'b0000_1000;	
	8'h04: select_reg = 8'b0001_0000;	
	8'h05: select_reg = 8'b0010_0000;	
	8'h06: select_reg = 8'b0100_0000;	
	8'h07: select_reg = 8'b1000_0000;
	default:
	       select_reg = 8'b0000_0000;	
	endcase
end

//PSLVERR
always @(posedge pclk or negedge preset_n) begin 
  if(!preset_n)
  	pslverr <= 1'b0;
  else
  	if(select_reg==8'h00)
	  pslverr<= 1'b1;
	else
	  pslverr<= 1'b0;
end 

//Ecoder
//read_enable= 1 khi thoa dieu kien doc (en=1, write=0, sel=1, ready=1)

assign read_en = penable && psel && pready && (!pwrite);

always @(read_en, select_reg) begin
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
	endcase
  end
  end

endmodule
