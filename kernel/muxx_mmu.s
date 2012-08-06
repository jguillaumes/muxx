	.TITLE MMU handling routines
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"

	.GLOBAL	mmu_initialize
/**
	Memory management initialization

	The initial MMU setup maps physical addresses to virtual addresses,
	excepting for the highest 8K, which are mapped to the unibus iospace.

	The map is identical for kernel and user mode (MUXX does not use
	supervisor at this time). The user mode mapping protects the
	unibus iospace (no access).
	
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

mmu_initialize:
	procentry numregs=3
	spl	7			// Inhibit interrupts
	clr 	MMU.MMR0		// MMU disabled
	mov	$MMU.UISAR0,r0		// R0 => @User Page Addr. Reg #0
	mov	$MMU.KISAR0,r1		// R1 => @Kernel Page Addr. Reg #0
	clr	r2			// R2 : Block addr (in 64 bytes blocks)
	mov	$007, r3		// R3 : First 7 64K blocks

	/*
	** Initialize the page address registers to the equivalent
	** physical address for PAR 0-6
	*/
10$:	mov	r2,(r0)+		// Store base into User PAR
	mov	r2,(r1)+		// Store base into Kernel PAR
	add	$K64,r2			// Increment base (next 8K block)
	sob	r3,10$			// Decrement counter and branch

	/*
	** Set up PDR 0-6
	*/
	mov	$MMU.UIDR0,r0		// R0 => @User Page Descr Reg #0
	mov	$MMU.KISDR0,r1		// R1 => @Kernel Page Descr Reg #0
	mov	$PDRSTAT, r2		// R4: PDR setup
	mov	$010, r3		// Counter: 8 pages

20$:	mov	r2,(r0)+
	mov	r2,(r1)+
	sob	r3,20$

	mov	$IOSPACE,MMU.UISAR0+016	// Highest page = IOSPACE (User)
	mov	$IOSPACE,MMU.KISAR0+016	// Highest page = IOSPACE (Kernel)
	mov	$PDRPROT,MMU.UIDR0+016	// Protect IOSPACE in User mode

	mov	MMU.MMR0, r0		// Enable memory management
	bis	$0x0001, r0
	mov	r0, MMU.MMR0
	spl	0			// Enable interrupts

	cleanup	numregs=3
	rts	pc

	.end
