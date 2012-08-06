	.NOLIST
	.INCLUDE "CONFIG.s"
	
	.macro seti level=0

	mov	r0,-(sp)
	mov	CPU.PSW, r0
	bic	$(7*32), r0
	bis	$(\level * 32), r0
	mov	r0, CPU.PSW
	mov	(sp)+, r0
	.endm


	.macro  CMKRNL
	bic	$0b1100000000000000, CPU.PSW
	.endm

	//.macro	CMSUPR
	//
	//.endm

	.macro	CMUSER
	bis	$0b1100000000000000, CPU.PSW
	.endm

	.macro MUXHLT
	mov 	r1,-(sp)
	clr	r1
	emt	0
	mov	(sp)+,r1
	.endm
	
	.macro	CONPTCHR char
	mov	$0,-(sp)
	mov	\char,-(sp)
	mov	sp,r1
	emt	1
	add	$4,sp
	.endm

	.macro	CONGTCHR
	clr	r1
	emt	2
	.endm
	.LIST



	


	
	