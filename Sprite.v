module sprite (cor,coluna,linha,verde,vermelho,amarelo,azul,new_cor);

	input verde,vermelho,amarelo,azul;
	input [9:0] linha;
	input [9:0] coluna;
	input [7:0] cor;
	
	output reg [7:0] new_cor;


	reg [15:0] shapecol;
	
	
	// Sprite Shape 1 (verde)
	reg [15:0] shapegreen[15:0];
	
	// Sprite Shape 2 (amarelo)
	reg [15:0] shapeyellow[15:0];
	
	// Sprite Shape 3 (vermelho)
	reg [15:0] shapered[15:0];
	
	// Sprite Shape 4 (azul)
	reg [15:0] shapeblue[15:0];
	
	
always @(cor) 
begin
		
			// Inicializar Shape 1
			// shape 128x128 separados em 8x8
			// ancora linha 57 coluna 84
			shapegreen[0] =  16'b0000000000000011;
			shapegreen[1] =  16'b0000000000011111;
			shapegreen[2] =  16'b0000000001111111;           
			shapegreen[3] =  16'b0000000111111111;           
			shapegreen[4] =  16'b0000001111111111;
			shapegreen[5] =  16'b0000011111111111;
			shapegreen[6] =  16'b0000111111111110;
			shapegreen[7] =  16'b0000111111110000;
			shapegreen[8] =  16'b0001111111000000;
			shapegreen[9] =  16'b0011111110000000;
			shapegreen[10] = 16'b0011111110000000;
			shapegreen[11] = 16'b0111111100000000;
			shapegreen[12] = 16'b0111111100000000;
			shapegreen[13] = 16'b0111111100000000;
			shapegreen[14] = 16'b0111111000000000;
			shapegreen[15] = 16'b0111111000000000;
			
			// Inicializar Shape 2
			// shape 128x128 separados em 8x8
			// ancora linha 57 coluna 316
			shapeyellow[0] =  16'b1100000000000000;
			shapeyellow[1] =  16'b1111100000000000;
			shapeyellow[2] =  16'b1111111100000000;           
			shapeyellow[3] =  16'b1111111111000000;           
			shapeyellow[4] =  16'b1111111111100000;
			shapeyellow[5] =  16'b1111111111110000;
			shapeyellow[6] =  16'b1111111111111000;
			shapeyellow[7] =  16'b0000111111111000;
			shapeyellow[8] =  16'b0000001111111100;
			shapeyellow[9] =  16'b0000000111111100;
			shapeyellow[10] = 16'b0000000011111110;
			shapeyellow[11] = 16'b0000000001111110;
			shapeyellow[12] = 16'b0000000001111110;
			shapeyellow[13] = 16'b0000000000111111;
			shapeyellow[14] = 16'b0000000000111111;
			shapeyellow[15] = 16'b0000000000111111;
			
			// Inicializar Shape 3
			// shape 128x128 separados em 8x8
			// ancora linha 295 coluna 89
			shapered[0] =  16'b1111110000000000;
			shapered[1] =  16'b1111110000000000;
			shapered[2] =  16'b1111111000000000;           
			shapered[3] =  16'b0111111000000000;           
			shapered[4] =  16'b0111111000000000;
			shapered[5] =  16'b0111111100000000;
			shapered[6] =  16'b0011111110000000;
			shapered[7] =  16'b0011111111000000;
			shapered[8] =  16'b0001111111110000;
			shapered[9] =  16'b0001111111111111;
			shapered[10] = 16'b0000111111111111;
			shapered[11] = 16'b0000001111111111;
			shapered[12] = 16'b0000000111111111;
			shapered[13] = 16'b0000000001111111;
			shapered[14] = 16'b0000000000011111;
			shapered[15] = 16'b0000000000000011;
			
			// Inicializar Shape 4
			// shape 128x128 separados em 8x8
			// ancora linha 294 coluna 321
			shapeblue[0] =  16'b0000000001111111;
			shapeblue[1] =  16'b0000000001111110;
			shapeblue[2] =  16'b0000000001111110;           
			shapeblue[3] =  16'b0000000011111110;           
			shapeblue[4] =  16'b0000000011111110;
			shapeblue[5] =  16'b0000000111111100;
			shapeblue[6] =  16'b0000000111111100;
			shapeblue[7] =  16'b0000001111111000;
			shapeblue[8] =  16'b0000011111111000;
			shapeblue[9] =  16'b0011111111110000;
			shapeblue[10] = 16'b1111111111100000;
			shapeblue[11] = 16'b1111111111100000;
			shapeblue[12] = 16'b1111111110000000;
			shapeblue[13] = 16'b1111111100000000;
			shapeblue[14] = 16'b1111110000000000;
			shapeblue[15] = 16'b1100000000000000;
			
			if(amarelo && linha >= 57 && linha <121 && coluna >= 316 && coluna < 380)
				new_cor = 8'hFB;
			else if(azul && linha >=294 && linha < 358 && coluna >=321 && coluna < 385)
				new_cor = 8'hFC;
			else if(vermelho && linha >=295 && linha < 359 && coluna >=89 && coluna <153)
				new_cor = 8'hF9;
			else if(verde && linha >= 57 && linha < 121 && coluna >= 84 && coluna < 148)
				new_cor = 8'hFA;
			else
				new_cor = cor;
end



endmodule
	
	