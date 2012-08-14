	.TITLE MMU handling routines
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXX.s"
	
	.GLOBAL	mmu_initialize,_muxx_getmap,_muxx_setmap 
/**
	Memory management initialization

	The initial MMU setup maps physical addresses to virtual addresses,
	excepting for the highest 8K, which are mapped to the unibus iospace.

	The map is identical for kernel and user mode (MUXX does not use
	supervisor at this time). The user mode mapping protects the
	unibus iospace (no access).

	The pages 4 and 5 are NOT allocated at startup
	
	This procedure also enables the MMU. 

**/
	

	K64 	= 0200			// 64 bytes = 32 words 
	PDRSTAT = 077406		// 77406 (8) = 0 111 111 100 000 110 (2)
					// RESIDENT - READ/WRITE
					// UPWARD EXPANDING
					// NOT WRITTEN INTO
					// 8KB PAGE SIZE
					// DON'T BYPASS CACHE
	PDRPROT = 0			// PDR: No access
	IOSPACE	= 07600			// IOSpace block address
	STACKPDR= 037416		// Stack page (4KB, downward)
					// 0 011 111 100 001 110
mmu_initialize:
	procentry numregs=3
	mov	$7,-(sp)
	jsr	pc,_setpl		// Inhibit interrupts
	add	$2,sp
	clr 	MMU.MMR0		// MMU disabled
	mov	$MMU.UISAR0,r0		// R0 => @User Page Addr. Reg #0
	mov	$MMU.KISAR0,r1		// R1 => @Kernel Page Addr. Reg #0
	clr	r2			// R2 : Block addr (in 64 bytes blocks)
	mov	$004, r3		// R3 : First 4 64K blocks

	/*
	** Initialize the page address registers to the equivalent
	** physical address for PAR 0-3
	*/
10$:	mov	r2,(r0)+		// Store base into User PAR
	mov	r2,(r1)+		// Store base into Kernel PAR
	add	$K64,r2			// Increment base (next 8K block)
	sob	r3,10$			// Decrement counter and branch

	/*
	** Set up page 6 to next physical 4KB block
	** R2 is 4KB up, we have to subtract 0100 from its current value
	*/
	sub	$0100,r2
	mov	r2, MMU.UISAR0+014
	mov	r2, MMU.KISAR0+014

	/*
	** Set up PDR 0-3
	*/
	mov	$MMU.UIDR0,r0		// R0 => @User Page Descr Reg #0
	mov	$MMU.KISDR0,r1		// R1 => @Kernel Page Descr Reg #0
	mov	$PDRSTAT, r2		// R4: PDR setup
	mov	$004, r3		// Counter: 4 pages

20$:	mov	r2,(r0)+
	mov	r2,(r1)+
	sob	r3,20$

	/*
	** Set up PDR 6 as 4KB stack page
	*/
	mov	$STACKPDR,r2
	mov	r2,MMU.UIDR0+014
	mov	r2,MMU.KISDR0+014
	
	mov	$IOSPACE,MMU.UISAR0+016	// Highest page = IOSPACE (User)
	mov	$IOSPACE,MMU.KISAR0+016	// Highest page = IOSPACE (Kernel)
	mov	$PDRPROT,MMU.UIDR0+016	// Protect IOSPACE in User mode
	mov	$PDRSTAT,MMU.KISDR0+016	// IOSPACE accessible in kernel mode

	mov	MMU.MMR0, r0		// Enable memory management
	bis	$0x0001, r0
	mov	r0, MMU.MMR0
	clr	-(sp)
	jsr	pc,_setpl		// Enable interrupts
	add	$2,sp

	cleanup	numregs=3
	rts	pc
	.PAGE
	.SBTTL	"muxx_getmap - Save the current MMU map"
	

_muxx_getmap:
	procentry numregs=3
	jsr	pc,_setpl7		// No interrupts
	mov	r0,r3			// Save previous IPL
	
	mov	4(r5),r0		// R0: address of TCB
	mov	$MMU.UISAR0,r1		// R1: Address of first user PAR
	mov	$8,r2			// R2: Number of words to move
	add	$TCB.UPAR0,r0		// R0: Address of UPAR in TCB
10$:	mov	(r1)+, (r0)+		// Move PAR to store area
	sob	r2,10$
	
	mov	4(r5),r0
	mov	$MMU.KISAR0,r1		// R1: Address of first kernel PAR
	mov	$8,r2			// R2: Words to move
	add	$TCB.KPAR0,r0
20$:	mov	(r1)+, (r0)+
	sob 	r2,20$

	mov	4(r5),r0
	mov	$MMU.SISAR0,r1		// R1: Address of first kernel PAR
	mov	$8,r2			// R2: Words to move
	add	$TCB.SPAR0,r0
30$:	mov	(r1)+, (r0)+
	sob 	r2,30$

	mov	r3,-(sp)		// Restore previous IPL
	jsr	pc,_setpl
	add	$2,sp
	
	cleanup numregs=3	
	rts	pc
	
	.PAGE
	.SBTTL	"muxx_setmap - Modify the current MMU map"

	
_muxx_setmap:	
	procentry numregs=3
	jsr	pc,_setpl7		// No interrupts
	mov	r0,r3			// Save previous IPL
	
	mov	4(r5),r0		// R0: address of TCB
	mov	$MMU.UISAR0,r1		// R1: Address of first user PAR
	mov	$8,r2			// R2: Number of words to move
	add	$TCB.UPAR0,r0
10$:	mov	(r0)+,(r1)+		// Store PAR value
	sob	r2,10$
	
	mov	4(r5),r0
	mov	$MMU.KISAR0,r1		// R1: Address of first kernel PAR
	mov	$8,r2			// R2: Words to move
	add	$TCB.KPAR0,r0
20$:	mov	(r0)+,(r1)+
	sob 	r2,20$

	mov	4(r5),r0
	mov	$MMU.SISAR0,r1		// R1: Address of first kernel PAR
	mov	$8,r2			// R2: Words to move
	add	$TCB.SPAR0,r0
30$:	mov	(r0)+,(r1)+
	sob 	r2,30$

	mov	r3,-(sp)		// Restore previous IPL
	jsr	pc,_setpl
	add	$2,sp
	
	cleanup numregs=3	
	rts	pc



	.end
