module vgatest(VGA_R,VGA_G,VGA_B,VGA_HS,VGA_VS,CLOCK_50,GPIO_1,GPIO_0,KEY,LEDR,LEDG,SW,SRAM_ADDR,SRAM_DQ,SRAM_WE_N,SRAM_CE_N,SRAM_OE_N,SRAM_UB_N,SRAM_LB_N);
input GPIO_1;
inout [15:0]SRAM_DQ;
output [17:0]SRAM_ADDR;
input [3:0] KEY;
input [9:0] SW;
output [9:0] LEDR;
output [7:0] LEDG;
output SRAM_WE_N,SRAM_CE_N,SRAM_OE_N,SRAM_UB_N,SRAM_LB_N;

//output [6:0] HEX1,HEX2;
output [15:0] GPIO_0;
output [3:0] VGA_R, VGA_G,VGA_B;
output VGA_HS,VGA_VS;
input CLOCK_50;

//wire [4:0] score1,score2;
//hex_to_7segment s1(score1,HEX1);
//hex_to_7segment s2(score2,HEX2);
wire [9:0] xposition, yposition;

wire on;
reg CLK25;
reg [30:0]counter;



always @(posedge CLOCK_50)
begin
	begin
		//counter <= counter +1;
		//if (counter == 20)
		//begin
			CLK25 <= !CLK25;
			//counter <= 0;
		//end
	end	
end
/*initial

begin
clearram <= 1;
end

reg clearram;
reg write;
wire [9:0] test;
//assign test = SW | counter;

always@(posedge CLOCK_50)
	begin
		if (clearram)
		begin
			write <= 1;			
			if (counter == 2700000)
			begin
				clearram <= 0;
				write <= 0;
			end
			else
			begin
				counter <= counter +1;
			end
		end	
	end*/
	wire [11:0] address;
	wire write;
	wire [11:0] write_data,read_data;
	assign LEDR = read_data;
	assign write_data = SW;
	assign write = KEY[0];
//vgaController tet(VGA_HS,VGA_VS,CLK25,on,xposition,yposition);
pong ponger(VGA_R,VGA_G,VGA_B,xposition,yposition,CLK25,on,{SW[0], ~SW[0],SW[1], ~SW[1]},score1,score2,SW[2]);
//snake snaker(VGA_R,VGA_G,VGA_B,xposition,yposition,CLK25,on,KEY,SW[0],GPIO_0,address,write,write_data,read_data,LEDR,LEDG);
//bram test(CLK25,write_data,write,read_data);
//SRAM_Controller srams(address,write,write_data,SRAM_DQ,read_data,SRAM_ADDR,SRAM_CE_N,SRAM_WE_N,SRAM_OE_N,SRAM_UB_N,SRAM_LB_N);
/*integer tt;
wire [15:0] read_data;
reg [15:0] write_data;
reg ww;
always@(posedge CLOCK_50)
begin
if (tt == 5000000)
	begin
		ww <= 1;
		write_data <= read_data +1;
		tt <= 0;
	end
else
	begin
		tt <= tt + 1;
		ww <= 0;
	end

end
assign LEDR = read_data;*/
//SRAM_Controller asdf(0,ww,write_data,SRAM_DQ,read_data,SRAM_ADDR,SRAM_CE_N,SRAM_WE_N,SRAM_OE_N,SRAM_UB_N,SRAM_LB_N);
//SRAM_Controller asdf(test,write ||~KEY[0] ,~KEY[3:1],SRAM_DQ,LEDR,SRAM_ADDR,SRAM_CE_N,SRAM_WE_N,SRAM_OE_N,SRAM_UB_N,SRAM_LB_N);

endmodule
