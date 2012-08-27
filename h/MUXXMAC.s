	.NOLIST

	.macro SYSHALT
	clr	r0
	trap	$KRN_HALT
	.endm

	.macro	YIELD
	clr	r0
	trap	$SRV_YIELD
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

	.macro	CREPRC name,type,entry,privs
	sub	$10,sp			// Room for 4 members parmlist
	mov	$4,(sp)			// size = 4
	mov	\privs,2(sp)
	mov	\entry,4(sp)
	mov	\type,6(sp)
	mov	\name,8(sp)
	mov	sp,r0
	trap	$SRV_CREPRC
	add	$10,sp
	.endm

	.macro GETTPI pid,tcb
	sub	$6,sp
	mov	$2,(sp)
	mov	\tcb,4(sp)
	mov	\pid,2(sp)
	mov	sp,r0
	trap	$SRV_GETTPI
	add	$6,sp
	.endm
	
	.macro SUSPEND tcb
	sub	$4,sp			// Room for parmlist
	mov	$1,(sp)			// Size = 1
	tst	\tcb			// null pointer?
	bne	10$			// No, use its value
	mov	_curtcb,2(sp)
	br	20$
10$:	mov	\tcb,2(sp)
20$:	mov	sp, r0
	trap	$SRV_SUSPEND
	add	$4,sp
	.endm
	
	.LIST
