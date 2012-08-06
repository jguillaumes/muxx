	.TITLE cputrap - Handling of CPU error/traps
	.IDENT "V01.00"

	.INCLUDE "CONFIG.s"
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
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$CPUERR,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_illins:
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$ILLINS,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_iot:
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$IOT,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_buserr:
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$BUSERR,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_fperr:
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$FPERR,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$
	br	trap_common

trap_mmuerr:
	mov	$6,r1
	mov	$NTRAP,r2
	mov	$MMUERR,r3
10$:	movb	(r3)+,(r2)+
	sob	r1,10$

	
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
	mov	2(sp),r0	// SP => Return address
	mov	r0,-(sp)
	mov	$UNIADDR, -(sp)
	jsr	pc,_otoa
	add	$4,sp

	mov	$LUNITRAP,-(sp)
	mov	$UNITRAP,-(sp)
	jsr	pc,_kputstrl
	add	$4,sp
	halt

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

CPUERR:		.ASCII "CPUERR"
ILLINS:		.ASCII "ILLINS"
IOT:		.ASCII "IOT   "
POWER:		.ASCII "POWER "
BUSERR:		.ASCII "BUSERR"
FPERR:		.ASCII "FPERR "
MMUERR:		.ASCII "MMUERR"

		.END

	