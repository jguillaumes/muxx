	.NOLIST

	.macro SYSHALT
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

	.LIST
