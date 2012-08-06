	.TITLE muxx_init: Initial set up and switch to user mode
	.IDENT "V01.00"

	.INCLUDE "MUXXMAC.s"
	
	.GLOBAL _muxx_init,kernsp

	.text
	
_muxx_init:
	CMKRNL
	reset				// Reset unibus devices
	mov 	$kernsp, sp		// KRNL SP to reserved area
	jsr	pc, _mmu_enable		// Enable MMU and interrupts
	jsr	pc, _muxx_setup		// Set up EMT handler
	mov	$0xC000,-(sp)		// Usermode PSW
	mov	$user_init,-(sp)	// Prepare stack to jump to user mode
	rti				// RTT => Jump to user mode

user_init:
	nop
	mov	$0160000, sp		// USR SP to top of last writeable page
	jmp	(r2)			// Return to system


	.data
	.space	512
	kernsp = .
	.end
	