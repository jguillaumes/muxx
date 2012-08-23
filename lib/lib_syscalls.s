	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL	_conputc,_suspend

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	
_conputc:
	procentry
	CONPUTC	4(r5)
	procexit 

_suspend:
	procentry
	SUSPEND 4(r5)
	procexit

	.end
