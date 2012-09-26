	.TITLE mutex - C Wrapper for MUTEX syscalls
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "ERRNO.s"
	
	.text

	.GLOBAL _mutex,_mutexw
	
_mutex:	
	procentry saver2=no,saver3=no,saver4=no
	MUTEX	 mutex=4(r5),op=6(r5)
	mov	$_curtcb,r1
	mov	TCB.TASKTUCB(r1),r1
	mov	r0,TUCB.ERRNO(r1)
	procexit  getr2=NO,getr3=no,getr4=no

_mutexw:
	procentry saver2=no,saver3=no,saver4=no
10$:	MUTEX 	mutex=4(r5),op=6(r5)
	cmp	$ELOCKED,r0
	bne 	20$
	YIELD
	br	10$
20$:	mov	$_curtcb,r1
	mov	TCB.TASKTUCB(r1),r1
	mov	r0,TUCB.ERRNO(r1)
	procexit  getr2=no,getr3=no,getr4=no

	.end
