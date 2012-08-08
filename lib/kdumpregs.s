	.TITLE kdumpregs - dump the contents of the GPRs in octal
	.IDENT "V01.00"

	.global	kdumpregs


kdumpregs:
	mov	r5,-(sp)
	mov	sp,r5
	mov	4(r5),-(sp)
	mov	r5,-(sp)
	mov	(r5),-(sp)
	mov	r4,-(sp)
	mov	r3,-(sp)
	mov	r2,-(sp)
	mov	r1,-(sp)
	mov	r0,-(sp)
	mov	sp,-(sp)
	jsr	pc,_dumpregs
	add	$2,sp
	mov	r5,sp
	add	$2,sp
	rts	pc

	.end
	