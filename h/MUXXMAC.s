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

	.macro	LOADPRC name,type,file,privs
	sub	$10,sp			// Room for 4 members parmlist
	mov	$4,(sp)			// size = 4
	mov	\privs,2(sp)
	mov	\file,4(sp)
	mov	\type,6(sp)
	mov	\name,8(sp)
	mov	sp,r0
	trap	$SRV_LOADPRC
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
	
	/*
	** Allocate or release a MUTEX
	** mutex: mutex number
	** op: operation: MUT_READ, MUT_ALLOC, MUT_DEALLOC
	*/
	.macro MUTEX mutex,op=MUT_READ
	sub	$6,sp
	mov	$2,(sp)
	mov	\op,2(sp)
	mov	\mutex,4(sp)
	mov	sp,r0
	trap	$SRV_MUTEX
	add	$6,sp
	.endm

	/*
	** Allocate or release a device
	** devnam: device driver name
	** op: operation: DRV_ALLOC, DRV_DEALLOC
	*/
	.macro ALLOC devnam,op
	sub	$6,sp
	mov	$2,(sp)
	mov	\op,2(sp)
	mov	\devnam,4(sp)
	mov	sp,r0
	trap	$SRV_ALLOC
	add	$6,sp
	.endm

	.macro OPEN devnam,flags=OO_READ
	sub	$6,sp
	mov	$2,(sp)
	mov	\flags,2(sp)
	mov	\devnam,4(sp)
	mov	sp,r0
	trap	$SRV_OPEN
	add	$6,sp
	.endm

	.macro CLOSE fd
	sub	$4,sp
	mov	$1,(sp)
	mov	\fd,2(sp)
	mov	sp,r0
	trap	$SRV_CLOSE
	add	$4,sp
	.endm

	.macro	DRVSTART drvname
	sub	$4,sp
	mov	$1,(sp)
	mov	\drvname,2(sp)
	mov	sp,r0
	trap	$KRN_DRVSTART
	add	$4,sp
	.endm

	.macro	DRVSTOP drvcb
	sub	$4,sp
	mov	$1,(sp)
	mov	\drvcb,2(sp)
	mov	sp,r0
	trap	$KRN_DRVSTOP
	add	$4,sp
	.endm

	.macro	WRITE iote,size,buffer
	sub	$8,sp
	mov	$3,(sp)
	mov	\buffer,2(sp)
	mov	\size,4(sp)
	mov	\iote,6(sp)
	mov	sp,r0
	trap	$SRV_WRITE
	add	$8,sp
	.endm
	
	.macro	READ iote,size,buffer
	sub	$8,sp
	mov	$3,(sp)
	mov	\buffer,2(sp)
	mov	\size,4(sp)
	mov	\iote,6(sp)
	mov	sp,r0
	trap	$SRV_READ
	add	$8,sp
	.endm

	.macro XCOPY srcpid=0, srcaddr, dstpid=0, dstaddr, size
	sub	$12,sp
	mov	$5,(sp)
	mov	\size,2(sp)
	mov	\dstaddr,4(sp)
	mov	\dstpid,6(sp)
	mov	\srcaddr,8(sp)
	mov	\srcpid,10(sp)
	mov	sp,r0
	trap	$KRN_XCOPY
	add	$12,sp
	.endm
	
	.LIST
