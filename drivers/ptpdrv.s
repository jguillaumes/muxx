	.TITLE ptpdrv - Paper Tape driver
	.IDENT "V01.00"

	.global _ptpdesc
	.INCLUDE "ERRNO.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXXDEF.s"
	
	ERROR = 0100000
	BUSY  = 0004000
	DONE  = 0000200
	READY = 0000200
	EINT  = 0000100
	ENAB  = 0000001

	.text

_ptpdesc:
	mov	$ptpdesct,r0
	rts	pc

ptpopen:
	clc
	clr	r0
	rts	pc

ptpclose:
	clc
	clr	r0
	rts	pc

ptpread:
	procentry saver2=no,saver3=no,saver4=no
	mov	4(r5),r1
	cmp	IOP_SIZE(r1),$1
	beq	5$
	mov	$EINVVAL,r0
	sec
	br	999$
5$:	clc
	mov	PTP.PRS,r0
	bit	$ERROR,r0
	beq	10$
	mov	$ERRDEV,r0
	sec
	br	999$
10$:	bis	$ENAB,PTP.PRS
20$:	bit	$DONE,PTP.PRS
	beq	20$
	mov	PTP.PRB,IOP_IOAREA(r1)
999$:	procexit getr2=no,getr3=no,getr4=no
	
ptpwrite:
	procentry saver3=no,saver4=no
	mov	4(r5),r2
	cmp	IOP_SIZE(r1),$2
	beq	5$
	mov	$EINVVAL,r0
	sec
	br	999$
5$:	clc
	mov	PTP.PPS,r1
	bit	$ERROR,r1
	beq	10$
	mov	$ERRDEV,r0
	sec
	br	999$
10$:	bit	$READY,PTP.PPS
	beq	10$
	movb	IOP_IOAREA(r2),PTP.PPB
999$:	mov	r1,r0
	procexit getr3=no,getr4=no


ptpstart:
ptpstop:
ptpquery:	
ptpioctl:	
	mov	$ENOIMPL,r0
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
	.WORD	0
	.ASCII  "PT      "
	.WORD	2
	.WORD	ptpisr,PTP.RVEC,PTP.PL
	.WORD	ptpisr,PTP.PVEC,PTP.PL
	.WORD	0
	.end
