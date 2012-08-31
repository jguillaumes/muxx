	.TITLE ptpdrv - Paper Tape driver
	.IDENT "V01.00"

	.global _ptpdesc

	.text

_ptpdesc:
	mov	$ptpdesct,r0
	rts	pc

ptpopen:
	clr	r0
	rts	pc


ptpclose:
	clr	r0
	rts	pc

ptpread:
	mov	$ENOIMPL,r0
	rts	pc

ptpwrite:
	mov	$ENOIMPL,r0
	rts	pc

ptpstart:
ptpstop:
ptpquery:	
	mov	$ENOIMPL,r0
	rts	pc
	
ptpisr:
	rti
	
	.data
ptpdesct:
	.WORD	$ptpstart
	.WORD	$ptpstop
	.WORD	$ptpopen
	.WORD	$ptpclose
	.WORD	$ptpread
	.WORD	$ptpwrite
	.WORD	$ptpioctl
	.WORD   $ptpquery
	.WORD	2
	.WORD	.ptpisr,$PTP.RVEC,$PTP.PL
	.WORD	.ptpisr,$PTP.PVEC,$PTP.PL
	.WORD	0
	.end
