	.TITLE pdpreadstr: Read a string from console
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXXMAC.s"

	.GLOBAL start

	.text

start:
	mov	$go, r2
	jmp	_muxx_init

go:	nop	
	movb	term, -(sp)
	mov	size, -(sp)
	mov	$buffer, -(sp)
	jsr	pc,_congtstr
	add	$6, sp

	jsr	pc,_conptlin

	mov	size,-(sp)
	mov	$buffer,-(sp)
	jsr	pc,_conptstrl
	add	$4, sp
	MUXHLT

	.data
term:	.byte	0x0d
size:	.word	sbuf
buffer:	.space	16
	sbuf = . - buffer

	.end

