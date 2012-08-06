	.TITLE muxx_systrap - Set up syscall trap
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	
	.GLOBAL muxx_systrap
	
	.data
_trap_table:	.WORD	svc_muxhlt	//  0: Halt system
		.WORD	muxx_unimpl	//  1: 	
		.WORD	muxx_unimpl	//  2:
		.WORD	muxx_unimpl	//  3:
		.WORD	muxx_unimpl	//  4:
		.WORD	muxx_unimpl	//  5:
		.WORD	muxx_unimpl	//  6:
		.WORD	muxx_unimpl	//  7:
		.WORD	muxx_unimpl	//  8:
		.WORD	muxx_unimpl	//  9:
		.WORD	muxx_unimpl	// 10:
		.WORD	muxx_unimpl	// 11:
		.WORD	muxx_unimpl	// 12:
		.WORD	muxx_unimpl	// 13:
		.WORD	muxx_unimpl	// 14:
		.WORD	muxx_unimpl	// 15:
		.WORD	muxx_unimpl	// 16:
		.WORD	muxx_unimpl	// 17:
		.WORD	muxx_unimpl	// 18:
		.WORD	muxx_unimpl	// 19:
		.WORD	muxx_unimpl	// 20:
		.WORD	muxx_unimpl	// 21:
		.WORD	muxx_unimpl	// 22:
		.WORD	muxx_unimpl	// 23:
		.WORD	muxx_unimpl	// 24:
	
		.WORD	muxx_unimpl	// KRNL 01
		.WORD	muxx_unimpl	// KRNL 02
		.WORD	muxx_unimpl	// KRNL 03
		.WORD	muxx_unimpl	// KRNL 04
		.WORD	srv_conputc	// KRNL 05
		.WORD	muxx_unimpl	// KRNL 06
	
	_trap_table_size	= . - _trap_table
	_trap_table_entries	= _trap_table_size/2

	.text
	
muxx_systrap:
	mov	r0,-(sp)
	mov	$VEC.TRAP,r0		// R0 => TRAP vector
	mov	$muxx_trap,(r0)		// Set up TRAP handler
	mov	$0x0000,2(r0)		// Set up PSW for handler
	mov	(sp)+, r0
	rts	pc

	/*
	*	SYSCALL scheduler
	*
	* syscall ABI:
	* At entry:
	*	R0: Parameter list
	*	=>	Number of parameters (unsigned word)
	*	=>	Array of WORD 
	*	=>	A null value marks the end of the parmlist.
	* At exit:
	*	R0: Status code
	*
	* Any value has to be returned thru memory areas pointed to
	* via a parmlist WORD.
	*
	* The syscall service routines will get the parameters
	* thru the stack, as per normal ABI. The order of the parameters
	* in the stack will be the same as the order in the parmlist. So
	* the lowest positive offsets in the parmlist will correspond to
	* the lowest (in absolute value) negative offsets to the FP (R5).
	*
	* An empty parameter list can be specified passing a null in R0 or
	* pointing to a zero WORD (zero-length parmlist).
	*
	*/
	
muxx_trap:
	procentry numregs=4
	mov	2(r5),r1		// Get return address in R1
	mov	-2(r1),r1		// Get TRAP instruction
	bic	$0xff00,r1		// Get TRAP number
	cmp	r1,$(_trap_table_entries-1) // Check TRAP in range
	blos	10$			// In range: proceeed
	movb	$0x00ff, r0		// Status: Wrong syscall
	br	999$			// Branch to end of handler
	
10$:	clr	r2			// R2: parameter stack usage counter
	clr	r3			// R3: parameter list cursor
	tst	r0			// R0 is null (no parmlist)
	beq	20$			// Yes: no parmlist
	
	mov	(r0)+,r3		// Get WORD from parmlist
	tst	r3			// Null parameter?
	beq	20$			// Yes: end of parmlist
	mov	r3,r2			// R2: Number of parameters to push
	asl	r2			// R2: Number of bytes to push

15$:	mov	(r0)+,-(sp)		// Get parameter from parmlist and push
	sob	r3,15$			// Repeat for all the parameters

20$:	mov	r1,r0			// R0: SYSCALL number
	asl	r1			// Get TRAP routine offset
	add	$_trap_table,r1		
	mov	(r1),r1			// R1 => Handling routine
	jsr	pc,(r1)			// JSR to handler address
	add	r2,sp			// Clean up parameters from stack
	
999$:	cleanup	numregs=4
	rtt				// Return from trap

svc_muxhlt:				// Note no procentry
	mov	$lhltmsg,-(sp)		// We don't really need it
	mov	$hltmsg,-(sp)		// and we want to keep the old FP
	jsr	pc,_kputstrl
	add	$4,sp

	mov	2(r5),-(sp)		// R5 still points to previous FP
	jsr	pc,trace_msg
	add	$2,sp
	
	halt

muxx_unimpl:
	mov	$nscall,-(sp)
	mov	r0,-(sp)
	jsr	pc,_otoa
	add	$4,sp

	mov	$lunimpl,-(sp)
	mov	$unimpl,-(sp)
	jsr	pc,_kputstrl
	add	$4,sp

	mov 	2(r5),r2		// R5 still points to prev SP
	mov	r2,-(sp)
	jsr	pc,trace_msg
	add	$2,sp
	
	halt

trace_msg:
	mov	$octval,-(sp)
	mov	2(r5),-(sp)
	jsr	pc,_otoa
	add	$4,sp

	mov	$hexval,-(sp)
	mov	2(r5),-(sp)
	jsr	pc,_htoa
	add	$4,sp
	
	mov	$ltrcmsg,-(sp)
	mov	$trcmsg,-(sp)
	jsr	pc,_kputstrl
	add	$4,sp
	rts	pc

	.data
trcmsg:	.ASCII	"Invoked from "
octval:	.SPACE  6
	.ASCII  " (0x"
hexval:	.SPACE 4
	.ASCII ")."
	ltrcmsg	= . - trcmsg
hltmsg:	.ASCII  "System halted."
	lhltmsg = . - hltmsg 
unimpl:	.ASCII "Unimplemented syscall ("
nscall:	.SPACE 6
	.ASCII ")."
	lunimpl = . - unimpl
	.END
