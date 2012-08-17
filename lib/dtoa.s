	.TITLE dtoa - Binary to decimal string conversion
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"

	
	.GLOBAL _dtoa

_dtoa:
	procentry 

	mov	4(r5),r3
	mov	6(r5),r1
	mov	$5,r0
	add	r0,r1

10$:	clr	r2
	div	$10,r2
	add	$'0',r3
	movb	r3,-(r1)
	mov 	r2,r3
	sob	r0,10$
	
	procexit

	.GLOBAL _dtoab

_dtoab:
	procentry
	movb	4(r5),r3
	mov	6(r5),r1
	mov	$3,r0
	add	r0,r1

10$:	clr	r2
	div	$10,r2
	add	$'0',r3
	movb	r3,(r1)+
	movb	r3,r2
	sob	r0,10$

	procexit


	.end
	