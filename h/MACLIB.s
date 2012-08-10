
	.NOLIST
	
	.macro push reg
	mov	/reg,-(sp)
	.endm

	.macro pop reg
	mov	(sp)+,reg
	.endm

	.macro procentry numregs=4,local=0,trap=no
	;	// Prologue
	mov	r5,-(sp)
	mov	sp,r5
	.ifgt	\local
	sub	$\local,sp
	.endif
	.ifgt	\numregs
	mov	r1,-(sp)
	.ifgt	\numregs - 1
	mov	r2,-(sp)
	.ifgt	\numregs - 2
	mov	r3,-(sp)
	.ifgt	\numregs - 3
	mov	r4,-(sp)
	.ifgt	\numregs - 4
	.error	"The upper limit for the number of pushed regs is 4"
	.endif
	.endif
	.endif
	.endif
	.endif
	.ifc	\trap,yes
	mov	r0,-(sp)
	.endif
	mov	r5,-(sp)
	.endm

	.macro cleanup numregs=4,trap=no
	;	// Epilogue
	mov	(sp)+,r5
 	.ifc	\trap,yes
	mov	(sp)+,r0
	.endif
	.ifgt	\numregs - 4
	.error	"The upper limit for the number of pushed regs is 4"
	.else
	.ifgt	\numregs - 3
	mov	(sp)+,r4
	.endif
	.ifgt	\numregs - 2
	mov	(sp)+,r3
	.endif
	.ifgt	\numregs - 1
	mov	(sp)+,r2
	.endif
	.ifgt	\numregs
	mov	(sp)+,r1
	.endif
	.endif
	mov	r5,sp
	mov	(sp)+,r5
	.endm


	/*
	** Copy state of processor to specified area
	**
	** This macro has to be called just at the entry of a procedure
	** or interrupt/trap handler, AFTER invoking the macro procentry
	** (use the default numregs or specify numregs=4)
	**
	** It will not overwrite any register, nor will modify the stack.
	** (Actually, it does both things, but cleans itself before the
	** end.
	**
	** The macro disables the interrupts while it is performing
	** the copy. At the end it restores the PSW, so the PL will be set
	** at the same level as at the entry.
	**
	** Stack/Frame the macro assumes:
	**
	**     [+4	PSW	(Just after trap/interrupt) ]
	**	+2	PC	(Return address)
	**	R5 =>	R5	(Previous R5)
	**	-2	R1	
	**	-4	R2
	**	-6	R3
	**	-8	R4
	**    [-10	R0	(Just if procentry with trap=yes) ]
	**     -10/12	R5	(Current FP)
	**     -12/14	SP-2	(SP after pushing R5)
	*/
	
	.macro copyregs dest,type=trap
	mov	CPU.PSW,-(sp)	// Push current PSW
	mov	$7,-(sp)	
	jsr	pc,_setpl	// No interrupts
	add	$2,sp
	mov	r0,-(sp)	// Push current R0 to use it
	mov	\dest,r0	// R5 => Save area
	.ifc	\type,trap
	mov	-10(r5),(r0)	// Save R0
	.else
	mov	(sp),(r0)	// Save R0
	.endif
	mov	-2(r5),2(r0)	// Save R1
	mov	-4(r5),4(r0)	// Save R2
	mov	-6(r5),6(r0)	// Save R3
	mov	-8(r5),8(r0)	// Save R4
	mov	(r5),10(r0)	// Save R5
	.ifc	\type,trap
	mov	r5,12(r0)	// Save old current SP...
	.else
	mov	r5,12(r0)	// Save old current SP...
	.endif
	add	$2,12(r0)	// ... adjusting it 
	mov	2(r5),14(r0)	// Save PC

	.ifc \type,trap
	mov	4(r5),16(r0)	// Save PSW from stack
	.else
	.ifc \type,call
	mov	CPU.PSW,16(r0)	// Save current PSW
	.else
	.error "Type must be trap or call. Default value is trap"
	.endif
	.endif

	/*
	** Kludge to access the other modes SP.
	** It is assumed this macro will be called in kernel mode.
	** If it is called in user/super mode BAD THINGS will happen.
	*/
	mov	r1,-(sp)
	mov	CPU.PSW,r1	// R0: Current PSW
	bis	$0b0011000000000000,r1	// Set previous mode to user
	mov	r1,CPU.PSW
	mfpi	r6		// Get user mode SP onto stack
	mov	(sp)+,18(r0)	// Extract USP and save it

	bic	$0b0010000000000000,r1	// Set previous mode to super
	mov	r1,CPU.PSW
	mfpi	r6
	mov	(sp)+,20(r0)

	bic	$0b0001000000000000,r1	// Set previous mode to kernel
	mov	r1,CPU.PSW
	mfpi	r6
	mov	(sp)+,22(r0)
	mov	(sp)+,r1
	/*
	** Final cleanup
	*/
	mov	(sp)+,r0	// Pop saved R0
	mov	(sp)+,CPU.PSW	// Pop PSW, maybe reenable interrupts
	.endm

	.macro	savecputask
	mov	r1,-(sp)
	mov	_curtcb,r1
	add	$TCB.CPUSTATE,r1
	copyregs dest=r1,type=trap
	mov	(sp)+,r1
	.endm

	.LIST
