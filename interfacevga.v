module interfacevga(cor_in,clk, rst, blank, l, contclk, cor, vsync, hsync);

input clk,rst;
input [7:0] cor_in;
output vsync, hsync, blank;
output reg [23:0] cor;	// atribuição com reg por conta da conversão de cores
output reg [9:0] l; 			// vai ate 525 em decimal

output reg [9:0] contclk;		// vai até 800 em decimal


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

		assign blank = (((contclk >= 0) & (contclk <= 143)) || (contclk >= 783) || (l <= 35) || (l >= 515))?0:1;
			
		assign vsync = ((l >= 0) & (l <= 1))? 0:1; 
			
		assign hsync = ((contclk >= 0) & (contclk <= 95))? 0:1;
		
		
always@(posedge clk)
begin

	if(rst) 
	begin
		contclk <= 0;
		l <= 0; 
	end
	
	else
	begin
		contclk <= contclk + 1;
		if (contclk == 800)
		begin
			contclk <= 0;
			l <= l + 1;
			if (l == 525) 
				l <= 0;
		end
	end
end

always@(cor)
begin
	/* CONVERSÃO DAS CORES - 8 BITS PARA 24 BITS */		
		case (cor_in)
			8'h00 : cor = 24'h000000;	/* COR:0		R:00 G:00 B:00 */
			8'h01 : cor = 24'h800000;	/* COR:1		R:80 G:00 B:00 */
			8'h02 : cor = 24'h008000;	/* COR:2		R:00 G:80 B:00 */
			8'h03 : cor = 24'h808000;	/* COR:3		R:80 G:80 B:00 */
			8'h04 : cor = 24'h000080;	/* COR:4		R:00 G:00 B:80 */
			8'h05 : cor = 24'h800080;	/* COR:5		R:80 G:00 B:80 */
			8'h06 : cor = 24'h008080;	/* COR:6		R:00 G:80 B:80 */
			8'h07 : cor = 24'hC0C0C0;	/* COR:7		R:C0 G:C0 B:C0 */
			8'h08 : cor = 24'hC0DCC0;	/* COR:8		R:C0 G:DC B:C0 */
			8'h09 : cor = 24'hA6CAF0;	/* COR:9		R:A6 G:CA B:F0 */
			8'h0A : cor = 24'h402000;	/* COR:10	R:40 G:20 B:00 */
			8'h0B : cor = 24'h602000;	/* COR:11	R:60 G:20 B:00 */
			8'h0C : cor = 24'h802000;	/* COR:12	R:80 G:20 B:00 */
			8'h0D : cor = 24'hA02000;	/* COR:13	R:A0 G:20 B:00 */
			8'h0E : cor = 24'hC02000;	/* COR:14	R:C0 G:20 B:00 */
			8'h0F : cor = 24'hE02000;	/* COR:15	R:E0 G:20 B:00 */
			8'h10 : cor = 24'h004000;	/* COR:16	R:00 G:40 B:00 */
			8'h11 : cor = 24'h204000;	/* COR:17	R:20 G:40 B:00 */
			8'h12 : cor = 24'h404000;	/* COR:18	R:40 G:40 B:00 */
			8'h13 : cor = 24'h604000;	/* COR:19	R:60 G:40 B:00 */
			8'h14 : cor = 24'h804000;	/* COR:20	R:80 G:40 B:00 */
			8'h15 : cor = 24'hA04000;	/* COR:21	R:A0 G:40 B:00 */
			8'h16 : cor = 24'hC04000;	/* COR:22	R:C0 G:40 B:00 */
			8'h17 : cor = 24'hE04000;	/* COR:23	R:E0 G:40 B:00 */
			8'h18 : cor = 24'h006000;	/* COR:24	R:00 G:60 B:00 */
			8'h19 : cor = 24'h206000;	/* COR:25	R:20 G:60 B:00 */
			8'h1A : cor = 24'h406000;	/* COR:26	R:40 G:60 B:00 */
			8'h1B : cor = 24'h606000;	/* COR:27	R:60 G:60 B:00 */
			8'h1C : cor = 24'h806000;	/* COR:28	R:80 G:60 B:00 */
			8'h1D : cor = 24'hA06000;	/* COR:29	R:A0 G:60 B:00 */
			8'h1E : cor = 24'hC06000;	/* COR:30	R:C0 G:60 B:00 */
			8'h1F : cor = 24'hE06000;	/* COR:31	R:E0 G:60 B:00 */
			8'h20 : cor = 24'h008000;	/* COR:32	R:00 G:80 B:00 */
			8'h21 : cor = 24'h208000;	/* COR:33	R:20 G:80 B:00 */
			8'h22 : cor = 24'h408000;	/* COR:34	R:40 G:80 B:00 */
			8'h23 : cor = 24'h608000;	/* COR:35	R:60 G:80 B:00 */
			8'h24 : cor = 24'h808000;	/* COR:36	R:80 G:80 B:00 */
			8'h25 : cor = 24'hA08000;	/* COR:37	R:A0 G:80 B:00 */
			8'h26 : cor = 24'hC08000;	/* COR:38	R:C0 G:80 B:00 */
			8'h27 : cor = 24'hE08000;	/* COR:39	R:E0 G:80 B:00 */
			8'h28 : cor = 24'h00A000;	/* COR:40	R:00 G:A0 B:00 */
			8'h29 : cor = 24'h20A000;	/* COR:41	R:20 G:A0 B:00 */
			8'h2A : cor = 24'h40A000;	/* COR:42	R:40 G:A0 B:00 */
			8'h2B : cor = 24'h60A000;	/* COR:43	R:60 G:A0 B:00 */
			8'h2C : cor = 24'h80A000;	/* COR:44	R:80 G:A0 B:00 */
			8'h2D : cor = 24'hA0A000;	/* COR:45	R:A0 G:A0 B:00 */
			8'h2E : cor = 24'hC0A000;	/* COR:46	R:C0 G:A0 B:00 */
			8'h2F : cor = 24'hE0A000;	/* COR:47	R:E0 G:A0 B:00 */
			8'h30 : cor = 24'h00C000;	/* COR:48	R:00 G:C0 B:00 */
			8'h31 : cor = 24'h20C000;	/* COR:49	R:20 G:C0 B:00 */
			8'h32 : cor = 24'h40C000;	/* COR:50	R:40 G:C0 B:00 */
			8'h33 : cor = 24'h60C000;	/* COR:51	R:60 G:C0 B:00 */
			8'h34 : cor = 24'h80C000;	/* COR:52	R:80 G:C0 B:00 */
			8'h35 : cor = 24'hA0C000;	/* COR:53	R:A0 G:C0 B:00 */
			8'h36 : cor = 24'hC0C000;	/* COR:54	R:C0 G:C0 B:00 */
			8'h37 : cor = 24'hE0C000;	/* COR:55	R:E0 G:C0 B:00 */
			8'h38 : cor = 24'h00E000;	/* COR:56	R:00 G:E0 B:00 */
			8'h39 : cor = 24'h20E000;	/* COR:57	R:20 G:E0 B:00 */
			8'h3A : cor = 24'h40E000;	/* COR:58	R:40 G:E0 B:00 */
			8'h3B : cor = 24'h60E000;	/* COR:59	R:60 G:E0 B:00 */
			8'h3C : cor = 24'h80E000;	/* COR:60	R:80 G:E0 B:00 */
			8'h3D : cor = 24'hA0E000;	/* COR:61	R:A0 G:E0 B:00 */
			8'h3E : cor = 24'hC0E000;	/* COR:62	R:C0 G:E0 B:00 */
			8'h3F : cor = 24'hE0E000;	/* COR:63	R:E0 G:E0 B:00 */
			8'h40 : cor = 24'h000040;	/* COR:64	R:00 G:00 B:40 */
			8'h41 : cor = 24'h200040;	/* COR:65	R:20 G:00 B:40 */
			8'h42 : cor = 24'h400040;	/* COR:66	R:40 G:00 B:40 */
			8'h43 : cor = 24'h600040;	/* COR:67	R:60 G:00 B:40 */
			8'h44 : cor = 24'h800040;	/* COR:68	R:80 G:00 B:40 */
			8'h45 : cor = 24'hA00040;	/* COR:69	R:A0 G:00 B:40 */
			8'h46 : cor = 24'hC00040;	/* COR:70	R:C0 G:00 B:40 */
			8'h47 : cor = 24'hE00040;	/* COR:71	R:E0 G:00 B:40 */
			8'h48 : cor = 24'h002040;	/* COR:72	R:00 G:20 B:40 */
			8'h49 : cor = 24'h202040;	/* COR:73	R:20 G:20 B:40 */
			8'h4A : cor = 24'h402040;	/* COR:74	R:40 G:20 B:40 */
			8'h4B : cor = 24'h602040;	/* COR:75	R:60 G:20 B:40 */
			8'h4C : cor = 24'h802040;	/* COR:76	R:80 G:20 B:40 */
			8'h4D : cor = 24'hA02040;	/* COR:77	R:A0 G:20 B:40 */
			8'h4E : cor = 24'hC02040;	/* COR:78	R:C0 G:20 B:40 */
			8'h4F : cor = 24'hE02040;	/* COR:79	R:E0 G:20 B:40 */
			8'h50 : cor = 24'h004040;	/* COR:80	R:00 G:40 B:40 */
			8'h51 : cor = 24'h204040;	/* COR:81	R:20 G:40 B:40 */
			8'h52 : cor = 24'h404040;	/* COR:82	R:40 G:40 B:40 */
			8'h53 : cor = 24'h604040;	/* COR:83	R:60 G:40 B:40 */
			8'h54 : cor = 24'h804040;	/* COR:84	R:80 G:40 B:40 */
			8'h55 : cor = 24'hA04040;	/* COR:85	R:A0 G:40 B:40 */
			8'h56 : cor = 24'hC04040;	/* COR:86	R:C0 G:40 B:40 */
			8'h57 : cor = 24'hE04040;	/* COR:87	R:E0 G:40 B:40 */
			8'h58 : cor = 24'h006040;	/* COR:88	R:00 G:60 B:40 */
			8'h59 : cor = 24'h206040;	/* COR:89	R:20 G:60 B:40 */
			8'h5A : cor = 24'h406040;	/* COR:90	R:40 G:60 B:40 */
			8'h5B : cor = 24'h606040;	/* COR:91	R:60 G:60 B:40 */
			8'h5C : cor = 24'h806040;	/* COR:92	R:80 G:60 B:40 */
			8'h5D : cor = 24'hA06040;	/* COR:93	R:A0 G:60 B:40 */
			8'h5E : cor = 24'hC06040;	/* COR:94	R:C0 G:60 B:40 */
			8'h5F : cor = 24'hE06040;	/* COR:95	R:E0 G:60 B:40 */
			8'h60 : cor = 24'h008040;	/* COR:96	R:00 G:80 B:40 */
			8'h61 : cor = 24'h208040;	/* COR:97	R:20 G:80 B:40 */
			8'h62 : cor = 24'h408040;	/* COR:98	R:40 G:80 B:40 */
			8'h63 : cor = 24'h608040;	/* COR:99	R:60 G:80 B:40 */
			8'h64 : cor = 24'h808040;	/* COR:100	R:80 G:80 B:40 */
			8'h65 : cor = 24'hA08040;	/* COR:101	R:A0 G:80 B:40 */
			8'h66 : cor = 24'hC08040;	/* COR:102	R:C0 G:80 B:40 */
			8'h67 : cor = 24'hE08040;	/* COR:103	R:E0 G:80 B:40 */
			8'h68 : cor = 24'h00A040;	/* COR:104	R:00 G:A0 B:40 */
			8'h69 : cor = 24'h20A040;	/* COR:105	R:20 G:A0 B:40 */
			8'h6A : cor = 24'h40A040;	/* COR:106	R:40 G:A0 B:40 */
			8'h6B : cor = 24'h60A040;	/* COR:107	R:60 G:A0 B:40 */
			8'h6C : cor = 24'h80A040;	/* COR:108	R:80 G:A0 B:40 */
			8'h6D : cor = 24'hA0A040;	/* COR:109	R:A0 G:A0 B:40 */
			8'h6E : cor = 24'hC0A040;	/* COR:110	R:C0 G:A0 B:40 */
			8'h6F : cor = 24'hE0A040;	/* COR:111	R:E0 G:A0 B:40 */
			8'h70 : cor = 24'h00C040;	/* COR:112	R:00 G:C0 B:40 */
			8'h71 : cor = 24'h20C040;	/* COR:113	R:20 G:C0 B:40 */
			8'h72 : cor = 24'h40C040;	/* COR:114	R:40 G:C0 B:40 */
			8'h73 : cor = 24'h60C040;	/* COR:115	R:60 G:C0 B:40 */
			8'h74 : cor = 24'h80C040;	/* COR:116	R:80 G:C0 B:40 */
			8'h75 : cor = 24'hA0C040;	/* COR:117	R:A0 G:C0 B:40 */
			8'h76 : cor = 24'hC0C040;	/* COR:118	R:C0 G:C0 B:40 */
			8'h77 : cor = 24'hE0C040;	/* COR:119	R:E0 G:C0 B:40 */
			8'h78 : cor = 24'h00E040;	/* COR:120	R:00 G:E0 B:40 */
			8'h79 : cor = 24'h20E040;	/* COR:121	R:20 G:E0 B:40 */
			8'h7A : cor = 24'h40E040;	/* COR:122	R:40 G:E0 B:40 */
			8'h7B : cor = 24'h60E040;	/* COR:123	R:60 G:E0 B:40 */
			8'h7C : cor = 24'h80E040;	/* COR:124	R:80 G:E0 B:40 */
			8'h7D : cor = 24'hA0E040;	/* COR:125	R:A0 G:E0 B:40 */
			8'h7E : cor = 24'hC0E040;	/* COR:126	R:C0 G:E0 B:40 */
			8'h7F : cor = 24'hE0E040;	/* COR:127	R:E0 G:E0 B:40 */
			8'h80 : cor = 24'h000080;	/* COR:128	R:00 G:00 B:80 */
			8'h81 : cor = 24'h200080;	/* COR:129	R:20 G:00 B:80 */
			8'h82 : cor = 24'h400080;	/* COR:130	R:40 G:00 B:80 */
			8'h83 : cor = 24'h600080;	/* COR:131	R:60 G:00 B:80 */
			8'h84 : cor = 24'h800080;	/* COR:132	R:80 G:00 B:80 */
			8'h85 : cor = 24'hA00080;	/* COR:133	R:A0 G:00 B:80 */
			8'h86 : cor = 24'hC00080;	/* COR:134	R:C0 G:00 B:80 */
			8'h87 : cor = 24'hE00080;	/* COR:135	R:E0 G:00 B:80 */
			8'h88 : cor = 24'h002080;	/* COR:136	R:00 G:20 B:80 */
			8'h89 : cor = 24'h202080;	/* COR:137	R:20 G:20 B:80 */
			8'h8A : cor = 24'h402080;	/* COR:138	R:40 G:20 B:80 */
			8'h8B : cor = 24'h602080;	/* COR:139	R:60 G:20 B:80 */
			8'h8C : cor = 24'h802080;	/* COR:140	R:80 G:20 B:80 */
			8'h8D : cor = 24'hA02080;	/* COR:141	R:A0 G:20 B:80 */
			8'h8E : cor = 24'hC02080;	/* COR:142	R:C0 G:20 B:80 */
			8'h8F : cor = 24'hE02080;	/* COR:143	R:E0 G:20 B:80 */
			8'h90 : cor = 24'h004080;	/* COR:144	R:00 G:40 B:80 */
			8'h91 : cor = 24'h204080;	/* COR:145	R:20 G:40 B:80 */
			8'h92 : cor = 24'h404080;	/* COR:146	R:40 G:40 B:80 */
			8'h93 : cor = 24'h604080;	/* COR:147	R:60 G:40 B:80 */
			8'h94 : cor = 24'h804080;	/* COR:148	R:80 G:40 B:80 */
			8'h95 : cor = 24'hA04080;	/* COR:149	R:A0 G:40 B:80 */
			8'h96 : cor = 24'hC04080;	/* COR:150	R:C0 G:40 B:80 */
			8'h97 : cor = 24'hE04080;	/* COR:151	R:E0 G:40 B:80 */
			8'h98 : cor = 24'h006080;	/* COR:152	R:00 G:60 B:80 */
			8'h99 : cor = 24'h206080;	/* COR:153	R:20 G:60 B:80 */
			8'h9A : cor = 24'h406080;	/* COR:154	R:40 G:60 B:80 */
			8'h9B : cor = 24'h606080;	/* COR:155	R:60 G:60 B:80 */
			8'h9C : cor = 24'h806080;	/* COR:156	R:80 G:60 B:80 */
			8'h9D : cor = 24'hA06080;	/* COR:157	R:A0 G:60 B:80 */
			8'h9E : cor = 24'hC06080;	/* COR:158	R:C0 G:60 B:80 */
			8'h9F : cor = 24'hE06080;	/* COR:159	R:E0 G:60 B:80 */
			8'hA0 : cor = 24'h008080;	/* COR:160	R:00 G:80 B:80 */
			8'hA1 : cor = 24'h208080;	/* COR:161	R:20 G:80 B:80 */
			8'hA2 : cor = 24'h408080;	/* COR:162	R:40 G:80 B:80 */
			8'hA3 : cor = 24'h608080;	/* COR:163	R:60 G:80 B:80 */
			8'hA4 : cor = 24'h808080;	/* COR:164	R:80 G:80 B:80 */
			8'hA5 : cor = 24'hA08080;	/* COR:165	R:A0 G:80 B:80 */
			8'hA6 : cor = 24'hC08080;	/* COR:166	R:C0 G:80 B:80 */
			8'hA7 : cor = 24'hE08080;	/* COR:167	R:E0 G:80 B:80 */
			8'hA8 : cor = 24'h00A080;	/* COR:168	R:00 G:A0 B:80 */
			8'hA9 : cor = 24'h20A080;	/* COR:169	R:20 G:A0 B:80 */
			8'hAA : cor = 24'h40A080;	/* COR:170	R:40 G:A0 B:80 */
			8'hAB : cor = 24'h60A080;	/* COR:171	R:60 G:A0 B:80 */
			8'hAC : cor = 24'h80A080;	/* COR:172	R:80 G:A0 B:80 */
			8'hAD : cor = 24'hA0A080;	/* COR:173	R:A0 G:A0 B:80 */
			8'hAE : cor = 24'hC0A080;	/* COR:174	R:C0 G:A0 B:80 */
			8'hAF : cor = 24'hE0A080;	/* COR:175	R:E0 G:A0 B:80 */
			8'hB0 : cor = 24'h00C080;	/* COR:176	R:00 G:C0 B:80 */
			8'hB1 : cor = 24'h20C080;	/* COR:177	R:20 G:C0 B:80 */
			8'hB2 : cor = 24'h40C080;	/* COR:178	R:40 G:C0 B:80 */
			8'hB3 : cor = 24'h60C080;	/* COR:179	R:60 G:C0 B:80 */
			8'hB4 : cor = 24'h80C080;	/* COR:180	R:80 G:C0 B:80 */
			8'hB5 : cor = 24'hA0C080;	/* COR:181	R:A0 G:C0 B:80 */
			8'hB6 : cor = 24'hC0C080;	/* COR:182	R:C0 G:C0 B:80 */
			8'hB7 : cor = 24'hE0C080;	/* COR:183	R:E0 G:C0 B:80 */
			8'hB8 : cor = 24'h00E080;	/* COR:184	R:00 G:E0 B:80 */
			8'hB9 : cor = 24'h20E080;	/* COR:185	R:20 G:E0 B:80 */
			8'hBA : cor = 24'h40E080;	/* COR:186	R:40 G:E0 B:80 */
			8'hBB : cor = 24'h60E080;	/* COR:187	R:60 G:E0 B:80 */
			8'hBC : cor = 24'h80E080;	/* COR:188	R:80 G:E0 B:80 */
			8'hBD : cor = 24'hA0E080;	/* COR:189	R:A0 G:E0 B:80 */
			8'hBE : cor = 24'hC0E080;	/* COR:190	R:C0 G:E0 B:80 */
			8'hBF : cor = 24'hE0E080;	/* COR:191	R:E0 G:E0 B:80 */
			8'hC0 : cor = 24'h0000C0;	/* COR:192	R:00 G:00 B:C0 */
			8'hC1 : cor = 24'h2000C0;	/* COR:193	R:20 G:00 B:C0 */
			8'hC2 : cor = 24'h4000C0;	/* COR:194	R:40 G:00 B:C0 */
			8'hC3 : cor = 24'h6000C0;	/* COR:195	R:60 G:00 B:C0 */
			8'hC4 : cor = 24'h8000C0;	/* COR:196	R:80 G:00 B:C0 */
			8'hC5 : cor = 24'hA000C0;	/* COR:197	R:A0 G:00 B:C0 */
			8'hC6 : cor = 24'hC000C0;	/* COR:198	R:C0 G:00 B:C0 */
			8'hC7 : cor = 24'hE000C0;	/* COR:199	R:E0 G:00 B:C0 */
			8'hC8 : cor = 24'h0020C0;	/* COR:200	R:00 G:20 B:C0 */
			8'hC9 : cor = 24'h2020C0;	/* COR:201	R:20 G:20 B:C0 */
			8'hCA : cor = 24'h4020C0;	/* COR:202	R:40 G:20 B:C0 */
			8'hCB : cor = 24'h6020C0;	/* COR:203	R:60 G:20 B:C0 */
			8'hCC : cor = 24'h8020C0;	/* COR:204	R:80 G:20 B:C0 */
			8'hCD : cor = 24'hA020C0;	/* COR:205	R:A0 G:20 B:C0 */
			8'hCE : cor = 24'hC020C0;	/* COR:206	R:C0 G:20 B:C0 */
			8'hCF : cor = 24'hE020C0;	/* COR:207	R:E0 G:20 B:C0 */
			8'hD0 : cor = 24'h0040C0;	/* COR:208	R:00 G:40 B:C0 */
			8'hD1 : cor = 24'h2040C0;	/* COR:209	R:20 G:40 B:C0 */
			8'hD2 : cor = 24'h4040C0;	/* COR:210	R:40 G:40 B:C0 */
			8'hD3 : cor = 24'h6040C0;	/* COR:211	R:60 G:40 B:C0 */
			8'hD4 : cor = 24'h8040C0;	/* COR:212	R:80 G:40 B:C0 */
			8'hD5 : cor = 24'hA040C0;	/* COR:213	R:A0 G:40 B:C0 */
			8'hD6 : cor = 24'hC040C0;	/* COR:214	R:C0 G:40 B:C0 */
			8'hD7 : cor = 24'hE040C0;	/* COR:215	R:E0 G:40 B:C0 */
			8'hD8 : cor = 24'h0060C0;	/* COR:216	R:00 G:60 B:C0 */
			8'hD9 : cor = 24'h2060C0;	/* COR:217	R:20 G:60 B:C0 */
			8'hDA : cor = 24'h4060C0;	/* COR:218	R:40 G:60 B:C0 */
			8'hDB : cor = 24'h6060C0;	/* COR:219	R:60 G:60 B:C0 */
			8'hDC : cor = 24'h8060C0;	/* COR:220	R:80 G:60 B:C0 */
			8'hDD : cor = 24'hA060C0;	/* COR:221	R:A0 G:60 B:C0 */
			8'hDE : cor = 24'hC060C0;	/* COR:222	R:C0 G:60 B:C0 */
			8'hDF : cor = 24'hE060C0;	/* COR:223	R:E0 G:60 B:C0 */
			8'hE0 : cor = 24'h0080C0;	/* COR:224	R:00 G:80 B:C0 */
			8'hE1 : cor = 24'h2080C0;	/* COR:225	R:20 G:80 B:C0 */
			8'hE2 : cor = 24'h4080C0;	/* COR:226	R:40 G:80 B:C0 */
			8'hE3 : cor = 24'h6080C0;	/* COR:227	R:60 G:80 B:C0 */
			8'hE4 : cor = 24'h8080C0;	/* COR:228	R:80 G:80 B:C0 */
			8'hE5 : cor = 24'hA080C0;	/* COR:229	R:A0 G:80 B:C0 */
			8'hE6 : cor = 24'hC080C0;	/* COR:230	R:C0 G:80 B:C0 */
			8'hE7 : cor = 24'hE080C0;	/* COR:231	R:E0 G:80 B:C0 */
			8'hE8 : cor = 24'h00A0C0;	/* COR:232	R:00 G:A0 B:C0 */
			8'hE9 : cor = 24'h20A0C0;	/* COR:233	R:20 G:A0 B:C0 */
			8'hEA : cor = 24'h40A0C0;	/* COR:234	R:40 G:A0 B:C0 */
			8'hEB : cor = 24'h60A0C0;	/* COR:235	R:60 G:A0 B:C0 */
			8'hEC : cor = 24'h80A0C0;	/* COR:236	R:80 G:A0 B:C0 */
			8'hED : cor = 24'hA0A0C0;	/* COR:237	R:A0 G:A0 B:C0 */
			8'hEE : cor = 24'hC0A0C0;	/* COR:238	R:C0 G:A0 B:C0 */
			8'hEF : cor = 24'hE0A0C0;	/* COR:239	R:E0 G:A0 B:C0 */
			8'hF0 : cor = 24'h00C0C0;	/* COR:240	R:00 G:C0 B:C0 */
			8'hF1 : cor = 24'h20C0C0;	/* COR:241	R:20 G:C0 B:C0 */
			8'hF2 : cor = 24'h40C0C0;	/* COR:242	R:40 G:C0 B:C0 */
			8'hF3 : cor = 24'h60C0C0;	/* COR:243	R:60 G:C0 B:C0 */
			8'hF4 : cor = 24'h80C0C0;	/* COR:244	R:80 G:C0 B:C0 */
			8'hF5 : cor = 24'hA0C0C0;	/* COR:245	R:A0 G:C0 B:C0 */
			8'hF6 : cor = 24'hFFFBF0;	/* COR:246	R:FF G:FB B:F0 */
			8'hF7 : cor = 24'hA0A0A4;	/* COR:247	R:A0 G:A0 B:A4 */
			8'hF8 : cor = 24'h808080;	/* COR:248	R:80 G:80 B:80 */
			8'hF9 : cor = 24'hFF0000;	/* COR:249	R:FF G:00 B:00 */
			8'hFA : cor = 24'h00FF00;	/* COR:250	R:00 G:FF B:00 */
			8'hFB : cor = 24'hFFFF00;	/* COR:251	R:FF G:FF B:00 */
			8'hFC : cor = 24'h0000FF;	/* COR:252	R:00 G:00 B:FF */
			8'hFD : cor = 24'hFF00FF;	/* COR:253	R:FF G:00 B:FF */
			8'hFE : cor = 24'h00FFFF;	/* COR:254	R:00 G:FF B:FF */
			8'hFF : cor = 24'hFFFFFF;	/* COR:255	R:FF G:FF B:FF */
		endcase 
		/* FIM DA CONVERSÃO DE CORES */	
end

endmodule
