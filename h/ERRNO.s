	.INCLUDE "ERRORS.s"
	.INCLUDE "MUXX.s"
	
	.macro ERRNO dest
	mov	r1,-(sp)
	mov	curtcb,r1
	mov	@TCB.TASKTUCB(r1),r1
	mov	TUCB.T_ERRNO(r1),\dest
	mov	(sp)+,r1
	.endm

