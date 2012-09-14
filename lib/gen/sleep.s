	.text

LC_0:
	.byte 0164,0151,0143,0153,0163,072,040,045,0154,012,0
	.even
	.globl _sleep
_sleep:

	;	/* function prologue sleep*/
	mov r5, -(sp)
	mov sp, r5
	sub $04, sp
	mov r2, -(sp)
	mov r3, -(sp)
	mov r5, -(sp)
	;/* end of prologue */

	tst 04(r5)
	bne L_2
	clr r0
	br L_3
L_2:
	mov _utimeticks,-04(r5)
	mov _utimeticks+02,-02(r5)
	mov -02(r5),-(sp)
	mov -04(r5),-(sp)
	mov $LC_0, -(sp)
	jsr pc, _printf
	add $06, sp
	br L_4
L_5:
	mov _utimeticks,r0
	mov _utimeticks+02,r1
	sub -04(r5), r0
	sub -02(r5), r1
	sbc r0
	mov r1,-(sp)
	mov r0,-(sp)
	mov $LC_0, -(sp)
	jsr pc, _printf
	add $06, sp
	jsr pc, _yield
L_4:
	mov _utimeticks,r0
	mov _utimeticks+02,r1
	sub -04(r5), r0
	sub -02(r5), r1
	sbc r0
	mov $074,-(sp)
	clr -(sp)
	mov r1,-(sp)
	mov r0,-(sp)
	jsr pc, ___udivsi3
	add $010, sp
	mov r0,r2
	mov r1,r3
	mov 04(r5), r1
	sxt r0
	cmp r0,r2
	bhi L_5
	cmp r0,r2
	bne L_7
	cmp r1,r3
	bhi L_5
L_7:
	clr r0
L_3:

	;	/*function epilogue */
	mov 0177766(r5), r5
	mov 0177770(r5), r3
	mov 0177772(r5), r2
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


