module ControladorMemoria (address, read_enable, clock, reset, address_to_memory, clock_to_memory);

input clock, reset, read_enable;
input [15:0] address;
output [15:0] address_to_memory;
output clock_to_memory;

// Implementar uma FSM (veja desenho que fiz na última aula) que fique no estado Inativo até que receba um sinal read_enable
// Após read_enable, a FSM aciona a Memória através dos sinais address_to_memory e clock_to_memory

endmodule 