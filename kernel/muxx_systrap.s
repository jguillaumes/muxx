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
	mov	$0x00E0,2(r0)		// Set up PSW for handler (KM, IPL7)
	mov	(sp)+, r0
	rts	pc

muxx_trap:
	mov	r0,-(sp)		// Preserve R0 (parmlist pointer)

	/*
	mov	r1,-(sp)
	mov	4(sp),-(sp)
	jsr	pc,_kputoct
	add	$2,sp
	mov	$crlf,-(sp)
	jsr	pc,_kputstrz
	add	$2,sp
	mov	(sp)+,r1
	*/
	
	mov	_curtcb,r0		// Copy current task status
	mov	r2,TCB.R2(r0)		// to the TCB
	mov	r3,TCB.R3(r0)		
	mov	r4,TCB.R4(r0)
	mov	r5,TCB.R5(r0)
	mov	sp,TCB.SP(r0)
	add	$2,TCB.SP(r0)		// Correct SP (we pushed R0)
	mov	2(sp),TCB.PC(r0)
	mov	4(sp),TCB.PSW(r0)

	mov	CPU.PSW,-(sp)		// Copy USP to TCB
	bis	$0b0011000000000000,CPU.PSW // Set previous mode to user
	mfpd	sp			// Get user mode SP onto stack
	mov	(sp)+,18(r0)		// Extract USP and save it

	.ifc	CPU_HAS_SUPER,"1"
	bic	$0b0010000000000000,CPU.PSW // Set previous mode to super
	mfpd	sp
	mov	(sp)+,20(r0)
	.endif
	mov	TCB.SP(r0),TCB.KSP(r0)	// Copy KSP from saved SP
	mov	(sp)+,CPU.PSW

	/*
	mov	r0,-(sp)
	mov	r1,-(sp)
	jsr	pc,_muxx_dumptcbregs
	mov	(sp)+,r1
	mov	(sp)+,r0
	*/
	
	bit	$0xC000,TCB.PSW(r0)	// Called from kernel mode?
	bne	5$			// No: proceed

	mov	$kmodet,-(sp)		// Yes: Panic
	jsr	pc,_panic
	add	$2,sp
3$:	halt
	br	3$
	
5$:	mov	(sp)+,r0		// Recover parmlist pointer
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

	.data
	
kmodet:	.ASCIZ "SYSCALL from kernel mode"
crlf:	.ASCIZ "\n\r"
	.END
