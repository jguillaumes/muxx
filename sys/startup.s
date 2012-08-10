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
	jsr	pc,trap_initialize		// Setup trap handlers
	jsr	pc,muxx_systrap			// Setup syscall handlers
	jsr	pc,_muxx_tctinit		// Initialize task table
	jsr	pc,_muxx_fakeproc		// Set up STARTUP task
	jsr	pc,_muxx_clock_setup
	jsr	pc,_muxx_clock_enable
loop:	br	loop

	/*
	mov	$EILLINST,-(sp)
	jsr	pc,_panic
	add	$4,sp
	*/

	/*
	mov	r0,077777			// Odd address
	*/
	
	mov	$0,r0
	mov	$1,r1
	mov	$2,r2
	mov	$3,r3
	mov	$4,r4
	mov	$5,r5
	mov	r0,0120000			// Illegal memory


	mov	$linitmsg,-(sp)			// Send halt message to console
	mov	$initmsg,-(sp)
	jsr	pc,_kputstrl
	SYSHALT					// HALT syscall
	
	.data
initmsg:
	.ASCII	"Muxx starting up..."
	linitmsg = . - initmsg
