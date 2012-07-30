	.TITLE muxxsta - Initial system setup
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"
	
	.GLOBAL _muxx_setup

	.data
_emt_table:	.WORD	_svc_muxhlt	// 0: Halt system
		.WORD	_svc_conptchr	// 1: Put char on console	
		.WORD	_svc_congtchr	// 2: Get char from console
	_emt_table_size		= . - _emt_table
	_emt_table_entries	= _emt_table_size/2

hltmsg:		.ASCII "System halted."
	lhltmsg = . - hltmsg

	.text
_muxx_setup:
	mov	r0,-(sp)
	mov	$VEC.EMT,r0		// R0 => EMT vector
	mov	$_muxx_hnd30,(r0)	// Set up EMT 30 handler
	mov	$0x0000,2(r0)		// Set up PSW for handler
	mov	(sp)+, r0
	rts	pc

_muxx_hnd30:
	mov	r2,-(sp)		// Save R2
	mov	r3,-(sp)		// Save R3
	mov	r4,-(sp)		// Save R4
	mov	6(sp),r2		// Get return address in R0
	mov	-2(r2),r2		// Get EMT instruction
	bic	$0xff00,r2		// Get EMT number
	cmp	r2,$(_emt_table_entries-1) // Check EMT in range
	blos	10$			// In range: proceeed
	movb	$0x00ff, r0		// Status: Wrong syscall
	br	999$			// Branch to end of handler
	
10$:	clr	r3			// R3: parameter stack usage counter

15$:	mfpd	(r1)+
	mov	(sp)+,r4
	tst	r4			// Null parameter?
	beq	20$			// Yes: end of parmlist
	mov	r4,-(sp)		// Push parameter from parmlist
	add	$2,r3			// R3: 2 more stack bytes used
	br	15$

20$:	asl	r2			// Get EMT routine offset
	add	$_emt_table,r2		
	mov	(r2),r2			// R2 => Handling routine
	jsr	pc,(r2)			// JSR to handler address
	add	r3,sp			// Clean up parameters from stack
	
999$:	mov	(sp)+,r4
	mov	(sp)+,r3		// Pop R3
	mov	(sp)+,r2		// Pop R2
	rtt				// Return from trap

_svc_muxhlt:
	mov	$lhltmsg,-(sp)
	mov	$hltmsg,-(sp)
	jsr	pc,_conptstr
	add	$4,sp
	halt
	.END
