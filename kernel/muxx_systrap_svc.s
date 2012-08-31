	.stabs	"/home/jguillaumes/muxx/kernel/",100,0,2,Ltext_0
	.stabs	"muxx_systrap_svc.c",100,0,2,Ltext_0
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
	.stabs	"CPUSTATE:t24=21",128,0,21,0
	.stabs	"MMUSTATE_S:T25=s64upar:26=ar23;0;7;17,0,128;updr:26,128,128;kpar:26,256,128;kpdr:26,384,128;;",128,0,0,0
	.stabs	"MMUSTATE:t27=25",128,0,41,0
	.stabs	"TCB_S:T28=s134taskname:29=ar23;0;7;2,0,64;pid:17,64,16;ppid:17,80,16;uic:18,96,32;status:17,128,16;flags:30=u2flword:17,0,16;flflags:31=s2sending:1,0,1;receiving:1,1,1;suspended:1,2,1;msgwait:1,3,1;filler:1,4,12;;,0,16;;,144,16;privileges:32=u2prvword:17,0,16;prvflags:33=s2operprv:1,0,1;ioprv:1,1,1;auditprv:1,2,1;filler:1,3,13;;,0,16;;,160,16;taskType:17,176,16;firstChild:34=*28,192,16;lastChild:34,208,16;nextSibling:34,224,16;nextInQueue:34,240,16;prevInQueue:34,256,16;cpuState:24,272,192;mmuState:27,464,512;clockTicks:18,976,32;created_timestamp:18,1008,32;localFlags:18,1040,32;;",128,0,0,0
	.stabs	"TCB:t35=28",128,0,98,0
	.stabs	"PTCB:t36=34",128,0,99,0
	.stabs	"TCTA_S:T37=s2152tcteye:29,0,64;tctTable:38=ar23;0;15;35,64,17152;;",128,0,0,0
	.stabs	"TCTA:t39=37",128,0,117,0
	.stabs	"PTCTA:t40=41=*37",128,0,118,0
	.stabs	"MMCB_S:T42=s16blockAddr:17,0,16;blockSize:17,16,16;ownerPID:17,32,16;ownerPAR:17,48,16;nextBlock:43=*42,64,16;prevBlock:43,80,16;mmcbFlags:44=u2flags:45=s2sharedBlock:1,0,1;fixedBlock:1,1,1;privBlock:1,2,1;iopage:1,3,1;stack:1,4,1;filler:1,5,11;;,0,16;word:17,0,16;;,96,16;reserved:17,112,16;;",128,0,0,0
	.stabs	"MMCB:t46=42",128,0,150,0
	.stabs	"PMMCB:t47=43",128,0,151,0
	.stabs	"MMCBT_S:T48=s2058mcbeye:29,0,64;numEntries:17,64,16;mmcbt:49=ar23;0;127;46,80,16384;;",128,0,0,0
	.stabs	"MMCBT:t50=48",128,0,164,0
	.stabs	"PMMCBT:t51=52=*48",128,0,165,0
	.stabs	"DRVISR_S:T53=s6handler:19,0,16;vector:19,16,16;ilevel:17,32,16;;",128,0,0,0
	.stabs	"DRVISR:t54=53",128,0,177,0
	.stabs	"PDRVISR:t55=56=*53",128,0,178,0
	.stabs	"DRVDESC_S:T57=s42callbacks:58=ar23;0;7;19,0,128;numisr:17,128,16;isrtable:59=ar23;0;3;54,144,192;;",128,0,0,0
	.stabs	"DRVDESC:t60=57",128,0,191,0
	.stabs	"PDRVDESC:t61=62=*57",128,0,192,0
	.stabs	"DRVCB_S:T63=s16drvname:29,0,64;desc:61,64,16;flags:64=s2free:1,0,1;loaded:1,1,1;active:1,2,1;stopped:1,3,1;reserved:1,4,12;;,80,16;taskid:17,96,16;status:17,112,16;;",128,0,0,0
	.stabs	"DRVCB:t65=63",128,0,211,0
	.stabs	"PDRVCB:t66=67=*63",128,0,212,0
	.stabs	"DRVCBT_S:T68=s138eyecat:29,0,64;numdrvcb:17,64,16;drvcbt:69=ar23;0;7;65,80,1024;;",128,0,0,0
	.stabs	"DRVCBT:t70=68",128,0,220,0
	.stabs	"TQUEUE_S:T71=s6head:36,0,16;tail:36,16,16;count:1,32,16;;",128,0,0,0
	.stabs	"TQUEUE:t72=71",128,0,18,0
	.stabs	"PTQUEUE:t73=74=*71",128,0,19,0
	.stabs	"__int8_t:t75=10",128,0,26,0
	.stabs	"__uint8_t:t76=11",128,0,27,0
	.stabs	"__int16_t:t77=1",128,0,32,0
	.stabs	"__uint16_t:t78=4",128,0,33,0
	.stabs	"__int_least16_t:t79=77",128,0,46,0
	.stabs	"__uint_least16_t:t80=78",128,0,47,0
	.stabs	"__int32_t:t81=3",128,0,62,0
	.stabs	"__uint32_t:t82=5",128,0,63,0
	.stabs	"__int_least32_t:t83=81",128,0,76,0
	.stabs	"__uint_least32_t:t84=82",128,0,77,0
	.stabs	"__int64_t:t85=6",128,0,99,0
	.stabs	"__uint64_t:t86=7",128,0,100,0
	.stabs	"_LOCK_T:t87=1",128,0,6,0
	.stabs	"_LOCK_RECURSIVE_T:t88=1",128,0,7,0
	.stabs	"_off_t:t89=3",128,0,16,0
	.stabs	"__dev_t:t90=8",128,0,24,0
	.stabs	"__uid_t:t91=9",128,0,29,0
	.stabs	"__gid_t:t92=9",128,0,32,0
	.stabs	"_off64_t:t93=6",128,0,36,0
	.stabs	"_fpos_t:t94=3",128,0,44,0
	.stabs	"_ssize_t:t95=3",128,0,58,0
	.stabs	"wint_t:t96=4",128,0,353,0
	.stabs	"_mbstate_t:t97=98=s6__count:1,0,16;__value:99=u4__wch:96,0,16;__wchb:100=ar23;0;3;11,0,32;;,16,32;;",128,0,75,0
	.stabs	"_flock_t:t101=88",128,0,79,0
	.stabs	"_iconv_t:t102=20",128,0,84,0
	.stabs	"__ULong:t103=5",128,0,21,0
	.stabs	"_Bigint:T104=s14_next:105=*104,0,16;_k:1,16,16;_maxwds:1,32,16;_sign:1,48,16;_wds:1,64,16;_x:106=ar23;0;0;103,80,32;;",128,0,0,0
	.stabs	"__tm:T107=s18__tm_sec:1,0,16;__tm_min:1,16,16;__tm_hour:1,32,16;__tm_mday:1,48,16;__tm_mon:1,64,16;__tm_year:1,80,16;__tm_wday:1,96,16;__tm_yday:1,112,16;__tm_isdst:1,128,16;;",128,0,0,0
	.stabs	"_on_exit_args:T108=s136_fnargs:109=ar23;0;31;20,0,512;_dso_handle:109,512,512;_fntypes:103,1024,32;_is_cxa:103,1056,32;;",128,0,0,0
	.stabs	"_atexit:T110=s204_next:111=*110,0,16;_ind:1,16,16;_fns:112=ar23;0;31;113=*114=f15,32,512;_on_exit_args:108,544,1088;;",128,0,0,0
	.stabs	"__sbuf:T115=s4_base:116=*11,0,16;_size:1,16,16;;",128,0,0,0
	.stabs	"__sFILE:T117=s58_p:116,0,16;_r:1,16,16;_w:1,32,16;_flags:8,48,16;_file:8,64,16;_bf:115,80,32;_lbfsize:1,112,16;_cookie:20,128,16;_read:118=*119=f1,144,16;_write:120=*121=f1,160,16;_seek:122=*123=f94,176,16;_close:124=*125=f1,192,16;_ub:115,208,32;_up:116,240,16;_ur:1,256,16;_ubuf:126=ar23;0;2;11,272,24;_nbuf:127=ar23;0;0;11,296,8;_lb:115,304,32;_blksize:1,336,16;_offset:1,352,16;_data:128=*129=xs_reent:,368,16;_lock:101,384,16;_mbstate:97,400,48;_flags2:1,448,16;;",128,0,0,0
	.stabs	"__FILE:t130=117",128,0,273,0
	.stabs	"_glue:T131=s6_next:132=*131,0,16;_niobs:1,16,16;_iobs:133=*130,32,16;;",128,0,0,0
	.stabs	"_rand48:T134=s14_seed:135=ar23;0;2;9,0,48;_mult:135,48,48;_add:9,96,16;;",128,0,0,0
	.stabs	"_reent:T129=s600_errno:1,0,16;_stdin:133,16,16;_stdout:133,32,16;_stderr:133,48,16;_inc:1,64,16;_emergency:136=ar23;0;24;2,80,200;_current_category:1,288,16;_current_locale:137=*138=k2,304,16;__sdidinit:1,320,16;__cleanup:139=*140=f15,336,16;_result:105,352,16;_result_k:1,368,16;_p5s:105,384,16;_freelist:141=*105,400,16;_cvtlen:1,416,16;_cvtbuf:142=*2,432,16;_new:143=u156_reent:144=s156_unused_rand:4,0,16;_strtok_last:142,16,16;_asctime_buf:145=ar23;0;25;2,32,208;_localtime_buf:107,240,144;_gamma_signgam:1,384,16;_rand_next:7,400,64;_r48:134,464,112;_mblen_state:97,576,48;_mbtowc_state:97,624,48;_wctomb_state:97,672,48;_l64a_buf:29,720,64;_signal_buf:146=ar23;0;23;2,784,192;_getdate_err:1,976,16;_mbrlen_state:97,992,48;_mbrtowc_state:97,1040,48;_mbsrtowcs_state:97,1088,48;_wcrtomb_state:97,1136,48;_wcsrtombs_state:97,1184,48;_h_errno:1,1232,16;;,0,1248;_unused:147=s120_nextf:148=ar23;0;29;116,0,480;_nmalloc:149=ar23;0;29;4,480,480;;,0,960;;,448,1248;_atexit:111,1696,16;_atexit0:110,1712,1632;_sig_func:150=*151=*152=f15,3344,16;__sglue:131,3360,48;__sf:153=ar23;0;2;130,3408,1392;;",128,0,0,0
	.stabs	"size_t:t154=4",128,0,212,0
	.stabs	"SVC:t155=156=*157=f1",128,0,10,0
	.stabs	"DRV:t158=159=*160=f1",128,0,11,0
	.stabs	"SVC_S:T161=s4svc:155,0,16;nparams:1,16,16;;",128,0,0,0
	.even
	.globl _muxx_systrap_handler
