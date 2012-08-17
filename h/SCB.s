	.TITLE scb - System Control Block mapping
	.IDENT "V01.00"
	.NOLIST

	.MACRO SCB

	.global _scbeye
	.global	_tct
	.global _tctsize
	.global _curtasks
	.global _readyq
	.global _blockq
	.global _suspq
	.global _curtcb
	.global	_kstackt
	.global _kstackb
	.global	_ustackt
	.global	_ustackb
	.global _mmcbtaddr
	.global _topspid
	.global _maxspid
	.global _minspid
	.global _topupid
	.global _maxupid
	.global _minupid
	.global	_utimeticks
	.global _clkcountdown
	.global _clkquantum
	
	jmp	end_scb			// Initial jump instruction

_scbeye:	.ASCII "SCBEYE--"	// Eyecatcher
_tct:		.WORD _tctArea		// Task control table address
_tctsize:	.WORD 0 		// Size of the TCT (in bytes)
_curtasks:	.WORD 0			// Number of running tasks
_readyq:	.WORD _readyQueue	// Address of ready queue structure
_blockq:	.WORD _blockedQueue	// Address of blocked list structure
_suspq:		.WORD _suspQueue	// Address of suspended list structure
_curtcb:	.WORD 0			// Address of running TCB
	
_kstackt:	.WORD TOP_STACK-2	// Top of kernel stack
_kstackb:	.WORD TOP_STACK-KRN_STACK	// Bottom of kernel stack
_ustackt:	.WORD TOP_STACK-KRN_STACK-2		// Top of user stack
_ustackb:	.WORD TOP_STACK-KRN_STACK-USR_STACK	// Bottom of user stack

_mmcbtaddr:	.WORD _mmcbt		// Address of MMCBT
	
_topspid:	.WORD 0			// Highest assigned system PID
_minspid:	.WORD 00001		// Minimal assignable system PID
_maxspid:	.WORD 00077		// Maximum assignable system PID

_topupid:	.WORD 0			// Highest assigned user PID
_minupid:	.WORD 00100		// Minimal assignable user PID
_maxupid:	.WORD 00777		// Maximum assignable user PID
	
_clkfreq:	.WORD CLK_FREQ		// Tick clock frequency
_clkquantum:	.WORD CLK_QUANTUM	// Ticks per quantum
_clkcountdown:	.WORD CLK_QUANTUM	// Ticks remaining in currrent quantum
_utimeticks:	.LONG 0			// Ticks of uptime
_datetime:	.LONG 0			// Ticks of datetime (1/1/1970 based)

	.ALIGN 6			// Align to 64 byte boundary
end_scb:
	.ENDM
	.LIST
