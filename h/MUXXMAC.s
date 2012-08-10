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

	.macro	PANIC code
	sub	$4,sp			// Make room for parms
	mov	$1,(sp)			// 1 parm
	mov	\code,2(sp)		// Error code
	mov	sp,r0
	trap	$KRN_PANIC
	.endm

	.LIST
