	.TITLE	spl - Set priority level (C Bindings)
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"
	.INCLUDE "CONFIG.s"
	
	.GLOBAL _setpl
	.GLOBAL _getpl
	

_setpl:	procentry numregs=1
	mov	4(r5),r0
	mov	CPU.PSW,r1
	bic	$0xff8f,r1
	ash	$4,r0
	bic	$0x0070,r0
	bis	r0,r1
	mov	r1,CPU.PSW
	cleanup numregs=1
	rts	pc

_getpl:	procentry numregs=0
	mov	CPU.PSW,r0
	bic	$0x0070,r0
	ash	$-4,r0
	cleanup numregs=0
	rts	pc

	.end

