	.TITLE muxx_clock - Clock interrupt service setup
	.IDENT "V01.00"

	.INCLUDE "MUXX.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXMAC.s"	
	.INCLUDE "CONFIG.s"
	
	.GLOBAL _muxx_clock_setup
	.GLOBAL _muxx_clock_enable
	.GLOBAL _muxx_clock_disable
	.GLOBAL muxx_clock_svc
	
_muxx_clock_setup:
	procentry
	mov	CPU.PSW,-(SP)
	mov	$muxx_clock_svc,CLK.VECTOR
	mov	$0x00C0,CLK.VECTOR+2		// Kernel mode, IPL=6
	mov	(sp)+,CPU.PSW
	procexit

_muxx_clock_enable:
	procentry
	bis	$000100,CLK.LKS			// Set interrupt enable
	procexit

_muxx_clock_disable:
	procentry 
	bic	$000100,CLK.LKS			// Clear interrupt enable
	procexit
	
muxx_clock_svc:	
	/*
	mov	r1,-(sp)
	mov	2(sp),-(sp)
	jsr	pc,_kputoct
	add	$2,sp
	mov	$crlf,-(sp)
	jsr	pc,_kputstrz
	add	$2,sp
	mov	(sp)+,r1
	*/

	traphandle	_muxx_clock_handler
	
	/*
	mov	r0,-(sp)		// Push R0
	mov	r1,-(sp)		// Push R1
	mov	r2,-(sp)		// Push R2
	mov	r3,-(sp)		// Push R3
	mov	r4,-(sp)		// Push R4
	mov	r5,-(sp)		// Push R5

	mov	sp,-(sp)		// Push current SP...
	jsr	pc,_muxx_clock_handler	// Call C clockhandler
	add	$2,sp			// Toss FP in stack

	mov	(sp)+,r5		// Pull R5
	mov	(sp)+,r4		// Pull R4
	mov	(sp)+,r3		// Pull R3
	mov	(sp)+,r2		// Pull R2
	mov	(sp)+,r1		// Pull R1
	mov	(sp)+,r0		// Pull R0
	*/
	
	rti 				// Interrupt done

	.data
crlf:	.ASCIZ	"\r\n"
	
	.end
