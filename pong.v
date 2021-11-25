module pong(
	Red,
	Green,
	Blue,
	Xpixel,
	Ypixel,
	CLK,
	displayON,
	buttons,
	score1,
	score2,
	reset);

	
	//parameters
	parameter SCREENHEIGHT = 480;
	parameter SCREENWIDTH = 640;
	parameter BALLWIDTH = 15;
	parameter BALLHEIGHT = 15;
	parameter PADDLEWIDTH = 15;
	parameter PADDLEHEIGHT = 100;
	parameter BORDERTHICKNESS = 15;
	
	//io
	input [3:0] buttons;
	input CLK;
	output[3:0] Red,Green,Blue;
	input displayON,reset;
	input [9:0] Xpixel,Ypixel;
	//objects
	wire ball,player1,player2,players,left,right,top,bottom,border,sides,ScreenRefresh;
	assign ScreenRefresh = (Xpixel == 0) && (Ypixel == 481); 
	reg [9:0] ballX, ballY,player1X,player1Y,player2X,player2Y,ballXVelocity,ballYVelocity;
	output reg [4:0] score1,score2;
	reg scored;
	
	assign player1 = {(Xpixel > player1X) && (Xpixel < (player1X + PADDLEWIDTH)) && (Ypixel > player1Y) && (Ypixel < (player1Y + PADDLEHEIGHT))};
	assign player2 = {(Xpixel > player2X) && (Xpixel < (player2X + PADDLEWIDTH)) && (Ypixel > player2Y) && (Ypixel < (player2Y + PADDLEHEIGHT))};
	assign border =	(Ypixel >= SCREENHEIGHT - BORDERTHICKNESS && Ypixel <= SCREENHEIGHT) || (Ypixel <= BORDERTHICKNESS);
	assign sides =  (Xpixel >  SCREENWIDTH  - BORDERTHICKNESS && Xpixel <   SCREENWIDTH) || (Xpixel < BORDERTHICKNESS);
	assign players = player1 || player2;
	assign ball = (Xpixel > ballX) && (Xpixel < (ballX + BALLWIDTH)) && (Ypixel > ballY) && (Ypixel < (ballY + BALLHEIGHT));
	//colliders
	assign left   = (Xpixel == ballX - 1) && (Ypixel == ballY + BALLWIDTH/2);
	assign right  = (Xpixel == ballX + BALLWIDTH + 1) && (Ypixel == ballY + BALLWIDTH/2);
	assign bottom = (Xpixel == ballX + BALLWIDTH/2) && (Ypixel == (ballY + BALLHEIGHT)+1);
	assign top    = (Xpixel == ballX + BALLWIDTH/2) && (Ypixel == ballY - 1);
	
	wire colliding = (border || sides || players) && (left||top||bottom||right);
	
	assign Red  = 15 & {4{displayON && ~(ball||players||border)}} ;
	assign Green	= 15 & {4{displayON && ~(ball||players)}};
	assign Blue = 15 & {4{displayON && ~(ball||players)}};
	
	initial
	begin
		score1 <= 0;
		score2 <= 0;
		ballX <= 320;
		ballY <= 240;
		player1X <= 40;
		player1Y <= 200;
		player2X <= 585;
		player2Y <= 200;
		ballXVelocity <= 2;
		ballYVelocity <= 5;
		scored <= 0;
	end
	
	always @(posedge CLK)
	begin		
		if (colliding)
		begin
			if (top) begin ballYVelocity <=  5; end
			if (bottom) begin ballYVelocity <= -5; end
			if (left)
			begin
				if (sides)
				begin
					score1<= score1 + 1;
					scored <= 1;
				end
				else
				begin
					ballXVelocity <= 5;
				end
			end
			if (right)
			begin
				if (sides)
				begin
					score2 <= score2 + 1;
					scored <= 1;
				end
				else
				begin
					ballXVelocity <= -5;
				end
			end					
		end
		if (ScreenRefresh)
		begin
			scored <= 0;		
			if (reset || scored)
			begin
				ballX <= 310;
				ballY <= 230;				
				player1X <= 40;
				player1Y <= 200;
				player2X <= 585;
				player2Y <= 200;
				if (scored)
				begin
					ballXVelocity <=  (ballXVelocity > 0) ? 2:-2 ;
				end
				else
				begin
					score1 <= 0;
					score2 <= 0;
					ballXVelocity <= 2;
					ballYVelocity <= 5;
				end
			end
			else
			begin		
				ballX <= ballX + ballXVelocity;
				ballY <= ballY + ballYVelocity;
				
				if (buttons[0] && player1Y < SCREENHEIGHT - PADDLEHEIGHT - BORDERTHICKNESS)	begin player1Y <= player1Y + 5; end
				if (buttons[1] && player1Y > BORDERTHICKNESS)					begin player1Y <= player1Y - 5; end			
				if (buttons[2] && player2Y < SCREENHEIGHT - PADDLEHEIGHT - BORDERTHICKNESS)	begin player2Y <= player2Y + 5; end
				if (buttons[3] && player2Y > BORDERTHICKNESS)					begin player2Y <= player2Y - 5; end
			end
		end	
	end
endmodule