_muxx_systrap_handler:
	.stabd	46,0,0
	.stabd	68,0,91
LFBB_1:

	;	/* function prologue muxx_systrap_handler*/
	mov r2, -(sp)
	mov r3, -(sp)
	;/* end of prologue */

	mov 06(sp), r0
	mov 010(sp), r2
	mov 012(sp), r3
	.stabd	68,0,135
	tst r0
	bge JMP_0
	jmp L_15
JMP_0:
	.stabd	68,0,135
	cmp r0,$0204
	ble JMP_1
	jmp L_15
JMP_1:
	.stabd	68,0,146
	cmp r0,$031
	beq L_6
	bgt L_10
	cmp r0,$01
	beq L_4
	cmp r0,$010
	beq L_5
	tst r0
	beq L_3
	jmp L_18
L_10:
	cmp r0,$033
	bne JMP_2
	jmp L_8
JMP_2:
	blt L_7
	cmp r0,$037
	beq JMP_3
	jmp L_18
JMP_3:
	br L_9
L_3:
LBB_16:
LBB_17:
	.stabd	68,0,47
;# 47 "muxx_systrap_svc.c" 1
	halt
;# 0 "" 2
	.stabd	68,0,48
;# 48 "muxx_systrap_svc.c" 1
	halt
;# 0 "" 2
	.stabd	68,0,49
