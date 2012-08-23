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
	// mov	_kstackt,sp			// Final kernel stack
	jsr	pc,_muxx_mem_init		// Set up MMCBs
	jsr	pc,trap_initialize		// Setup trap handlers
	jsr	pc,muxx_systrap			// Setup syscall handlers

	mov	$linitmsg,-(sp)			// Send init message to console
	mov	$initmsg,-(sp)
	jsr	pc,_kputstrl
	
	jsr	pc,_muxx_tctinit		// Initialize task table
	jsr	pc,_muxx_fakeproc		// Set up STARTUP task
	jsr	pc,_muxx_clock_setup		// Setup clock interrupt..
	jsr	pc,_muxx_clock_enable		// ... and enable it

	jsr	pc,_muxx_switch
	
loop:	br	loop				// Endless loop...
	
	SYSHALT					// HALT syscall
	
	.data
initmsg:
	.ASCII	"Muxx starting up..."
	linitmsg = . - initmsg

	.END
