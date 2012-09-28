
	.NOLIST
	
	.macro push reg
	mov	/reg,-(sp)
	.endm

	.macro pop reg
	mov	(sp)+,reg
	.endm

	/*
	** Procedure call frame setup
	*/
	.macro procentry saver2=yes,saver3=yes,saver4=yes,local=0
	mov	r5,-(sp)		// Save previous frame pointer
	mov	sp,r5			// Set up current frame pointer
	.ifgt \local
	sub	$2*\local,sp		// Allocate space for local variables
	.endif
	.ifc	\saver2,yes
	mov 	r2,-(sp)		// Push the GPRs...
	.endif
	.ifc	\saver3,yes
	mov	r3,-(sp)		//
	.endif
	.ifc	\saver4,yes
	mov	r4,-(sp)		//
	.endif
	mov	r5,-(sp)		// Push the current FP 
	.endm

	/*
	** Procedure clenaup and exit
	*/
	.macro procexit getr2=yes,getr3=yes,getr4=yes,local=0
	mov	(sp)+,r5		// Pull the current Frame Pointer
	.ifc	\getr4,yes
	mov	-2*\local-6(r5),r4	// Pull the saved GPRs, 
	.endif
	.ifc	\getr3,yes
	mov	-2*\local-4(r5),r3	// relative to the frame pointer
	.endif
	.ifc	\getr2,yes
	mov	-2*\local-2(r5),r2
	.endif
	mov	r5,sp			// Cleanup local variables/saved GPRs
	mov	(sp)+,r5		// Pull the previous frame pointer
	rts	pc		 	// Return to caller
	.endm


	/*
	** Interrupt/trap handler wrapper
	*/
	.macro traphandle handler,saveall=yes
	.ifc	\saveall,yes
	mov	r0,-(sp)		// Push R0
	mov	r1,-(sp)		// Push R1
	.else
	.ifnc	\saveall,no
	.error	"saveall must be yes or no. Default is yes"
	.else
	clr	-(sp)			// Space to keep offsets right
	clr	-(sp)			// Space to keep offsets right
	.endif
	.endif
	mov	r2,-(sp)		// Push R1
	mov	r3,-(sp)		// Push R1
	mov	r4,-(sp)		// Push R1
	mov	r5,-(sp)		// Push 1R
	mov	sp,-(sp)		// Push current SP...
	jsr	pc,\handler		// Call the real handler
	add	$2,sp			// Toss FP in stack 
	mov	(sp)+,r5		// Pull R5
	mov	(sp)+,r4		// Pull R4
	mov	(sp)+,r3		// Pull R3
	mov	(sp)+,r2		// Pull R2
	.ifc	\saveall,yes
	mov	(sp)+,r1		// Pull R1
	mov	(sp)+,r0		// Pull R0
	.else
	add	$4,sp			// Close space
	.endif
	.endm	
		
	.LIST