;# 49 "muxx_systrap_svc.c" 1
	halt
;# 0 "" 2
L_9:
LBE_17:
LBE_16:
LBB_18:
LBB_19:
	.stabd	68,0,43
	movb r2, -(sp)
	jsr pc, _kconputc
LBE_19:
LBE_18:
	.stabd	68,0,152
	add $02, sp
	jmp L_2
L_4:
	.stabd	68,0,154
	mov 016(sp), -(sp)
	mov 016(sp), -(sp)
	mov r3, -(sp)
	mov r2, -(sp)
	jsr pc, _muxx_svc_creprc
	.stabd	68,0,155
	add $010, sp
	jmp L_2
L_5:
	mov _curtcb, r0
LBB_20:
LBB_21:
	.stabd	68,0,57
	tst r2
	bne L_11
	.stabd	68,0,58
	mov r0, r2
L_11:
	.stabd	68,0,62
	movb 024(r0), r1
	bicb $-02, r1
	bne L_12
	cmp 014(r0),014(r2)
	bne L_17
	cmp 016(r0),016(r2)
	bne L_17
L_12:
	.stabd	68,0,64
	jsr pc, _setpl7
	mov r0, r3
	.stabd	68,0,65
	mov r2, -(sp)
	mov _readyq, -(sp)
	jsr pc, _muxx_qRemoveTask
	.stabd	68,0,66
	mov $04, 020(r2)
	.stabd	68,0,67
	mov r2, -(sp)
	mov _suspq, -(sp)
	jsr pc, _muxx_qAddTask
	.stabd	68,0,68
	add $010, sp
	cmp r2,_curtcb
	bne L_13
	.stabd	68,0,69
	jsr pc, _copyMMUstate
	.stabd	68,0,70
	jsr pc, _muxx_schedule
