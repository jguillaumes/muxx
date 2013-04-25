	.TITLE startup: System startup task
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MUXXDEF.s"
	
	.GLOBAL _init
	
	.text

_init:
	CREPRC 	$NPTPHND,$DRV_TASK,$_ptphnd,$TSK_IOPRV
	mov	r0,r3
	clr	r3
	jsr	pc,_ptpdesc
	mov	r0,r2
	DRVREG 	$NPTPDRV,r2,r3
	tst	r0
	bmi	error1
	DRVSTART $NPTPDRV
	tst	r0
	bmi	error2
	
	CREPRC 	$NLPTHND,$DRV_TASK,$_lpthnd,$TSK_IOPRV
	mov	r0,r3
	clr 	r3
	jsr	pc,_lptdesc
	mov	r0,r2
	DRVREG	$NLPTDRV,r2,r3
	tst	r0
	bmi	error3
	DRVSTART $NLPTDRV
	tst	r0
	bmi	error4
	
	LOADPRC $NSTART,$(SYS_TASK + TSZ_SMALL),$FSTART,$TSK_OPERPRV

loop:	SUSPEND	$0
	br loop

error1:
error3:	
	mov	r0,-(sp)
	mov	$ERRMSG1,-(sp)
	jsr	pc,_putstr
	add	$4,sp
	//
	br	h
	
error2:
error4:	
	mov	r0,-(sp)
	mov	$ERRMSG2,-(sp)
	jsr	pc,_putstr
	add 	$4,sp
	//
	
h:	SYSHALT

	.data
NSTART: .ASCII  "STARTUP  "
FSTART:	.ASCIZ  "PT      "
NPTPDRV: .ASCII  "PTPDRV  "
NLPTDRV: .ASCII  "LPTDRV  "	
NPTPHND: .ASCII  "PTPHND  "
NLPTHND: .ASCII  "LPTHND  "
NTASKA:	.ASCII	"TASKA   "

ERRMSG1:	.ASCIZ	"Error DRVREG, rc="
ERRMSG2:	.ASCIZ	"Error DRVSTART, rc=" 
	.END
