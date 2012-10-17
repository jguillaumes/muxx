	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL	_conputc,_suspend,_yield,_gettpi
	.GLOBAL _drvreg,_exit,_abort
	
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	
	.text

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
	GETTPI 4(r5),6(r5)
	procexit getr2=no,getr3=no,getr4=no

_drvreg:
	procentry saver2=no,saver3=no,saver4=no
	DRVREG 	4(r5),6(r5),8(r5) 
	procexit  getr2=NO,getr3=no,getr4=no

_drvstart:
	procentry saver2=no,saver3=no,saver4=no
	DRVSTART 4(r5) 
	procexit  getr2=NO,getr3=no,getr4=no

_drvstop:
	procentry saver2=no,saver3=no,saver4=no
	DRVSTOP	4(r5) 
	procexit  getr2=NO,getr3=no,getr4=no
	
_exit:
	procentry saver2=no,saver3=no,saver4=no
	EXIT 	4(r5)
	procexit  getr2=NO,getr3=no,getr4=no

_abort:
	procentry saver2=no,saver3=no,saver4=no
	EXIT 	4(r5)
	procexit  getr2=NO,getr3=no,getr4=no

_xcopy:
	procentry saver2=no,saver3=no,saver4=no
	XCOPY	4(r5),6(r5),8(r5),10(r5),12(r5)
	procexit  getr2=NO,getr3=no,getr4=no
	
	.end
