	.TITLE muxx_drvctl_a - Driver control routines - asm interface
	.IDENT "V01.00"

	.INCLUDE "MUXX.s"
	.INCLUDE "MUXXDEF.s"
	.INCLUDE "ERRNO.s"
	.INCLUDE "MACLIB.s"

	.GLOBAL _muxx_drv_exec

	/*
	** Invoke a device driver function
	**
	** Parameters (in stack)
	**
	** 4(R5)	DRVCB address
	** 6(R5)	IOPKT address  WORD size;
	**
	** C call sequence:
	**
	** rc = muxx_drv_exec(PDRVCB, PIOPKT)
	*/
_muxx_drv_exec:
	procentry saver4=no
	mov	4(r5),r2	// R2: driver control block addr.
	mov	6(r5),r3	// R3: IOPKT address
	mov	r3,-(sp)	// Push IOPKT address
	add	$DRV_DESC,r2	// R2 points now to dev descriptor
	add	r3,r2		// R2 points to driver routine
	jsr	pc,@0(r2)	// Call handler routine
	add	$2,sp		// Remove parameter
	procexit getr4=no

	.end
