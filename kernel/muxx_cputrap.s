	.TITLE cputrap - Handling of CPU error/traps
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
	.INCLUDE "MUXX.s"
	.INCLUDE "MACLIB.s"

	
	.GLOBAL trap_initialize
	.GLOBAL _otoa
	.GLOBAL	_kputstrl

	.macro setvec vector,address,psw
	mov	\address, \vector
	mov	\psw, \vector+2
	.endm
	
	
	.text
trap_initialize:
	procentry numregs=4
	mov	$trap_unimplemented, r0
	mov	PSWTRAP, r1

	setvec	VEC.CPUERR,$trap_cpuerr,r1
	setvec	VEC.ILLINS,$trap_illins,r1
	setvec	VEC.TRACE,r0,r1
	setvec	VEC.IOT,$trap_iot,r1
	setvec	VEC.POWER,r0,r1
	setvec	VEC.BUSERR,$trap_buserr,r1
	setvec	VEC.FPERR,$trap_fperr,r1
	setvec	VEC.MMUERR,$trap_mmuerr,r1
	
	cleanup	numregs=4
	rts	pc

trap_cpuerr:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	mov	$CPUADDR,-(sp)
	mov	CPU.ERR,-(sp)
	jsr	pc,_otoa
	add	$4,sp
	mov	$LCPUTRAP,-(sp)
	mov	$CPUTRAP,-(sp)
	jsr	pc,_kputstrl
	add	$4,sp
	halt

trap_illins:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$ILLINS,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_iot:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$IOT,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_buserr:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$BUSERR,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_fperr:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$FPERR,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_mmuerr:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	mov	MMU.MMR0,r0
	swab	r0
	bic	$0xFF00,r0
	mov	$MMUCODE,-(sp)
	movb	r0,-(sp)
	jsr	pc,_htoab
	add	$4,sp
	
	mov	MMU.MMR0,r0
	asr	r0
	bic	$0b1111111111111000,r0
	mov	$MMUPAGE,-(sp)
	movb	r0,-(sp)
	jsr	pc,_htoab
	add	$4,sp
	
	mov	MMU.MMR2,r0
	mov	$MMUADDR,-(sp)
	mov	r0,-(sp)
	jsr	pc,_otoa
	add	$4,sp
	
	mov	$LMMUTRAP,-(sp)
	mov	$MMUTRAP,-(sp)
	jsr	pc,_kputstrl
	add	$4,sp
	halt
	
trap_common:	
	mov	(sp),r1
	mov	2(sp),r2
	mov	$KADDR,-(sp)
	mov	r1,-(sp)
	jsr	pc,_otoa
	add	$4,sp


	mov	$KPSW,-(sp)
	mov	r2,-(sp)
	jsr	pc,_otoa
	add	$4,sp

	mov	$LKTRAP,-(sp)
	mov	$KTRAP,-(sp)
	jsr	pc,_kputstrl
	add	$4,sp
	halt

trap_unimplemented:
	procentry saver0=yes
	savecputask
	jsr	pc,_dumptcbregs
	br	trap_common

	.data
	
PSWTRAP:	.WORD	0x0000
UNITRAP:	.ASCII	"Unimplemented trap triggered at "
UNIADDR:	.SPACE	6	;
		.ASCII  "."
	LUNITRAP = . - UNITRAP
KTRAP:		.ASCII "Trap "
NTRAP:		.SPACE 6
		.ASCII " triggered at "
KADDR:		.SPACE 6
		.ASCII ", PSW="
KPSW:		.SPACE 6
		.ASCII	". "
	LKTRAP = . - KTRAP

MMUTRAP:	.ASCII	"Memory access violation trap "
MMUCODE:	.SPACE  2
		.ASCII  ", page="
MMUPAGE:	.SPACE	2
		.ASCII  " triggered at "
MMUADDR:	.SPACE  6
	LMMUTRAP = . - MMUTRAP

CPUTRAP:	.ASCII	"CPU trap, code="
CPUADDR:	.SPACE	6
		.ASCII  "."
	LCPUTRAP = . - CPUTRAP
	
ILLINS:		.ASCII "ILLINS"
IOT:		.ASCII "IOT   "
POWER:		.ASCII "POWER "
BUSERR:		.ASCII "BUSERR"
FPERR:		.ASCII "FPERR "

		.END
