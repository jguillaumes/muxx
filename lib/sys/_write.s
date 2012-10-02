	.TITLE _read/_write: wrappers for the READ and WRITE syscalls
	.IDENT "V01.00"
	.GLOBAL __read, __write

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MUXXDEF.s"
	
__write:
	procentry saver2=no,saver3=no,saver4=no
	WRITE 4(r5),6(r5),8(R5)
	procexit getr2=no,getr3=no,getr4=no

	.end
