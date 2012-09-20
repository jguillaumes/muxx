	.text

	.even
	.globl _printf
_printf:

	;	/* function prologue printf*/
	mov r5, -(sp)
	mov sp, r5
	mov r5, -(sp)
	;/* end of prologue */

	clr -(sp)
	mov $010, r0
	add r5, r0
	mov r0, -(sp)
	mov 04(r5), -(sp)
	jsr pc, _doprnt
	clr r0

	;	/*function epilogue */
	mov 0177776(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


