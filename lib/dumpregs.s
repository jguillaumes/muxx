	.stabs	"/home/jguillaumes/muxx/lib/",100,0,2,Ltext_0
	.stabs	"dumpregs.c",100,0,2,Ltext_0
	.text

Ltext_0:
	.stabs	"gcc2_compiled.",60,0,0,0
	.stabs	"int:t1=r1;-32768;32767;",128,0,0,0
	.stabs	"char:t2=r2;0;127;",128,0,0,0
	.stabs	"long int:t3=@s32;r3;020000000000;017777777777;",128,0,0,0
	.stabs	"unsigned int:t4=r4;0;0177777;",128,0,0,0
	.stabs	"long unsigned int:t5=@s32;r5;0;037777777777;",128,0,0,0
	.stabs	"long long int:t6=@s64;r6;01000000000000000000000;0777777777777777777777;",128,0,0,0
	.stabs	"long long unsigned int:t7=@s64;r7;0;01777777777777777777777;",128,0,0,0
	.stabs	"short int:t8=r8;-32768;32767;",128,0,0,0
	.stabs	"short unsigned int:t9=r9;0;0177777;",128,0,0,0
	.stabs	"signed char:t10=@s8;r10;-128;127;",128,0,0,0
	.stabs	"unsigned char:t11=@s8;r11;0;255;",128,0,0,0
	.stabs	"float:t12=r1;8;0;",128,0,0,0
	.stabs	"double:t13=r1;8;0;",128,0,0,0
	.stabs	"long double:t14=r1;8;0;",128,0,0,0
	.stabs	"void:t15=15",128,0,0,0
	.stabs	"BYTE:t16=11",128,0,3,0
	.stabs	"WORD:t17=9",128,0,4,0
	.stabs	"LONGWORD:t18=5",128,0,5,0
	.stabs	"ADDRESS:t19=20=*15",128,0,7,0
	.stabs	"CPUSTATE_S:T21=s24gpr:22=ar23=r23;0;0177777;;0;5;17,0,96;sp:17,96,16;pc:17,112,16;psw:17,128,16;usp:17,144,16;ssp:17,160,16;ksp:17,176,16;;",128,0,0,0
	.stabs	"CPUSTATE:t24=21",128,0,17,0
	.stabs	"MMUSTATE_S:T25=s48upar:26=ar23;0;7;17,0,128;spar:26,128,128;kpar:26,256,128;;",128,0,0,0
	.stabs	"MMUSTATE:t27=25",128,0,25,0
	.stabs	"TCB_S:T28=s114taskname:29=ar23;0;7;2,0,64;pid:17,64,16;ppid:17,80,16;uic:18,96,32;status:17,128,16;flags:30=u2flword:17,0,16;flflags:31=s2sending:1,0,1;receiving:1,1,1;suspended:1,2,1;msgwait:1,3,1;filler:1,4,12;;,0,16;;,144,16;privileges:32=u2prvword:17,0,16;prvflags:33=s2operprv:1,0,1;ioprv:1,1,1;filler:1,2,14;;,0,16;;,160,16;taskType:17,176,16;firstChild:34=*28,192,16;lastChild:34,208,16;nextSibling:34,224,16;nextInQueue:34,240,16;prevInQueue:34,256,16;cpuState:24,272,192;mmuState:27,464,384;clock_ticks:18,848,32;created_timestamp:18,880,32;;",128,0,0,0
	.stabs	"TCB:t35=28",128,0,69,0
	.stabs	"PTCB:t36=34",128,0,70,0
	.stabs	"TCTA_S:T37=s1832tcteye:29,0,64;tctTable:38=ar23;0;15;35,64,14592;;",128,0,0,0
	.stabs	"TCTA:t39=37",128,0,77,0
	.stabs	"PTCTA:t40=41=*37",128,0,78,0
	.stabs	"TQUEUE_S:T42=s6head:36,0,16;tail:36,16,16;count:1,32,16;;",128,0,0,0
	.stabs	"TQUEUE:t43=42",128,0,18,0
	.stabs	"PTQUEUE:t44=45=*42",128,0,19,0
LC_0:
	.byte 0
	.even
	.globl _dumpregs
_dumpregs:
	.stabd	46,0,0
	.stabd	68,0,6
LFBB_1:

	;	/* function prologue dumpregs*/
	mov r5, -(sp)
	mov sp, r5
	sub $012, sp
	mov r5, -(sp)
	;/* end of prologue */

	.stabd	68,0,11
	clr -02(r5)
	.stabd	68,0,12
	clr -(sp)
	mov $LC_0, -(sp)
	jsr pc, _kputstrl
	add $04, sp
	.stabd	68,0,13
	mov 04(r5), -04(r5)
	.stabd	68,0,15
	clr -02(r5)
	br L_2
