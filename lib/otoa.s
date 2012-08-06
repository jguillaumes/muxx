	.TITLE otoa 	- Convert from octal to ASCII
	.IDENT "V01.00"
	
	.INCLUDE "MACLIB.s"
	.GLOBAL _otoa

//**********************************************************************
// Conversion from an octal word to an ASCII string
//
// Stack at entry
//	Offset	Datatype	Content
//	+4	ADDRESS		Pointer to output buffer (6 bytes)
//	+2	WORD		Value to convert
// SP=>	0	ADDRESS		Return address
// FP=>         ADDRESS		Old FP
//**********************************************************************
	azero = 0x30
	
_otoa:	procentry numregs=4
	clr	r0			// Return value
	mov	4(r5),r1		// R1 => Number to convert
	mov	6(r5),r2		// R2 => Output buffer address
	mov	$6,r3			// R3 => Digit counter
	add	r3,r2			// R2 => End of buffer
	
10$:	mov	r1,r4			
	bic	$0b1111111111111000,r4	// Clear all bits except digit
	add	$azero,r4		// Add ASCII value of '0'
	movb	r4,-(r2)		// Store in buffer
	ash	$-3,r1			// Shift number to get next digit
	sob	r3,10$			// Rinse and repeat

	cleanup	numregs=4
	rts	pc
