@En la memoria RAM se encontraran 2 numeros. Se debe obtener ambos numeros, elevarlos al cuadrado y sumarlos (Teorema de pitagoras)
@El resultado se debe guardar en 0x20070020 e imprimirlo en pantalla.
.data

numeros: .hword 3,4
mensaje: .asciz "El resultado es: "

.text

main:
	ldr r0,=numeros
	ldrh r1,[r0]
	ldrh r2,[r0,#2]
	mul r1,r1
	mul r2,r2
	add r1,r2
	
	@Store
	ldr r0,=0x20070020
	strh r1,[r0]
	
	@Print
	mov r4,r1
	ldr r2,=mensaje
	mov r0,#0 @Columna en donde empieza el print
	mov r1,#0 @Fila en donde empieza el print
	bl printString
	mov r2,r4
	bl printInt

end: wfi

.end
