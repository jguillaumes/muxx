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
//	mov	$0x00E0,2(r0)		// Set up PSW for handler (KM, IPL7)
	mov	$0x0000,2(r0)		// Set up PSW for handler (KM, IPL0)
	mov	(sp)+, r0
	rts	pc

muxx_trap:
	traphandle	muxx_trap_handle,saveall=no
	rtt

muxx_trap_handle:
	mov	2(sp),-(sp)		// Push trap frame pointer
	mov	r0,-(sp)		// Preserve R0 (parmlist pointer)

	/*
	mov	CPU.PSW,-(sp)		// Save PSW (IPL)
	mov	$0x00C0,CPU.PSW		// Set IPL=7, inhibit interrupts
	mov	r1,-(sp)		// Copy frame to TCB
	jsr	pc,_copytrapfp
	add	$2,sp
	mov	(sp)+,CPU.PSW		// Restore IPL level
	*/
	
	mov	_curtcb,r0		// R0: Current TCB
	
	mov	CPU.PSW,r1
	mov	r1,r2			// (DEBUGGING!!!)
	bic	$0xCFFF,r1		// Called from kernel mode?
	bne	5$			// No: proceed

	mov	$kmodet,-(sp)		// Yes: Panic
	jsr	pc,_panic
3$:	halt
	br	3$
	
5$:
	mov	(sp)+,r0		// Recover parmlist pointer
	mov	r5,-(sp)		// Push previous frame pointer
	mov	sp,r5			// Set up current FP
	tst	r0			// Have we got a parmlist
	beq	noparms			// no, branch away
	mov	(r0)+,r1		// Does the parmlist contain anything?
	beq	noparms			// no, branch away
10$:	mov	(r0)+,-(sp)		// Push parameters
	sob	r1,10$			// ... until done

noparms:
//	mov	_curtcb,r1		// R1 => Current TCB
//	mov	TCB.PC(r1),r1		// R1 => Trap return address

	mov	2(r5),r1		// R1: Trap frame pointer
	mov	r1,-(sp)		// ... pushed as 2nd parm
	mov	14(r1),r1		// R1: Trap return address 
 	mov	-2(r1),r1		// R1 contains the EMT/TRAP instruction
	bic	$0xff00,r1		// R1 contains now the EMT/TRAP number
	mov	r1,-(sp)		// ... pushed as first parm
	jsr	pc,_muxx_systrap_handler // Call the C trap handler
	mov	r5,sp			// Clean up parameters from stack 
	mov	(sp)+,r5		// Get previous frame pointer
	add	$2,sp			// Toss interrupt frame 
	rts	pc			// Return from trap

	.data
	
kmodet:	.ASCIZ "SYSCALL from kernel mode"
crlf:	.ASCIZ "\n\r"
	.END
