.data
word1: .word 36 @Usar una word entera (32 bits)
bytes: .byte 0x20 @Solo usa 8 bits
bytes2: .byte 0x30 @Recalcar donde se almacena este byte.
mediaWord: .hword 0x40 @Usa 16 bits
DolbeWord: .quad 0x50 @Usa 64 bits.
libre: .space 32 @Reserva 32 espacios de memoria, es decir, 8 palabras.
str: .asciz "Soy una cadena" @(Guardar cadenas de texto)
.text

main:
	mov r0,#1 @Solo permite guardar datos de tamaño un byte = 8 bits
	ldr r0,=1028 @Se puede usar ldr para guardar datos mas grandes

	ldr r1,=word1 @Guardamos la direccion de memoria que contiene 36 en r1
	ldr r2,[r1] @En r2 cargamos lo que contiene la direccion de memoria entregada por r1. ldr por defecto carga 32 bits.
	
	ldr r2,[r1,#4]

	ldrb r2,[r1,#4] @Solo carga 8 bits
	ldrh r2,[r1,#4] @Solo carga 16 bits
	strb r2,[r0,#0]		

end: wfi
.end
