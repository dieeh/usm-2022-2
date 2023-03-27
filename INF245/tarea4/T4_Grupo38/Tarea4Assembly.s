.data
func: .word 1
len1: .word 
len2: .word 
nums: .word 2,7,1,2,8,2,1,2,8
str1: .word
str2: .word
.text
main:
    ldr r0,=func
	ldr r0,[r0]
	mov r1,#1
	cmp r0,r1
	beq func1
	mov r1,#2
	cmp r0,r1
	@beq func2
	mov r1,#3
	mov r3,#0
	mov r4,#4
	cmp r0,r1
	beq func3
func1:
    mov r0,#0
    mov r1,#0
    mov r2,#0
    mov r3,#0
    ldr r0,=nums

    ldr r4,[r0,#0]
    ldr r5,[r0,#16]
    ldr r6,[r0,#32]
    mul r4,r5
    mul r4,r6
    mov r1,r4

    ldr r4,[r0,#4]
    ldr r5,[r0,#20]
    ldr r6,[r0,#24]
    mul r4,r5
    mul r4,r6
    mov r2,r4

    ldr r4,[r0,#8]
    ldr r5,[r0,#12]
    ldr r6,[r0,#28]
    mul r4,r5
    mul r4,r6
    mov r3,r4

    add r7,r1,r2
    add r7,r7,r3

    ldr r4,[r0,#0]
    ldr r5,[r0,#20]
    ldr r6,[r0,#28]
    mul r4,r5
    mul r4,r6
    mov r1,r4

    ldr r4,[r0,#4]
    ldr r5,[r0,#12]
    ldr r6,[r0,#32]
    mul r4,r5
    mul r4,r6
    mov r2,r4

    ldr r4,[r0,#8]
    ldr r5,[r0,#16]
    ldr r6,[r0,#24]
    mul r4,r5
    mul r4,r6
    mov r3,r4

    add r6,r1,r2
    add r6,r6,r3
    sub r6,r7,r6

    mov r0,#0
    mov r1,#0
    mov r2, r6
    bl printInt

func3:
    ldr r0,=nums
	mov r5,#0
	mov r6,#0
	b while
	while:
		ldr r1,[r0,r3]
		ldr r2,[r0,r4]
		add r5,r5,r1
		add r6,r6,r2
		cmp r1,#0
		cmp r2,#0
		beq done

		add r3,r3,#8
		add r4,r4,#8
		b while
	done:
	mul r5,r5
	mul r6,r6
	add r5,r5,r6
	mov r0,#1
	mov r1,#1
	mov r2,#0
	b for
	for:
		cmp r2,r5
		bgt done2

		mul r1,r1
		mov r2,r1
		add r0,r0,#1
		mov r1,r0
		b for
	
	done2:
	sub r0,r0,#2
	mov r2,r0
	mov r0,#0
	mov r1,#2
	bl printInt


end: wfi
.end
