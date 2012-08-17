	.TITLE startup: System startup
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "ERRNO.s"
	.INCLUDE "SCB.s"
	
	.GLOBAL start
	
	.text

start:
	SCB
	reset					// Reset machine
	mov	$tempstackt,sp			// Temporary stack
	jsr	pc,mmu_initialize		// Memory mapping
	mov	_kstackt,sp			// Final kernel stack
	jsr	pc,_muxx_mem_init		// Set up MMCBs
	jsr	pc,trap_initialize		// Setup trap handlers
	jsr	pc,muxx_systrap			// Setup syscall handlers

	mov	$linitmsg,-(sp)			// Send init message to console
	mov	$initmsg,-(sp)
	jsr	pc,_putstrl
	
	jsr	pc,_muxx_tctinit		// Initialize task table
	jsr	pc,_muxx_fakeproc		// Set up STARTUP task
	jsr	pc,_muxx_clock_setup		// Setup clock interrupt..
	jsr	pc,_muxx_clock_enable		// ... and enable it

	CREPRC $NTASKA,$0,$_taska,$0
	CREPRC $NTASKB,$0,$_taskb,$0
	
loop:	wait					// Wait for interrupts...


	

	/*
	mov	$EILLINST,-(sp)
	jsr	pc,_panic
	add	$4,sp
	*/

	/*
	mov	r0,077777			// Odd address
	*/
	
	/*
	mov	$0,r0
	mov	$1,r1
	mov	$2,r2
	mov	$3,r3
	mov	$4,r4
	mov	$5,r5
	mov	r0,0120000			// Illegal memory
	*/

	br	loop
	SYSHALT					// HALT syscall
	
	.data
initmsg:
	.ASCII	"Muxx starting up..."
	linitmsg = . - initmsg
NTASKA:	.ASCII	"TASKA   "
NTASKB:	.ASCII 	"TASKB   "

	.END

	