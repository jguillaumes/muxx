	.TITLE	Copy trap frame to current CPU state area
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	.INCLUDE "MACLIB.s"
	
	.global _copytrapfp,_restoretrapf
	.global _copyMMUstate,_restoreMMUstate 

	
_copytrapfp:
	mov	2(sp),r1		// No stack frame based on R5

	mov	_curtcb,r0

	mov	2(r1),TCB.R5(r0)
	mov	4(r1),TCB.R4(r0)
	mov	6(r1),TCB.R3(r0)
	mov	8(r1),TCB.R2(r0)
	mov	10(r1),TCB.R1(r0)
	mov	12(r1),TCB.R0(r0)
	mov	14(r1),TCB.PC(r0)	// PC
	mov	16(r1),TCB.PSW(r0)	// PSW
	add	$14,r1			// Initial SP
	mov	r1,TCB.SP(r0)
	
	mov	CPU.PSW,-(sp)
	bis	$0b0011000000000000,CPU.PSW // Set previous mode to user
	mfpd	sp			// Get user mode SP onto stack
	mov	(sp)+,TCB.USP(r0)	// Extract USP and save it

	.ifc	CPU_HAS_SUPER,"1"
	bic	$0b0010000000000000,CPU.PSW // Set previous mode to super
	mfpd	r6
	mov	(sp)+,TCB.SSP(r0)
	.endif

	mov	TCB.SP(r0),TCB.KSP(r0)	// Copy KSP from saved SP
	mov	(sp)+,CPU.PSW

	// jsr	pc,_muxx_dumpctcb
	
	rts	pc

	/*
	** Copy the MMU state
	** Currently we don't use separated I/D spaces
	** so we just handle the instruction space
	**
	*/
_copyMMUstate:
	procentry saver3=no,saver4=no
	
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
	
	procexit getr3=no,getr4=no
	
	.END
