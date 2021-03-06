	.TITLE muxx_xmem - Cross-memory copy procedures
	.IDENT "V01.00"

	.INCLUDE "MACLIB.s"
	.INCLUDE "MUXXMAC.s"

	.SBTTL _muxx_pcopy: physical memory copy
	.global _muxx_pcopy

	/*
	* _muxx_pcopy Physical memory copy.
	*
	* This procedure moves up to 1KB from a source physical location to
	* a destination physical location. Source and destination are
	* specified with a block number (offset in 64 bytes blocks from physical
	* bottom of memory) and an offset number (6 bit quantity, up to 8K-1).
	*
	* The procedure returns a status code in R0:
	* 0: OK
	* -1: Invalid size (greater than 1K)
	* -2: Source and destination offsets must be even
	*
	* Stack at entry (offsets related to R5)
	*
	* +12	WORD	Length of block to move
	* +10	ADDRESS	Destination address (block offset)
	* + 8	WORD	Destination address (block number)
	* + 6	ADDRESS	Source address (block offset)
	* + 4	WORD	Source address (block number)
	* + 2	ADDRESS	Return address
	* R5 => ADDRESS Previous R5 content
	* SP =>         First available stack word
	*/
	
_muxx_pcopy:
	procentry
	cmp	12(r5),$1024		// Check max block size
	blos	5$			// OK, proceed
	mov	$EINVVAL,r0
	br	999$

5$:	mov	6(r5),r0		// Check if source is even
	ror	r0
	bcc	7$			// Even: proceed
	mov	$EINVVAL,r0
	br	999$

7$:	mov	10(r5),r0		// Check if destination is even
	ror	r0
	bcc	9$			// Even: proceed
	mov	$-1,r0
	br	999$

9$:	nop				// Normalize source
	mov	6(r5),r1		// R1: Source offset
	clr	r2			// R2: Will get new offset
	mov	$6,r0			// Rotation counter
10$:	ror	r1			// r1 = r1 / 2, C: remainder
	rol	r2			// Inject remainder into r2
	sob	r0,10$			// Repeat 6 times (to divide by 64)
	add	4(r5), r1		// r1 = New block, r2 = New offset

					// Normalize destination
	mov	10(r5),r3		// R3: Dest offset
	clr	r4			// R4 will get new offset
	mov	$6,r0			// Rotation counter
20$:	ror	r3			// r3 = R3 / 2, C: remainder
	rol	r4			// Inject remainder intro r4
	sob	r0,20$			// Repeat 6 times (divide by 64)
	add	8(r5),r3		// r3: new bloc, r4: new offset


	mov	CPU.PSW,-(sp)		// Push current PSW
	spl	7			// Inhibit interrupts

	mov	MMU.KISAR0,-(sp)	// Store kernel PAR #0
	mov	MMU.KISAR0+2,-(sp)	// Store kernel PAR #1

	mov	r1,MMU.KISAR0		// Set up PAR #0 for source block
	mov	r3,MMU.KISAR0+2		// Set up PAR #1 for dest. block
	
	add	$020000,r4		// Adjust virtual for dest to PAR#1
	mov	12(r5),r0		// Get number of bytes to move
	asr	r0			// R0: Number of words to move
30$:	mov	(r2)+,(r4)+		// Move a full word
	sob	r0,30$			// Repeat for number of words

	mov	(12)r5,r0		// Check if there if last byte to move
	bit	$1,r0			// Check last bit
	beq	40$			// If zero, we are done
	movb	(r2)+,(r4)+		// If not, move last byte

40$:	mov	(sp)+,MMU.KISAR0+2	// Restore kernel PAR #1
	mov	(sp)+,MMU.KISAR0	// Restore kernel PAR #0
	mov	+(sp),CPU.PSW		// Pop PSW (maybe enabling interrupts)
	clr	r0			// R0: OK status
	
999$:	procexit
	
	.PAGE
	.SBTTL _muxx_xcopy: cross-process memory copy
	.global _muxx_xcopy
	
_muxx_xcopy:
	procentry local=4

	mov	CPU.PSW,-(sp)
	jsr	pc,_setpl7	
	
	mov	4(r5),-(sp)			
	call	_muxx_findtcb
	add	$2,sp
	tst	r0
	bhi	10$
	mov	$-1,r0
	br	999$

10$:	mov	r0,-4(r5)
	mov	8(r5),-6(r5)
	call	_muxx_findtcb
	tst	r0
	bhi	20$
	mov	$-1,r0
	br 	999$

20$:	mov	r0,-8(r5)
	mov	6(r5),r0
	mov	10(r5),r1
	mov	12(r5),r2

	cmp	$MAX_XCOPY,r2
	blos	30$
	mov	$-2,r0
	br	999$

30$	bic	$0160000,r0
	add	r2,r0

	bic	$0160000,r1
	add	r2,r1
	
	cmp	r0,r1
	blos	40$

999$:	mov	(sp)+,CPU.PSW
	procexit

	.end
