.text

main:
	mov r5, #4 @ r5 <- 4
	mov r4, #3
	add r0,r5,r4 @ r0 <- r5+r4
	add r4,r4,#1 @ r4<-r4+1
	sub r4,r4,#1
	cmp r4,r5 @ r4-r5, setea flags
	neg r0,r0 @ r0<- -r0
	mul r4,r5 @ r4 <- r4*r5

end: wfi
.end
