	.TITLE dtoa - Binary to decimal string conversion
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"

	
	.GLOBAL _dtoa

_dtoa:
	procentry numregs=3
	mov	2(r5),r2
	mov	4(r5),r1
	mov	$5,r0
	add	r0,r1

10$:	clr	r3
	div	$10,r2
	add	$'0',r3
	movb	r3,(r1)+
	sob	r0,10$

	cleanup	numregs=3
	rts	pc

	.GLOBAL _dtoab

_dtoab:
	procentry numregs=3
	movb	2(r5),r2
	mov	4(r5),r1
	mov	$3,r0
	add	r0,r1

10$:	clr	r3
	div	$10,r2
	add	$'0',r3
	movb	r3,(r1)+
	sob	r0,10$

	cleanup	numregs=3
	rts	pc
