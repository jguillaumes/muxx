	.TITLE startup: System startup
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "MUXXMAC.s"
	.INCLUDE "ERRNO.s"
	.INCLUDE "SCB.s"

	.GLOBAL sysstart

	.text

sysstart:
	SCB

	reset					// Reset machine
	mov	$tempstackt,sp			// Temporary stack
	jsr	pc,mmu_initialize		// Memory mapping
	// mov	_kstackt,sp			// Final kernel stack
	jsr	pc,_muxx_mem_init		// Set up MMCBs
	jsr	pc,trap_initialize		// Setup trap handlers
	jsr	pc,muxx_systrap			// Setup syscall handlers

	mov	$linitmsg,-(sp)			// Send init message to console
	mov	$initmsg,-(sp)
	jsr	pc,_kputstrl

	jsr	pc,_muxx_tctinit		// Initialize task table
	jsr	pc,_muxx_drvinit		// Init. device driver table
	jsr	pc,_muxx_iottinit		// Init. channel table
	jsr	pc,_muxx_fakeproc		// Set up INIT task
	jsr	pc,_muxx_clock_setup		// Setup clock interrupt..
	jsr	pc,_muxx_clock_enable		// ... and enable it

	jsr	pc,_muxx_switch			// Switch to INIT task

loop:	br	loop				// Endless loop...

	SYSHALT					// HALT syscall

	.data
initmsg:
	.ASCII	"Muxx starting up..."
	linitmsg = . - initmsg
	.even
long:	.LONG	123456789
long2	= long+2
buffer:	.space	10
stup:	.ASCIZ  "INIT   "
stupf:	.ASCIZ  "PT     "

	.END
