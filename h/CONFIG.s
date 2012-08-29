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

	MMU.UISDR0	= 0177600	// User I space descriptor reg
	MMU.UISDR1	= 0177602	// User I space descriptor reg
	MMU.UISDR2	= 0177604	// User I space descriptor reg
	MMU.UISDR3	= 0177606	// User I space descriptor reg
	MMU.UISDR4	= 0177610	// User I space descriptor reg
	MMU.UISDR5	= 0177612	// User I space descriptor reg
	MMU.UISDR6	= 0177614	// User I space descriptor rge
	MMU.UISDR7	= 0177616	// User I space descriptor rge
	MMU.UDSDR0	= 0177620	// User D space descriptor reg.
	MMU.UISAR0	= 0177640	// User I space address reg.
	MMU.UISAR1	= 0177642	// User I space address reg.
	MMU.UISAR2	= 0177644	// User I space address reg.
	MMU.UISAR3	= 0177646	// User I space address reg.
	MMU.UISAR4	= 0177650	// User I space address reg.
	MMU.UISAR5	= 0177652	// User I space address reg.
	MMU.UISAR6	= 0177654	// User I space address reg.
	MMU.UISAR7	= 0177656	// User I space address reg.
	
	MMU.UDSAR0	= 0177660	// User D space address reg.
	MMU.SISDR0	= 0172200	// Supervisor I space descriptor reg.
	MMU.SDSDR0	= 0172220	// Supervisor D space descriptor reg.
	MMU.SISAR0	= 0172240	// Supervisor I space address reg.
	MMU.SDSAR0	= 0172260	// Supervisor D space address reg.
	MMU.KISDR0	= 0172300	// Kernel I space descriptor reg.
	MMU.KISDR1	= 0172302	// Kernel I space descriptor reg.
	MMU.KISDR2	= 0172304	// Kernel I space descriptor reg.
	MMU.KISDR3	= 0172306	// Kernel I space descriptor reg.
	MMU.KISDR4	= 0172310	// Kernel I space descriptor reg.
	MMU.KISDR5	= 0172312	// Kernel I space descriptor reg.
	MMU.KISDR6	= 0172314	// Kernel I space descriptor reg.
	MMU.KISDR7	= 0172316	// Kernel I space descriptor reg.
	MMU.KDSDR0	= 0172320	// Kernel D space descriptor reg.
	MMU.KISAR0	= 0172340	// Kernel I space address reg.
	MMU.KISAR1	= 0172342	// Kernel I space address reg.
	MMU.KISAR2	= 0172344	// Kernel I space address reg.
	MMU.KISAR3	= 0172346	// Kernel I space address reg.
	MMU.KISAR4	= 0172350	// Kernel I space address reg.
	MMU.KISAR5	= 0172352	// Kernel I space address reg.
	MMU.KISAR6	= 0172354	// Kernel I space address reg.
	MMU.KISAR7	= 0172356	// Kernel I space address reg.
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
	MEM_BLOCKS = 4096 // 4096 * 64 = 256K
	MEM_NMCBS = 128	  // 4096 / 32 = 128 MCBs. 1 MCB controls 32 blocks

	CPU_HAS_SPL = 0		// Support for spl instruction
	CPU_HAS_CIS = 0		// Commercial Instruction set
	CPU_HAS_FPP = 0		// Floating Point processor
	CPU_HAS_ERROR = 1	// CPU Error trap mask
	CPU_HAS_SUPER = 0	// Supervisor mode supported and enabled
	CPU_HAS_SEPID = 0	// Separated I and D address spaces
	
	.LIST
