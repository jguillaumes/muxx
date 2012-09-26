	.TITLE ptpdrv - Paper Tape driver
	.IDENT "V01.00"

	.global _ptpdesc
	.INCLUDE "ERRNO.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXX.s"
	
	ERROR = 0100000
	BUSY  = 0004000
	DONE  = 0000200
	READY = 0000200
	EINT  = 0000100
	ENAB  = 0000001

	.text

_ptpdesc:
	mov	$ptpdesct,r0
	clc
	rts	pc

ptpopen:
	clc
	clr	r0
	rts	pc

ptpclose:
	clc
	clr	r0
	rts	pc

	/*
	** Read a byte from punched tape reader
	*/
ptpread:
	procentry saver2=no,saver3=no,saver4=no
	mov	4(r5),r1		// R1: IOPKT address
	cmp	IOPKT.SIZE(r1),$1		// Buffer size must be one
	beq	5$
	mov	$EINVVAL,r0		// Error: Invalid value
	br	900$

5$:	clc				// Carry clear: OK
	mov	PTP.PRS,r0		// R0: Paper Reader Status Register
	bit	$ERROR,r0		// Error in dev?
	beq	10$			// No: go on
	mov	$ERRDEV,r0		// Prepare error code
	br	900$

10$:	bis	$ENAB,PTP.PRS		// Enable reader
20$:	bit	$(DONE+ERROR),PTP.PRS	// Check done or error
	beq	20$			// No: try again
	bit	$ERROR,PTP.PRS		// Error?
	bne	readok			// No: then read OK
	mov	$ERRDEV,r0		// Yes: prepare error code
	br	900$
	
readok:	movb	PTP.PRB,IOPKT.IOAREA(r1)	// Move read byte to buffer
	br	999$			// Anhd exit

900$:	sec				// Error => Carry set
	mov	r0,IOPKT.ERROR(r1)	// Copy error code to IOPK

999$:	procexit getr2=no,getr3=no,getr4=no

	/*
	** Punch a byte
	*/
ptpwrite:
	procentry saver3=no,saver4=no
	mov	4(r5),r2		// R2: IOPK address
	cmp	IOPKT.SIZE(r2),$2		// Check size (must be one)
	beq	5$			
	mov	$EINVVAL,r0		// Prepare error code		
	br	900$
	
5$:	clc				// Carry clear: OK

10$:	bit	$(READY+ERROR),PTP.PPS	// Check device ready/error
	beq	10$			// Not ready/error: repeat
	bit	$ERROR,PTP.PPS		// Check error status
	beq	dowrite			// No error, then we arew ready
	mov	$ERRDEV,r0		// Error: prepare error code
	br	900$
	
dowrite:	
	movb	IOPKT.IOAREA(r2),PTP.PPB
	br	999$
	
900$:	sec
	mov	r0,IOPKT.ERROR(r2)	// Copy error code to IOPK	

999$:	mov	r1,r0
	procexit getr3=no,getr4=no

ptpflush:
	clc
	clr	r0
	rts	pc


ptpstart:
	clc
	clr	r0
	rts	pc
	
ptpstop:
ptpquery:	
ptpioctl:	
ptpseek:	
	mov	$ENOIMPL,r0
	sec
	rts	pc
	
ptpisr:
	rti
	
	.data
ptpdesct:
	.WORD	ptpstart
	.WORD	ptpstop
	.WORD	ptpopen
	.WORD	ptpclose
	.WORD	ptpread
	.WORD	ptpwrite
	.WORD	ptpioctl
	.WORD   ptpquery
	.WORD	ptpseek
	.WORD	ptpflush
	.WORD	0			// Flags
	.ASCII  "PT      "
	.WORD	0			// Default buffer size
	.WORD	2			// Number of ISRs
	.WORD	ptpisr,PTP.RVEC,PTP.PL
	.WORD	ptpisr,PTP.PVEC,PTP.PL
	.WORD	0
	.end
