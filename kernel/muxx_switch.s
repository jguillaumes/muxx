	.TITLE switchcontext - full switch to new task
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	.INCLUDE "MUXXDEF.s"

	
	.GLOBAL _muxx_switch
	
_muxx_switch:

//	jsr	pc,_muxx_dumpctcb
	mov	_curtcb,r0		// R0: Current TCB

	mov	TCB.R1(r0),r1		// Set GPRS 1 to 6
	mov	TCB.R2(r0),r2
	mov	TCB.R3(r0),r3
	mov	TCB.R4(r0),r4
	mov	TCB.R5(r0),r5

	mov	TCB.KPAR6(r0),MMU.KISAR6 // Set up kernel stack page
	mov	TCB.UPAR6(r0),MMU.UISAR6 // Set up usermode stack page
	mov	TCB.KPDR6(r0),MMU.KISDR6
	mov	TCB.UPDR6(r0),MMU.UISDR6

	.ifc	CPU_HAS_SUPER,"1"
	mov	TCB.SSAR6(r0),MMU.SISAR6 // Set up supervisor stack page
	mov	TCB.SPDR6(r0),MMU.SISDR6
	.endif

	mov	TCB.KSP(r0),sp		// Switch to dest kernel stack

	
	cmp	TCB.STATUS(r0),$TSK_INIT	// Init state?
	bne	5$			// No: Address already in stack
	
	mov	TCB.PSW(r0),-(sp)	// Push return PSW
	mov	TCB.PC(r0),-(sp)	// Push return PC

5$:	mov	$TSK_RUN,TCB.STATUS(r0)	// New task status	
	
	mov	CPU.PSW,-(sp)		// Set up USP
	mov	$0x30E0,CPU.PSW
	mov	TCB.USP(r0),-(sp)
	mtpd	sp
	mov	(sp)+,CPU.PSW

	.ifc	CPU_HAS_SUPER,"1" 
	mov	CPU.PSW,-(sp)		// Set up SSP (if configured)
	mov	$0x10E0,CPU.PSW
	mov	TCB.SSP(r0),-(sp)
	mtpd	sp
	mov	(sp)+,CPU.PSW
	.endif


	mov	r3,-(sp)		// Preserve r3
	mov	r2,-(sp)		// Preserve r2
	mov	r1,-(sp)		// Preserve r1
	mov	TCB.R0(r0),-(sp)	// Set content of r0
	mov	r0,r3			// R3: Current TCB
	
	mov	r3,r0
	mov	$MMU.UISAR0,r1
	mov	$8,r2
10$:	mov	TCB.UPAR(r0),(r1)+
	add	$2,r0
	sob	r2,10$

	mov	r3,r0			// R0: Current TCB
	mov	$MMU.UISDR0,r1		// Copy USER PDRs
	mov	$8,r2
20$:	mov	TCB.UPDR(r0),(r1)+
	add	$2,r0
	sob	r2,20$

	.ifc	CPU_HAS_SUPER,"1"
	mov	r3,r0			// R0: Current TCB
	mov	$MMU.SISAR0,r1		// Copy super PARs
	mov	$8,r2
30$:	mov	TCB.SPAR(r0),(r1)+
	add	$2,r0
	sob	r2,30$

	mov	r3,,r0			// R0: Current TCB
	mov	$MMU.SISDR0,r1		// Copy super PDRs
	mov	$8,r2
40$:	mov	TCB.SPDR(r0),(r1)+
	add	$2,r0
	sob	r2,40$
	.endif

	mov	r3,r0			// R0: Current TCB
	mov	$MMU.KISAR0,r1		// Copy kernel PARs
	mov	$8,r2
50$:	mov	TCB.KPAR(r0),(r1)+
	add 	$2,r0
	sob	r2,50$

	mov	r3,r0			// R0: Current TCB
	mov	$MMU.KISDR0,r1		// Copy kernel PDRs.
	mov	$8,r2
60$:	mov	TCB.KPDR(r0),(r1)+
	add	$2,r0
	sob	r2,60$

	// sr	pc,_muxx_dumpctcb

	mov	(sp)+,r0		// Recover R0
	mov	(sp)+,r1		// Recover R1
	mov	(sp)+,r2		// Recover R2
	mov	(sp)+,r3		// Recover R3
	rti				// Return from interrupt

	.end
