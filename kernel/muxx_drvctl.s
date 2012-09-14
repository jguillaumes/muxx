	.text

	.even
	.globl _muxx_find_driver
_muxx_find_driver:

	;	/* function prologue muxx_find_driver*/
	mov r5, -(sp)
	mov sp, r5
	sub $02, sp
	mov r2, -(sp)
	mov r3, -(sp)
	mov r4, -(sp)
	mov r5, -(sp)
	;/* end of prologue */

	mov _drvcbtaddr, r4
	clr r3
L_4:
	mov r3, r1
	mul $022, r1
	mov r1, r2
	mov r4, r0
	add r1, r0
	movb 024(r0), r0
	ash $07,r0
	movb r0, r0
	ash $-07,r0
	tstb r0
	bne L_6
	mov $010, -(sp)
	add $012, r2
	add r4, r2
	mov r2, -(sp)
	mov 04(r5), r1
	mov r1, -(sp)
	jsr pc, _memcmp
	add $06, sp
	tst r0
	bne L_6
	mov r2, r0
	br L_2
L_6:
	clr r0
L_2:
	inc r3
	cmp r3,$010
	beq L_3
	tst r0
	beq L_4
L_3:

	;	/*function epilogue */
	mov 0177766(r5), r5
	mov 0177770(r5), r4
	mov 0177772(r5), r3
	mov 0177774(r5), r2
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
	.globl _muxx_locate_pdev
_muxx_locate_pdev:

	;	/* function prologue muxx_locate_pdev*/
	mov r5, -(sp)
	mov sp, r5
	sub $024, sp
	mov r2, -(sp)
	mov r3, -(sp)
	mov r4, -(sp)
	mov r5, -(sp)
	;/* end of prologue */

	mov r5, r2
	add $-011, r2
	mov $011, -(sp)
	clr -(sp)
	mov r2, -(sp)
	jsr pc, _memset
	mov 04(r5), r0
	mov $010, r1
	
movestrhi0:
	movb (r0)+, (r2)+
	sob r1, movestrhi0
	mov r5, r0
	dec r0
	add $06, sp
	mov $07, r3
	br L_9
L_11:
	clrb (r0)
	dec r3
	cmp r3,$-01
	bne L_9
L_12:
	clrb r1
	movb r1, -013(r5)
	movb r1, -014(r5)
	clr r1
	mov r1, -016(r5)
	clr r4
	br L_10
L_9:
	cmpb -(r0),$040
	beq L_11
	br L_12
L_10:
	mov _drvcbtaddr, r0
	mov r4, r1
	mul $022, r1
	mov r0, r2
	add r1, r2
	movb 024(r2), r2
	ash $07,r2
	movb r2, r2
	ash $-07,r2
	tstb r2
	bne L_16
	mov r1, r2
	add $012, r2
	add r0, r2
	mov 010(r2), r1
	add $022, r1
	mov r1, -020(r5)
	mov r3, -(sp)
	mov r1, -(sp)
	mov 04(r5), r1
	mov r1, -(sp)
	mov $_memcmp, r1
	jsr pc, (r1)
	add $06, sp
	tst r0
	beq L_17
	mov $-011, r0
	add r5, r0
	add r3, r0
	movb (r0), r0
	movb r0, -023(r5)
	mov ___ctype_ptr__, r1
	mov r1, -022(r5)
	movb r0, r0
	add r1, r0
	movb 01(r0), r0
	bic $-05, r0
	beq L_13
	movb -023(r5), r1
	movb r1, -014(r5)
	dec r3
	mov r3, -(sp)
	mov -020(r5), r1
	mov r1, -(sp)
	mov 04(r5), r1
	mov r1, -(sp)
	mov $_memcmp, r1
	jsr pc, (r1)
	add $06, sp
	tst r0
	beq L_18
	mov $-011, r0
	add r5, r0
	add r3, r0
	movb (r0), r0
	movb r0, -020(r5)
	movb r0, r0
	mov -022(r5), r1
	add r1, r0
	movb 01(r0), r0
	bic $-04, r0
	beq L_13
	movb -020(r5), r1
	movb r1, -013(r5)
	br L_13
L_16:
	clr r2
	br L_13
L_17:
	clrb r1
	movb r1, -013(r5)
	movb r1, -014(r5)
	br L_22
L_18:
	clrb r1
	movb r1, -013(r5)
L_22:
	mov $01, r1
	mov r1, -016(r5)
L_13:
	inc r4
	cmp r4,$010
	beq L_14
	tst r2
	beq L_10
L_14:
	mov -016(r5), r1
	cmp r1,$01
	bne L_19
	mov 06(r5), r1
	mov r2, 02(r1)
	movb -013(r5), r0
	movb r0, 012(r1)
	movb -014(r5), r0
	movb r0, 013(r1)
	clr r0
	br L_15
L_19:
	mov $-013, r0
L_15:

	;	/*function epilogue */
	mov 0177744(r5), r5
	mov 0177746(r5), r4
	mov 0177750(r5), r3
	mov 0177752(r5), r2
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
	.globl _muxx_svc_alloc
_muxx_svc_alloc:

	;	/* function prologue muxx_svc_alloc*/
	mov r5, -(sp)
	mov sp, r5
	mov r2, -(sp)
	mov r3, -(sp)
	mov r4, -(sp)
	mov r5, -(sp)
	;/* end of prologue */

	mov 04(r5), r4
	mov 06(r5), -(sp)
	jsr pc, _muxx_find_driver
	add $02, sp
	mov r0, r2
	beq L_28
	mov $01, -(sp)
	mov $05, -(sp)
	mov r4, -(sp)
	jsr pc, _muxx_svc_mutex
	mov r0, r3
	add $06, sp
	tst r0
	bne L_25
	movb 012(r2), r0
	bicb $-021, r0
	tst 010(r5)
	bne L_26
	tstb r0
	bne L_29
	mov _curtcb, 016(r2)
	bisb $020, 012(r2)
	br L_25
L_26:
	tstb r0
	beq L_30
	mov _curtcb, r0
	cmp 016(r2),r0
	beq L_27
	movb 024(r0), r0
	bicb $-02, r0
	beq L_27
	mov $-07, r3
L_27:
	clr 016(r2)
	movb 012(r2), r0
	bicb $020, r0
	movb r0, 012(r2)
	br L_25
L_29:
	mov $-011, r3
	br L_25
L_30:
	mov $-012, r3
L_25:
	mov $02, -(sp)
	mov $05, -(sp)
	mov r4, -(sp)
	jsr pc, _muxx_svc_mutex
	add $06, sp
	br L_24
L_28:
	mov $-013, r3
L_24:
	mov r3, r0

	;	/*function epilogue */
	mov 0177770(r5), r5
	mov 0177772(r5), r4
	mov 0177774(r5), r3
	mov 0177776(r5), r2
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


