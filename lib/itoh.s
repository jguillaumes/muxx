	.TITLE itoh 	- Convert from hexadecimal to ASCII
	.IDENT "V01.00"
	
	.INCLUDE "MACLIB.s"
	.GLOBAL _itoh

//**********************************************************************
// Conversion from an hexadecimal word to an ASCII string
//
// Stack at entry
//	Offset	Datatype	Content
//	+4	ADDRESS		Pointer to output buffer (4 bytes)
//	+2	WORD		Value to convert
// SP=>	0	ADDRESS		Return address
// 
//**********************************************************************
	azero = 0x30
	
_itoh:	procentry 
	clr	r0			// Return value
	mov	4(r5),r1		// R1 => Number to convert
	mov	6(r5),r2		// R2 => Output buffer address
	mov	$4,r3			// R3 => Digit counter
	add	r3,r2			// R2 => End of buffer
	
10$:	mov	r1,r4			
	bic	$0b1111111111110000,r4	// Clear all bits except digit
	add	$htab,r4		// R4 => ASCII character
	movb	(r4),-(r2)		// Store in buffer
	ash	$-4,r1			// Shift number to get next digit
	sob	r3,10$			// Rinse and repeat

	procexit


//**********************************************************************
// Conversion from an hexadecimal byte to an ASCII string
//
// Stack at entry
//	Offset	Datatype	Content
//	+4	ADDRESS		Pointer to output buffer (2 bytes)
//	+2	WORD		Value to convert
// SP=>	0	ADDRESS		Return address
// 
//**********************************************************************
	.GLOBAL	_itohb
	
_itohb:	procentry 
	clr	r0
	movb	4(r5),r1		// R1 => Number to convert
	mov	6(r5),r2		// R2 => Output buffer address
	mov	$2,r3			// R3 => Digit counter
	add	r3,r2			// R2 => End of buffer
	
10$:	movb	r1,r4			
	bic	$0b1111111111110000,r4	// Clear all bits except digit
	add	$htab,r4		// R4 => ASCII character
	movb	(r4),-(r2)		// Store in buffer
	ash	$-4,r1			// Shift number to get next digit
	sob	r3,10$			// Rinse and repeat

	procexit


	.data
htab:	.ASCII "0123456789ABCDEF"
	.end
