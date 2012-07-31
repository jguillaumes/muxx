
	.NOLIST
	
	.macro push reg
	mov	/reg,-(sp)
	.endm

	.macro pop reg
	mov	(sp)+,reg
	.endm

	.macro procentry numregs=0
	mov	r5,-(sp)
	mov	sp,r5
	.ifgt	\numregs
	mov	r1,-(sp)
	.ifgt	\numregs - 1
	mov	r2,-(sp)
	.ifgt	\numregs - 2
	mov	r3,-(sp)
	.ifgt	\numregs - 3
	mov	r4,-(sp)
	.ifgt	\numregs - 4
	.error	"The upper limit for the number of pushed regs is 4"
	.endif
	.endif
	.endif
	.endif
	.endif
	.endm

	.macro cleanup numregs
	.ifgt	\numregs - 4
	.error	"The upper limit for the number of pushed regs is 4"
	.else
	.ifgt	\numregs - 3
	mov	(sp)+,r4
	.endif
	.ifgt	\numregs - 2
	mov	(sp)+,r3
	.endif
	.ifgt	\numregs - 1
	mov	(sp)+,r2
	.endif
	.ifgt	\numregs
	mov	(sp)+,r1
	.endif
	.endif
	mov	r5,sp
	mov	(sp)+,r5
	.endm

	.LIST
	



