	.TITLE memblocks - Routines related to memory blocks (copy, compare, fill...)
	.IDENT "V01.00"
//*************************************************************************
// Memory block related low-level functions:
// - memcopy:  copies memory blocks (suports overlapping)
// - memfill:  fills a memory block with a byte value
// - memclear: zeroes a memory block (fills with zeroes)
// - memcomp:  compares two memory blocks of the same length
//             (as byte strings)
//*************************************************************************
	.INCLUDE "MACLIB.s"
	
	.SBTTL	memcopy - Copy a memory block
	.GLOBAL _memcopy

//
// Copy a memory block to a different address
// This implementation suports overlapping bloks
// Stack at entry:
//	+6	WORD: 	Block size
//	+4	PTR:	Destination address
//	+2	PTR:	Source address
//	0	PTR:	Return address
//	
	
_memcopy:
	procentry 3
	clr	r0
	
	mov	2(r5),r1
	mov	4(r5),r2
	mov	6(r5),r3

	cmp	r1,r2
	bhi	10$
	beq	999$

	add	r3,r1
	inc	r1
	add	r3,r2
	inc	r2
	
5$:	mov	-(r1),-(r2)
	sob	r3,5$
	br	999$

10$:	mov	(r1)+,(r2)+
	sob	r3,10$

999$:
	cleanup	3
	rts	pc
	.PAGE

	.SBTTL memfill - Fill a	memory block
	.GLOBAL _memfill

//
// Fill a memory block with a byte value
// Stack at entry:
//	+6	WORD: 	Block size
//	+4	BYTE:	Fill character
//	+2	PTR:	Block address
//	0	PTR:	Return address
//	

_memfill:
	procentry 3
	clr	r0
	mov	2(r5),r1
	movb	4(r5),r2
	mov	6(r5),r3

10$:	mov	r2,(r1)+
	sob	r3,10$

	cleanup	3
	rts	pc
	.PAGE
	
	.SBTTL memclear - Zero fill a memory block
	.GLOBAL	_memclear
//
// Fill a memory block with zeroes
// Stack at entry:
//	+4	WORD:	Block size
//	+2	PTR:	Block address
//	0	PTR:	Return address
//	

_memclear:
	procentry 2
	clr	r0
	mov	2(r5),r1
	mov	4(r5),r2

10$:	clr	(r1)+
	sob	r2,10$

	cleanup 2
	rts	pc

	.end
	