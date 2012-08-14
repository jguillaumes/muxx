	.text

	.even
	.globl _muxx_mem_getblock
_muxx_mem_getblock:

	;	/* function prologue muxx_mem_getblock*/
	mov r5, -(sp)
	mov sp, r5
	sub $016, sp
	mov r2, -(sp)
	mov r5, -(sp)
	;/* end of prologue */

	mov _mmcbtaddr, -06(r5)
	mov -06(r5), r0
	add $012, r0
	mov r0, -010(r5)
	clr -02(r5)
	clr -012(r5)
	clr -04(r5)
	clr -014(r5)
	clr -016(r5)
	cmp 06(r5),$0200
	blos L_2
	mov $06, r0
	jmp L_3
L_2:
	mov -010(r5), -02(r5)
	mov $07, -(sp)
	jsr pc, _setpl
	add $02, sp
	mov r0, -016(r5)
L_7:
	mov -02(r5), r0
	mov 02(r0), r0
	cmp r0,06(r5)
	blo L_4
	mov $01, -04(r5)
	br L_5
L_4:
	mov -02(r5), r0
	mov 010(r0), -02(r5)
L_5:
	tst -02(r5)
	beq L_6
	tst -04(r5)
	beq L_7
L_6:
	tst -02(r5)
	bne L_8
	mov $01, r0
	br L_3
L_8:
	jsr pc, _findFreeMMCB
	mov r0, -014(r5)
	tst -014(r5)
	bne L_9
	mov $01, r0
	br L_3
L_9:
	mov -06(r5), r1
	add $012, r1
	mov -014(r5), r0
	add r0, r0
	add r0, r0
	add r0, r0
	add r0, r0
	mov r1, r2
	add r0, r2
	mov r2, -012(r5)
	mov -02(r5), r0
	mov 02(r0), r0
	mov r0, r1
	sub 06(r5), r1
	mov -02(r5), r0
	mov r1, 02(r0)
	mov -012(r5), r0
	mov 06(r5), 02(r0)
	mov @-02(r5), r0
	mov r0, @-012(r5)
	mov @-02(r5), r0
	add 06(r5), r0
	mov r0, @-02(r5)
	mov -012(r5), r0
	mov 04(r5), 04(r0)
	mov -012(r5), r0
	mov 012(r5), 06(r0)
	mov -012(r5), r0
	mov -02(r5), 012(r0)
	mov -02(r5), r0
	mov 010(r0), r0
	tst r0
	beq L_10
	mov -02(r5), r0
	mov 010(r0), r0
	mov -012(r5), 012(r0)
L_10:
	mov -02(r5), r0
	mov -012(r5), 010(r0)
	mov -02(r5), r0
	mov 010(r0), r1
	mov -012(r5), r0
	mov r1, 010(r0)
	mov -012(r5), r0
	mov 010(r5), 014(r0)
	clr r0
L_3:

	;	/*function epilogue */
	mov 0177756(r5), r5
	mov 0177760(r5), r2
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


LC_0:
	.byte 0115,0115,0103,0102,0124,055,055,055,0
	.even
	.globl _muxx_mem_init
_muxx_mem_init:

	;	/* function prologue muxx_mem_init*/
	mov r5, -(sp)
	mov sp, r5
	sub $04, sp
	mov r2, -(sp)
	mov r5, -(sp)
	;/* end of prologue */

	clr -02(r5)
	mov _mmcbtaddr, -04(r5)
	mov -04(r5), r0
	mov $04012, r1
	mov r1, -(sp)
	clr -(sp)
	mov r0, -(sp)
	jsr pc, _memset
	add $06, sp
	mov -04(r5), r0
	mov $LC_0, r1
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	movb (r1)+, (r0)+
	mov -04(r5), r0
	mov $0200, 010(r0)
	clr -02(r5)
	br L_12
L_13:
	mov -02(r5), r0
	add r0, r0
	add r0, r0
	add r0, r0
	add r0, r0
	add -04(r5), r0
	add $016, r0
	mov $-01, (r0)
	inc -02(r5)
