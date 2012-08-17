	.TITLE muxx_systrap - Set up syscall trap
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXX.s"
	.INCLUDE "ERRNO.s"
	
	.GLOBAL muxx_systrap
	
	.text
	
muxx_systrap:
	mov	r0,-(sp)
	mov	$VEC.TRAP,r0		// R0 => TRAP vector
	mov	$muxx_trap,(r0)		// Set up TRAP handler
	mov	$0x0000,2(r0)		// Set up PSW for handler
	mov	(sp)+, r0
	rts	pc

	
muxx_trap:
	mov	r5,-(sp)		// Push previous frame pointer
	mov	sp,r5			// Set up current FP
	tst	r0			// Have we got a parmlist
	beq	noparms			// no, branch away
	mov	(r0)+,r1		// Does the parmlist contain anything?
	beq	noparms			// no, branch away
10$:	mov	(r0)+,-(sp)		// Push parameters
	sob	r1,10$			// ... until done
noparms:
	mov	2(r5),r1		// R1 points to return address
	mov	-2(r1),r1		// R1 contains the EMT/TRAP instruction 
	bic	$0xff00,r1		// R1 contains now the EMT/TRAP number
	mov	r1,-(sp)		// … which is pushed in the stack
	jsr	pc,_muxx_systrap_handler // Call the C trap handler
	mov	r5,sp			// Clean up parameters from stack 
	mov	(sp)+,r5		// Get previous frame pointer
	rtt				// Return from trap

	.END
