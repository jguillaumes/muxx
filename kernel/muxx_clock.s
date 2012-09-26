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
	procentry saver2=no,saver3=no,saver4=no
	mov	CPU.PSW,-(SP)
	mov	$muxx_clock_svc,CLK.VECTOR
	mov	$0x00C0,CLK.VECTOR+2		// Kernel mode, IPL=6
	mov	(sp)+,CPU.PSW
	procexit getr2=no,getr3=no,getr4=no

_muxx_clock_enable:
	procentry saver2=no,saver3=no,saver4=no
	bis	$000100,CLK.LKS			// Set interrupt enable
	procexit getr2=no,getr3=no,getr4=no

_muxx_clock_disable:
	procentry saver2=no,saver3=no,saver4=no
	bic	$000100,CLK.LKS			// Clear interrupt enable
	procexit getr2=no,getr3=no,getr4=no
	
muxx_clock_svc:	
	traphandle	_muxx_clock_handler	
	rti 				// Interrupt done

	.end
