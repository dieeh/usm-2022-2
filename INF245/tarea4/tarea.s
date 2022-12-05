.data

func: .byte 
len1: .byte 
len2: .byte 
nums: .word
str1: .asciz
str2: .asciz

main:
    ldr r0, =nums
    ldr r1, [r0]
    







end: wfi

.end
