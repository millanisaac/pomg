module vgaController(Hsync,Vsync,PixelClock,displayON,Xpixel,Ypixel);
output reg Hsync,Vsync;
input PixelClock;
output reg[9:0] Xpixel,Ypixel;
reg HdisplayOn,VdisplayOn;
output displayON;
assign displayON = HdisplayOn & VdisplayOn;
reg xoverflow;
initial 
begin
	Xpixel <= 0;
	Ypixel <= 0;
	HdisplayOn <= 0;
	VdisplayOn <= 0;
	Hsync <= 1;
	Vsync <= 1;
	xoverflow <= 0;
end
always @ (posedge PixelClock)
begin
	if (Xpixel == 798)
	begin
		Xpixel <= 0;
		xoverflow <= 1;		
	end
	
	else
	begin
		Xpixel <= Xpixel +1;
		xoverflow <= 0;
	end
	
	case(Xpixel)
		0: HdisplayOn <= 1;
		640: HdisplayOn <= 0;
		655: Hsync <= 0;
		700: Hsync <= 1;
	endcase
	
end
always @(posedge xoverflow)
begin
	if (Ypixel == 525)
		begin
			Ypixel <= 0;
		end
		else
		begin
			Ypixel <= Ypixel + 1;
		end
		case(Ypixel)
			0: VdisplayOn <= 1;
			480: VdisplayOn <= 0;
			490: Vsync <= 0;
			492: Vsync <= 1;
		endcase
end
endmodule

