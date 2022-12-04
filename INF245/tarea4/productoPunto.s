@La operacion producto entre dos vectores (x1,x2,x3...);(y1,y2,y3,...) como una sumatoria entre xi*yi. Suponga que en la direccion de 
@memoria 0x2007000 tiene una serie de numeros que representan el primer vector, en 0x20070010 hay otro vector, y en 0x20070020 la
@dimension del vector.
@Calcule el producto punto.

@ ProductoPunto(x,y,n):
@	r = 0
@	for i in 0,1,2,...,n:
@		r += x[i]*y[i]
@	return r

.data

vec1: .byte 1,2,3,4,3,5,6,3,4,10,15,4,20,5,3,17
vec2: .byte 1,2,3,4,57,6,5,76,5,7,5,4,20,45,34,1
n: .byte 4

.text

pp:	mov r4,#1 @ i
ppfor:	cmp r4,r2
	bgt fin
	ldrb r6,[r0] @ r6 <-x[base+1*i]
	ldrb r7,[r1]
	mul r6,r7
	push {r6}
	add r4,#1
	add r0,#1
	add r1,#1
	b ppfor
fin:	pop {r3}
	cmp r3,#30
	bne end
	mov pc,lr
main:
	ldr r0,=vec1 @ x
	ldr r1,=vec2 @ y
	ldr r2,=n
	ldrb r2,[r2] @ r2 = n
	bl pp
	b end
end: wfi
.end
