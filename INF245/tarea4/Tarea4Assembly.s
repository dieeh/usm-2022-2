.data
func: .word 2
len1: .word 8
len2: .word 
nums: .word 3,-1,7,4,1,5,9,-2
str1: .word
str2: .word
.text
main:
    mov r0,#1
    mov r1,#2
    mov r2,#3
    ldr r3,=func
    ldr r3,[r3]
    cmp r0,r3
    beq func1
    cmp r1,r3
    @beq func2
    cmp r2,r3
    @beq func3
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

    mov r0,#1


    
    

end: wfi
.end
