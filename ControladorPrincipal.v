 module ControladorPrincipal (data_from_memory, clock, reset, address, clock_memory,cor_out, vertical, horizontal);

input [63:0] data_from_memory;
input clock, reset;
input [9:0] vertical;
input [9:0] horizontal;

output reg [14:0] address;
output reg clock_memory;
output reg [7:0]cor_out;

reg [63:0] oitoPixels_8bits_1;
reg [63:0] oitoPixels_8bits_2;

integer x; 
reg reset_1;

parameter
		inicio = 4'd1,
		implementar_x = 4'd2,
		acessar_mem = 4'd3,
		espera_1 = 4'd4,
		espera_2 = 4'd5,
		espera_3 = 4'd6,
		paridade = 4'd7,
		espera_4 = 4'd8,
		espera_5 = 4'd9;

reg [3:0] estado_atual;
reg [3:0] estado_futuro;

always@(posedge clock)		//registrador
begin
	if (reset)
		estado_atual <= inicio;
	
	else 
		estado_atual <= estado_futuro;
end


always@(*)		// dec saída
begin
	case (estado_atual)
	
		inicio:
		begin
		x = -1;
		end
		
		implementar_x:
		begin
			x = x + 1;
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[63:56];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[63:56];
			end
		end

		acessar_mem:
		begin
			address = x;
			clock_memory = 0;
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[55:48];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[55:48];
			end
		end
		
		espera_1:
		begin
			clock_memory = 1;
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[47:40];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[47:40];
			end
		end
		
		espera_2:
		begin
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[39:32];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[39:32];
			end
		end
		
		espera_3:
		begin
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[31:24];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[31:24];
			end
		end
		
		paridade:
		begin
			if(x[0]==0)
			begin
				oitoPixels_8bits_1 = data_from_memory;
				cor_out = oitoPixels_8bits_2[23:16];
			end
			else
			begin
				oitoPixels_8bits_2 = data_from_memory;
				cor_out = oitoPixels_8bits_1[23:16];
			end
		end
	
		espera_4:
		begin
			clock_memory = 0;
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[15:8];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[15:8];
			end
		end
		
		espera_5:
		begin
			if(x[0]==0)
			begin
				cor_out = oitoPixels_8bits_2[7:0];
			end
			else
			begin
				cor_out = oitoPixels_8bits_1[7:0];
			end
		end
	
	endcase
end


always@(*) // dec entrada
begin
	case(estado_atual)

			inicio: 
		begin
		if (((horizontal >= 0) & (horizontal <= 135)) || (horizontal >= 775) || (vertical <= 35) || (vertical >= 515)) // nas áreas cegas fica desativado
			estado_futuro = inicio;
		else
			estado_futuro = implementar_x;
		end
		
		implementar_x:
		begin
		estado_futuro = acessar_mem;
		end

		acessar_mem:
		begin
		estado_futuro = espera_1;
		end
		
		espera_1:
		begin
		estado_futuro = espera_2;
		end
		
		espera_2:
		begin
		estado_futuro = espera_3;
		end
		
		espera_3:
		begin
		estado_futuro = paridade;
		end
		
		paridade:
		begin
		estado_futuro = espera_4;
		end
	
		espera_4:
		begin
		estado_futuro = espera_5;
		end
		
		espera_5:
		begin
		if (((horizontal >= 0) & (horizontal <= 135)) || (horizontal >= 775) || (vertical <= 35) || (vertical >= 515))	// tempo não visivel
			estado_futuro = espera_5;
		else if (vertical == 525)
			estado_futuro = inicio;
		else 
			estado_futuro = implementar_x;
		end
	
	endcase
end

endmodule


// Implementar duas FSMs: FSM_obtencao_pixels e FSM_VGA


// FSM_obtencao_pixels deverá fazer as seguintes atividades:
// 1 - Gerar um endereço entre 0 e 38399
// 2 - Para cada endereço X gerado:
// 2.1 - address = X; clock_memory = 1;
// 2.2 - Aguardar os ciclos de memória necessários (por exemplo, 3 ciclos)
// 2.3 - OitoPixels_8bits = data_from_memory;
// 2.4 - clock_memory = 0; Acionar conversão de OitoPixels_8bits em OitoPixels_24bits
// 2.5 - Salvar resultado da conversão de forma alternada, entre OitoPixels_24bits_1 e OitoPixels_24bits_2; retornar para 1
// Observações:
// Obs. 1: para cada linha L exibível da tela, esta FSM deverá estar num estado Inativo até 8 pulsos de clock anteriores ao primeiro pixel da linha
// Obs. 2: durante a exibição da linha L, esta FSM deverá percorrer exatamente 8 estados, de acordo com os passos 1 a 2.5 acima
// Obs. 3: 8 pulsos de clock antes do término de exibição da linha L, esta FSM deverá voltar para o estado Inativo, repetindo-se tal ciclo para a próxima linha

// FSM_VGA deverá fazer as seguintes atividades:
// 1 - Implementar os contadores horizontal e vertical, para controlar os sinais V_Sync, H_Sync e Blank
// 2 - Para cada linha L exibível da tela, esta FSM deverá repassar para a saída RGB os dados de OitoPixels_24bits_1 ou de OitoPixels_24bits_2 (de forma alternada)
// Observação: para cada linha L:
// - os pixels de 0 a 7 são obtidos de OitoPixels_24bits_1
// - os pixels de 8 a 15 são obtidos de OitoPixels_24bits_2
// - os pixels de 16 a 23 são obtidos de OitoPixels_24bits_1
// - os pixels de 24 a 31 são obtidos de OitoPixels_24bits_2
// e assim sucessivamente, até o término da parte exibível da linha L
