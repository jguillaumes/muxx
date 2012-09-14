	.NOLIST

	/*
	** Halt the system
	** The calling task must be privileged
	*/
	.macro SYSHALT
	clr	r0
	trap	$KRN_HALT
	.endm

	/*
	** Yield the processor and return the current task to the ready queue
	*/
	.macro	YIELD
	clr	r0
	trap	$SRV_YIELD
	.endm

	/*
	** Write a character upon console
	** char: character to output
	*/
	.macro	CONPUTC char
	sub	$4,sp			// Make space for parmlist
	mov	$1,(sp)			// Number of parameters
	movb	\char,2(sp)		// Character value
	mov	sp,r0			// R0 => Parmlist
	trap	$KRN_PUTCON		// Do it!
	add	$4,sp			// Cleanup stack
	.endm

	.macro	CONGETC addr
	sub	$4,sp			// Make room for parmlist
	mov	$1,(sp)			// Number of parameters
	mov	\addr,2(sp)		// Address of read char
	mov	sp,r0			// R0 => Parmlist
	trap	$KRN_GETCON		// Do it!
	add	$4,sp			// cleanup stack
	.endm

	/*
	** Create Process
	** name:  Process name (8 bytes)
	** type:  TSK_SYSTEM or TSK_USER
	** entry: Initial entry point for the new task
	** privs: Privileges bitmap
	*/
	.macro	CREPRC name,type,entry,privs
	sub	$10,sp			// Room for 4 members parmlist
	mov	$4,(sp)			// size = 4
	mov	\privs,2(sp)
	mov	\entry,4(sp)
	mov	\type,6(sp)
	mov	\name,8(sp)
	mov	sp,r0
	trap	$SRV_CREPRC
	add	$10,sp
	.endm

	/*
	** Get Task-Process information
	** pid: PID of the task top query, or zero for own task
	** tcb: Address of a TCB-sized memory area to copy the queried TCB
	*/
	.macro GETTPI pid,tcb
	sub	$6,sp
	mov	$2,(sp)
	mov	\tcb,2(sp)
	mov	\pid,4(sp)
	mov	sp,r0
	trap	$SRV_GETTPI
	add	$6,sp
	.endm

	/*
	** Suspend a task and add it to the suspended task queue
	** tcb: Task to suspend
	**      Must be owned by the same UIC as the caller, or
	**      called by a privileged task.
	*/
	.macro SUSPEND tcb
	sub	$4,sp			// Room for parmlist
	mov	$1,(sp)			// Size = 1
	tst	\tcb			// null pointer?
	bne	10$			// No, use its value
	mov	_curtcb,2(sp)
	br	20$
10$:	mov	\tcb,2(sp)
20$:	mov	sp, r0
	trap	$SRV_SUSPEND
	add	$4,sp
	.endm

	/*
	** Register a device driver
	** name: Device driver name (8 characters)
	** desc: Address of the DRVDESC structure for the driver
	** handler: PID of the handler server process
	*/
	.macro DRVREG name,desc,handler
	sub	$8,sp			// Room for 3 parms
	mov	$3,(sp)			// Size = 3
	mov	\handler,2(sp)
	mov	\desc,4(sp)
	mov	\name,6(sp)
	mov	sp,r0			// R0: Parmlist
	trap	$KRN_DRVREG
	add	$8,sp
	.endm

	/*
	** Normally terminate a process
	** rcode: return code 
	*/
	.macro EXIT rcode
	sub	$4,sp
	mov	$1,(sp)
	mov	\rcode,2(sp)
	mov	sp,r0
	trap	$SRV_EXIT
	add	$4,sp
	.endm
	
	/*
	** Abnormally terminate a process
	** rcode: return code 
	*/
	.macro ABORT rcode
	sub	$4,sp
	mov	$1,(sp)
	mov	\rcode,2(sp)
	mov	sp,r0
	trap	$SRV_EXIT
	add	$4,sp
	.endm
	
	.macro MUTEX mutex,op=MUT_READ
	sub	$6,sp
	mov	$2,(sp)
	mov	\op,2(sp)
	mov	\mutex,4(sp)
	mov	sp,r0
	trap	$SRV_MUTEX
	add	$6,sp
	.endm

	.macro ALLOC devnam,op
	sub	$6,sp
	mov	$2,(sp)
	mov	\op,2(sp)
	mov	\devnam,4(sp)
	mov	sp,r0
	trap	$SRV_ALLOC
	add	$6,sp
	.endm
	
	.LIST
