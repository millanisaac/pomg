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
always @(posedge CLOCK_50)
begin
	CLK25 <= !CLK25;	
end
vgaController vgadisplay(.Hsync(VGA_HS),.Vsync(VGA_VS),.PixelClock(CLK25),.displayON(on),.Xpixel(xposition),.Ypixel(yposition));
pong ponger(.Red(VGA_R),.Green(VGA_G),.Blue(VGA_B),.Xpixel(xposition),.Ypixel(yposition),.CLK(CLK25),.displayON(on),.buttons({SW[0], ~SW[0],SW[1], ~SW[1]}),.score1(LEDR),.score2(LEDG),.reset(SW[2]));
endmodule
