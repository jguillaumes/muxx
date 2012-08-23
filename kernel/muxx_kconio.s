	.TITLE kconio - Console low-level services
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MACLIB.s"
	
	.SBTTL kconputc : synchronously send a byte to the system console
	.GLOBAL _kconputc
	
	/************************************************** 
	** Input interface:
	** - Char to send in r0
	**
	** Output interface:
	** - R0: status code in r0
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
	**	MOV	char,r0
	**	JSR	pc,_conputc
	**	BNE	error...
	**
	** C call sequence
	** 	status = conptchr(character) ;
	**************************************************/ 

	TXRDY	= 0x0080	// DL11 transmission ready bit
	NRETRY	= 5000		// Wait loop constant

	.text

_kconputc:
	procentry
	mov	4(r5),r0
	jsr	pc,kconputch
	procexit
	
kconputch:
	mov	r2,-(sp)
	mov 	$NRETRY, r1	// R1 <= Retries (wait loop)
10$:
	mov	CON.XCSR,r2	// R2 <= Transmit control register
	bit	r2, $TXRDY	// Ready to transmit?
	bne	20$		// Yes: proceed
	sob	r1,10$		// No: try again while R1 is not zero
	mov	$1,r0		// Out of retries: timeout		
	jmp	999$		

20$:	movb	r0,CON.XBUF	// Write to transmit buffer
	mov	$NRETRY, r1	// Setup waiting loop again
30$:	mov	CON.XCSR,r2	// Check transmit control reg...
	bit	r2, $TXRDY	// Ready to transmit again?
	bne	40$		// Yes: we are done
	sob	r1,30$		// No: retry
	mov	$1, r0		// Out of retries: timeout
	jmp	999$		// 

40$:	mov	$0, r0		// Everything OK, RC=0
999$:
	mov	(sp)+,r2
	rts	pc

	.PAGE
	
	.SBTTL congetc: synchronously read a byte from the system console

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
	** 	JSR	PC,_congetc
	** 	MOV	R0,<destination>
	**
	** C call sequence
	** 	ch = congtchr();
	**************************************************/ 

	.GLOBAL _kcongetc

	RCDONE	= 0x0080	// DL11 receive ready bit
	RCENAB  = 0x0001	// DL11 receive enable

	.text

_kcongetc:
	procentry

10$:
	mov	CON.RCSR,r1	// Wait for a character to read
	bit	r1, $RCDONE	//
	beq	10$		//

	movb	CON.RBUF,r0	//
	bis	$RCENAB, r1	// Enable  

	procexit


	.PAGE
	.SBTTL kputstr - Print a string to console
	.GLOBAL _kputstr,_kputstrz,_kputstrl,_kputstrzl

_kputstr:
	procentry
	mov	6(r5),r2
	mov	4(r5),r3
10$:	movb	(r3)+,r0
	jsr	pc,kconputch
	sob	r2,10$
	procexit

_kputstrz:
	procentry
	mov	4(r5),r2
10$:	movb	(r2)+,r0
	beq	20$
	jsr	pc,kconputch
	br	10$
20$:	procexit

_kputstrl:
	procentry
	mov	6(r5),-(sp)
	mov	4(r5),-(sp)
	jsr	pc,_kputstr
	add	$4,sp
	mov	$2,-(sp)
	mov	$crlf,-(sp)
	jsr	pc,_kputstr
	add	$4,sp
	procexit

_kputstrzl:
	procentry
	mov	4(r5),-(sp)
	jsr	pc,_kputstrz
	add	$2,sp
	mov	$2,-(sp)
	mov	$crlf,-(sp)
	jsr	pc,_kputstr
	add	$4,sp
	procexit

	
	.data
crlf:	.ascii	"\n\r"

	.END