L_13:
	.stabd	68,0,72
	mov r3, -(sp)
	jsr pc, _setpl
	add $02, sp
	br L_19
L_6:
LBE_21:
LBE_20:
LBB_23:
LBB_24:
	.stabd	68,0,80
	jsr pc, _setpl7
	.stabd	68,0,81
	mov _curtcb, r0
	mov $01, 020(r0)
	.stabd	68,0,82
	mov r0, -(sp)
	mov _readyq, -(sp)
	jsr pc, _muxx_qAddTask
	.stabd	68,0,83
	jsr pc, _copyMMUstate
	.stabd	68,0,84
	jsr pc, _muxx_schedule
	add $04, sp
L_7:
LBE_24:
LBE_23:
LBB_25:
LBB_26:
	.stabd	68,0,33
	tst r2
	bne L_18
	.stabd	68,0,38
	mov _curtcb, r0
	mov $0206, r1
	
movestrhi0:
	movb (r0)+, (r3)+
	sob r1, movestrhi0
L_19:
	.stabd	68,0,39
	clr r0
	br L_2
L_8:
LBE_26:
LBE_25:
LBB_28:
LBB_29:
	.stabd	68,0,26
	clr -(sp)
	mov $02, -(sp)
	jsr pc, (r3)
LBE_29:
LBE_28:
	.stabd	68,0,167
	add $04, sp
	br L_18
L_15:
	.stabd	68,0,136
	mov $-06, r0
	br L_2
L_17:
LBB_30:
LBB_22:
	.stabd	68,0,74
	mov $-07, r0
	br L_2
L_18:
LBE_22:
LBE_30:
LBB_31:
LBB_27:
	.stabd	68,0,36
	mov $-01747, r0
L_2:
LBE_27:
LBE_31:

	;	/*function epilogue */
	mov (sp)+, r3
	mov (sp)+, r2
	rts pc
	;/* end of epilogue*/


	.stabs	"muxx_systrap_handler:F1",36,0,91,_muxx_systrap_handler
	.stabs	"numtrap:p1",160,0,91,6
	.stabs	"p1:p17",160,0,91,8
	.stabs	"p2:p17",160,0,91,10
	.stabs	"p3:p17",160,0,91,12
	.stabs	"p4:p17",160,0,91,14
	.stabs	"rc:r1",64,0,133,0
	.stabs	"numtrap:r1",64,0,91,0
	.stabs	"p1:r17",64,0,91,2
	.stabs	"p2:r17",64,0,91,3
	.stabn	192,0,0,LFBB_1
	.stabs	"theTask:r36",64,0,54,2
	.stabs	"curpl:r1",64,0,55,3
	.stabn	192,0,0,LBB_21
	.stabn	224,0,0,LBE_21
	.stabs	"theTask:r36",64,0,54,2
	.stabs	"curpl:r1",64,0,55,3
	.stabn	192,0,0,LBB_22
	.stabn	224,0,0,LBE_22
	.stabn	224,0,0,Lscope_1
Lscope_1:
