	.TITLE startup: System startup task
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MUXXDEF.s"
	
	.GLOBAL _startup
	
	.text

_startup:
	CREPRC $NPTHND,$DRV_TASK,$_ptphnd,$TSK_IOPRV
	mov	r0,r3
	jsr	pc,_ptpdesc
	mov	r0,r2
	DRVREG $NPTPDRV,r2,r3
	CREPRC $NTASKA,$(USR_TASK + TSZ_MED),$_taska,$0
	CREPRC $NTASKB,$(USR_TASK + TSZ_BIG),$_taskb,$0

loop:	//mov	$MSG,-(sp)
	//jsr	pc,_printf
	//add	$2,sp
	YIELD
	br loop

	.data
NPTPDRV:.ASCII  "PTPDRV  "
NPTHND:	.ASCII  "PTPHND  "
NTASKA:	.ASCII	"TASKA   "
NTASKB:	.ASCII 	"TASKB   "
MSG:	.ASCIZ	"Idle task\n"
	.END
