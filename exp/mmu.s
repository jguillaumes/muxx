	.TITLE MMU handling routines
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXXMAC.s"

	.GLOBAL	_mmu_enable


	K64 	= 0200			// 64 bytes = 32 words 
	PDRSTAT = 077406		// 77406 (8) = 0 111 111 100 000 110 (2)
					// RESIDENT - READ/WRITE
					// UPWARD EXPANDING
					// NOT WRITTEN INTO
					// 8KB PAGE SIZE
					// DON'T BYPASS CACHE
	PDRPROT = 0			// PDR: No access
	IOSPACE	= 07600			// IOSpace block address

_mmu_enable:
	seti	7			// Inhibit interrupts
	mov	r2,-(sp)
	mov	r3,-(sp)
	clr 	MMU.MMR0		// MMU disabled
	mov	$MMU.UISAR0,r0		// R0 => @User Page Addr. Reg #0
	mov	$MMU.KISAR0,r1		// R1 => @Kernel Page Addr. Reg #0
	clr	r2			// R2 : Block addr (in 64 bytes blocks)
	mov	$010, r3		// R3 : Num total blocs (8 x 8k =64K)

	/*
	** Initialize the page address registers to the equivalent
	** physical address
	*/
10$:	mov	r2,(r0)+		// Store base into User PAR
	mov	r2,(r1)+		// Store base into Kernel PAR
	add	$K64,r2			// Increment base (next block)
	sob	r3,10$			// Decrement counter and branch

	/*
	** Set up PDRs
	*/
	mov	$MMU.UIDR0,r0		// R0 => @User Page Descr Reg #0
	mov	$MMU.KISDR0,r1		// R1 => @Kernel Page Descr Reg #0
	mov	$PDRSTAT, r2		// R4: PDR setup
	mov	$010, r3		// Counter: 8 pages

20$:	mov	r2,(r0)+
	mov	r2,(r1)+
	sob	r3,20$

//	mov	$IOSPACE,MMU.UISAR0+016	// Highest page = IOSPACE (User)
	mov	$IOSPACE,MMU.KISAR0+016	// Highest page = IOSPACE (Kernel)
//	mov	$PDRPROT,MMU.UIDR0+016	// Protect IOSPACE in User mode

	mov	$07400,MMU.UISAR0+016	// Highest user page

	mov	MMU.MMR0, r0
	bis	$0x0001, r0
	mov	r0, MMU.MMR0
	seti	0			// Enable interrupts

	mov	(sp)+,r3
	mov	(sp)+,r2
	rts	pc
