	.text

LC_0:
	.byte 0101,072,040,0124,0141,0163,0153,040,0101,012,0
	.even
	.globl _taska
_taska:

	;	/* function prologue taska*/
	mov r5, -(sp)
	mov sp, r5
	sub $02, sp
	mov r5, -(sp)
	;/* end of prologue */

	clr -02(r5)
L_2:
	mov $LC_0, -(sp)
	jsr pc, _printf
	add $02, sp
	mov $01, -(sp)
	jsr pc, _sleep
	add $02, sp
	br L_2

	;	/*function epilogue */
	mov 0177774(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


