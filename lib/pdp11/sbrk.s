	.TITLE sbrk - Get/set the top limit of static memory
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"

	.GLOBAL _sbrk

	// sbrk() basic implementation
	// MUXX does not allow to add memory to the static segment
	// of a task. So sbrk(0) returns simply the break address
	// computed and set by the linker (in the global _toptask),
	// and any attempt to modiy the break limit returns -1
	//
	// Possibly in a future version the sbrk() will be really functional
	// and the top-of-task will be settable via memory management.
	//
	
_sbrk:	procentry saver2=no,saver3=no,saver4=no
	mov	4(r5),r1
	beq	10$
	mov	$-1,r0
	br	20$
10$:	mov	$_toptask,r0
20$:	procexit getr2=no,getr3=no,getr4=no

	.end
