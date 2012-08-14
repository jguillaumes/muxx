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
	procentry numregs=0
	mov	CPU.PSW,-(SP)
	mov	$6,-(sp)
	jsr	pc,_setpl
	add	$2,sp
	mov	$muxx_clock_svc,CLK.VECTOR
	mov	$0040,CLK.VECTOR+2		// Kernel mode, IPL=4
	mov	(sp)+,CPU.PSW
	cleanup numregs=0
	rts	pc

_muxx_clock_enable:
	procentry numregs=0
	bis	$000100,CLK.LKS			// Set interrupt enable
	cleanup	numregs=0
	rts	pc

_muxx_clock_disable:
	procentry numregs=0
	bic	$000100,CLK.LKS			// Clear interrupt enable
	cleanup	numregs=0
	rts	pc
	
muxx_clock_svc:
	procentry saver0=yes
	inc	_utimeticks
	bne	5$
	inc	_utimeticks+2

5$:	dec	_clkcountdown
	bne	10$

	halt
	savecputask
	halt
	
	jsr	pc,_muxx_check_quantums
	mov	_clkquantum,_clkcountdown

10$:	jsr	pc,_muxx_check_timers

	cleanup saver0=yes
	rti

	.end