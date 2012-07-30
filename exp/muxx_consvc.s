	.TITLE mux_consvc - Console low-level services
	.IDENT "V01.00"

	.SBTTL svc_conptchr: send a byte to the system console

	/************************************************** 
	** Input interface:
	** - Char to send in stack
	**
	** Output interface:
	** - R0: status code
	**	 0: OK
	**	 1: Timeout
	**
	** Stack usage:
	**      CHAROUT			(char to send)
	** 	RETADDR
	**	Old R5  <= FP (R5)
	** 	R1
	**	R2 <= SP
	**
	** ASM call sequence:
	**	MOV	char,-(SP)
	** 	JSR	PC,_conptchr
	**	INC	SP
	**	TST	R0
	**	BNE	error...
	**
	** C call sequence
	** 	status = conptchr(character) ;
	**************************************************/ 

	.INCLUDE "CONFIG.s"
	.GLOBAL _svc_conptchr

	TXRDY	= 0x0080	// DL11 transmission ready bit
	NRETRY	= 5000		// Wait loop constant

	CHAROFS = 4		// Offset of char to send in frame

	.text

_svc_conptchr:
	mov	r5,-(sp)	// Save old stack frame
	mov	sp, r5		// Get new stack frame

	mov	r1,-(sp)	// Push R1
	mov	r2,-(sp)	// Push R2
	mov 	$NRETRY, r1	// R1 <= Retries (wait loop)
10$:
	mov	CON.XCSR,r2	// R2 <= Transmit control register
	bit	r2, $TXRDY	// Ready to transmit?
	bne	20$		// Yes: proceed
	sob	r1,10$		// No: try again while R1 is not zero
	mov	$1,r0		// Out of retries: timeout		
	jmp	999$		

20$:	movb	CHAROFS(r5),CON.XBUF	// Write to transmit buffer
	mov	$NRETRY, r1	// Setup waiting loop again
30$:	mov	CON.XCSR,r2	// Check transmit control reg...
	bit	r2, $TXRDY	// Ready to transmit again?
	bne	40$		// Yes: we are done
	sob	r1,30$		// No: retry
	mov	$1, r0		// Out of retries: timeout
	jmp	999$		// 

40$:	mov	$0, r0		// Everything OK, RC=0
999$:
	mov (sp)+, r2		// Pop R2
	mov (sp)+, r1		// Pop R1
	mov (sp)+, r5		// Pop old FP
	rts	pc		// Return!

	.SBTTL _svc_congtchr: read a byte from the system console

	/************************************************** 
	** Input interface: none
	**
	** Output interface:
	** - R0: character read in low byte
	**
	** Stack usage:
	** 	RETADDR
	** 	R1	<= SP
	**
	** ASM call sequence:
	** 	JSR	PC,_congtchr
	** 	MOV	R0,<destination>
	**
	** C call sequence
	** 	ch = congtchr();
	**************************************************/ 

	.GLOBAL _svc_congtchr

	RCDONE	= 0x0080	// DL11 receive ready bit
	RCENAB  = 0x0001	// DL11 receive enable

	.text

_svc_congtchr:
	mov	r1,-(sp)	// Push R1

10$:
	mov	CON.RCSR,r1	// Wait for a character to read
	bit	r1, $RCDONE	//
	beq	10$		//

	movb	CON.RBUF,r0	//
	bis	$RCENAB, r1	// Enable  

	mov (sp)+, r1
	rts	pc

	.end
