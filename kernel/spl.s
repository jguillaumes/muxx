	.TITLE	spl - Set priority level (C Bindings)
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"
	.INCLUDE "CONFIG.s"
	
	.GLOBAL _setpl,_setpl7,_setpl0
	.GLOBAL _getpl


_setpl7:
	procentry
	.if  CPU_HAS_SPL==1
	mov	CPU.PSW,r0
	spl	7
	bic	$0xFF1F,r0
	ash	$-5,r0
	.else
	mov	$7,-(sp)
	jsr	pc,_setpl
	add	$2,sp
	.endif
	procexit

_setpl0:
	procentry
	.if CPU_HAS_SPL==1
	mov	CPU.PSW,r0
	spl	0
	bic	$0xFF1F,r0
	ash	$-5,r0
	.else
	clr	-(sp)
	jsr	pc,_setpl
	add	$2,sp
	.endif
	procexit

_setpl:	procentry
	mov	4(r5),r0		// R0: New IPL
	mov	CPU.PSW,r2		// R2: Current PSW
	mov	r2,r1			// R1: Current PSW 
	bic	$0x00E0,r1		// Clear IPL bits in R1
	ash	$5,r0			// Shift new IPL value to position
	bic	$0xff1f,r0		// CLear non-IPL bits in R0
	bis	r0,r1			// Set new IPL bits in R1
	mov	r1,CPU.PSW		// ... and store it to the PSW
	mov	r2,r0			// R0: Old PSW value
	bic	$0xff1f,r0		// Clear non-IPL bits
	ash	$-5,r0			// Shift to get integer value
	procexit

_getpl:	procentry
	mov	CPU.PSW,r0
	bic	$0xFF1F,r0
	ash	$-5,r0
	procexit

	.end

