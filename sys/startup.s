	.TITLE startup: System startup
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "SCB.s"
	
	.GLOBAL start
	
	.text

start:
	reset
	SCB

	mov	$tempstackt,sp			// Temporary stack
	jsr	pc,mmu_initialize		// Memory mapping
	mov	_kstackt,sp			// Final kernel stack
	jsr	pc,trap_initialize
	jsr	pc,muxx_systrap
	jsr	pc,_muxx_tctinit
	
//	mov	r0,0120000	
	
	mov	$linitmsg,-(sp)
	mov	$initmsg,-(sp)
	jsr	pc,_kputstrl
	HALT
	
	.data
initmsg:
	.ASCII	"Muxx starting up..."
	linitmsg = . - initmsg
