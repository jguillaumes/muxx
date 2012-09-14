	.TITLE lib_syscalls - C bindindings for system calls
	.GLOBAL	_conputc,_suspend,_yield,_gettpi
	.GLOBAL _drvreg,_exit,_abort,_mutex,_mutexw
	.GLOBAL _alloc,_allocw
	
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "ERRNO.s"
	
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

_exit:
	procentry saver2=no,saver3=no,saver4=no
	EXIT 	4(r5)
	procexit  getr2=NO,getr3=no,getr4=no

_abort:
	procentry saver2=no,saver3=no,saver4=no
	EXIT 	4(r5)
	procexit  getr2=NO,getr3=no,getr4=no

_mutex:	
	procentry saver2=no,saver3=no,saver4=no
	MUTEX	 mutex=4(r5),op=6(r5)
	procexit  getr2=NO,getr3=no,getr4=no

_mutexw:
	procentry saver2=no,saver3=no,saver4=no
10$:	MUTEX 	mutex=4(r5),op=6(r5)
	cmp	$ELOCKED,r0
	bne 	20$
	YIELD
	br	10$
20$:	procexit  getr2=no,getr3=no,getr4=no

_alloc:
	procentry saver2=no,saver3=no,saver4=no
	ALLOC     4(r5),6(r5)
	procexit  getr2=NO,getr3=no,getr4=no
	
_allocw:
	procentry saver2=no,saver3=no,saver4=no
10$:	ALLOC	4(r5),6(r5)
	cmp	$ENOAVAIL,r0
	bne 	20$
	YIELD
	br	10$
20$:	procexit  getr2=no,getr3=no,getr4=no
	
	.end
