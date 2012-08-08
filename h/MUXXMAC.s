	.NOLIST

	.macro HALT
	clr	r0
	trap	$KRN_HALT
	.endm
	
	.macro	CONPUTC char
	sub	$4,sp			// Make space for parmlist
	mov	$1,(sp)			// Number of parameters
	movb	\char,2(sp)		// Character value
	mov	sp,r0			// R0 => Parmlist
	trap	$KRN_PUTCON		// Do it!
	add	$4,sp			// Cleanup stack
	.endm

	.macro	CONGETC addr
	sub	$4,sp			// Make room for parmlist
	mov	$1,(sp)			// Number of parameters
	mov	\addr,2(sp)		// Address of read char
	mov	sp,r0			// R0 => Parmlist
	trap	$KRN_GETCON		// Do it!
	add	$4,sp			// cleanup stack
	.endm

	.macro	NOIRQ
	mov	CPU.PSW,r0
	mov	$(7*32),r1
	com	r1
	bic	r1,r0
	mov	r0,-(sp)
	mov	CPU.PSW,r0
	bic	$(7*32),r0
	bis	$7,r0
	mov	r0,CPU.PSW
	.endm

	.LIST
