	.TITLE lib_alloc - C bindings for ALLOC system calls
	.IDENT "V01.00"

	.GLOBAL _alloc,_allocw

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "ERRNO.s"
	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	
	.text

_alloc:
	procentry saver2=no,saver3=no,saver4=no
	ALLOC     4(r5),6(r5)
	mov	_curtcb,r1
	mov	TCB.TASKTUCB(r1),r1
	mov	r0,TUCB.ERRNO(r1)
	procexit  getr2=NO,getr3=no,getr4=no

	.end
	