L_12:
	cmp -02(r5),$0177
	ble L_13
	mov -04(r5), r0
	clr 012(r0)
	mov -04(r5), r0
	mov $0200, 014(r0)
	mov -04(r5), r0
	mov $01, 016(r0)
	mov -04(r5), r0
	clr 020(r0)
	mov -04(r5), r0
	clr 024(r0)
	mov -04(r5), r1
	add $032, r1
	mov -04(r5), r0
	mov r1, 022(r0)
	mov -04(r5), r0
	movb 026(r0), r1
	bisb $01, r1
	movb r1, 026(r0)
	mov -04(r5), r0
	movb 026(r0), r1
	bisb $02, r1
	movb r1, 026(r0)
	mov -04(r5), r0
	movb 026(r0), r1
	bisb $04, r1
	movb r1, 026(r0)
	mov -04(r5), r0
	movb 026(r0), r1
	bicb $010, r1
	movb r1, 026(r0)
	mov -04(r5), r0
	mov $0200, 032(r0)
	mov -04(r5), r0
	mov $0200, 034(r0)
	mov -04(r5), r0
	mov $01, 036(r0)
	mov -04(r5), r0
	mov $01, 040(r0)
	mov -04(r5), r1
	add $012, r1
	mov -04(r5), r0
	mov r1, 044(r0)
	mov -04(r5), r1
	add $052, r1
	mov -04(r5), r0
	mov r1, 042(r0)
	mov -04(r5), r0
	movb 046(r0), r1
	bisb $01, r1
	movb r1, 046(r0)
	mov -04(r5), r0
	movb 046(r0), r1
	bisb $02, r1
	movb r1, 046(r0)
	mov -04(r5), r0
	movb 046(r0), r1
	bisb $04, r1
	movb r1, 046(r0)
	mov -04(r5), r0
	movb 046(r0), r1
	bicb $010, r1
	movb r1, 046(r0)
	mov -04(r5), r0
	mov $0400, 052(r0)
	mov -04(r5), r0
	mov $0100, 054(r0)
	mov -04(r5), r0
	mov $01, 056(r0)
	mov -04(r5), r0
	mov $06, 060(r0)
	mov -04(r5), r1
	add $032, r1
	mov -04(r5), r0
	mov r1, 064(r0)
	mov -04(r5), r1
	add $072, r1
	mov -04(r5), r0
	mov r1, 062(r0)
	mov -04(r5), r0
	movb 066(r0), r1
	bicb $01, r1
	movb r1, 066(r0)
	mov -04(r5), r0
	movb 066(r0), r1
	bicb $02, r1
	movb r1, 066(r0)
	mov -04(r5), r0
	movb 066(r0), r1
	bicb $04, r1
	movb r1, 066(r0)
	mov -04(r5), r0
	movb 066(r0), r1
	bicb $010, r1
	movb r1, 066(r0)
	mov -04(r5), r0
	mov $0500, 072(r0)
	mov -04(r5), r0
	mov $07500, 074(r0)
	mov -04(r5), r0
	clr 076(r0)
	mov -04(r5), r0
	clr 0100(r0)
	mov -04(r5), r1
	add $052, r1
	mov -04(r5), r0
	mov r1, 0104(r0)
	mov -04(r5), r1
	add $0112, r1
	mov -04(r5), r0
	mov r1, 0102(r0)
	mov -04(r5), r0
	movb 0106(r0), r1
	bicb $01, r1
	movb r1, 0106(r0)
	mov -04(r5), r0
	movb 0106(r0), r1
	bicb $02, r1
	movb r1, 0106(r0)
	mov -04(r5), r0
	movb 0106(r0), r1
	bicb $04, r1
	movb r1, 0106(r0)
	mov -04(r5), r0
	movb 0106(r0), r1
	bicb $010, r1
	movb r1, 0106(r0)
	mov -04(r5), r0
	mov $07600, 0112(r0)
	mov -04(r5), r0
	mov $0200, 0114(r0)
	mov -04(r5), r0
	mov $01, 0116(r0)
	mov -04(r5), r0
	mov $07, 0120(r0)
	mov -04(r5), r1
	add $072, r1
	mov -04(r5), r0
	mov r1, 0124(r0)
	mov -04(r5), r0
	clr 0122(r0)
	mov -04(r5), r0
	movb 0126(r0), r1
	bisb $01, r1
	movb r1, 0126(r0)
	mov -04(r5), r0
	movb 0126(r0), r1
	bisb $02, r1
	movb r1, 0126(r0)
	mov -04(r5), r0
	movb 0126(r0), r1
	bicb $04, r1
	movb r1, 0126(r0)
	mov -04(r5), r0
	movb 0126(r0), r1
	bisb $010, r1
	movb r1, 0126(r0)

	;	/*function epilogue */
	mov 0177770(r5), r5
	mov 0177772(r5), r2
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
	.globl _muxx_mem_freeblock
_muxx_mem_freeblock:

	;	/* function prologue muxx_mem_freeblock*/
	mov r5, -(sp)
	mov sp, r5
	mov r5, -(sp)
	;/* end of prologue */


	;	/*function epilogue */
	mov 0177776(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
_findFreeMMCB:

	;	/* function prologue findFreeMMCB*/
	mov r5, -(sp)
	mov sp, r5
	sub $06, sp
	mov r5, -(sp)
	;/* end of prologue */

	mov _mmcbtaddr, -06(r5)
	clr -02(r5)
	clr -04(r5)
	clr -02(r5)
	br L_16
L_19:
	mov -02(r5), r0
	add r0, r0
	add r0, r0
	add r0, r0
	add r0, r0
	add -06(r5), r0
	add $016, r0
	mov (r0), r0
	tst r0
	bne L_17
	mov -02(r5), -04(r5)
L_17:
	inc -02(r5)
L_16:
	mov -02(r5), r1
	mov -06(r5), r0
	mov 010(r0), r0
	cmp r1,r0
	bhis L_18
	tst -04(r5)
	beq L_19
L_18:
	mov -04(r5), r0

	;	/*function epilogue */
	mov 0177770(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


