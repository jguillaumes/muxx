	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL	_conputc

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	
_conputc:
	procentry numregs=1
	CONPUTC	4(r5)
	cleanup numregs=1
	rts	pc
