	.TITLE	spl - Set priority level (C Bindings)
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"
	.INCLUDE "CONFIG.s"
	
	.GLOBAL _setpl,_setpl7,_setpl0
	.GLOBAL _getpl


_setpl7:
	procentry numregs=0
	.if  CPU_HAS_SPL==1
	mov	CPU.PSW,r0
	spl	7
	bic	$0xFF8F,r0
	ash	$-4,r0
	.else
	mov	$7,-(sp)
	jsr	pc,_setpl
	add	$2,sp
	.endif
	cleanup numregs=0
	rts	pc

_setpl0:
	procentry numregs=0
	.if CPU_HAS_SPL==1
	mov	CPU.PSW,r0
	spl	0
	bic	$0xFF8F,r0
	ash	$-4,r0
	.else
	clr	-(sp)
	jsr	pc,_setpl
	add	$2,sp
	.endif
	cleanup numregs=0
	rts	pc

_setpl:	procentry numregs=2
	mov	4(r5),r0		// R0: New IPL
	mov	CPU.PSW,r2		// R2: Current PSW
	mov	r2,r1			// R1: Current PSW 
	bic	$0x0070,r1		// Clear IPL bits in R1
	ash	$4,r0			// Shift new IPL value to position
	bic	$0xff8f,r0		// CLear non-IPL bits in R0
	bis	r0,r1			// Set new IPL bits in R1
	mov	r1,CPU.PSW		// ... and store it to the PSW
	mov	r2,r0			// R0: Old PSW value
	bic	$0xff8f,r0		// Clear non-IPL bits
	ash	$-4,r0			// Shift to get integer value
	cleanup numregs=2
	rts	pc		

_getpl:	procentry numregs=0
	mov	CPU.PSW,r0
	bic	$0xFF8F,r0
	ash	$-4,r0
	cleanup numregs=0
	rts	pc

	.end

