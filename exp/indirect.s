	.text

	.even
_muxx_svc_muxxhlt:

	;	/* function prologue muxx_svc_muxxhlt*/
	mov r5, -(sp)
	mov sp, r5
	mov r5, -(sp)
	;/* end of prologue */

;# 15 "indirect.c" 1
	halt
;# 0 "" 2

	;	/*function epilogue */
	mov 0177776(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
_muxx_unimpl:

	;	/* function prologue muxx_unimpl*/
	mov r5, -(sp)
	mov sp, r5
	mov r5, -(sp)
	;/* end of prologue */

	mov $-01, r0

	;	/*function epilogue */
	mov 0177776(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
_muxx_svc_conputc:

	;	/* function prologue muxx_svc_conputc*/
	mov r5, -(sp)
	mov sp, r5
	mov r5, -(sp)
	;/* end of prologue */

	mov @06(r5), r0
	movb (r0), r0
	mov r0, -(sp)
	jsr pc, _kconputc
	add $02, sp

	;	/*function epilogue */
	mov 0177776(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.even
	.globl _muxx_systrap_handler
_muxx_systrap_handler:

	;	/* function prologue muxx_systrap_handler*/
	mov r5, -(sp)
	mov sp, r5
	mov r5, -(sp)
	;/* end of prologue */

	mov r5, r1
	add $04, r1
	mov (r1)+, r0
	ash $02,r0
	mov r1, -(sp)
	mov _trap_table.1217+02(r0), -(sp)
	add $_trap_table.1217, r0
	jsr pc, @(r0)
	add $04, sp

	;	/*function epilogue */
	mov 0177776(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.data

	.even
_trap_table.1217:
	.word	_muxx_svc_muxxhlt /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
	.word	_muxx_svc_conputc /* short */
	.word	01 /* short */
	.word	_muxx_unimpl /* short */
	.word	0 /* short */
