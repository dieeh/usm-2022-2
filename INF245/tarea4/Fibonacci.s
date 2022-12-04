
.text

fib:	push {lr}
	cmp r1,#1
	ble else
	push {r1}
	sub r1,#1
	bl fib
	@ en R2 tenemos resultado
	pop {r1}
	push {r2}
	sub r1,#2
	bl fib
	pop {r4}
	add r2,r4,r2
	pop {pc}
else:	mov r2,r1
	pop {pc}
	mov pc,lr
main:	ldr r7,=0x20070000
	mov r0,#14 @cantidad de terminos
	mov r1,#0 @i
ciclo:	cmp r1,r0
	bge end
	mov r6,r1
	bl fib
	strb r2, [r7]
	add r7,#1
	mov r1,r6
	add r1,#1
	b ciclo
end: wfi
.end
