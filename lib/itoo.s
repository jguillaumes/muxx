	.TITLE itoo 	- Convert from octal to ASCII
	.IDENT "V01.00"
	
	.INCLUDE "MACLIB.s"
	.GLOBAL _itoo

//**********************************************************************
// Conversion from an octal word to an ASCII string
//
// Stack at entry
//	Offset	Datatype	Content
//	+6	ADDRESS		Pointer to output buffer (6 bytes)
//	+4	WORD		Value to convert
// SP=>	0	ADDRESS		Return address
// FP=>         ADDRESS		Old FP
//**********************************************************************
	azero = 0x30
	
_itoo:	procentry
	clr	r0			// Return value
	mov	4(r5),r1		// R1 => Number to convert
	mov	6(r5),r2		// R2 => Output buffer address
	mov	$6,r3			// R3 => Digit counter
	add	r3,r2			// R2 => End of buffer
	
	mov	$5,r3			// First we do the complete 3bit groups
10$:	mov	r1,r4			
	bic	$0b1111111111111000,r4	// Clear all bits except digit
	add	$azero,r4		// Add ASCII value of '0'
	movb	r4,-(r2)		// Store in buffer
	ash	$-3,r1			// Shift number to get next digit
	sob	r3,10$			// Rinse and repeat

	mov	r1,r4			// Last digit (will be 0 or 1)
	bic	$0b1111111111111110,r4	// Clear all bits except last bit
	add	$azero,r4		// Add ASCII value of '0'
	movb	r4,-(r2)		// Store last digit in buffer

	procexit

	.GLOBAL _itool

//**********************************************************************
// Conversion from an octal longword to an ASCII string
//
// Stack at entry
//	Offset	Datatype	Content
//	+8	ADDRESS		Pointer to output buffer (11 bytes)
//	+4	LONGWORD	Value to convert
// SP=>	0	ADDRESS		Return address
// FP=>         ADDRESS		Old FP
//**********************************************************************
	
_itool:	procentry
	clr	r0			// Return value
	mov	6(r5),r1		// R1 => Number to convert (low)
	mov	8(r5),r2		// R2 => Output buffer address
	mov	$11,r3			// R3 => Digit counter
	add	r3,r2			// R2 => End of buffer
	
	mov	$5,r3			// First we do the complete 3bit groups
10$:	mov	r1,r4			
	bic	$0b1111111111111000,r4	// Clear all bits except digit
	add	$azero,r4		// Add ASCII value of '0'
	movb	r4,-(r2)		// Store in buffer
	ash	$-3,r1			// Shift number to get next digit
	sob	r3,10$			// Rinse and repeat

	mov	r1,r4			// Last bit of low word
	bic	$0b1111111111111110,r4	// Clear all bits except last bit
	mov	r4,-(sp)		// Preserve remaining of low word
	mov	4(r5),r1		// R1: High word to convert
	mov	r1,r4
	bic	$0b1111111111111100,r4	// Isolate 2 lowest bits
	asl	r4			// shift 1 to the left...
	bis	(sp)+,r4		// ... and set lowest (saved)
	add	$azero,r4		// Add ASCII '0'
	movb	r4,-(r2)		// Store converted digit

	mov	$5,r3			// 5 more groups to go
	asl	r1			// Shift past already done bit...
20$:	mov	r1,r4			// ... and proceed
	bic	$0b1111111111111000,r4
	add	$azero,r4
	movb	r4,-(r2)
	ash	$-3,r1
	sob	r3,20$

	procexit

	.end
