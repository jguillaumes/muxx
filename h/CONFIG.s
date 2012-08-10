	.NOLIST

	/*
	** System Interrupt vectors
	*/
	VEC.CPUERR	= 0004		
	VEC.ILLINS	= 0010
	VEC.TRACE	= 0014
	VEC.IOT		= 0020
	VEC.POWER	= 0024
	VEC.EMT		= 0030		// Vector for EMT instruction
	VEC.TRAP	= 0034		// Vector for TRAP instruction
	VEC.BUSERR	= 0114
	VEC.FPERR	= 0244
	VEC.MMUERR	= 0250
	
	/*
	** PSW:	
	** 	0: 	C
	**	1: 	V
	**	2: 	Z
	**	3: 	N
	**	4: 	T
	**	5-7:	Priority (0-7, 7:inhibited)	
	**	8:	CIS Suspension
	**	9-10:	Reserved (MBZ)
	**	11:	GPR set
	**	12-13:	Previous mode  
	**	14-15:	Current mode
	**			00: Kernel
	**			01: Supervisor
	**			11: User
	**
	** ERR:
	**	0-1:	Not used
	**	2:	Stack overflow (red)
	**	3:	Stack overflow (yellow)
	**	4:	UNIBUS timeout
	**	5:	Non-existent memory
	**	6:	Odd address
	**	7:	Illegal HALT
	**	8-15:	Not used
	**
	** PIR:
	**	0:	Not used
	**	1-3:	PIA
	**	4:	Not used
	**	5-7:	PIA
	**	8:	Not used
	**	9-15:	Interrupt request
	*/
	
	/*
	** Console device registers
	*/
	CON.RCSR 	= 0177560	// DL11 receive control register
	CON.RBUF 	= 0177562	// DL11 receive buffer
	CON.XCSR 	= 0177564	// DL11 transmit control reg.
	CON.XBUF 	= 0177566	// DL11 transmit buffer

	/*
	** Line time Clock (KL11-L) registers and constants
	*/
	CLK.LKS		= 0177546	// Clock status register
	CLK.VECTOR	= 0100		// Interrupt vector
	CLK.PL		= 06		// Interrupt priority

	/*
	** Paper tape read/punch registers and constants
	*/
	PTP.PRS		= 0177550	// Paper Read status register
	PTP.PRB		= 0177552	// Paper read buffer
	PTP.PPS		= 0177554	// Paper Punch status register
	PTP.PPB		= 0177556	// Paper punch buffer
	PTP.RVEC	= 070		// Paper reader interrupt vector
	PTP.PVEC	= 074		// Paper punch interrupt vector
	PTP.PL		= 04		// Interrupt priority
	
	/*
	** CPU registers
	*/
	CPU.LOWER	= 0177760
	CPU.UPPER	= 0177762
	CPU.SYSID	= 0177764
	CPU.ERR		= 0177766
	CPU.KSP		= 0177706
	CPU.SSP		= 0177716
	CPU.USP		= 0177717
	CPU.PIR		= 0177772
	CPU.STACKLIM	= 0177774
	CPU.PSW		= 0177776
	/*
	** MMU registers
	**
	** MMR0:
	** MMR1:
	** MMR2:
	** MMR3:
	** PAR:
	** PDR:
	**	0-2: Access Control Field
	**		000: No access (abort)
	**		001: Read access with trap on read (abort on write)
	**		010: Read access (abort on write)
	**		011: Unuse (aborts)
	**		100: Read/write (with trap on both read and write)
	**		101: Read/write (with trap on write)
	**		110: Read/write
	**		111: Unused (aborts)
	**	3:   Expansion direction (0: Up, 1: Down)
	**	4-5: Reserved (MBZ)
	**	6:   W: Modified page
	**	7:   A: One access caused trap per ACF value
	**	8-14:PLF (length), in 64 byte blocks
	**	15:  Bypass cache
	*/
	MMU.MMR0	= 0177572	// Mem. Mgt. Reg #0
	MMU.MMR1	= 0177574	// Mem. Mgt. Reg #1
	MMU.MMR2	= 0177576 	// Mem. Mgt. Reg #2
	MMU.MMR3	= 0172516	// Mem. Mgt. Reg #3

	MMU.UIDR0	= 0177600	// User I space descriptor reg
	MMU.UDSDR0	= 0177620	// User D space descriptor reg.
	MMU.UISAR0	= 0177640	// User I space address reg.
	MMU.UDSAR0	= 0177660	// User D space address reg.
	MMU.SISDR0	= 0172200	// Supervisor I space descriptor reg.
	MMU.SDDR0	= 0172220	// Supervisor D space descriptor reg.
	MMU.SISAR0	= 0172240	// Supervisor I space address reg.
	MMU.SDSAR0	= 0172260	// Supervisor D space address reg.
	MMU.KISDR0	= 0172300	// Kernel I space descriptor reg.
	MMU.KDSDR0	= 0172320	// Kernel D space descriptor reg.
	MMU.KISAR0	= 0172340	// Kernel I space address reg.
	MMU.KDSAR0	= 0172360	// Kernel D space address reg.


	/*
	** Kernel config constants
	*/
	MAX_TASKS = 16
	CLK_FREQ = 60
	CLK_QUANTUM = 6	
	KRN_STACK = 1024
	USR_STACK = 3072
	TOP_STACK = 0160000
	MEM_BLOCKS = 4096		// 4096 * 64 = 256K
	MEM_NMCBS = (4096/16)		// 256 MCBs. 1 MCB controls 16 blocks
	.LIST