L_3:
LBB_2:
	.stabd	68,0,16
	mov -02(r5), r1
	mov r1, r0
	asl r0
	add r1, r0
	asl r0
	add $_nregs.1282, r0
	mov $05, -(sp)
	mov r0, -(sp)
	jsr pc, _kputstr
	add $04, sp
	.stabd	68,0,17
	mov -02(r5), r0
	asl r0
	add -04(r5), r0
	mov (r0), r0
	mov r5, r1
	add $-012, r1
	mov r1, -(sp)
	mov r0, -(sp)
	jsr pc, _otoa
	add $04, sp
	.stabd	68,0,18
	mov $06, -(sp)
	mov r5, r0
	add $-012, r0
	mov r0, -(sp)
	jsr pc, _kputstr
	add $04, sp
LBE_2:
	.stabd	68,0,15
	inc -02(r5)
L_2:
	cmp -02(r5),$03
	ble L_3
	.stabd	68,0,20
	clr -(sp)
	mov $LC_0, -(sp)
	jsr pc, _kputstrl
	add $04, sp
	.stabd	68,0,21
	mov $04, -02(r5)
	br L_4
L_5:
LBB_3:
	.stabd	68,0,22
	mov -02(r5), r1
	mov r1, r0
	asl r0
	add r1, r0
	asl r0
	add $_nregs.1282, r0
	mov $05, -(sp)
	mov r0, -(sp)
	jsr pc, _kputstr
	add $04, sp
	.stabd	68,0,23
	mov -02(r5), r0
	asl r0
	add -04(r5), r0
	mov (r0), r0
	mov r5, r1
	add $-012, r1
	mov r1, -(sp)
	mov r0, -(sp)
	jsr pc, _otoa
	add $04, sp
	.stabd	68,0,24
	mov $06, -(sp)
	mov r5, r0
	add $-012, r0
	mov r0, -(sp)
	jsr pc, _kputstr
	add $04, sp
LBE_3:
	.stabd	68,0,21
	inc -02(r5)
L_4:
	cmp -02(r5),$07
	ble L_5
	.stabd	68,0,26
	clr -(sp)
	mov $LC_0, -(sp)
	jsr pc, _kputstrl
	add $04, sp
	.stabd	68,0,27
	mov $010, -02(r5)
	br L_6
L_7:
LBB_4:
	.stabd	68,0,28
	mov -02(r5), r1
	mov r1, r0
	asl r0
	add r1, r0
	asl r0
	add $_nregs.1282, r0
	mov $05, -(sp)
	mov r0, -(sp)
	jsr pc, _kputstr
	add $04, sp
	.stabd	68,0,29
	mov -02(r5), r0
	asl r0
	add -04(r5), r0
	mov (r0), r0
	mov r5, r1
	add $-012, r1
	mov r1, -(sp)
	mov r0, -(sp)
	jsr pc, _otoa
	add $04, sp
	.stabd	68,0,30
	mov $06, -(sp)
	mov r5, r0
	add $-012, r0
	mov r0, -(sp)
	jsr pc, _kputstr
	add $04, sp
LBE_4:
	.stabd	68,0,27
	inc -02(r5)
L_6:
	cmp -02(r5),$013
	ble L_7
	.stabd	68,0,32
	clr -(sp)
	mov $LC_0, -(sp)
	jsr pc, _kputstrl
	add $04, sp

	;	/*function epilogue */
	mov 0177764(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.stabs	"dumpregs:F15",36,0,6,_dumpregs
	.stabs	"cst:p46=*24",160,0,6,4
	.stabs	"cword:47=ar23;0;5;2",128,0,7,-10
	.stabs	"ptrreg:48=*17",128,0,8,-4
	.stabs	"nregs:V49=ar23;0;11;47",38,0,10,_nregs.1282
	.stabs	"i:1",128,0,11,-2
	.stabn	192,0,0,LFBB_1
	.stabn	224,0,0,Lscope_1
Lscope_1:
	.even
	.globl _dumptcbregs
_dumptcbregs:
	.stabd	46,0,0
	.stabd	68,0,35
LFBB_2:

	;	/* function prologue dumptcbregs*/
	mov r5, -(sp)
	mov sp, r5
	sub $02, sp
	mov r5, -(sp)
	;/* end of prologue */

	.stabd	68,0,37
	mov _curtcb, -02(r5)
	.stabd	68,0,39
	mov -02(r5), r0
	add $042, r0
	mov r0, -(sp)
	jsr pc, _dumpregs
	add $02, sp

	;	/*function epilogue */
	mov 0177774(r5), r5
	mov r5, sp
	mov (sp)+, r5
	rts pc
	;/* end of epilogue*/


	.stabs	"dumptcbregs:F15",36,0,35,_dumptcbregs
	.stabs	"tcb:36",128,0,36,-2
	.stabn	192,0,0,LFBB_2
	.stabn	224,0,0,Lscope_2
Lscope_2:
	.data

_nregs.1282:
	.byte 040,040,0122,060,075,0
	.byte 054,040,0122,061,075,0
	.byte 054,040,0122,062,075,0
	.byte 054,040,0122,063,075,0
	.byte 040,040,0122,064,075,0
	.byte 054,040,0122,065,075,0
	.byte 054,040,0123,0120,075,0
	.byte 054,040,0120,0103,075,0
	.byte 040,0120,0123,0127,072,0
	.byte 054,0125,0123,0120,072,0
	.byte 054,0123,0123,0120,072,0
	.byte 054,0113,0123,0120,072,0
