module interfacevga(clk, cor, vsync, hsync, blank);

input clk;
output vsync, hsync, blank;
output [7:0] cor;

[2:0]l; 			// vai ate 525 em decimal
[2:0]contclk;		// vai até 800 em decimal
rst;

/* 
blank alto = 637 pulsos
frontph = 17 pulsos
hsync baixo = 97 pulsos
backph = 49 pulsos

blank alto = 480 linhas
frontpv = 10 linhas
vsync baixo = 2 linhas
backpv = 33 linhas
*/
	
	
// pode fazer com assign ou always@(*)

begin

		begin	assign blank = ? ((1'd0 <= contclk <= 3'd163)||(1'd0 <= l <= 2'd45)):1'b0:1'b1; end
			
		begin	assign vsync = ? (2'd11 <= l <= 2'd12):1'b0:1'b1; end
			
		begin	assign hsync = ? (2'd18 <= contclk <= 3'd115):1'b0:1'b1; end
			
		begin	assign l = ? (contclk==3'd800):l+1; end
				
		begin	assign contclk = ? (contclk>3'd800):1'd0; end
			
		begin	assign l = ? (l>525):1'd0; end
		
end

always@(posedge clk)
begin

	if(rst) begin
	contclk <= 0;
	l <= 0; end
	
	else begin
	contclk <= contclk + 1;
	end
end

endmodule
