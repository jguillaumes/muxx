	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL	_conputc,_suspend,_yield,_gettpi

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	
_conputc:
	procentry saver2=no,saver3=no,saver4=no
	CONPUTC	4(r5)
	procexit getr2=no,getr3=no,getr4=no

_suspend:
	procentry saver2=no,saver3=no,saver4=no
	SUSPEND 4(r5)
	procexit getr2=no,getr3=no,getr4=no

_yield:
	procentry saver2=no,saver3=no,saver4=no
	YIELD
	procexit getr2=no,getr3=no,getr4=no

_gettpi:
	procentry saver2=no,saver3=no,saver4=no
	GETTPI 6(r5),4(r5)
	procexit getr2=no,getr3=no,getr4=no
	
	.end
