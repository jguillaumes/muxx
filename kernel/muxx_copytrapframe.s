	.TITLE	Copy trap frame to current CPU state area
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	
	.global _copytrapf,_restoretrapf

_copytrapf:
	mov	_curtcb,r0
	add	$TCB.CPUSTATE,r0
	mov	8(r5),(r0)		// R0
	mov	6(r5),2(r0)		// R1
	mov	-2(r5),4(r0)		// R2
	mov	-4(r5),6(r0)		// R3
	mov	-6(r5),8(r0)		// R4
	mov	-8(r5),10(r0)		// R5
	mov	4(r5),12(r0)		// SP+4
	add	$-4,12(r0)		// Adjust SP
	mov	10(r5),14(r0)		// PC
	mov	12(r5),16(r0)		// PSW
	mov	CPU.PSW,-(sp)
	bis	$0b0011000000000000,CPU.PSW // Set previous mode to user
	mfpi	sp		// Get user mode SP onto stack
	mov	(sp)+,18(r0)	// Extract USP and save it
	bic	$0b0010000000000000,CPU.PSW // Set previous mode to super
	mfpi	r6
	mov	(sp)+,20(r0)
	mov	12(r0),22(r0)	// Copy KSP from saved SP
	mov	(sp)+,CPU.PSW
	rts	pc


_restoretrapf:
	mov	_curtcb,r0
	add	$TCB.CPUSTATE,r0
	halt
	bis	$0b0011000000000000,CPU.PSW // Set previous mode to user
	mov	18(r0),-(sp)
	mtpi	sp		// 
	bic	$0b0010000000000000,CPU.PSW // Set previous mode to super
	mov	20(r0),-(sp)
	mtpi	r6
	
	mov	2(r0),r1
	mov	4(r0),r2
	mov	6(r0),r3
	mov	8(r0),r4
	mov	10(r0),r5
	mov	12(r0),sp
	mov	14(r0),(sp)
	mov	16(r0),2(sp)
	mov	(r0),r0
	halt
	rti


	.END

	