	.TITLE cputrap - Handling of CPU error/traps
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	.INCLUDE "MACLIB.s"
	
	.GLOBAL trap_initialize

	.macro setvec vector,address,psw
	mov	\address, \vector
	mov	\psw, \vector+2
	.endm

	.macro TRAPHALT
	.if	MUXX_TRAPHALT == 1
	halt
	.endif
	.endm

	
	PSWTRAP = 0x00E0		// Traps: IPL:7 (No interrupts)
	
	.text
trap_initialize:
	procentry saver2=no,saver3=no,saver4=no
	mov	$trap_unimplemented, r0
	mov	$PSWTRAP, r1

	setvec	VEC.CPUERR,$trap_cpuerr,r1
	setvec	VEC.ILLINS,$trap_illins,r1
	setvec	VEC.TRACE,$trap_trace,r1
	setvec	VEC.IOT,$trap_iot,r1
	setvec	VEC.POWER,$trap_power,r1
	setvec	VEC.BUSERR,$trap_buserr,r1
	setvec	VEC.FPERR,$trap_fperr,r1
	setvec	VEC.MMUERR,$trap_mmuerr,r1
	
	procexit getr2=no,getr3=no,getr4=no

trap_cpuerr:
	TRAPHALT
	traphandle _muxx_handle_cpuerr
	halt
0$:	br	0$
	
trap_illins:
	TRAPHALT
	traphandle _muxx_handle_illins
	halt
0$:	br	0$
	
trap_iot:
	TRAPHALT
	traphandle _muxx_handle_iot
	halt
0$:	br	0$		;
	
trap_buserr:
	TRAPHALT
	traphandle _muxx_handle_buserr
	halt
0$:	br	0$		;
	
trap_fperr:
	TRAPHALT
	traphandle _muxx_handle_fperr
	halt
0$:	br	0$
	
trap_mmuerr:
	TRAPHALT
	traphandle _muxx_handle_mmuerr
	halt
0$:	br	0$


trap_trace:
	TRAPHALT
	traphandle _muxx_handle_trace
	halt
0$:	br	0$

trap_power:
	TRAPHALT
	traphandle _muxx_handle_power
	halt
0$:	br	0$

	
trap_unimplemented:
	TRAPHALT	
	traphandle _muxx_handle_unimpl
	halt
0$:	br	0$

	.END
