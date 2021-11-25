module vgatest(VGA_R,
	       VGA_G,
	       VGA_B,
	       VGA_HS,
	       VGA_VS,
	       CLOCK_50,
	       KEY,
	       LEDR,
	       LEDG,
	       SW);
input [3:0] KEY;
input [9:0] SW;
output [9:0] LEDR,LEDG;
output [3:0] VGA_R, VGA_G,VGA_B;
output VGA_HS,VGA_VS;
input CLOCK_50;
wire [9:0] xposition, yposition;

wire on;
reg CLK25;
reg [30:0]counter;



always @(posedge CLOCK_50)
begin
	CLK25 <= !CLK25;	
end
vgaController tet(VGA_HS,VGA_VS,CLK25,on,xposition,yposition);
pong ponger(VGA_R,VGA_G,VGA_B,xposition,yposition,CLK25,on,{SW[0], ~SW[0],SW[1], ~SW[1]},LEDR,LEDG,SW[2]);
endmodule
