	.TITLE crt0 - user task entry point/block
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXX.s"
	
	.GLOBAL start,_heapb,_heapt,_endcode,_toptask,___main

	PAGESIZE   = 8192
	ETASKSMALL = PAGESIZE * 4
	ETASKMED   = PAGESIZE * 5
	ETASKBIG   = PAGESIZE * 6

	/*
	** The start point is 0060000
	** The symbol start must be just at that address
	*/
start:
	br	_start_task
	/*
	** Task prefix block (TPB)
	*/
_heapb:	.WORD	_end
_heapt:	.WORD	0
_endcode:
	.WORD	0
_toptask:
	.WORD	0
_tiot:	.SPACE  (IOT_SIZE * IOT_ENTRIES)
	
	.align 6
	/*
	** main() invocation.
	** No line command parameters nor environment supported
	** at this point...
	*/
_start_task:
	mov	_curtcb,r0
	mov	TCB.TASKTYPE(r0),r1
	bic	$0177707,r1
	cmp	r1,$TSZ_SMALL
	bne	10$
	mov	$ETASKSMALL, _toptask
	mov	$_end,_endcode
	br	999$

10$:	cmp	r1,$TSZ_MED
	bne	20$
	mov	$ETASKMED,_toptask
	br	999$

20$:	mov	$ETASKBIG,_toptask
	
999$:	mov	$0,-(sp)	// Null envp
	mov	$0,-(sp)	// Null argv
	mov	$0,-(sp)	// Zero argc
	jsr	pc,_main	// Execute main()
	add	$6,sp
	EXIT	r0		// EXIT syscall

___main:			// Do-nothing ___main() to make gcc happy
	rts	pc
	
	.end
