	.TITLE empty_proc - Empty procedure to test stack handling
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"
	
	.GLOBAL _empty_proc


_empty_proc:
	HALT		// Halt to debug
	procentry 
	HALT		// New halt
	mov	$10,r0	// Clobber registers
	mov	$11,r1
	mov	$12,r2
	mov	$13,r3
	mov	$14,r4
	HALT		//
	procexit

	.end

