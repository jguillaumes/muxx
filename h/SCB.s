	.TITLE scb - System Control Block mapping
	.IDENT "V01.00"
	.NOLIST

	.MACRO SCB

	.global _scbeye
	.global	_tct
	.global _tctsize
	.global _curtasks
	.global	_kstackt
	.global _kstackb
	.global	_ustackt
	.global	_ustackb
	.global _topspid
	.global _maxspid
	.global _minspid
	.global _topupid
	.global _maxupid
	.global _minupid
	
	jmp	end_scb			// Initial jump instruction

_scbeye:	.SPACE 8		// Eyecatcher
_tct:		.WORD 0			// Task control table address
_tctsize:	.WORD 0			// Size of the TCT (in bytes)
_curtasks:	.WORD 0			// Number of running tasks
_kstackt:	.WORD _kernstackt	// Top of kernel stack
_kstackb:	.WORD _kernstackb	// Bottom of kernel stack
_ustackt:	.WORD 0			// Top of user stack
_ustackb:	.WORD 0			// Bottom of user stack

_topspid:	.WORD 0			// Highest assigned system PID
_minspid:	.WORD 00001		// Minimal assignable system PID
_maxspid:	.WORD 00077		// Maximim assignable system PID

_topupid:	.WORD 0			// Highest assigned user PID
_minupid:	.WORD 00100		// Minimal assignable user PID
_maxupid:	.WORD 00777		// Maximum assignable user PID
	
_clfreq:	.WORD CLOCK_FREQ	// Tick clock frequency
_utime:		.LONG 0			// Ticks of uptime
_datetime:	.LONG 0			// Ticks of datetime (1/1/1970 based)

	.ALIGN 7			// Align to 64 byte boundary
end_scb:
	mov	_kstackt,sp
	.ENDM
	.LIST
