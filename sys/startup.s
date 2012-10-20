	.TITLE startup: System startup task
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MUXXDEF.s"
	
	.GLOBAL _startup
	
	.text

_startup:
//	CREPRC 	$NPTHND,$DRV_TASK,$_ptphnd,$TSK_IOPRV
//	mov	r0,r3
	clr	r3
	jsr	pc,_ptpdesc
	mov	r0,r2
	DRVREG 	$NPTPDRV,r2,r3
	tst	r0
	bmi	error1
	DRVSTART $NPTPDRV
	tst	r0
	bmi	error2
	
	clr 	r3
	jsr	pc,_lptdesc
	mov	r0,r2
	DRVREG	$NLPTDRV,r2,r3
	tst	r0
	bmi	error3
	DRVSTART $NLPTDRV
	tst	r0
	bmi	error4
	
//	CREPRC $NTASKA,$(USR_TASK + TSZ_SMALL),$_proca,$0
	LOADPRC $NTASKA,$(USR_TASK + TSZ_SMALL),$FTASKA,$0
	LOADPRC $NTASKB,$(USR_TASK + TSZ_SMALL),$FTASKB,$0
	LOADPRC $NTASKC,$(USR_TASK + TSZ_SMALL),$FTASKC,$0
	LOADPRC $NTASKD,$(USR_TASK + TSZ_MED),$FTASKD,$0
//	CREPRC  $NTASKD,$(USR_TASK + TSZ_MED),$_procd,$0	

loop:
//	mov	$1,-(sp)
//	mov	$DOT,-(sp)
//	jsr	pc,_putstr
//	add	$4,sp

	YIELD

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
NPTPDRV: .ASCII  "PTPDRV  "
NLPTDRV: .ASCII  "LPTDRV  "	
NPTPHND: .ASCII  "<PTPHND  "
NLPTHND: .ASCII  "LPTHND  "
NTASKA:	.ASCII	"TASKA   "
NTASKB:	.ASCII 	"TASKB   "
NTASKC:	.ASCII 	"TASKC   "
NTASKD:	.ASCII 	"TASKD   "
FTASKA:	.ASCIZ  "PT      "
FTASKB:	.ASCIZ  "PT      "
FTASKC:	.ASCIZ  "PT      "
FTASKD:	.ASCIZ  "PT      "	
MSG:	.ASCIZ	"Idle task\n"
DOT:	.ASCII  "."
ERRMSG1:	.ASCIZ	"Error DRVREG, rc="
ERRMSG2:	.ASCIZ	"Error DRVSTART, rc=" 
	.END
