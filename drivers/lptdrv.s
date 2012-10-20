	.TITLE lptdrv - Line Printer driver
	.IDENT "V01.00"

	.global _lptdesc
	.INCLUDE "ERRNO.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXX.s"
	
	ERROR = 0100000
	BUSY  = 0004000
	DONE  = 0000200
	EINT  = 0000100
	ENAB  = 0000001

	.text

_lptdesc:
	mov	$lptdesct,r0
	clc
	rts	pc

lptopen:
	clc
	clr	r0
	rts	pc

lptclose:
	clc
	clr	r0
	rts	pc

	/*
	** Read a byte: not supported
	*/
lptread:
	procentry saver2=no,saver3=no,saver4=no
30$:	mov	$ENOTSUP,r0
900$:	sec				// Error => Carry set
	mov	r0,IOPKT.ERROR(r1)	// Copy error code to IOPK

999$:	procexit getr2=no,getr3=no,getr4=no

	/*
	** Print a byte
	*/
lptwrite:
	procentry saver2=no,saver3=no,saver4=no
	mov	4(r5),r1		// R2: IOPK address
	cmp	IOPKT.SIZE(r1),$1	// Check size (must be one)
	beq	5$			
	mov	$EINVVAL,r0		// Prepare error code		
	br	900$
	
5$:	clc				// Carry clear: OK

10$:	bit	$(ERROR+DONE),LPT.LPS	// Check device ready/error
	beq	10$			// Not ready/error: repeat
	bit	$ERROR,LPT.LPS		// Check error status
	beq	dowrite			// No error, then we arew ready
	mov	$ERRDEV,r0		// Error: prepare error code
	br	900$
	
dowrite:
	movb	IOPKT.IOAREA(r1),LPT.LPB // Send byte to device
	mov	$1,r0			 // 1 written byte
	br	999$
	
900$:	sec
	mov	r0,IOPKT.ERROR(r1)	// Copy error code to IOPK	

999$:	
	procexit getr2=no,getr3=no,getr4=no

lptflush:
	clc
	clr	r0
	rts	pc


lptstart:
	clc
	clr	r0
	rts	pc
	
lptstop:
lptquery:	
lptioctl:	
lptseek:	
	mov	$ENOIMPL,r0
	sec
	rts	pc
	
lptisr:
	rti
	
	.data
lptdesct:
	.WORD	lptstart
	.WORD	lptstop
	.WORD	lptopen
	.WORD	lptclose
	.WORD	lptread
	.WORD	lptwrite
	.WORD	lptioctl
	.WORD   lptquery
	.WORD	lptseek
	.WORD	lptflush
	.WORD	0			// Flags
	.ASCII  "LP      "
	.WORD	1			// Default buffer size
	.WORD	1			// Number of ISRs
	.WORD	lptisr,LPT.LPVEC,LPT.PL
	.WORD	0
	.end
