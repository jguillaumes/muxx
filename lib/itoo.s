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

	.end
