	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL	_conputc
	.GLOBAL _panic

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	
_conputc:
	procentry numregs=1
	CONPUTC	4(r5)
	cleanup numregs=1
	rts	pc

_panic:
	procentry numregs=0
	PANIC 4(r5)
	cleanup numregs=0
	
	.end
