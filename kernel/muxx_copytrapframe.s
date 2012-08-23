	.TITLE	Copy trap frame to current CPU state area
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	.INCLUDE "MACLIB.s"
	
	.global _copytrapf,_copytrapfp,_restoretrapf
	.global _copyMMUstate,_restoreMMUstate 

_copytrapfp:
	mov	2(sp),r5

_copytrapf:
	mov	_curtcb,r0
	add	$TCB.CPUSTATE,r0

	mov	8(r5),(r0)		// R0
	mov	6(r5),2(r0)		// R1
	mov	-2(r5),4(r0)		// R2
	mov	-4(r5),6(r0)		// R3
	mov	-6(r5),8(r0)		// R4
	mov	-8(r5),10(r0)		// R5
	mov	r5,12(r0)
	add	$10,12(r0)		// SP
	mov	10(r5),14(r0)		// PC
	mov	12(r5),16(r0)		// PSW

	mov	CPU.PSW,-(sp)
	bis	$0b0011000000000000,CPU.PSW // Set previous mode to user
	mfpd	sp		// Get user mode SP onto stack
	mov	(sp)+,18(r0)	// Extract USP and save it

	.ifc	CPU_HAS_SUPER,"1"
	bic	$0b0010000000000000,CPU.PSW // Set previous mode to super
	mfpd	r6
	mov	(sp)+,20(r0)
	.endif

	mov	12(r0),22(r0)	// Copy KSP from saved SP
	mov	(sp)+,CPU.PSW
	rts	pc

	/*
	** Copy the MMU state
	** Currently we don't use separated I/D spaces
	** so we just handle the instruction space
	**
	*/
_copyMMUstate:
	procentry
	mov	_curtcb,r0			// Copy user PARs
	add	$TCB.MMUSTATE,r0

	mov	$MMU.UISAR0,r1
	mov	$8,r2
10$:	mov	(r1)+,(r0)+
	sob	r2,10$

	mov	$MMU.UISDR0,r1			// Copy USER PDRs
	mov	$8,r2
20$:	mov	(r1)+,(r0)+
	sob	r2,20$

	.ifc	CPU_HAS_SUPER,"1"
	mov	$MMU.SISAR0,r1			// Copy super PARs
	mov	$8,r2
30$:	mov	(r1)+,(r0)+
	sob	r2,30$

	mov	$MMU.SISDR0,r1			// Copy super PDRs
	mov	$8,r2
40$:	mov	(r1)+,(r0)+
	sob	r2,40$
	.endif
	
	mov	$MMU.KISAR0,r1			// Copy kernel PARs
	mov	$8,r2
50$:	mov	(r1)+,(r0)+
	sob	r2,50$

	mov	$MMU.KISDR0,r1			// Copy kernel PDRs.
	mov	$8,r2
60$:	mov	(r1)+,(r0)+
	sob	r2,60$
	procexit
	
	.END
