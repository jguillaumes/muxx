	.TITLE itod - Binary to decimal string conversion
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"

	
	.GLOBAL _itod,_itods,_itodl,_itodb

_itod:
	procentry saver4=no 

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
	
	procexit getr4=no

_itods:
	procentry saver2=no,saver3=no,saver4=no
	mov	4(r5),r0
	mov	6(r5),r1
	bpl	10$
	movb	$'-',(r1)+
	neg	r0
	br	20$

10$:	movb	$' ',(r1)+
20$:	mov	r1,-(sp)
	mov	r0,-(sp)
	jsr	pc,_itod
	add	$4,sp
	procexit getr2=no,getr3=no,getr4=no
	
_itodb: saver4=no
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

	procexit getr4=no
_itodl:	
	procentry local=3
	
	mov	4(r5),r2
	mov	6(r5),r3
	div	$10000,r2			// r2: 5 upper digits

	mov	r5,r1
	sub	$6,r1				// R1: points to work buffer
	mov	r1,-(sp)			// Push buffer address...
	mov	r1,-(sp)			// twice (we'll need it)
	mov	r2,-(sp)			// Push 4 first digits value
	jsr	pc,_itod			// Convert upper 
	add	$4,sp

	mov 	(sp),r0				// Work buffer in stack 
	mov	$5,r1				// Move the first 5 bytes
	mov	8(r5),r4
10$:	movb	(r0)+,(r4)+
	sob	r1,10$

	mov	(sp),r1				// R1: work buffer (NOT PULLED)
	mov	r3,-(sp)			// Push 4 lower digits
	jsr	pc,_itod			// Convert
	add	$2,sp				// Don't pull buffer addr

	mov	(sp)+,r0			// R0: work buffer (PULLED!)
	inc	r0				// Skip first digit ('0')
	mov	$4,r1				// Move 4 bytes
20$:	movb	(r0)+,(r4)+
	sob	r1,20$
	clr	r0
	
	procexit local=3
	
	.end
