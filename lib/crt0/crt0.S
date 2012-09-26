	.TITLE crt0 - user task entry point/block
	.IDENT "V01.00"

	#include  "CONFIG.s"
	#include  "MUXXMAC.s"
	#include  "MUXXDEF.s"
	#include  "MUXX.s"
	
	.GLOBAL start,_heapb,_heapt,_endcode,_toptask,___main

	PAGESIZE   = 8192
	ETASKSMALL = PAGESIZE * 4
	ETASKMED   = PAGESIZE * 5
	ETASKBIG   = PAGESIZE * 6

#define	TUCB_ADJSIZE 64
	
	/*
	** The start point is 0060000
	** The symbol start must be just at that address
	*/
start:
	mov	_curtcb,r0
	mov	TCB.TASKTUCB(r0),r1

	mov	$(TUCB_ADJSIZE),r2
10$:	clr	(r1)+
	sob	r2,10$

	mov	TCB.TASKTUCB(r0),r1
	mov	r1,TUCB.TOPTASK(r1)
	mov	$_end,TUCB.ENDCODE(r1)

999$:	mov	$0,-(sp)	// Null envp
	mov	$0,-(sp)	// Null argv
	mov	$0,-(sp)	// Zero argc
	jsr	pc,_main	// Execute main()
	add	$6,sp
	EXIT	r0		// EXIT syscall

___main:			// Do-nothing ___main() to make gcc happy
	rts	pc
	
	.end
