	.TITLE startup: System startup task
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"
	.INCLUDE "MUXXDEF.s"
	
	.GLOBAL _startup
	
	.text

_startup:
	CREPRC $NTASKA,$0,$_taska,$0
//	CREPRC $NTASKB,$0,$_taskb,$0

loop:	mov	$MSG,-(sp)
	jsr	pc,_putstrzl
	add	$2,sp
//	wait
	br loop


	.data
NTASKA:	.ASCII	"TASKA   "
NTASKB:	.ASCII 	"TASKB   "
MSG:	.ASCIZ	"Idle task"
	.END
