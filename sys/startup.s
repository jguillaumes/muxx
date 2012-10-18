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
	
	LOADPRC $NTASKA,$(USR_TASK + TSZ_MED), $FTASKA,$0
	LOADPRC $NTASKB,$(USR_TASK + TSZ_BIG), $FTASKB,$0
	LOADPRC $NTASKC,$(USR_TASK + TSZ_SMALL), $FTASKC,$0


loop:
//	mov	$1,-(sp)
//	mov	$DOT,-(sp)
//	jsr	pc,_putstr
//	add	$4,sp

	YIELD

	br loop

error1:
	mov	r0,-(sp)
	mov	$ERRMSG1,-(sp)
	jsr	pc,_putstr
	add	$2,sp
	//
	br	h
	
error2:
	mov	r0,-(sp)
	mov	$ERRMSG2,-(sp)
	jsr	pc,_putstr
	add 	$2,sp
	//
	
h:	SYSHALT

	.data
NPTPDRV:.ASCII  "PTPDRV  "
NPTHND:	.ASCII  "PTPHND  "
NTASKA:	.ASCII	"TASKA   "
NTASKB:	.ASCII 	"TASKB   "
NTASKC:	.ASCII 	"TASKC   "
FTASKA:	.ASCIZ  "PT      "
FTASKB:	.ASCIZ  "PT      "
FTASKC:	.ASCIZ  "PT      "	
MSG:	.ASCIZ	"Idle task\n"
DOT:	.ASCII  "."
ERRMSG1:	.ASCIZ	"Error DRVREG, rc="
ERRMSG2:	.ASCIZ	"Error DRVSTART, rc=" 
	.END
