@Ultimo Teorema de Fermat establece que, para n positivo mayor que 3, no se cumple la igualdad x^n + y^n = c^n, para x,y,z enteros
@positivos. Construya un programa que demuestre para n = 2 la igualdad se cumple, y que para n > 3, no se cumple hasta el numero 30.
@Considere x = 3,y = 4,z = 5. Los resultados debe guardarlos en la direccion de memoria 0x2007010 como [x^n,y^n,z^n,r], donde r = 1,
@ssi x^n + y^n = z^n, en otro caso r = 0

@	MAIN
@ for i in 2,3,.......,30
@	Cargar x,y,z
@	x = x^n => pow(x,n)
@	y = x^n
@	z = x^n
@	if x+y == z:
@		Guardar r = 1
@	else
@		Guardar r = 0

@pow(x,n):
@	d = 1
@	for j in 0,1,.....n:
@		d = d*x
@	return d

@Para MAIN se necesitaran 4 registros: Guardar x,y,z y contador i del for
@Para pow se necesitan 4 registros: Recibir x,n, Guardar d y contador j del for
.data
datos: .byte 3,4,5

.text
pow:	mov r7,#1 @ r7 = d
	mov r6,#0 @ r6=j
	cmp r6,r0
	beq powfin
	add r6,r6,#1
powfor:	cmp r6,r0 @r0 = n
	bgt powfin
	mul r7,r5 @r4 = x
	add r6,#1
	b powfor

powfin: mov pc,lr


main:	mov r0,#2 @ r0 = i = 2
	ldr r1,=datos
	ldr r5,=0x20070010
	push {r5}
for:	cmp r0,#30
	bge end
	ldrb r5,[r1] @ r5 = x
	bl pow
	mov r2,r7 @ r2 <- x^n
	ldrb r5,[r1,#1]
	bl pow
	mov r3,r7@ r3 <- y^n
	ldrb r5,[r1,#2]
	bl pow
	mov r4,r7 @ <- z^n
	pop {r5}
	str r2,[r5]
	str r3,[r5,#4]
	str r4,[r5,#8]
	add r2,r2,r3
	add r0,#1
	cmp r2,r4
	beq iguales
	mov r4,#0
	str r4,[r5,#12]
	add r5,#16
	push {r5}
	b for	
iguales:mov r4,#1
	str r4,[r5,#12]
	add r5,#16
	push {r5}	
	b for
end: wfi
.end
