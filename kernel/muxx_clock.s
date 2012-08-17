	.TITLE muxx_clock - Clock interrupt service setup
	.IDENT "V01.00"

	.INCLUDE "MUXX.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXMAC.s"	
	.INCLUDE "CONFIG.s"
	
	.GLOBAL _muxx_clock_setup
	.GLOBAL _muxx_clock_enable
	.GLOBAL _muxx_clock_disable
	
_muxx_clock_setup:
	procentry
	mov	CPU.PSW,-(SP)
	mov	$6,-(sp)
	jsr	pc,_setpl
	add	$2,sp
	mov	$muxx_clock_svc,CLK.VECTOR
	mov	$0x0040,CLK.VECTOR+2		// Kernel mode, IPL=4
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
	mov	r0,-(sp)		// Push R0
	mov	r1,-(sp)		// Push R1
	mov	sp,-(sp)		// Push current SP...
	sub	$4,(sp)			// ... and make it point to FP
	jsr	pc,_muxx_clock_handler	// Call C clockhandler
	add	$2,sp			// Toss FP in stack 
	mov	(sp)+,r1		// Pull R1
	mov	(sp)+,r0		// Pull R0
	rti 				// Interrupt done

	.end
